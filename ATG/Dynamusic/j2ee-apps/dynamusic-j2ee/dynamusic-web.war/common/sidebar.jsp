
<dsp:page>
	<dsp:importbean bean="/atg/userprofiling/Profile"/>

	<font face="Verdana,Geneva,Arial" size="-1" color="steelblue">
		<b>
			<li><a href="home.jsp">Home</a></li>
			<li><a href="artists.jsp">Artists</a></li>
			<li><a href="venues.jsp">Venues</a></li>
			<li><a href="search.jsp">Search</a></li>
			<li><a href="interests.jsp">Interests</a></li>

			<dsp:droplet name="/atg/dynamo/droplet/Switch">
				<dsp:param bean="Profile.transient" name="value"/>
				<dsp:oparam name="true">
				 	<li><a href="login.jsp">Log In</a></li>
				</dsp:oparam>
				<dsp:oparam name="false">
					<li><a href="updateProfile.jsp">Profile</a></li>
					<li><a href="logout.jsp">Log Out</a></li>
				</dsp:oparam>
			</dsp:droplet>
		</b>
	</font>
</dsp:page>

