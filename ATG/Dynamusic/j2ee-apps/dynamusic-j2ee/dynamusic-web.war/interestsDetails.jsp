
<dsp:page>
<HTML>
<HEAD>
	<TITLE>Dynamusic Interests</TITLE>
</HEAD>
<BODY>
	<dsp:droplet name="/dynamusic/ArtistLookupDroplet">
		<dsp:param name="id" param="itemId" />
		<dsp:oparam name="output">
			<dsp:include page="common/header.jsp">
				<dsp:param name="pagename" param="element.name" />
			</dsp:include>
		</dsp:oparam>
	</dsp:droplet>

	<table width="700" cellpadding="8">
		<tr>
			<!-- Sidebar -->
			<td width="100" bgcolor="ghostwhite" valign="top"><dsp:include
					page="common/sidebar.jsp"></dsp:include> <br> <font
				face="Verdana,Geneva,Arial" size="-1" color="steelblue"> <b><dsp:a
							href="editArtist.jsp">
							<dsp:param name="artistId" param="itemId" />Edit Artist Info</dsp:a>
				</b>
			</font></td>


			<!-- Page Body -->

			<td VALIGN=TOP>
				<!-- *** Start page content *** --> <dsp:droplet
					name="/dynamusic/ArtistLookupDroplet">
					<dsp:param name="id" param="itemId" />
					<dsp:oparam name="output">
						<table CELLPADDING=10>
							<tr>
								<td VALIGN=TOP><img
									SRC='<dsp:valueof param="element.photoURL" />' NOSAVE></td>
								<td><font face="Geneva,Arial"><font size=-2><dsp:valueof
												param="element.description" />
									</font>
								</font></td>
							</tr>
						</table>
					</dsp:oparam>
				</dsp:droplet>
				<ul>

					<dsp:droplet name="/atg/dynamo/droplet/RQLQueryForEach">
						<dsp:param name="queryRQL"
							value='artist.id = :itemId ORDER BY name' />
						<dsp:param name="itemDescriptor" value="album" />
						<dsp:param name="repository" value="/dynamusic/SongsRepository" />
						<dsp:oparam name="output">
							<li><font face="Verdana,Geneva,Arial"><font size=-1>
										<dsp:a href="albumDetails.jsp">
											<dsp:param name="itemId" param="element.id" />
											<dsp:param name="dsource" value="artist-details" />
											<dsp:valueof param="element.title" />
										</dsp:a> </font>
							</font></li>
						</dsp:oparam>
					</dsp:droplet>
				</ul> <!-- *** End real content *** -->
			</td>
		</tr>
	</table>

</BODY>
	</HTML>
</dsp:page>