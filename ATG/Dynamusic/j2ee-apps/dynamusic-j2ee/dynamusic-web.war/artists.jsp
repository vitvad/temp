<%@ taglib uri="/dspTaglib" prefix="dsp" %>
<dsp:page>


<!-------------------------------------------------------------
  Dynamusic Site Mockup
  
  ARTISTS
  
  List of artists whose songs appear on this site.
  
  ------------------------------------------------------------->
  

<HTML>
  <HEAD>
    <TITLE>Dynamusic Artists</TITLE>
  </HEAD>
  <BODY>

  <dsp:include page="common/header.jsp">
    <dsp:param name="pagename" value="Artists"/>
  </dsp:include>    
    <table width="700" cellpadding="8">
      <tr>
        <!-- Sidebar -->
        <td width="100" bgcolor="ghostwhite" valign="top">
          <dsp:include page="common/sidebar.jsp"></dsp:include> 
          <br>
          <font face="Verdana,Geneva,Arial" size="-1" color="steelblue">
            <b><dsp:a href="newArtist.jsp">Add Artist</dsp:a></b></font>     
        </td>
        <!-- Page Body -->


<td VALIGN=TOP><!-- *** Start page content *** -->
<ol>
<dsp:droplet name="/atg/dynamo/droplet/RQLQueryForEach">
	<dsp:param name="queryRQL" value="ALL ORDER BY name" />
	<dsp:param name="itemDescriptor" value="artist" />
	<dsp:param name="repository" value="/dynamusic/SongsRepository" />
	<dsp:oparam name="output">
		<li>
			<font face="Verdana,Geneva,Arial"><font size=-1>
				<dsp:a href="artistDetails.jsp"><dsp:param name="itemId" param="element.id" /><dsp:valueof param="element.name"/></dsp:a>
			</font></font>
		</li>
	</dsp:oparam>
</dsp:droplet>
</ol>


          <!-- *** End content *** -->
          
          </font>
        </td>
    </table>
  </BODY>
</HTML>
</dsp:page>

