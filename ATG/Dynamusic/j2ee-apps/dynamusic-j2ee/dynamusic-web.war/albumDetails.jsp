
<dsp:page>
<!-------------------------------------------------------------
  Dynamusic Site Mockup
  
  ALBUM DETAILS
  
  Description of an album and list of songs.
  
  ------------------------------------------------------------->
  

<HTML>
  <HEAD>
    <TITLE>Dynamusic Album</TITLE>
  </HEAD>
  <BODY>
	<dsp:include page="common/header.jsp">
		<dsp:param name="pagename" value="Album Details" />
	</dsp:include>
    <!-- (replace this entire table by dynamically including 
          common/header.html) -->
	<dsp:droplet name="/dynamusic/ArtistLookupDroplet">
		<dsp:param name="id" param="itemId"/>
		<dsp:oparam name="output">
			<dsp:include page="common/header.jsp">
				<dsp:param name="pagename" param="element.title"/>
			</dsp:include>
		</dsp:oparam>
	</dsp:droplet>
	<table width="700" cellpadding="8">
		<tr>
		<!-- Sidebar -->
		<td width="100" bgcolor="ghostwhite" valign="top">
		<!-- (replace contents of this table cell by dynamically including common/sidebar.html) -->
		<dsp:include page="common/sidebar.jsp"></dsp:include>
	</td>


<!-- Page Body -->

<td VALIGN=TOP>
<!-- *** Start page content *** -->
<dsp:droplet name="/dynamusic/AlbumLookupDroplet">
	<dsp:param name="id" param="itemId"/>
	<dsp:oparam name="output">
		<table CELLPADDING=10 >
			<tr>
				<td VALIGN=TOP>
					<img SRC="<dsp:valueof param="element.coverURL" />" NOSAVE height=119 width=120>
				</td>
				<td VALIGN=TOP>
					<font face="Geneva,Arial"><font size=-1>
						<dsp:valueof param="element.description" />
					</font></font>
				</td>
			</tr>
		</table>
	</dsp:oparam>
</dsp:droplet>
<ul>
	<dsp:droplet name="/atg/dynamo/droplet/RQLQueryForEach">
		<dsp:param name="queryRQL" value='id = :itemId' />
		<dsp:param name="itemDescriptor" value="album" />
		<dsp:param name="repository" value="/dynamusic/SongsRepository" />
		<dsp:oparam name="output">
			<dsp:droplet name="/atg/dynamo/droplet/ForEach">
				<dsp:param param="element.songList" name="array"/>
				<dsp:oparam name="outputStart">
					<ul>
				</dsp:oparam>
				<dsp:oparam name="outputEnd">
					</ul>
				</dsp:oparam>
				<dsp:oparam name="output">
					<li>
						<font face="Verdana,Geneva,Arial"><font size=-1>
							<dsp:a href="song.jsp"><dsp:param name="itemId" param="element.id" /><dsp:valueof param="element.title"/></dsp:a>
						</font></font>
					</li>
				</dsp:oparam>
				<dsp:oparam name="empty">
					No song's in this album.
				</dsp:oparam>
			</dsp:droplet>
		</dsp:oparam>
	</dsp:droplet>
</ul>
<!-- *** End real content *** --></td>
</tr>
</table>


  </BODY>
</HTML>
</dsp:page>