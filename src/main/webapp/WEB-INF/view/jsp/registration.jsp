<!DOCTYPE html>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<head>
	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	
	<title>UniHyr</title>
	
	<link rel="stylesheet" href="css/media.css" media="screen" />
    <link rel="stylesheet" href="css/style.css" media="screen" />
	<link rel="stylesheet" href="css/font-awesome.css" media="screen"   />
	<link href="css/main.css" type="text/css" media="all" rel="stylesheet" />
	<link href="css/fonts.css" type="text/css" media="all" rel="stylesheet" />
	<style type="text/css">
		input[type="text"], input[type="password"], input[type="tel"], input[type="search"], input[type="email"], textarea, select 
		{
			margin-top: 10px;
		}
	</style>
	<script type="text/javascript" src="js/jquery.min.js"></script>
	<script type="text/javascript" src="js/client_js.js"></script>
</head>
<body style="background-image: url('images/bg-image.png')">
	<%
		String uidex = (String)request.getAttribute("uidex");
		String usermsg = ""; 
		if(uidex != null && uidex.equals("exist"))
		{
			usermsg = "user aleady registered !";
		}
	
	%>


	<section>
		<div class="container">
			<div class="reg-form">
				<form:form method="POST" action="clientregistration" commandName="regForm">
					<div class="reg-header">
						<a href="home"><img alt="" src="images/logo.png"></a>
						<h2 style="float: right;">Registration for Employer</h2>
					</div>
					<div class="login-wrap"></div>
					<div class="reg-wrap">
						<div style="padding-bottom: 10px;" class='clearfix'>
							<label>Organization Name</label>
							<form:input path="organizationName" required="required"/>
							<span class="error">&nbsp;<form:errors path="organizationName" /></span>
						</div>
					</div>
					<div class="reg-wrap">
						<div style="padding-bottom: 10px;" class='clearfix'>
							<label>Email id</label>
							<form:input path="userid" type="email"  required="required"/>
							<span class="error">&nbsp;<form:errors path="userid" /> <%= usermsg %></span>
						</div>
					</div>
					<div class="reg-wrap">
						<div style="padding-bottom: 10px;" class='clearfix'>
							<label>Password <img alt="" src="images/question-mark.png" width="11px" title="password must contain alphanumeric and one special symbol "></label>
							<form:password path="password"  required="required" title="password must contain alphanumeric and one special symbol "/>
							<span class="error">&nbsp;<form:errors path="password" /></span>
						</div>
					</div>
					<div class="reg-wrap">
						<div style="padding-bottom: 10px;" class='clearfix'>
							<label>Re-Password</label>
							<form:password path="repassword"  required="required" />
							<span class="error">&nbsp;<form:errors path="repassword" /></span>
						</div>
					</div>
					<div class="reg-wrap">
						<div style="padding-bottom: 10px;" class='clearfix'>
							<label>Revenues</label>
							<form:input path="revenue" cssClass="number_only" maxlength="10"  required="required"/>
							<span class="error">&nbsp;<form:errors path="revenue" /></span>
						</div>
					</div>
					<div class="reg-wrap">
						<div style="padding-bottom: 10px;" class='clearfix'>
							<label>Industry</label>
							<form:select path="industry.id" >
			            		<form:option value="0">Select Industry</form:option>
			            		<c:forEach var="item" items="${industryList}">
								   <form:option value="${item.id}">${item.industry }</form:option>
								</c:forEach>
			            	</form:select>
			            	<span class="error">&nbsp;<form:errors path="industry.id" /></span>
						</div>
					</div>
					<div class="reg-wrap">
						<div style="padding-bottom: 10px;" class='clearfix'>
							<label>No. of Peoples</label>
							<form:input path="noofpeoples" cssClass="number_only" maxlength="10"  required="required"/>
							<span class="error">&nbsp;<form:errors path="noofpeoples" /></span>
						</div>
					</div>
					<div class="reg-wrap">
						<div style="padding-bottom: 10px;" class='clearfix'>
							<label>Contact No.</label>
							<form:input path="contact" cssClass="number_only" maxlength="11" minlength="10"  required="required"/>
							<span class="error">&nbsp;<form:errors path="contact" /></span>
						</div>
					</div>
					<div class="reg-wrap">
						<div style="padding-bottom: 10px;" class='clearfix'>
							<label>Office Address</label>
							<form:input path="officeLocations" required="required"  />
							<span class="error">&nbsp;<form:errors path="officeLocations"  /></span>
						</div>
					</div>
					<div class="reg-wrap">
						<div style="padding-bottom: 10px;" class='clearfix'>
							<label>Head Office Address</label>
							<form:input path="hoAddress" />
							<span class="error">&nbsp;<form:errors path="hoAddress" /></span>
						</div>
					</div>
					
					<div class="login-footer bottom-padding clearfix">
						<div class="form_submt bottom-padding10" class='clearfix'>
					        <button type="submit" class=" btn-login btn yelo_btn">Sign up</button>
					    </div>
				        <a href="login"> Already have an account ?</a>
					</div>
				</form:form>
			</div>
		</div>
	
	</section>

<script src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/script.js"></script>
</body>
</html>