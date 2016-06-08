<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<head>
	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	
	<title>UniHyr</title>
	
	<link rel="stylesheet" href="css/fonts.css" media="screen"   />
	<link rel="stylesheet" href="css/media.css" media="screen" />
    <link rel="stylesheet" href="css/style.css" media="screen" />
	<link rel="stylesheet" href="css/font-awesome.css" media="screen"   />
	<link href="css/main.css" type="text/css" media="all" rel="stylesheet" />
	<style type="text/css">
		input[type="text"], input[type="password"], input[type="tel"], input[type="search"], input[type="email"], textarea, select 
		{
			margin-top: 10px;
		}
	</style>
</head>
<body style="background: #EDEDED;">
	<section>
		<div class="container" style="background: inherit;">
			<div class="login-form"  style="max-width: 700px">
				<div class="login-header">
					<a href="index"><img alt="" src="images/logo.png"></a>
					<a href="home"><span class="close" title="Home Page">Home</span></a>
				</div>
				<div class="login-wrap bottom-padding">
						<%
							String regSuccess = (String) request.getParameter("regSuccess");
							if (regSuccess != null && regSuccess.equals("true"))
							{
								String org = (String) request.getParameter("orgName");
								%>
									<form class="form-box bottom-padding" method="POST" action="j_spring_security_check">
									<p style="font-weight: bold;">
										Thank You for showing interest in UniHyr. Our representative will get in touch with you within 24 business hours . For any other information, please write to register@unihyr.com
									</p>	
									</form>
									<sec:authorize access="hasRole('ROLE_ADMIN')">
										<a href="adminuserlist" class="btn" style="background-color: green;border: 1px solid gray; padding:5px 10px;color: #fff;">Back To Users List</a>
									</sec:authorize>
								<%
							}
						%>					
				</div>
			</div>
		</div>
	
	</section>


	











	<script src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/script.js"></script>
</body>
</html>