<!DOCTYPE html>
<%@page import="com.unihyr.domain.Registration"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
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
	function  loadclientposts(pn)
	{
		var pid = $('#selected_post').val();
		
		var sel_con = $('#cons_list > li').hasClass("active");
		var conid = "";
		if(sel_con)
		{
			conid = $('#cons_list  .active').attr("id");
		}

		$.ajax({
			type : "GET",
			url : "postapplicantlist",
			data : {'pn':pn,'pid':pid,'conid':conid},
			contentType : "application/json",
			success : function(data) {
//				alert(data);
				$('#candidate_profiles').html(data);
			},
			error: function (xhr, ajaxOptions, thrownError) {
		        alert(xhr.status);
		      }
	    }) ;
	}
</script>
</head>
<body class="loading"  onload="loadclientposts('1')"  >
<%
	List<Registration> consList = (List)request.getAttribute("consList");
	
%>
<div class="mid_wrapper">
  <div class="container">
    <div class="new_post_info">
      <div class="left_side">
        <div class="left_menu">
          <h2>Hiring Partners</h2>
          <ul id="cons_list">
            <%
            	if(consList != null && !consList.isEmpty())
            	{
            		for(Registration con : consList)
            		{
            			%>
				            <li id="<%= con.getUserid()%>"><a><%= con.getConsultName() %></a></li>
            			<%		
            		}
            	}
            %>
          </ul>
        </div>
      </div>
      <div class="right_side">
        <div class="profiles_col">
          <h2 class="title"><span id="selected_postname">Profiles for All Posts</span></h2>
          <div class="rightside_in new_table" style="padding-bottom: 0">
            <div class="block consulting">
              <div class="pull-left selected_consultantname" >
                <h2>Profiles for All Hiring Partners</h2>
              </div>
              <div class="pull-right">
                <select id="selected_post" >
                  <option value="0">All</option>
                  <c:forEach var="item" items="${postsList}">
					   <option value="${item.postId}">${item.title}</option>
					</c:forEach>
                </select>
              </div>
            </div>
           </div>
          <div id="candidate_profiles" class="rightside_in new_table ">
            
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

</body>
</html>
