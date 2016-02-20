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
<c:redirect url="/clientaddpost" />
<%
	Registration registration = (Registration)request.getSession().getAttribute("registration");
	System.out.println("registration : " + registration);
	registration = null;
	%>
	<%
	if(registration == null)
	{
	}
	
%>
<div class="mid_wrapper">
  <div class="container">
    <div class="positions_info">
      
      
      
    </div>
  </div>
</div>

</body>
</html>
