package dynamusic.forms;

import java.io.IOException;
import java.util.Enumeration;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.ServletException;

import atg.droplet.DropletException;
import atg.droplet.GenericFormHandler;
import atg.servlet.DynamoHttpServletRequest;
import atg.servlet.DynamoHttpServletResponse;

public class MyFormHandler extends GenericFormHandler {
	public String name;
	public String email;
	public String successURL;


	public String getSuccessURL() {return successURL;}
	public void setSuccessURL(String successURL) {this.successURL = successURL;}

	public String getEmail() {return email;}
	public void setEmail(String email) {this.email = email;}

	public String getName() {return name;}
	public void setName(String name) {this.name = name;}

	public boolean handleSubmit(DynamoHttpServletRequest dReq, DynamoHttpServletResponse dRes) throws IOException, ServletException{

		final Enumeration formElements = dReq.getParameterNames();
		boolean flag = true;

		while (formElements.hasMoreElements()) {
			String formName = (String) formElements.nextElement();
			String value = dReq.getParameter(formName);
			if(formName.equals("email")){
				if(isValidEmailAddress(value)){
					flag = true;
				}else{
					logError("this is email==" + value);
					flag = false;
					addFormException(new DropletException("invalid email==" + value));
				}
			}
		}

		dRes.sendLocalRedirect(this.getSuccessURL(), dReq);
		return flag;
	};

	public boolean isValidEmailAddress(String emailAddress){
		String emailExpression="^[\\w]([\\.\\w\\-])*[\\w]+@([\\w\\-]+\\.)+[A-Z]{2,4}$";
		CharSequence inputStr = emailAddress;
		Pattern pattern = Pattern.compile(emailExpression,Pattern.CASE_INSENSITIVE);
		Matcher matcher = pattern.matcher(inputStr);
		return matcher.matches();  
	}
}
