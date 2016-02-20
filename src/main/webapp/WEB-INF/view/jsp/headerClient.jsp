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
<link href="css/font-awesome.css" type="text/css" media="all"
	rel="stylesheet" />
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/jquery.IE.js"></script>
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/client_js.js"></script>
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
</head>
<body class="loading">
<tilesx:useAttribute name="currentpage"/>
<header>
<%
	Registration reg = (Registration)request.getSession().getAttribute("registration");
	if(reg == null)
	{
		%>
			<script type="text/javascript">
				window.location.href = "login"; 
			</script>
		<%
	}
%>
  <div class="header">
    <div class="container">
      <div class="logo"> <a href="clientdashboard"><img src="images/logo.png" alt="Logo"></a> 
      	<div class="last_login"><p>Last Login: May 20, 2015 at 09:39 AM</p></div>
      </div>
      
      <div class="header_right">
        <div class="brnad_logo">
        	<span>Welcome</span> 
        	<%
        		if(reg.getLogo() != null && reg.getLogo().length() > 0)
        		{
        			%>
			        	<img src="<%= reg.getLogo() %>" alt="">
        			<%
        		}
        	%>
       	</div>
        <div class="address_info">
<!--         	<p><span>Account Details:</span>  (Update Account Info)<br>DLF Phase V, <br>Gurgaon</p> -->
	        <p><span><a href="clientaccount"><%= reg.getOrganizationName() %> </a></span ></p>
	        <p><span>+91-<%= reg.getContact() %> </span></p>
	        <p><span style="color: red;cursor: pointer;" onclick="getLogOut()">Log out </span></p>
        </div>
<!--         <div class="contact_our"> -->
<!-- 	        <p>Key Contact Persons: </p> -->
<!--         </div> -->
      </div>
    </div>
  </div>
  <nav>
    <div class="container"> <a href="javascript:void(0);" onClick="$('.toggle_menu').slideToggle();" class="toggle-icon"></a>
      <ul class="toggle_menu">
        <li class="${currentpage == 'clientdashboard' ? 'active' : ''}"><a href="clientdashboard">Home</a></li>
        <li class="${currentpage == 'yourpost' ? 'active' : ''}"><a href="clientyourpost">New Post</a></li>
        <li class="${currentpage == 'clientapplicants' ? 'active' : ''}"><a href="clientpostapplicants">Your Posts </a></li>
        <li><a href="">BIlling Details</a></li>
        <li><a href="">Profiles Center</a></li>
      </ul>
    </div>
  </nav>
</header>

</body>
</html>
