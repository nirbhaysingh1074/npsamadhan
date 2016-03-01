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
	function  loadconsdashboardposts(pn)
	{
		var db_post_status = $('#cons_db_post_status').val();
		
// 		alert("hello " + db_post_status);
		$.ajax({
			type : "GET",
			url : "consDashboardList",
			data : {'pn':pn,'db_post_status':db_post_status},
			contentType : "application/json",
			success : function(data) {
//				alert(data);
				$('.cons_db_posts').html(data);
			},
			error: function (xhr, ajaxOptions, thrownError) {
		        alert(xhr.status);
		      }
	    }) ;
	}
</script>

</head>
<body class="loading" onload="loadconsdashboardposts('1')">
<div class="mid_wrapper">
  <div class="container">
  	<div id="positions_info">
	  	<div style="padding-bottom: 0" class="rightside_in new_table">
	        <div class="bottom-padding">
	        	<div class="col-md-4">
	        		Total number of positions being worked upon
	        	</div>
	        	<div class="col-md-2">
	        		${totalProfiles}
	        	</div>
	        	
	        	<div class="col-md-4" style="text-align: center;">
	        		<%
	        			long totalProfiles = (Long)request.getAttribute("totalProfiles");
	        			long totalActive = (Long)request.getAttribute("totalActive");
	        			long active = 0;
	        			long inactive = 0;
	        			if(totalProfiles > 0)
	        			{
		        			active = (totalActive*100)/totalProfiles;
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
	        		Total number of profiles sent
	        	</div>
	        	<div class="col-md-2">
	        		${sendProfiles }
	        	</div>
	        	
	        </div>
	        <br><br>
	        <div class="block consulting">
	          <div class="">
	            <select id="cons_db_post_status">
	               <option value="all">All</option>
				   <option value="active">Active</option>
				   <option value="inactive">Inactive</option>
				</select>
	          </div>
	        </div>
	    </div>
	  	<div class="cons_db_posts" >
		    
	    </div>
   	</div>
    <div id="post_detail" style="padding-top: 25px">
    </div>
  </div>
</div>
</body>
</html>
