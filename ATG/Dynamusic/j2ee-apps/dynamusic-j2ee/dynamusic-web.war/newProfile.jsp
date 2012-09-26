
<dsp:page>
	<dsp:importbean bean="/atg/userprofiling/ProfileFormHandler" />

	<!-------------------------------------------------------------
  Dynamusic Site Mockup
  
  NEW PROFILE
  
  Allows creation of new user profile
  
  ------------------------------------------------------------->


<HTML>
<HEAD>
	<TITLE>Dynamusic Edit Profile</TITLE>
</HEAD>
<BODY>
	<dsp:include page="common/header.jsp">
		<dsp:param name="pagename" value="Register" />
	</dsp:include>
	<table width="700" cellpadding="8">
		<tr>
			<!-- Sidebar -->
			<td width="100" bgcolor="ghostwhite">
				<dsp:include page="common/sidebar.jsp"></dsp:include>
			</td>
			<!-- Page Body -->
			<td valign="top">
				<font face="Verdana,Geneva,Arial" size="-1">
					<!-- *** Start page content *** -->
					<dsp:form>

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

						<h3>Login information (required)</h3>
						<p>Login: <br /><dsp:input size="24" type="text" required="true" bean="ProfileFormHandler.value.login" /></p>
						
						<dsp:input type="hidden" bean="ProfileFormHandler.confirmPassword" value="true" />
						<p>Password:<br /><dsp:input size="24" type="password" required="true" bean="ProfileFormHandler.value.password" /></p>
						<p>Retype password to confirm:<br> <dsp:input size="24" type="password" required="true" bean="ProfileFormHandler.value.confirmPassword" /></p>
						<hr>
						<h3>Personal information (optional)</h3>
						<p>First name:<br /> <dsp:input size="24" type="text" bean="ProfileFormHandler.value.firstName" /></p>
						<p>Last name:<br /> <dsp:input size="24" type="text" bean="ProfileFormHandler.value.lastName" /></p>
						<p>State:<br /> <dsp:input size="2" type="text" bean="ProfileFormHandler.value.homeAddress.state" /></p>
						<p>Your favorite genres:</p>
						<ul>
							<li><dsp:input type="checkbox" value="pop" bean="ProfileFormHandler.value.prefGenres" /> Pop</li>
							<li><dsp:input type="checkbox" value="jazz" bean="ProfileFormHandler.value.prefGenres" />Jazz</li>
							<li><dsp:input type="checkbox" value="classical"  bean="ProfileFormHandler.value.prefGenres" />Classical</li>
							<li><dsp:input type="checkbox" value="blues" bean="ProfileFormHandler.value.prefGenres" />Blues</li>
							<li><dsp:input type="checkbox" value="country" bean="ProfileFormHandler.value.prefGenres" />Country</li>
						</ul>
						<p>Make your profile viewable by others?</p>
						<ul>
							<li><dsp:input type="radio" value="true" bean="ProfileFormHandler.value.shareProfile" />yes</li>
							<li><dsp:input type="radio" value="false" bean="ProfileFormHandler.value.shareProfile" />no</li>
						</ul>

						<p>Personal info:</p>
						<p><dsp:textarea bean="ProfileFormHandler.value.info" name="info" rows="5" cols="40"></dsp:textarea></p>

						<!-- defines the URL to go to on success (relative to 'action')-->
						<dsp:input bean="/atg/userprofiling/ProfileFormHandler.createSuccessURL" type="hidden" value="home.jsp" />
						<dsp:input bean="/atg/userprofiling/ProfileFormHandler.create" type="Submit" value="Register" />
						<dsp:input bean="/atg/userprofiling/ProfileFormHandler.cancelURL" type="hidden" value="home.jsp" />
						<dsp:input bean="/atg/userprofiling/ProfileFormHandler.cancel" type="Submit" value="Cancel" />
					</dsp:form>
				</font>
				<!-- *** End real content *** -->
			</td>
		</tr>
	</table>
</BODY>
</HTML>
</dsp:page>