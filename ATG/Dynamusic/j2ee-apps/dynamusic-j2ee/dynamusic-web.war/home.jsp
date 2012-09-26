<dsp:page>
<dsp:importbean bean="/atg/userprofiling/Profile"/>
<dsp:importbean bean="/dynamusic/FeaturedSongs"/>
<dsp:importbean bean="/dynamusic/Customer"/>
<dsp:importbean bean="/dynamusic/form/MyFormHandler"/>
<HTML>
<HEAD>
	<TITLE>Dynamusic Home</TITLE>
</HEAD>
<BODY>
	<!-- (replace this entire section by dynamically including common/header.jsp) -->
	<dsp:include page="common/header.jsp">
		<dsp:param name="pagename" value="Home Page"/>
	</dsp:include>

	<!-- (end header banner) -->
	<table width="700" cellpadding="8">
		<tr>
			<!-- Sidebar -->
			<td width="100" bgcolor="ghostwhite" valign="top">
				<!-- (replace contents of this table cell by dynamically including common/sidebar.html) -->
				<dsp:include page="common/sidebar.jsp"></dsp:include>
				<!-- end sidebar -->
			</td>

			<!-- Page Body -->
			<td valign="top">
				<font face="Verdana,Geneva,Arial" size="-1">
				<!-- *** Start page content *** -->
				<table width="560">
					<tr>
						<td>
							<dsp:droplet name="/atg/dynamo/droplet/Switch">
								<dsp:param bean="Profile.transient" name="value"/>
								<dsp:oparam name="true">
									Welcome to Dynamusic.  <a href="newProfile.jsp">Click here</a> to register or <a href="login.jsp">log in</a> . <p>
								</dsp:oparam>
								<dsp:oparam name="false">
									<p>Welcome, <b><dsp:valueof bean="Profile.firstName"/> <dsp:valueof bean="Profile.lastName"/></b><p>
								</dsp:oparam>
							</dsp:droplet>

							This week's featured songs are:

							<dsp:droplet name="/atg/dynamo/droplet/ForEach">
								<dsp:param bean="FeaturedSongs.songs" name="array"/>
								<dsp:oparam name="outputStart">
									<ul>
								</dsp:oparam>
								<dsp:oparam name="outputEnd">
									</ul>
								</dsp:oparam>
								<dsp:oparam name="output">
									<li><dsp:valueof param="element"/>
								
								</dsp:oparam>
								<dsp:oparam name="empty">
									No featured songs this week.
								</dsp:oparam>
							</dsp:droplet>



	<%-- Test Form Handler --%>
							<dsp:form action="home.jsp">
								<!-- Default form error handling support -->
								<dsp:droplet name="/atg/dynamo/droplet/ErrorMessageForEach">
									<dsp:oparam name="output">
										<strong><dsp:valueof param="message"/></strong><br>
									</dsp:oparam>
									<dsp:oparam name="outputStart">
										<li>
									</dsp:oparam>
									<dsp:oparam name="outputEnd">
										</li>
									</dsp:oparam>
								</dsp:droplet>

								<p>Name: <dsp:input type="text" bean="MyFormHandler.name" size="15" /></p>
								<p>Email: <input type="text" name="email" /></p>
								<dsp:input bean="MyFormHandler.successURL" type="hidden" value="home.jsp" required="true"/>
								<p>Submit: <dsp:input type="submit" value="Submit Button" bean="MyFormHandler.submit" /></p>
							</dsp:form>

	<%-- Test Value Output --%>
							<p>Customer name is: <dsp:valueof bean="Customer.name" /></p>

	<%-- Test Droplet --%>
							<dsp:droplet name="/dynamusic/droplet/OutCustomerInfo">
								<dsp:param bean="Customer" name="client"/>
								<dsp:oparam name="profile">
									<h1>Hello dear <dsp:valueof param="profile.name" /></h1>
								</dsp:oparam>
								<dsp:oparam name="date">
									<p>Current date is: <dsp:valueof param="date" /></p>
								</dsp:oparam>
								<dsp:param name="dformat" value="dd/MM/yyyy" />
								<dsp:oparam name="localParam">
									Trololo text is after date <dsp:valueof param="localParam" />
								</dsp:oparam>
							</dsp:droplet>

						</td>
						<td width="160" align="center">
	
							<dsp:getvalueof param="sortBy" var="sortBy" />
							<dsp:getvalueof param="sortDirection" var="sortDirection" />

							<c:choose>
								<c:when test="${sortDirection ne null}">
									<c:set var="sortDirection" value="${sortDirection}" />
								</c:when>
								<c:otherwise>
									<c:set var="sortDirection" value="asc" />
								</c:otherwise>
							</c:choose>
							<c:choose>
								<c:when test="${sortBy ne null}">
									<c:set var="sortBy" value="${sortBy}" />
								</c:when>
								<c:otherwise>
									<c:set var="sortBy" value="rating" />
								</c:otherwise>
							</c:choose>

							<h3>Our user's interests</h3>
							<form action="#">
								<select name="sortBy" onchange="this.form.submit();">
									<option value="rating" ${sortBy eq 'rating' ? 'selected="selected"' : ''}>Rating</option>
									<option value="name" ${sortBy eq "name" ? 'selected="selected"' : ''}>Name</option>
								</select>
								<select name="sortDirection" onchange="this.form.submit();">
									<option value="asc" ${sortDirection eq 'asc' ? 'selected="selected"' : ''}>Ascending</option>
									<option value="desc" ${sortDirection eq 'desc' ? 'selected="selected"' : ''}>Descending</option>
								</select>
							</form>
							<dsp:droplet name="/dynamusic/droplet/InterestView">
								<dsp:param name="sortBy" value="${sortBy}" />
								<dsp:param name="sortDirection" value="${sortDirection}" />
								<dsp:oparam name="output">
									<li style="clear:both;list-style:none;text-align:left;">
										<span style="float:left;"><dsp:valueof param="element.name" /></span>
										<span style="float:right;"><dsp:valueof param="element.rating" /></span>
									</li>
								</dsp:oparam>
								<dsp:oparam name="start">
									<ul>
								</dsp:oparam>
								<dsp:oparam name="end">
									</ul>
								</dsp:oparam>
							</dsp:droplet>
							<br/>
							<h3>Login Form</h3>
							<dsp:form action="login.jsp" method="post">
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
								Login name: 
								<dsp:input bean="/atg/userprofiling/ProfileFormHandler.value.login" name="login" size="24" type="text" /><br>
								Password: 
								<dsp:input bean="/atg/userprofiling/ProfileFormHandler.value.password" name="password" size="24" type="password" value="" /><br>
								<dsp:input bean="/atg/userprofiling/ProfileFormHandler.loginSuccessURL" type="hidden" value="updateProfile.jsp" />
								<dsp:input bean="/atg/userprofiling/ProfileFormHandler.login" type="Submit" value="Login" />
							</dsp:form>

							<dsp:droplet name="/atg/targeting/TargetingForEach">
								<dsp:param bean="/atg/registry/Slots/AlbumPromo" name="targeter" />
								<dsp:oparam name="output">Featured Album:<br />
									<dsp:a href="albumDetails.jsp">
										<dsp:param name="itemId" param="element.id" />
										<dsp:param name="dsource" value="albumpromo" />
										<img src="<dsp:valueof param='element.coverURL'/>" />
										<br>
										<b><dsp:valueof param='element.title' />
										</b> - <dsp:valueof param='element.artist.name' />
									</dsp:a>
								</dsp:oparam>
							</dsp:droplet>
						</td>
					</tr>
					<tr><td height="80">&nbsp;</td><td></td></tr>
					<tr>
						<td valign="top">
							Playing at a venue near you... <p>
							<ul>
							<li> 22 May 2004 - <a href="concertDetails.html">Eric Clapton at the House of Blues</a>
							<li> 9 June 2004 - <a href="concertDetails.html">Loreena McKennitt at Sanders Theater</a>
							<li> 14 June 2004 - <a href="concertDetails.html">Shania Twain at the Fleet Center</a>
							</ul>
						</td>
					</tr>
				</table>
				<!-- *** End real content *** -->
				</font>
			</td>
		</tr>
	</table>
</BODY>
</HTML>
</dsp:page>