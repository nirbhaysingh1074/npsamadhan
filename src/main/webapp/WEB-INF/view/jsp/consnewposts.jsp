<!DOCTYPE html>
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
		$.ajax({
			type : "GET",
			url : "consnewpostslist",
			data : {'pn':pn},
			contentType : "application/json",
			success : function(data) {
//				alert(data);
				$('.positions_info').html(data);
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
    <div class="positions_info">
      
      
      
    </div>
  </div>
</div>

</body>
</html>
