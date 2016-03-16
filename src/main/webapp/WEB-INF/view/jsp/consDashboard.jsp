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
		var db_sel_client = $('#cons_db_sel_client').val();
// 		alert("hello " + db_sel_client);
		$.ajax({
			type : "GET",
			url : "consDashboardList",
			data : {'pn':pn,'db_post_status':db_post_status,'db_sel_client':db_sel_client},
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

	  
        $(':checkbox:checked').each(function(i){
        val[i] = $(this).val();
      });
        alert(val);
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
	function actionSelected()
	{
		var val = [];
		 $(':checkbox:checked').each(function(i){
	        val[i] = $(this).val();
	      });
	 
		
		 $.ajax({
				type : "GET",
				url : "bulkAction",
				data : {'pids':val.toString(),'abc':"1234567890"},
				contentType : "application/json",
				success : function(data) {
					alert(data);
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
    <div id="post_detail" style="padding: 25px 20px">
    </div>
  </div>
</div>
</body>
</html>
