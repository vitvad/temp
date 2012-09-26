package dynamusic.forms;

import java.io.IOException;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.ServletException;

import atg.droplet.DropletException;
import atg.repository.MutableRepository;
import atg.repository.MutableRepositoryItem;
import atg.repository.RepositoryException;
import atg.repository.servlet.RepositoryFormHandler;
import atg.servlet.DynamoHttpServletRequest;
import atg.servlet.DynamoHttpServletResponse;

public class UserInterests extends RepositoryFormHandler {
	private static final Pattern VALIDATE_PATTERN = Pattern.compile("^[\\d]{1,2}$");
	private static final Integer MAX_RATING = 10;
	private static final Integer MIN_RATING = 1;
	public String name;
	public String rating;
	public String userId;
	public String createSuccessURL;
	public String errorURL;

	public String getErrorURL() {return errorURL;}
	public void setErrorURL(String errorURL) {this.errorURL = errorURL;}

	public String getCreateSuccessURL() {return createSuccessURL;}
	public void setCreateSuccessURL(String createSuccessURL) {this.createSuccessURL = createSuccessURL;}

	public String getUserId() {return userId;}
	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getRating() {return rating;}
	@SuppressWarnings("unchecked")
	public void setRating(String rating) {
		this.getValue().put("rating", rating);
		this.rating = rating;
	}

	public String getName() {return name;}
	@SuppressWarnings("unchecked")
	public void setName(String name) {
		this.getValue().put("name", name);
		this.name = name;
	}

	@Override
	public boolean handleUpdate(DynamoHttpServletRequest req, DynamoHttpServletResponse res) throws ServletException, IOException {
		boolean result = this.validateForm();
		if (result) {
			super.handleUpdate(req, res);
		}else{
			super.redirectOrForward(req, res, this.getErrorURL());
		};
		return result;
	}
	@Override
	public boolean handleDelete(DynamoHttpServletRequest req, DynamoHttpServletResponse res) throws ServletException, IOException {
		try{
			//get this interest
			MutableRepository interestRepo = (MutableRepository) this.getRepository();
			MutableRepositoryItem interestToDelete = (MutableRepositoryItem) interestRepo.getItem(this.getRepositoryId(), this.getItemDescriptor().getItemDescriptorName());

			//get user and delete this interest
			MutableRepositoryItem mutableUser = this.getRepository().getItemForUpdate(this.getUserId(), "user");

			Set userInterestSet = (Set) mutableUser.getPropertyValue("interests");
			if(userInterestSet.contains(interestToDelete)) userInterestSet.remove(interestToDelete);

			this.getRepository().updateItem(mutableUser);

		} catch (RepositoryException e) {
			throw new IllegalStateException(e);
		}
		super.redirectOrForward(req, res, this.getDeleteSuccessURL());
		return true;//super.handleDelete(req, res);
	}

	public boolean handleCreate(DynamoHttpServletRequest req, DynamoHttpServletResponse res) throws ServletException, IOException {
		boolean result = this.validateForm();
		if (result){
			try {
	//create new interest
				MutableRepository interestRepo = (MutableRepository) this.getRepository();
				MutableRepositoryItem newInterest = interestRepo.createItem("interest");
				newInterest.setPropertyValue("name", this.getName());
				newInterest.setPropertyValue("rating", Integer.parseInt(this.getRating()));
				interestRepo.addItem(newInterest);

	//get user and add there new interest 
				MutableRepositoryItem mutableUser = this.getRepository().getItemForUpdate(this.getUserId(), "user");

				Set userInterestSet = (Set) mutableUser.getPropertyValue("interests");
				userInterestSet.add(newInterest);

				this.getRepository().updateItem(mutableUser);
			} catch (RepositoryException e) {
				throw new IllegalStateException(e);
			}
			super.redirectOrForward(req, res, this.getCreateSuccessURL());
		};
		return result;
	}

	
	
	public boolean isValidNumber(final String number) {
		final Matcher matcher = VALIDATE_PATTERN.matcher(number);
		return matcher.matches();
	}

	private boolean validateForm() {
		boolean result = true;
		if (null == this.getName() || !this.isValidNumber(this.getRating()) || ((Integer.parseInt(this.getRating()) > MAX_RATING) || (Integer.parseInt(this.getRating()) < MIN_RATING))) {
			result = false;
			this.addFormException(new DropletException("invalid rating value==" + this.getRating()+ ", should be in range 1-10"));
		}
		if (null == this.getName() || this.getName().trim().length() == 0) {
			result = false;
			addFormException(new DropletException("name value is empty"));
		}
		return result;
	}
}
