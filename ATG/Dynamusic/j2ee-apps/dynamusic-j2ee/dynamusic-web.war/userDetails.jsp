
<dsp:page>

<%-- Required input param: itemId (id of the user to display --%>

<!-------------------------------------------------------------
 Dynamusic Site Mockup
 
 USER
 
 Shows a user's profile.

 ------------------------------------------------------------->

<HTML>
<HEAD>
	<TITLE>Dynamusic User Page</TITLE>
</HEAD>
<BODY>
<!-- (replace this entire table by dynamically including common/header.jsp) -->
<dsp:include page="common/header.jsp">
	<dsp:param name="pagename" value="User" />
</dsp:include>

<table width="700" cellpadding="8">
	<tr>
		<!-- Sidebar -->
		<td width="100" bgcolor="ghostwhite" valign="top"><dsp:include
			page="common/sidebar.jsp"></dsp:include></td>
		<!-- Page Body -->
		<td valign="top"><font face="Verdana,Geneva,Arial" size="-1">

		<!-- *** Start page content *** -->

		<table width="560">
			<tr>
				<td><dsp:droplet name="/atg/targeting/RepositoryLookup">
					<dsp:param name="id" param="itemId" />
					<dsp:param name="itemDescriptor" value="user" />
					<dsp:param bean="/atg/userprofiling/ProfileAdapterRepository" name="repository" />

					<dsp:oparam name="output">
						<dsp:droplet name="/atg/dynamo/droplet/Switch">
							<dsp:param name="value" param="element.shareProfile" />
							<dsp:oparam name="true">
								<table>
									<tr>
										<td>Name:</td>
										<td><b><dsp:valueof param="element.firstName" /><dsp:valueof param="element.lastName" /></b></td>
									</tr>
									<tr>
										<td>Email address:</td>
										<td><b><dsp:valueof param="element.email" /> </b></td>
									</tr>
									<tr>
										<td>Favorite genres</td>
										<td><dsp:droplet name="/atg/dynamo/droplet/ForEach">
											<dsp:param name="array" param="element.prefGenres" />
											<dsp:oparam name="outputStart">
												<b>
											</dsp:oparam>
											<dsp:oparam name="outputEnd">
												</b>
											</dsp:oparam>
											<dsp:oparam name="output">
												<li><dsp:valueof param="element" /><br>
											</dsp:oparam>
											<dsp:oparam name="empty">
												This user has not specified any interests.
											</dsp:oparam>
										</dsp:droplet></td>
									</tr>
									<tr>
									
									
									
										<td>User info</td>
										<td><b><dsp:valueof param="element.info" /></b></td>
									</tr>
									<tr>
										<td>Location</td>
										<td><b><dsp:valueof
											param="element.homeAddress.state" /></b></td>
									</tr>
									<tr>
										<td>Interests</td>
										<td>
1<dsp:valueof param="user" />
2<%@ taglib uri="/dspTaglib" prefix="dsp" %>
<%@ page import="atg.servlet.*" %>

<dsp:page>

<head>
<title>Title</title>
</head>

<body>

Content

</body>

</dsp:page><dsp:valueof param="itemId" />
				<dsp:droplet name="/atg/targeting/RepositoryLookup">
					<dsp:param name="id" param="itemId" />
					<dsp:param name="itemDescriptor" value="user" />
					<dsp:param bean="/atg/userprofiling/ProfileAdapterRepository" name="repository" />

					<dsp:oparam name="output">
						Interests<br>
						<dsp:valueof param="element.interests" />
						<dsp:droplet name="/atg/dynamo/droplet/ForEach">
							<dsp:param name="array" value="element.interests" />
							<dsp:oparam name="outputStart">
								<ul>
							</dsp:oparam>
							<dsp:oparam name="outputEnd">
								</ul>
							</dsp:oparam>
							<dsp:oparam name="output">
								<li>ololo
									<!--
										display interests
									-->
								</li>
							</dsp:oparam>
							<dsp:oparam name="empty">
								You don't have any interests.
							</dsp:oparam>
						</dsp:droplet>
						<a href="newInterests.jsp">Create new one interests?</a>
					</dsp:oparam>
				</dsp:droplet>

										</td>
									</tr>

								</table>
							</dsp:oparam>
							<dsp:oparam name="false">
								You are not authorized to view information on that user.
							</dsp:oparam>
						</dsp:droplet>

					</dsp:oparam>
					<dsp:oparam name="empty">
						No such user found.
					</dsp:oparam>

				</dsp:droplet></td>
			</tr>
		</table>

		<!-- *** End real content *** --> </font></td>
	</tr>
</table>
</BODY>
</HTML>
</dsp:page>
