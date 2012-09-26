
<dsp:importbean bean="/atg/userprofiling/Profile"/>
<dsp:importbean bean="/atg/dynamo/droplet/Switch"/>

<dsp:page>


	<!-------------------------------------------------------------
  Dynamusic Site Mockup
  
  ARTISTS
  
  List of artists whose songs appear on this site.
  
  ------------------------------------------------------------->

<HTML>
	<HEAD>
		<TITLE>Dynamusic Interests</TITLE>
	</HEAD>
<BODY>
	<dsp:include page="common/header.jsp">
		<dsp:param name="pagename" value="Interest List" />
	</dsp:include>
	<table width="700" cellpadding="8">
		<tr>
			<!-- Sidebar -->
			<td width="100" bgcolor="ghostwhite" valign="top">
				<dsp:include page="common/sidebar.jsp"></dsp:include>
				<br/>
				<font face="Verdana,Geneva,Arial" size="-1" color="steelblue">
					<b><dsp:a href="interests/newInterest.jsp">Add Interest</dsp:a></b>
				</font>
			</td>
			<!-- Page Body -->

			<td VALIGN=TOP>
				<h3>Our user's interests</h3>
				<dsp:droplet name="/dynamusic/droplet/InterestView">
					<dsp:param name="sortBy" value="${sortBy}" />
					<dsp:param name="sortDirection" value="${sortDirection}" />
					<dsp:oparam name="output">
						<li style="clear:both;list-style:none;text-align:left;">
							<span style="float:left;"><dsp:valueof param="element.name" /></span>
							<span style="float:right;"><dsp:valueof param="element.rating" /></span>
						</li>
					</dsp:oparam>
					<dsp:oparam name="controll">
						<dsp:valueof param="controll" valueishtml="true" />
					</dsp:oparam>
					<dsp:oparam name="start">
						<ul>
					</dsp:oparam>
					<dsp:oparam name="end">
						</ul>
					</dsp:oparam>
				</dsp:droplet>
			</td>
		</tr>
	</table>
</BODY>
</HTML>
</dsp:page>

