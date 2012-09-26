package dynamusic.droplet;

import javax.servlet.ServletException;
import java.io.IOException;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import atg.servlet.DynamoServlet;
import atg.servlet.DynamoHttpServletRequest;
import atg.servlet.DynamoHttpServletResponse;


public class OutCustomerInfo extends DynamoServlet{
	public final String CLIENTINFO = "profile";
	public final String CURRENTDATE = "date"; 
	public final String DATEFORMAT = "dformat"; 
	
	public void service(DynamoHttpServletRequest pRequest, DynamoHttpServletResponse pResponse)
		throws ServletException, IOException {
				Object customer = pRequest.getObjectParameter("client");
				if(pRequest.getParameter(CLIENTINFO) != null){
					pRequest.setParameter(CLIENTINFO, customer);
					pRequest.serviceLocalParameter(CLIENTINFO, pRequest, pResponse);
				}
				
				String dateFormat = pRequest.getParameter(DATEFORMAT);

				if(pRequest.getParameter(CURRENTDATE) != null && dateFormat != null){
					Calendar today = Calendar.getInstance();
					SimpleDateFormat dateFormater = new SimpleDateFormat(dateFormat);
					String dateString = dateFormater.format(today.getTime());

					pRequest.setParameter(CURRENTDATE, dateString);
					pRequest.serviceLocalParameter(CURRENTDATE, pRequest, pResponse);

					String pLocal = pRequest.getParameter("localParam");
					if(pRequest.getParameter("localParam")!= null){
						pRequest.setParameter("localParam", "asdfasdfasdfasd zsdf");
						pRequest.serviceLocalParameter(pLocal, pRequest, pResponse);
					}
				}
		}
}
