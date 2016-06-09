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
		  $('#sel_all').removeAttr("checked");
	  }
	  else
	  {
	  	$('#sel_all').attr("checked","checked");
	  }

    });
	
	$(document.body).on('change', '#sel_all' ,function(){
		if($('#sel_all').attr('checked'))
		{
			$('.sel_posts:checkbox').attr('checked','checked')
		}
		else
		{
			$('.sel_posts:checkbox').removeAttr('checked')
		}
		
	});
	
	
	
  });
	
</script>
<style type="text/css">
.report_sum{padding: 5px 0;}
</style>
</head>
<body class="loading" onload="loadclientdashboardposts('1')">
<div class="mid_wrapper">
  <div class="container">
  	<div id="positions_info">
		  	<div style="padding-bottom: 0" class="rightside_in new_table">
		  		<%-- <sec:authorize access="hasRole('ROLE_EMP_MANAGER')">
			        <div class="bottom-padding" style=" border: 2px solid gray; border-radius: 5px; margin-bottom: 10px;  padding: 10px;">
				        <div class="bottom-padding">
				        	
				        	<div class="col-md-4 report_sum" >
					        	<div class="col-md-9">
					        		Active Positions
					        	</div>
					        	<div class="col-md-3">
					        		${totalActive}
					        	</div>
				        	</div>
				        	<div class="col-md-4 report_sum" >
					        	<div class="col-md-9">
					        		InActive Positions
					        	</div>
					        	<div class="col-md-3">
					        		${totalposts - totalActive}
					        	</div>
				        	</div>
				        	<div class="col-md-4 report_sum" >
					        	<div class="col-md-9">
					        		No of Profile Recieved
					        	</div>
					        	<div class="col-md-3">
					        		${totalprofiles }
					        	</div>
				        	</div>
				        	<div class="col-md-4 report_sum" >
					        	<div class="col-md-9">
					        		No of Profile Shortlisted
					        	</div>
					        	<div class="col-md-3">
					        		${totalshortlist }
					        	</div>
				        	</div>
				        	<div class="col-md-4 report_sum" >
					        	<div class="col-md-9">
					        		No of Candidate Joined
					        	</div>
					        	<div class="col-md-3">
					        		${totaljoin }
					        	</div>
				        	</div>
				        	<div class="col-md-4 report_sum" >
					        	<div class="col-md-9">
					        		No of Partners
					        	</div>
					        	<div class="col-md-3">
					        		${totalpartner }
					        	</div>
				        	</div>
				        	
				        </div>
			        </div>
			    </sec:authorize> --%>
		        <div class="block consulting">
		          <div style="    float: left;">
		            <select id="db_post_status">
		               <option value="all">All</option>
					   <option value="active">Active</option>
					   <option value="published">Submitted</option>
					   <option value="saved">Saved</option>
					   <option value="closed">Closed</option>
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
