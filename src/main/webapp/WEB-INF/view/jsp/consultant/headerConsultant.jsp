<!DOCTYPE html>

<%@page import="com.unihyr.domain.Registration"%>
<html dir="ltr" lang="en-US">
<head>
<%@ taglib uri="http://tiles.apache.org/tags-tiles-extras"
	prefix="tilesx"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Uni Hyr</title>
<link href="css/fonts.css" type="text/css" media="all" rel="stylesheet" />
	<link rel="stylesheet" href="css/fonts.css" media="screen"   />
<link href="css/main.css" type="text/css" media="all" rel="stylesheet" />
<link href="css/media.css" type="text/css" media="all" rel="stylesheet" />
<link href="css/font-awesome.css" type="text/css" media="all"rel="stylesheet" />
<link rel="stylesheet" href="css/alertify.core.css" />
<link rel="stylesheet" href="css/alertify.default.css" id="toggleCSS" />

<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/jquery.IE.js"></script>
<script type="text/javascript" src="js/consult_js.js"></script>
<script type="text/javascript" src="js/common_js.js"></script>
<link rel="stylesheet" href="css/model.popup.css" />


<script src="js/alertify.min.js"></script>

<script type="text/javascript">
jQuery(document).ready(function() {
	$.ajax({
		type : "GET",
		url : "consmessages",
		 async: false,
		data : {},
		contentType : "application/json",
		success : function(data) {
			var obj = jQuery.parseJSON(data);
			if(obj.mList.length > 0)
			{
				$('#messageCount').html(obj.mList.length);
			}
		},
		error: function (xhr, ajaxOptions, thrownError) {
	        alert(xhr.status);
	      }
	}) ;
	$.ajax({
		type : "GET",
		url : "getUserNotifications",
		data : {},
		contentType : "application/json",
		success : function(data) {
			var obj = jQuery.parseJSON(data);
			if(obj.mList.length > 0)
			{
				$('#notificationCount').html(obj.mList.length);
			}
		},
		error: function (xhr, ajaxOptions, thrownError) {
	        alert(xhr.status);
	      }
    }) ;
});

function getMessages(){
	pleaseWait();
	$('.notification .noti_inner').html("");
	$('.noti_title').html("Messages");
	$.ajax({
		type : "GET",
		url : "consmessages",
		async: false,
		data : {},
		contentType : "application/json",
		success : function(data) {
			var obj = jQuery.parseJSON(data);
			if(obj.mList.length > 0)
			{
				$('.notification .noti_inner').html("");
				$('.noti_title').html("Messages");
				$('#messageCount').html(obj.mList.length);
				$.each(obj.mList , function(i, val) {
				$('.notification .noti_inner').append("<a href='consapplicantinfo?ppid="+val.ppid+"'><div class='noti_row' title='"+val.message+"' postprofile='"+val.ppid+"'>" +
							"<span class='noti-cons'>"+val.cons+"</span> send a message on " +
							"<span class='post-title'>"+val.ptitle+"</span>.</div></a>");
				});
			}
			else
			{
				$('.notification .noti_inner').append("<p>No message available</p>");
			}
			pleaseDontWait();
		},
		error: function (xhr, ajaxOptions, thrownError) {
	        alert(xhr.status);
	      }
	}) ;
}

function getNotifications(){
	pleaseWait();
	$('.notification .noti_inner').html("");	
	$('.noti_title').html("Notifications");
	$.ajax({
		type : "GET",
		url : "getUserNotifications",
		data : {},
		contentType : "application/json",
		success : function(data) {
		var obj = jQuery.parseJSON(data);
		$('.notification .noti_inner').html("");	
		$('.noti_title').html("Notifications");
			if(obj.mList.length > 0)
			{
				$('#notificationCount').html(obj.mList.length);
				$.each(obj.mList , function(i, val) {
					$('.notification .noti_inner').append("<div class='noti_row'><p>"+val.notification+"</p></div>");
				});
			}
			else
			{
				$('.notification .noti_inner').append("<p>No notification available</p>");
			}
			pleaseDontWait();
		},
		error: function (xhr, ajaxOptions, thrownError) {
	        alert(xhr.status);
	      }
    }) ;
}
</script>

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
		    		 window.location.href="${pageContext.request.contextPath}/j_spring_security_logout";
		    		}
			}
			x.open("GET", "${pageContext.request.contextPath}/insertLogOut",true);
			x.send();
			return true;
		}
</script>
</head>
<body class="loading"  >
<tilesx:useAttribute name="currentpage" />
<%
Registration reg = (Registration)request.getSession().getAttribute("registration");
%>
<header>
    <div class="container">
		<div class="header">
	      <div class="logo">
	      	<a href="consdashboard"><img src="images/logo.png" alt="Logo"></a> 
	      </div>
	      <div class="header_right">
	        <div class="address_info">
	        	<p><span><a href="consultantaccount"><%= reg.getConsultName() %> </a></span>| <span>  <a>FAQ </a></span> | <span style="color: red;cursor: pointer;" onclick="getLogOut()">Log out </span></span ></p>
	        </div>
	        <div class="notification">
			<div class="noti-icon more_product" onclick="getMessages()">
				<div class="icon "  >
					<img  class="messageIcon"  src="images/mailbox.png">
					
					<span id="messageCount" class="messageCount" ></span>
				</div>
			</div>
			<div class="noti-icon more_product" onclick="getNotifications()">
				<div class="icon "  >
					<img style="" src="images/reminder.png">
					
					<span id="notificationCount" class="notificationCount" ></span>
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
				<a href="javascript:void(0);"
					onClick="$('.toggle_menu').slideToggle();" class="toggle-icon"></a>
				<ul class="toggle_menu">
					<li class="${currentpage == 'consdashboard' ? 'active' : ''}"><a href="consdashboard">Home</a></li>
					<li class="${currentpage == 'consnewposts' ? 'active' : ''}" class="active"><a href="consnewposts">Recently Posted</a></li>
					<li class="${currentpage == 'cons_your_positions' ? 'active' : ''}"><a href="cons_your_positions">Manage Positions</a></li>
				
				<sec:authorize access="hasRole('ROLE_CON_MANAGER')">
					<li class="${currentpage == 'consBillingDetails' ? 'active' : ''}"><a href="consBillingDetails">Billing Details</a></li>
					<li class="${currentpage == 'consprofilecenter' ? 'active' : ''}"><a href="consprofilecenter">Profiles Center</a></li>
				</sec:authorize>
				</ul>
		</nav>
	</div>
</header>

<%
if(reg.getFirstTime()!=null){
	
	if(!reg.getFirstTime()){

	System.out.println(reg.getFirstTime());
%>

<div class="firstTimeLoginPopup" style="border:1px solid #f8b910;">
				<div class="login-header" style="padding: 3px 3px 3px 2px;
line-height: 44px;
height: 30px;">
					
					<a href="javascript:void(0)"><span style="padding: 0px 16px;top: 22px;" class="close" title="Close" onclick="$('.bodyCover').css('display','none');$('.firstTimeLoginPopup').css('display','none');setFirstTimeFalse('<%=reg.getUserid() %>')"><img style="    height: 40px;" src="images/close.png" /></span></a>
				</div>
				<div class="login-wrap" style="padding: 10px;">
				
				Congratulations on signing up
			with UniHyr. Now you can access our partner network to fulfill your
			hiring mandates. Start by posting a new position from the Post a New
			Job tab. Our user interface is intuitive and easy to use. In case of
			any issues, please feel free to reach out to your Account Manager or
			our Help Desk</div>
			<div style="text-align: center;padding: 10px;" class="login-wrap">
			<h2 style="color: #f8b910;font-weight: bold;">HAPPY HIRING!</h2>
			<input style="margin-top: 15px;color: #fff;font-size: 14px;font-weight: bold;" type="button" value="Get started with UniHyr" class="profile_status_buttonGen" onclick="$('.bodyCover').css('display','none');$('.firstTimeLoginPopup').css('display','none');setFirstTimeFalse('<%=reg.getUserid() %>')"  /> 
			</div>
			</div>

<div class="bodyCover">

</div>


<%}} %>


</body>
</html>
