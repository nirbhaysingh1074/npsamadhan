<!DOCTYPE html>
<%@page import="com.unihyr.domain.Registration"%>
<%@page import="com.unihyr.constraints.DateFormats"%>
<%@page import="com.unihyr.domain.Post"%>
<%@page import="java.util.List"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html dir="ltr" lang="en-US">
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Uni Hyr</title>
<style type="text/css">
	.error{color: red;}
</style>
<script type="text/javascript">
	function  loadclientdashboardposts(pn)
	{
		var db_post_status = $('#db_post_status').val();
		
// 		alert("hello " + db_post_status);
		$.ajax({
			type : "GET",
			url : "clientDashboardList",
			data : {'pn':pn,'db_post_status':db_post_status},
			contentType : "application/json",
			success : function(data) {
//				alert(data);
				$('.client_db_posts').html(data);
			},
			error: function (xhr, ajaxOptions, thrownError) {
		        alert(xhr.status);
		      }
	    }) ;
	}
</script>


</head>
<body class="loading" onload="loadclientdashboardposts('1')">
<div class="mid_wrapper">
  <div class="container">
  	<div id="positions_info">
	  	<div style="padding-bottom: 0" class="rightside_in new_table">
	        <div class="bottom-padding">
	        	<div class="col-md-4">
	        		Total number of positions posted
	        	</div>
	        	<div class="col-md-2">
	        		${totalposts}
	        	</div>
	        	
	        	<div class="col-md-4" style="text-align: center;">
	        		<%
	        			long totalposts = (Long)request.getAttribute("totalposts");
	        			long totalActive = (Long)request.getAttribute("totalActive");
	        			long active = 0;
	        			long inactive = 0;
	        			if(totalposts > 0)
	        			{
		        			active = (totalActive*100)/totalposts;
		        			inactive = 100-active;
		        			if(active > 0)
		        			{
			        			%>
					        		<div style="float:left; width: <%= active%>%; background-color: green;"><%= active %> % </div>
					        	<%
		        			}
		        			if(inactive > 0)
		        			{
			        			%>
					        		<div style="float:left;width: <%= inactive%>%; background-color: red;"><%= inactive%> % </div>
			        			<%
		        			}
	        			}
	        			
	        		%>
	        		
	        	</div>
	        	<div style="clear: both;"></div>
	        	<div class="col-md-4">
	        		Total number of profiles received
	        	</div>
	        	<div class="col-md-2">
	        		${totalprofiles }
	        	</div>
	        	
	        </div>
	        <br><br>
	        <div class="block consulting">
	          <div class="">
	            <select id="db_post_status">
	               <option value="all">All</option>
				   <option value="active">Active</option>
				   <option value="inactive">Inactive</option>
<!-- 				   <option value="deleted">Deleted</option> -->
				</select>
	          </div>
	        </div>
	    </div>
	  	<div class="client_db_posts" >
		    
	    </div>
   	</div>
    <div id="post_detail" style="padding-top: 25px">
    </div>
  </div>
</div>
</body>
</html>
