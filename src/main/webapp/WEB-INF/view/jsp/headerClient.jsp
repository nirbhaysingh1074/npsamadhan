<!DOCTYPE html>
<%@page import="com.unihyr.domain.Registration"%>
<html dir="ltr" lang="en-US">
<head>
<%@ taglib uri="http://tiles.apache.org/tags-tiles-extras"
	prefix="tilesx"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Uni Hyr</title>
<link href="css/main.css" type="text/css" media="all" rel="stylesheet" />
<link href="css/media.css" type="text/css" media="all" rel="stylesheet" />
<link href="css/fonts.css" type="text/css" media="all" rel="stylesheet" />
<link href="css/font-awesome.css" type="text/css" media="all"rel="stylesheet" />
<link rel="stylesheet" href="css/alertify.core.css" />
<link rel="stylesheet" href="css/alertify.default.css" id="toggleCSS" />
	
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/jquery.IE.js"></script>
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/client_js.js"></script>
<script type="text/javascript" src="js/common_js.js"></script>
<script src="js/alertify.min.js"></script>
<link rel="stylesheet" href="css/model.popup.css" />


<script>
		function getLogOut(){
			if (XMLHttpRequest)
			{
				x=new XMLHttpRequest();
			}
			else
			{
				x=new ActiveXObject("Microsoft.XMLHTTP");
			}
		     x.onreadystatechange=function()
			{
		    	 if(x.readyState==4 && x.status==200)
					{
		    		 var res = x.responseText;
// 		    		 alert(res);
		    		 window.location.href="${pageContext.request.contextPath}/j_spring_security_logout";
		    		}
			}
			x.open("GET", "${pageContext.request.contextPath}/insertLogOut",true);
			x.send();
			return true;
		}
</script>
<script type="text/javascript">
jQuery(document).ready(function() {
	alertify.set({
		labels : {
			ok     : "OK",
			cancel : "Cancel"
		},
		delay : 5000,
		buttonReverse : false,
		buttonFocus   : "ok"
	});
});

</script>

</head>
<body class="loading" style="background-image: url('images/bg-image.png')">
<tilesx:useAttribute name="currentpage"/>




<header>
<%
	Registration reg = (Registration)request.getSession().getAttribute("registration");
	
%>
<div class="container">
   <div class="header">
      <div class="logo"> 
      	<a href="clientdashboard"><img src="images/logo.png" alt="Logo"></a> 
      </div>
      <div class="header_right">
        <div class="address_info">
	        <p>
	        	<%
	        		if(reg.getAdmin() != null)
	        		{
	        			%>
				        	<span><a href="clientaccount"><%= reg.getAdmin().getOrganizationName() %> </a></span>| 
	        			<%
	        		}
	        		else
	        		{
	        			%>
				        	<span><a href="clientaccount"><%= reg.getOrganizationName() %> </a></span>| 
	        			<%
	        		}
	        	%>
	        	<span>  <a>FAQ </a></span> | 
	        	<span style="color: red;cursor: pointer;" onclick="getLogOut()">Log out </span>
        	</p>
        </div>
		<div class="notification">
			<div class="noti-icon more_product">
				<div class="icon " >
					<img style="" src="images/reminder.png">
				</div>
			</div>
			<div class="user_noti_content arrow_box_1">
				<div class="noti_title">Messages</div>
				<div class="noti_inner ">
					<!-- <div class="noti_row" title="text message ">
						<span class="noti-cons">Uni Consultant</span> send a message on  
						<span class="post-title">post title</span>.
					</div> -->
					
				</div>
			</div>
		</div>
	</div>
    </div>
	  <nav class="nav">
	   		<a href="javascript:void(0);" onClick="$('.toggle_menu').slideToggle();" class="toggle-icon"></a>
	      <ul class="toggle_menu">
	        <li class="${currentpage == 'clientdashboard' ? 'active' : ''}"><a href="clientdashboard">Home</a></li>
	        <li class="${currentpage == 'yourpost' ? 'active' : ''}"><a href="clientaddpost">New Post</a></li>
	        <li class="${currentpage == 'clientapplicants' ? 'active' : ''}"><a href="clientpostapplicants">Manage Positions </a></li>
	        <li class="${currentpage == 'clientBillingDetails' ? 'active' : ''}"><a href="clientBillingDetails">Billing Details</a></li>
	        <li><a href="clientprofilecenter">Profiles Center</a></li>
	      </ul>
	  </nav>
</div>
</header>

</body>
</html>
