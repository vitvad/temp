<%@ taglib uri="/dspTaglib" prefix="dsp" %>
<dsp:page>
<dsp:importbean bean="/dynamusic/SongsManager"/>

<!-- requires parameter artistId, will try to delete all albums by that artist -->

<html>
<head>
  <title>SongsManager deleteAlbumsByArtist test</title>
</head>

<body bgcolor="#ffffff">
  <h1>SongsManager deleteAlbumsByArtist test</h1>

SongsManager.repository.repositoryName: <dsp:valueof bean="SongsManager.repository">unset</dsp:valueof><br>

Now attempting to delete albums<br>

  <dsp:droplet name="/atg/dynamo/droplet/IsEmpty">
    <dsp:param param="artistId" name="value"/>
    <dsp:oparam name="true">
You must set artistId to a value (append "?artistId=xxxx" to the URL and reload).  
  
    </dsp:oparam>
    <dsp:oparam name="false">
       Artist Id = <dsp:valueof param="artistId">unset</dsp:valueof><br>

<%! 

    dynamusic.SongsManager sm; 
%> <dsp:getvalueof id="sm" bean="SongsManager"
idtype="dynamusic.SongsManager">

   <dsp:getvalueof id="artistId" param="artistId" >
<%

    try {
      sm.deleteAlbumsByArtist(artistId.toString());
      out.println("Succeeded.<br>");
    }
    catch (Exception e) {
      out.println("Failed.  Exception occurred: " + e + "<br>");
    }
%>

   </dsp:getvalueof>
</dsp:getvalueof>

       Completed.<br>
    </dsp:oparam>
  </dsp:droplet>

</body>
</html>


</dsp:page>
