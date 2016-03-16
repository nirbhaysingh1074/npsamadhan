<!DOCTYPE html>
<%@page import="com.unihyr.domain.Registration"%>
<%@page import="com.unihyr.domain.PostConsultant"%>
<%@page import="com.unihyr.domain.PostProfile"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.unihyr.domain.CandidateProfile"%>
<%@page import="java.util.Set"%>
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
	<%
		Registration reg = (Registration)request.getSession().getAttribute("registration");
		long totalCount = (Long)request.getAttribute("totalCount");
       	List<Post> postList = (List)request.getAttribute("postList");
		int pn = (Integer) request.getAttribute("pn");
		int rpp = (Integer) request.getAttribute("rpp");
		int tp = 0;
		String cc = "";
		if(totalCount  == 0)
		{
			cc = "0 - 0";
		}
		else if(totalCount % rpp == 0)
		{
			tp = (int)totalCount/rpp;
			cc = ((pn-1)*rpp)+1 + " - " + ((pn)*rpp);
		}
		else
		{
			tp = (int)(totalCount/rpp)+1;
			if((pn)*rpp < totalCount)
			{
				cc = ((pn-1)*rpp)+1 + " - " + ((pn)*rpp);
			}
			else
			{
				cc = ((pn-1)*rpp)+1 + " - " + totalCount;
			}
		}
		
	%>
      <div class="filter">
        <div class="col-md-7 pagi_summary"><span>Showing <%= cc %> of <%= totalCount %></span></div>
        <div class="col-md-5">
              <ul class="page_nav unselectable">
              	<%
          		if(pn > 1)
          		{
          			%>
			            <li><a onclick="consnewposts('1')">First</a></li>
			            <li><a onclick="consnewposts('<%= pn-1 %>')" ><i class="fa fa-fw fa-angle-double-left"></i></a></li>
          			<%
          		}
          		else
          		{
          			%>
			            <li class="disabled"><a>First</a></li>
			            <li class="disabled"><a><i class="fa fa-fw fa-angle-double-left"></i></a></li>
	      			<%
          		}
          		%>
		            <li class="active current_page"><a><%= pn %></a></li>
          		<%
	          	if(pn < tp)
	      		{
	      			%>
	      				<li ><a onclick="consnewposts('<%= pn+1 %>')"><i class="fa fa-fw fa-angle-double-right"></i></a></li>
			            <li><a onclick="consnewposts('<%=tp %>')">Last</a></li>
	      			<%
	      		}
	      		else
	      		{
	      			%>
	      				<li class="disabled"><a><i class="fa fa-fw fa-angle-double-right"></i></a></li>
			            <li class="disabled"><a>Last</a></li>
	      			<%
	      		}
	      	
          	%>
              
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
       				<%
		             	if(postList != null && !postList.isEmpty())
		             	{
		             		for(Post post : postList)
		             		{
		             			%>
		             				<tr>
		             					<td><strong><%= post.getJobCode() %> </strong></td>
		             					<td><%= DateFormats.ddMMMMyyyy.format(post.getPublished()) %></td>
		             					<td><%= post.getClient().getOrganizationName() %></td>
		             					<td><%= post.getTitle() %></td>
		             					<td><%= post.getLocation()%></td>
		             					<td><%= post.getCtc_min()%> to <%= post.getCtc_max()  %> Lacs </td>
		             					<td class="text-center">
		             						<div class="pre_check" style="float: none;padding: 0;">
						                		<a id="<%= post.getPostId() %>" class="view_post " title="Click to view post detail">
						                			<img width="35px" alt="View" src="images/view-icon.png">
					                			</a>
						                	</div>
		             					</td>
		             					<td class="text-center">
		             						<div class="pre_check" style="float: none;padding: 0;">
						                  		<%
						                  			Iterator<PostConsultant> it = post.getPostConsultants().iterator();
						                  			
						                  			PostConsultant pocl = null;
						                  			while(it.hasNext())
						                  			{
						                  				PostConsultant pc = it.next();
						                  				if(pc.getConsultant().getUserid().equals(reg.getUserid()))
						                  				{
						                  					pocl = pc;
						                  				}
						                  			}
						                  			
						                  			if(pocl != null)
						                  			{
						                  				%>
						                  					<a title="You show interest for this post" href="#" ><img src="images/int-icon.png" alt="interested"></a>
						                  				<%
						                  			}
						                  			else
						                  			{
						                  				%>
										                	<a title = "Are you interested ?" href="#" id="<%= post.getPostId()%>" class="post_interest"><img src="images/ic_4.png" alt="img"></a>
						                  				<%
						                  			}
						                  		%>
						                	</div>
						                	
<!-- 						                  	<div class="pre_check"> -->
<%-- 						                  		<a href="uploadprofile?pid=<%=post.getPostId() %>" class="btn yelo_btn">Submit</a> --%>
<!-- 						                  	</div> -->
		             					</td>
		             					
		             				</tr>
		             			<%
		             		}
		             	}
		             	
             			
           			%>
       			</tbody>
       		</table>
        
      </div>
      <div class="block tab_btm">
        <div class="pagination">
          <ul class="pagi">
          	<%
          		if(pn > 1)
          		{
          			%>
			            <li><a onclick="consnewposts('1')">First</a></li>
			            <li><a onclick="consnewposts('<%= pn-1 %>')" ><i class="fa fa-fw fa-angle-double-left"></i></a></li>
          			<%
          		}
          		else
          		{
          			%>
			            <li class="disabled"><a>First</a></li>
			            <li class="disabled"><a><i class="fa fa-fw fa-angle-double-left"></i></a></li>
	      			<%
          		}
          		%>
		            <li class="active current_page"><a><%= pn %></a></li>
          		<%
	          	if(pn < tp)
	      		{
	      			%>
	      				<li ><a onclick="consnewposts('<%= pn+1 %>')"><i class="fa fa-fw fa-angle-double-right"></i></a></li>
			            <li><a onclick="consnewposts('<%=tp %>')">Last</a></li>
	      			<%
	      		}
	      		else
	      		{
	      			%>
	      				<li class="disabled"><a><i class="fa fa-fw fa-angle-double-right"></i></a></li>
			            <li class="disabled"><a>Last</a></li>
	      			<%
	      		}
	      	
          	%>
          </ul>
        </div>
        <div class="sort_by"> <span>Sort by</span>
          <select>
            <option>Recent Posts</option>
          </select>
        </div>
      </div>
   

</body>
</html>
