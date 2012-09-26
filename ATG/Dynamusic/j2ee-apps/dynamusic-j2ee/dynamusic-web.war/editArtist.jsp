<%@ taglib uri="/dspTaglib" prefix="dsp" %>
<dsp:importbean bean="/dynamusic/form/ArtistFormHandler" />
<dsp:page>

<!-------------------------------------------------------------
  Dynamusic Site                                DAF Site Mockup
  
  EDIT ARTIST
  
  Modify description of an artist and her/his list of albums.
  
  ------------------------------------------------------------->
  

<HTML>
  <HEAD>
    <TITLE>Dynamusic Artist</TITLE>
  </HEAD>
  <BODY>
  <dsp:include page="common/header.jsp">
    <dsp:param name="pagename" value="Edit Artist"/>
  </dsp:include>
    
    <table width="700" cellpadding="8">
      <tr>
        <!-- Sidebar -->
        <td width="100" bgcolor="ghostwhite" valign="top">
        <dsp:include page="common/sidebar.jsp"></dsp:include>
        </td>
        <!-- Page Body -->
        <td valign="top">
          <font face="Verdana,Geneva,Arial" size="-1">
          
          <!-- *** Start page content *** -->
			<dsp:setvalue bean="ArtistFormHandler.repositoryId" paramvalue="artistId" />
            <dsp:form action="editDetails.jsp">
				<dsp:input bean="ArtistFormHandler.repositoryId" type="hidden" paramvalue="artistId"/>
					<dsp:droplet name="/atg/dynamo/droplet/ErrorMessageForEach">
						<dsp:oparam name="output">
							<li><strong><dsp:valueof param="message"/></strong></li>
						</dsp:oparam>
						<dsp:oparam name="outputStart">
							<ul>
						</dsp:oparam>
						<dsp:oparam name="outputEnd">
							</ul>
						</dsp:oparam>
					</dsp:droplet>

              <table cellpadding="10">
                <tr>
                  <td valign="middle" align="right">Artist Name</td>
                  <td valign="middle">
                    <font face="Courier New" size="-1">
                      <dsp:input type="text" bean="ArtistFormHandler.value.name" size="30" required="true" />
                    </font>
                  </td>
                </tr>
                <tr>
                  <td valign="middle" align="right">Photo URL</td>
                  <td valign="middle">
                    <font face="Courier New" size="-1">
                      <dsp:input type="text" bean="ArtistFormHandler.value.photoURL" size="30"/>
                    </font>
                  </td>
                </tr>
                <tr>
                  <td valign="top" align="right">Description</td>
                  <td valign="top">
                      <dsp:textarea cols="60" rows="10" wrap="SOFT" bean="ArtistFormHandler.value.description"></dsp:textarea>
                  </td>
                </tr>
                <tr>
                   <td> </td>
                   <td>
                   		<dsp:input type="hidden" bean="ArtistFormHandler.updateSuccessURL" value="success.jsp"/> 
						<dsp:input type="hidden" bean="ArtistFormHandler.deleteSuccessURL" value="success.jsp"/>
                        <dsp:input type="submit" bean="ArtistFormHandler.update" value="Save Changes"/>
                        <dsp:input type="submit" bean="ArtistFormHandler.delete" value="Delete This Artist"/>
                   </td>
              </table>
            </dsp:form>
          <!-- *** End real content *** -->
          </font>
        </td>
      </tr>
    </table>
  </BODY>
</HTML>

</dsp:page>


