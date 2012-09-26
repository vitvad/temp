<%@ taglib uri="/dspTaglib" prefix="dsp" %>
<dsp:page>
<!-------------------------------------------------------------
  Dynamusic Site                                DAF Site Mockup
  
  CONCERT DETAILS
  
  Display details of a given concert, including participating 
  artists.
  
  ------------------------------------------------------------->
  

<HTML>
  <HEAD>
    <TITLE>Dynamusic Venues</TITLE>
  </HEAD>
  <BODY>
   <dsp:droplet name="/dynamusic/ConcertLookupDroplet">
    <dsp:param name="id" param="itemId"/>
    <dsp:oparam name="output">

       <dsp:include page="common/header.jsp">
          <dsp:param name="pagename" param="element.name"/>
       </dsp:include>

    <table width="700" cellpadding="8">
      <tr>
        <!-- Sidebar -->
        <td width="100" bgcolor="ghostwhite" valign="top">
          <dsp:include page="common/sidebar.jsp">
          </dsp:include>
        </td>
        <!-- Page Body -->
        <td valign="top">
          <font face="Verdana,Geneva,Arial" size="-1">
          
          <!-- *** Start page content *** -->
          

          <table cellpadding="4">
            <tr>
             <td valign="center"> <img src="<dsp:valueof param='element.imageURL'/>"> </td>
             <td valign="center">
               <font face="Courier New"><b>
                 <dsp:valueof param="element.name"/><br>
                 <dsp:valueof param="element.venue.name"/><br>
                 <dsp:valueof param="element.date" date="MMM dd,yyyy"/><br>
               </b></font>
             </td>
           </tr>
          </table>
          <p>&nbsp;<p>
          <font face="Geneva, Arial" size="-1">
              <dsp:valueof param="element.description"/>
          </font>
          <p>
          Artists:
          <p> 
          <dsp:droplet name="/atg/dynamo/droplet/ForEach">
            <dsp:param name="array" param="element.artists"/>
            <dsp:oparam name="outputStart">
              <ul>
            </dsp:oparam>
            <dsp:oparam name="outputEnd">
              </ul>
            </dsp:oparam>
            <dsp:oparam name="output">
              <li><dsp:a href="artistDetails.jsp">
                  <dsp:param name="itemId" param="element.id"/>
                  <dsp:valueof param="element.name"/>
                </dsp:a>
            </dsp:oparam>
            <dsp:oparam name="empty">
              No artists found for this event.
            </dsp:oparam>
          </dsp:droplet>
            
          <!-- *** End real content *** -->
          
          </font>
        </td>
      </tr>
    </table>
</dsp:oparam>
</dsp:droplet>
  </BODY>
</HTML>
</dsp:page>