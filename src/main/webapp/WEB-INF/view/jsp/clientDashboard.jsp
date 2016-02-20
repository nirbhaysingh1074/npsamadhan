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
</head>
<body class="loading">
<div class="mid_wrapper">
  <div class="container">
    <div class="positions_info">
      <div class="filter">
        <div class="col-md-7"><span>Showing </span></div>
        <div class="col-md-5">
<!--           <div class="set_col"><a href=""><img src="images/ic_1.png" alt="img"> <img src="images/ic_2.png" alt="img"></a></div> -->
          <ul class="page_nav">
            <li class="active"><a href="clientaddpost"> Add New Post</a></li>
          </ul>
        </div>
      </div>
      <div class="positions_tab">
        <div class="">
	        <table class="table no-margin">
	        	<thead>
	        		<tr>
	       				<th>Sno.</th>
	       				<th align="left">Position</th>
	       				<th>Location</th>
	       				<th>Posted Date</th>
	       				<th>No. of Partners</th>
	       				<th>Profiles Received</th>
	       				<th>Shortlisted</th>
	       			</tr>
       			</thead>
       			<tbody>
	       			<tr>
	        			<td>1</td>
	       				<td style="text-align: left;">AVP Operations XYZ</td>
	       				<td>Lucknow</td>
	       				<td>20 Jan 2016</td>
	       				<td>20</td>
	       				<td>50</td>
	       				<td>10</td>
	        		</tr>
	        	</tbody>
	        </table>
        </div>
        
      </div>
    </div>
  </div>
</div>
</body>
</html>
