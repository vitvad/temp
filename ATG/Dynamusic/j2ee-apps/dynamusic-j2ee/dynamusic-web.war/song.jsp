<%@ taglib uri="/dspTaglib" prefix="dsp" %>
<dsp:page>
<dsp:importbean bean="/atg/userprofiling/Profile"/>

<%-- Required input param: itemId (id of the song to display --%>

<!-------------------------------------------------------------
  Dynamusic Site Mockup
  
  SONG
  
  Description of an individual song.
  
  ------------------------------------------------------------->
  

<HTML>
  <HEAD>
    <TITLE>Dynamusic Song</TITLE>
  </HEAD>
  <BODY>
  <dsp:droplet name="/dynamusic/SongLookupDroplet">
    <dsp:param name="id" param="itemId"/>
    <dsp:oparam name="output">

    <!-- (replace this entire table by dynamically including 
          common/header.html) -->
          <dsp:include page="common/header.jsp">
            <dsp:param name="pagename" param="element.title"/>
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
            
          <table cellpadding="10">
            <tr>
             <td valign="top" align="right"> Song: </td>
             <td valign="top">
               <font face="Courier New"><b> <dsp:valueof param="element.title"/> </b></font>
               &nbsp
               <font size=-2 face="Courier New"><a href="<dsp:valueof param="element.downloadURL"/>">Download</a></font>
             </td>
           </tr>
           <tr>
             <td valign="top" align="right"> Artist: </td>
             <td valign="top">
               <font face="Courier New"><b>
                 <dsp:a href="artistDetails.jsp">
                    <dsp:param name="itemId" param="element.artist.id"/>
                    <dsp:valueof param="element.artist.name"/>
                 </dsp:a> </b></font>
             </td>
           </tr>
           <tr>
            <td valign="top" align="right"> Album(s): </td>
             <td valign="top">
               <font face="Courier New"><b>
               <dsp:droplet name="/atg/dynamo/droplet/RQLQueryForEach">
                 <dsp:param name="queryRQL" value="songList INCLUDES :element"/>
                 <dsp:param name="repository" value="/dynamusic/SongsRepository"/>
                 <dsp:param name="itemDescriptor" value="album"/>
                 <dsp:oparam name="output">
                   <dsp:a href="albumDetails.jsp">
                     <dsp:param name="itemId" param="element.id"/>
                   <dsp:valueof param="element.title"/>
                   </dsp:a>
                 </dsp:oparam>
                 <dsp:oparam name="empty">
                   No albums found for this song.
                 </dsp:oparam>
               </dsp:droplet>
               </b></font>
             </td>
           </tr>
           <tr>
           	<td>Genre</td>
           	<td><dsp:valueof param="element.genre" /></td>
           </tr>
          </table>
          
          &nbsp;<p>
          <font face="Geneva,Arial" size="-1">
            <i>
            <dsp:valueof param="element.description"/>
            </i>
          </font>                 
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
