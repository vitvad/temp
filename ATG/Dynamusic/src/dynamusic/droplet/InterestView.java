package dynamusic.droplet;

import java.io.IOException;
import java.lang.reflect.Field;
import java.util.Arrays;
import java.util.Collection;
import java.util.Comparator;

import javax.servlet.ServletException;

import atg.repository.MutableRepository;
import atg.repository.Query;
import atg.repository.QueryBuilder;
import atg.repository.Repository;
import atg.repository.RepositoryException;
import atg.repository.RepositoryItem;
import atg.repository.RepositoryItemDescriptor;
import atg.repository.RepositoryView;
import atg.repository.SortDirective;
import atg.repository.SortDirectives;
import atg.servlet.DynamoHttpServletRequest;
import atg.servlet.DynamoHttpServletResponse;
import atg.servlet.DynamoServlet;
import atg.targeting.RepositoryLookup;

public class InterestView extends DynamoServlet {

	private MutableRepository profileRepository;
	
	public MutableRepository getProfileRepository() {
		return profileRepository;
	}
	
	public void setProfileRepository(MutableRepository profileRepository) {
		this.profileRepository = profileRepository;
	}
	

	
	public void service(DynamoHttpServletRequest req, DynamoHttpServletResponse res) throws ServletException, IOException {
		try{
			RepositoryView view = this.profileRepository.getView("interest");
			if(view != null){
				QueryBuilder qb = view.getQueryBuilder();
				Query query = qb.createUnconstrainedQuery();
				SortDirectives sortDirectives = new SortDirectives();

				String sortBy = req.getParameter("sortBy");
				if(sortBy == null) sortBy = "rating";//default

				String sortDirection = req.getParameter("sortDirection");
				Integer sortOption = SortDirective.DIR_ASCENDING; //default
				if(sortDirection != null && sortDirection.equalsIgnoreCase("desc")){
					sortOption = SortDirective.DIR_DESCENDING;
				}else{
					sortDirection = "asc";
				};

				sortDirectives.addDirective(new SortDirective(sortBy, sortOption));

				RepositoryItem[] items = view.executeQuery(query, sortDirectives);

				if(req.getParameter("start")!= null){
					req.serviceLocalParameter("start", req, res);
				}

				for (RepositoryItem repositoryItem : items) {
					if(req.getParameter("output")!= null){
						req.setParameter("element", repositoryItem);
						req.serviceLocalParameter("output", req, res);
					}
				}

				if(req.getParameter("end")!= null){
					req.serviceLocalParameter("end", req, res);
				}
			}
		}catch (RepositoryException e){
			throw new IllegalStateException(e);
		}
		
	}

}