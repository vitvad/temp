
<dsp:importbean bean="/dynamusic/form/InterestFormHandler" />
<dsp:importbean bean="/atg/userprofiling/Profile" />
<dsp:page>

<HTML>
<HEAD>
	<TITLE>Dynamusic User Interests</TITLE>
</HEAD>
<BODY>
	<dsp:include page="common/header.jsp">
		<dsp:param name="pagename" value="New Interest" />
	</dsp:include>

	<table width="700" cellpadding="8">
		<tr>
			<td width="100" bgcolor="ghostwhite" valign="top">
				<dsp:include page="common/sidebar.jsp"></dsp:include>
			</td>
			<td valign="top">
				<dsp:form action="newInterests.jsp">
					<dsp:input bean="InterestFormHandler.repositoryId" type="hidden" paramvalue="userId" />
					<dsp:droplet name="/atg/dynamo/droplet/ErrorMessageForEach">
						<dsp:oparam name="output">
							<li><strong><dsp:valueof param="message" /></strong></li>
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
							<td valign="middle" align="right">User Interest Name</td>
							<td valign="middle">
								<dsp:input type="text" size="30" required="true" bean="InterestFormHandler.name" />
							</td>
						</tr>
						<tr>
							<td valign="middle" align="right">User Interest Rating</td>
							<td valign="middle">
								<dsp:input type="text" required="true" size="2" bean="InterestFormHandler.rating" />
							</td>
						</tr>
						<tr>
							<td></td>
							<td>
								<dsp:input type="hidden" bean="InterestFormHandler.userId" beanvalue="Profile.id" />
								<dsp:input type="hidden" bean="InterestFormHandler.createSuccessURL" value="updateProfile.jsp" />
								<dsp:input type="submit" bean="InterestFormHandler.create" value="Create user interest" />
							</td>
						</tr>
					</table>
				</dsp:form>
			</td>
		</tr>
	</table>
</BODY>
</HTML>
</dsp:page>