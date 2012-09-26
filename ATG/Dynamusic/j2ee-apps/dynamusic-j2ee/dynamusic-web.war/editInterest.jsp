
<dsp:importbean bean="/dynamusic/form/InterestFormHandler" />
<dsp:importbean bean="/atg/userprofiling/Profile" />
<dsp:page>
	<HTML>
	<HEAD>
	<TITLE>Dynamusic User Interest</TITLE>
	</HEAD>
	<BODY>
	<dsp:include page="common/header.jsp">
		<dsp:param name="pagename" value="Edit User Interest" />
	</dsp:include>

	<table width="700" cellpadding="8">
		<tr>
			<td width="100" bgcolor="ghostwhite" valign="top">
				<dsp:include page="common/sidebar.jsp" />
			</td>

			<td valign="top">
 				<dsp:setvalue bean="InterestFormHandler.repositoryId" paramvalue="intId" />
				<dsp:form action="editInterest.jsp">
					<dsp:input bean="InterestFormHandler.itemDescriptorName" type="hidden" value="interest" />
					<dsp:input bean="InterestFormHandler.repositoryId" type="hidden" paramvalue="intId" />
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
								<dsp:input type="text" size="30" required="true" bean="InterestFormHandler.name" beanvalue="InterestFormHandler.value.name" />
							</td>
						</tr>
						<tr>
							<td valign="middle" align="right">User Interest Rating</td>
							<td valign="middle">
								<dsp:input type="text" size="2" required="true" bean="InterestFormHandler.rating" beanvalue="InterestFormHandler.value.rating" />
							</td>
						</tr>
						<tr>
							<td></td>
							<td>
								<dsp:input type="hidden" bean="InterestFormHandler.userId" beanvalue="Profile.id" />
								<dsp:input type="hidden" bean="InterestFormHandler.errorURL" value="editInterest.jsp" />
								<dsp:input type="hidden" bean="InterestFormHandler.updateSuccessURL" value="updateProfile.jsp" />
								<dsp:input type="hidden" bean="InterestFormHandler.deleteSuccessURL" value="updateProfile.jsp" />
								<dsp:input type="submit" bean="InterestFormHandler.update" value="Save Changes" />
								<dsp:input type="submit" bean="InterestFormHandler.delete" value="Delete This Interest" />
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