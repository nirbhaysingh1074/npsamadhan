<!DOCTYPE html>
<%@page import="com.unihyr.domain.Industry"%>
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
	function  consnewposts(pn)
	{
// 		alert("hello");
		var sel_industry = $('#cons_db_sel_industry').val();
		$.ajax({
			type : "GET",
			url : "consnewpostslist",
			data : {'pn':pn,'sel_industry':sel_industry},
			contentType : "application/json",
			success : function(data) {
//				alert(data);
				$('.cons_new_posts').html(data);
			},
			error: function (xhr, ajaxOptions, thrownError) {
		        alert(xhr.status);
		      }
	    }) ;
	}
	
	
</script>

</head>
<body class="loading" onload="consnewposts('1')">

<div class="mid_wrapper">
  <div class="container">
	  	<div id="positions_info">
		  	<div>
				<div class="rightside_in new_table" style="padding-bottom: 0">
				  	<div class="block consulting">
				        <div class="">
							<select id="cons_db_sel_industry"  onchange="consnewposts('1')">
				        		<option value="0">All Industries</option>
				        		<c:forEach var="item" items="${indList}">
								   <option value="${item.id}"  >${item.industry}</option>
								</c:forEach>
				        	</select>
						</div>
				    </div>
			   </div>
		  </div>
	    <div  class="positions_info cons_new_posts">
	      <div class="filter">
	        
	        <div class="col-md-7 pagi_summary"><span>Showing 0 - 0 of 0</span></div>
	        <div class="col-md-5">
	              <ul class="page_nav unselectable">
			            <li class="disabled"><a>First</a></li>
			            <li class="disabled"><a><i class="fa fa-fw fa-angle-double-left"></i></a></li>
		            	<li class="active current_page"><a>1</a></li>
	      				<li class="disabled"><a><i class="fa fa-fw fa-angle-double-right"></i></a></li>
			            <li class="disabled"><a>Last</a></li>
	              </ul>
	            </div>
	      </div>
	      <div class="positions_tab">
	        	<table class="table no-margin" style="border: 1px solid gray;">
		        	<thead>
		        		<tr>
		       				<th align="left">Job Id</th>
		       				<th align="left">Posted Date</th>
		       				<th align="left">Org</th>
		       				<th align="left">Position</th>
		       				<th align="left">Location</th>
		       				<th align="left">Exp Range</th>
		       				<th>View JD</th>
		       				<th>Action</th>
		       			</tr>
	       			</thead>
	       			<tbody>
	       				
	       			</tbody>
	       		</table>
	        
	      </div>
	      <div class="block tab_btm">
	        <div class="pagination">
	          <ul class="pagi">
		            <li class="disabled"><a>First</a></li>
		            <li class="disabled"><a><i class="fa fa-fw fa-angle-double-left"></i></a></li>
	            	<li class="active current_page"><a>1</a></li>
	   				<li class="disabled"><a><i class="fa fa-fw fa-angle-double-right"></i></a></li>
		            <li class="disabled"><a>Last</a></li>
	          </ul>
	        </div>
	        <div class="sort_by"> <span>Sort by</span>
	          <select>
	            <option>Recent Posts</option>
	          </select>
	        </div>
	      </div>
	      
	      
	    </div>
    </div>
    <div id="post_detail"  style="padding: 25px 20px;">
	    
    </div>
  </div>
</div>

</body>
</html>
