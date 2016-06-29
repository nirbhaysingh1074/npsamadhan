<!DOCTYPE html>
<%@page import="com.unihyr.domain.Registration"%>
<%@page import="com.unihyr.constraints.DateFormats"%>
<%@page import="com.unihyr.domain.Post"%>
<%@page import="java.util.List"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
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
		pleaseWait();
		var db_post_status = $('#db_post_status').val();
		var sortParam=$('#sortParam').val();
		if(typeof sortParam != 'undefined'){}
		else
			sortParam='published';
// 		alert("hello " + db_post_status);
		$.ajax({
			type : "GET",
			url : "clientDashboardList",
			data : {'pn':pn,'db_post_status':db_post_status,'sortParam':sortParam},
			contentType : "application/json",
			success : function(data) {
//				alert(data);
				$('.client_db_posts').html(data);
			pleaseDontWait();
			},
			error: function (xhr, ajaxOptions, thrownError) {
		        alert(xhr.status);
		      }
	    }) ;
	}
</script>
<script type="text/javascript">
jQuery(document).ready(function() {
	$(document.body).on('change', '.sel_posts' ,function(){
	  var val = [];
	  if($('.sel_posts:checkbox').length > $('.sel_posts:checkbox:checked').length)
	  {
		  $('#sel_all').prop("checked",false);
	  }
	  else
	  {
	  	$('#sel_all').prop("checked",true);
	  }

    });
	
	$(document.body).on('change', '#sel_all' ,function(){
		if($("input[name='sel_all']").is(':checked'))
		{
			$('.sel_posts:checkbox').prop("checked",true);
		}
		else
		{
			$('.sel_posts:checkbox').prop("checked",false);
		}
		
	});
	
	
	
  });
	
</script>
<style type="text/css">
.report_sum{padding: 5px 0; background: #ededed;margin:10px;}
</style>
</head>
<body class="loading" onload="loadclientdashboardposts('1')">
<div class="mid_wrapper">
  <div class="container">
  	<div id="positions_info">
		  	<div style="padding-bottom: 0" class="rightside_in new_table">
		  		 <sec:authorize access="hasRole('ROLE_EMP_MANAGER')">
			        <div class="bottom-padding" >
				        <div class="bottom-padding">
				        	
				        	<div class="col-md-2 report_sum" >
					        	<div class="col-md-11">
					        		<img src="images/active.png"  width="20px">
					        		
					        		${totalActive} Active Positions
					        	</div>
					        	<div class="col-md-3">
					        	</div>
				        	</div>
				        	<div class="col-md-2 report_sum" >
					        	<div class="col-md-11">
					        	<img src="images/inactive.png" width="20px">
					        		${totalposts - totalActive} Inactive Positions
					        	</div>
					        	<div class="col-md-3">
					        		
					        	</div>
				        	</div>
				        	<div class="col-md-2 report_sum" >
					        	<div class="col-md-11">
					        	<img src="images/profiles.png" width="20px">
					        		${totalprofiles } Profiles Received
					        	</div>
					        	<div class="col-md-3">
					        		
					        	</div>
				        	</div>
				        	<div class="col-md-2 report_sum" >
					        	<div class="col-md-11">
					        		
					        		<img src="images/check-cloud.png"  width="20px">
					        		${totalposts} Published
					        	</div>
					        	<div class="col-md-3">
<%-- 					        		${totalshortlist } --%>
					        	</div>
				        	</div>
				        	<div class="col-md-2 report_sum" >
					        	<div class="col-md-11">
					        		<img src="images/check-cloud.png"  width="20px">
					        		${totaljoin } Candidate Joined
					        	</div>
					        	<div class="col-md-3">
<%-- 					        		${totaljoin } --%>
					        	</div>
				        	</div>
<!-- 				        	<div class="col-md-2 report_sum" > -->
<!-- 					        	<div class="col-md-10"> -->
<!-- 					        		<img src="images/check-cloud.png"  width="20px"> -->
<!-- 					        		No of Partners -->
<!-- 					        	</div> -->
<!-- 					        	<div class="col-md-3"> -->
<%-- 					        		${totalpartner } --%> 
<!-- 					        	</div> -->
<!-- 				        	</div> -->
				        	
				        </div>
			        </div>
			    </sec:authorize> 
		        <div class="block consulting">
		          <div style="    float: left;">
		            <select id="db_post_status">
		               <option value="all">All</option>
					   <option value="isActive" selected="selected">Active</option>
					   <option value="isNotActive" >Inactive</option>
					   <option value="pending">Pending Verification</option>
					   <option value="saved">Saved</option>
					   <option value="closeDate">Closed</option>
					</select>
		          </div>
		        <!--  <div  class="sort_by"> <span>Sort by</span>
	          <select id="sortParam" onchange="loadclientdashboardposts('1')">
	            <option value="published">Recent Posts</option>
	            <option value="location">Location(A-Z)</option>
	            <option value="title">Job Post(A-Z)</option>
	          </select>
	        </div> -->
	        <%
	        String sortParam=(String)request.getAttribute("sortParam");
	        %>
	        <script type="text/javascript">
		        <%if(sortParam!=null){%>
			        $("#sortParam").val('<%=sortParam%>');
			        $("#sortParam option[value='<%=sortParam%>']").attr('selected','selected');
		        <%}%>
	        </script>
		        </div>
		    </div>
	  	<div class="client_db_posts" >
		    
	    </div>
   	</div>
    <div id="post_detail" style="padding: 15px">
    </div>
  </div>
</div>
</body>
</html>
