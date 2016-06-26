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
	.report_sum{padding: 5px 0;}
</style>
<script type="text/javascript">
	function  loadconsdashboardposts(pn)
	{
		pleaseWait();
		var sortParam=$('#sortParam').val();
		if(typeof sortParam != 'undefined'){}
		else
			sortParam='published';
		var db_post_status = $('#cons_db_post_status').val();
		var db_sel_client = $('#cons_db_sel_client').val();
		var db_sel_loc = $('#cons_db_sel_loc').val();
		
		if(db_post_status == undefined)
		{
			db_post_status="";
		}
		if(db_sel_client == undefined)
		{
			db_sel_client="";
		}
		if(db_sel_loc == undefined)
		{
			db_sel_loc="";
		}
		
		
// 		alert("hello " + $('#cons_db_post_status').val());
		$.ajax({
			type : "GET",
			url : "consDashboardList",
			data : {'pn':pn,'db_post_status':db_post_status,'db_sel_client':db_sel_client,'db_sel_loc':db_sel_loc,'sortParam':sortParam},
			contentType : "application/json",
			success : function(data) {
//				alert(data);
				$('.cons_db_posts').html(data);
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
	$(document.body).on('change', '.sel_posts1' ,function(){
	  var val = [];
	  if($('.sel_posts:checkbox').length > $('.sel_posts:checkbox:checked').length)
	  {
		  $('#sel_all').removeAttr("checked");
	  }
	  else
	  {
	  	$('#sel_all').attr("checked","checked");
	  }

	  
        $(':checkbox:checked').each(function(i){
        val[i] = $(this).val();
      });
       // alert(val);
        alertify.confirm("Are you sure to close this post ?", function (e, str) {
			if (e) 
			{
				$.ajax({
					type : "GET",
					url : "consBulkClose",
					data : {'pids':val.toString()},
					contentType : "application/json",
					success : function(data) {
						var obj = jQuery.parseJSON(data);
						if(obj.status == "success")
						{
							alertify.success("Hi, posts closed successfully !");
							loadclientdashboardposts($('.page_nav .current_page').attr("id"));
						}
						
					},
					error: function (xhr, ajaxOptions, thrownError) {
						alert(xhr.status);
					}
				}) ;
			}
		 
		});
        
        
        
    });
	
	$(document.body).on('change', '#sel_all' ,function(){
// 		alert("test");
		if($('#sel_all').attr('checked'))
		{
// 			alert("checked");
			$('.sel_posts:checkbox').attr('checked','checked')
		}
		else
		{
			$('.sel_posts:checkbox').removeAttr('checked')
		}
		
	});
	
	
	
  });
</script>

</head>
<body class="loading" onload="loadconsdashboardposts('1')">
<div class="mid_wrapper">
  <div class="container">
  	<div id="positions_info">
		  	<div style="padding-bottom: 0" class="rightside_in new_table">
			  	<%-- <sec:authorize access="hasRole('ROLE_CON_MANAGER')">
			        <div class="bottom-padding" style=" border: 2px solid gray; border-radius: 5px; margin-bottom: 10px; padding: 10px;">
				        <div class="bottom-padding">
				        	
				        	<div class="col-md-4 report_sum">
					        	<div class="col-md-9">
					        		My Active Positions
					        	</div>
					        	<div class="col-md-3">
					        		${totalActive }
					        	</div>
				        	</div>
				        	<div class="col-md-4 report_sum">
					        	<div class="col-md-9">
					        		No of Profile Submitted
					        	</div>
					        	<div class="col-md-3">
					        		${totalprofiles }
					        	</div>
				        	</div>
				        	<div class="col-md-4 report_sum">
					        	<div class="col-md-9">
					        		No of Profile Shortlisted
					        	</div>
					        	<div class="col-md-3">
					        		${totalshortlist }
					        	</div>
				        	</div>
				        	
				        	<div class="col-md-4 report_sum">
					        	<div class="col-md-9">
					        		No of Candidate Joined
					        	</div>
					        	<div class="col-md-3">
					        		${totaljoin }
					        	</div>
				        	</div>
				        	<div class="col-md-4 report_sum">
					        	<div class="col-md-9">
					        		No of Clients
					        	</div>
					        	<div class="col-md-3">
					        		${totalpartner }
					        	</div>
				        	</div>
				        	
				        </div>
			        </div>
			    </sec:authorize> --%>
		       
		        <div class="block consulting" style="padding: 0 8px;">
		          <div  style="float: left;">
	<!-- 	          <input type="hidden" value="all" id="cons_db_post_status"/> -->
	<!-- 	          <input type="hidden" value="all" id="cons_db_post_status"/>  -->
		            <!-- <select id="cons_db_post_status">
		               <option value="all">All</option>
					   <option value="active">Active</option>
					   <option value="inactive">Inactive</option>
					</select> -->
		          </div>
		        <!--   <div class="sort_by" style="display: none;"> <span>Sort by</span>
			          <select id="sortParam" onchange="loadconsdashboardposts('1')">
			            <option value="published">Recent Posts</option>
			            <option value="location">Location(A-Z)</option>
			            <option value="title">Job Post(A-Z)</option>
			          </select>
			        </div> -->
		        </div>
		    </div>
	  	<div class="cons_db_posts" >
		    
	    </div>
   	</div>
    <div id="post_detail" style="padding: 25px 20px">
    </div>
  </div>
</div>
</body>
</html>
