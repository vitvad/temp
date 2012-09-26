<%@ taglib uri="/dspTaglib" prefix="dsp" %>
<dsp:page>
<!-------------------------------------------------------------
  Dynamusic Site Mockup
  
  Venues
  
  Display local concert venues.
  
  ------------------------------------------------------------->
  

<HTML>
  <HEAD>
    <TITLE>Dynamusic Venues</TITLE>
  </HEAD>
  <BODY>
    <dsp:include page="common/header.jsp">
       <dsp:param name="pagename" value="Venues"/>
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

          
            <p>Concert venues: <p>
            
            <dsp:droplet name="/atg/dynamo/droplet/RQLQueryForEach">
              <dsp:param name="queryRQL" value="ALL"/>
              <dsp:param name="repository" value="/dynamusic/EventsRepository"/>
              <dsp:param name="itemDescriptor" value="venue"/>
              <dsp:oparam name="outputStart">
                <ul>
              </dsp:oparam>
              <dsp:oparam name="outputEnd">
                </ul>
              </dsp:oparam>
              <dsp:oparam name="output">
                <li><dsp:a href="venueDetails.jsp">
                <dsp:param name="itemId" param="element.id"/>
                <dsp:param name="dsource" value="venuelist"/>
                <dsp:valueof param="element.name"/>
              </dsp:a>
            
              </dsp:oparam>
              <dsp:oparam name="empty">
                No venues found.
              </dsp:oparam>
            </dsp:droplet>

          <!-- *** End real content *** -->
          
          </font>
        </td>
      </tr>
    </table>
  </BODY>
</HTML>
</dsp:page>

