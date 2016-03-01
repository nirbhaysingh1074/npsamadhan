<!DOCTYPE html>
<%@page import="com.unihyr.domain.PostProfile"%>
<%@page import="java.util.HashSet"%>
<%@page import="com.unihyr.constraints.GeneralConfig"%>
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
		long totalCount = (Long)request.getAttribute("totalCount");
       	List<Post> postList = (List)request.getAttribute("postList");
		int pn = (Integer) request.getAttribute("pn");
		int rpp = (Integer) request.getAttribute("rpp");
		int tp = 0;
		String cc = "";
		if(totalCount == 0)
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
      
	    <div class="positions_info ">
	      <div class="filter">
	        <div class="col-md-7"><span>Showing <%= cc %> of <%= totalCount %></span></div>
	         <div class="col-md-5">
                <ul class="page_nav unselectable">
                	<%
		          		if(pn > 1)
		          		{
		          			%>
					            <li><a onclick="loadclientdashboardposts('1')">First</a></li>
					            <li><a onclick="loadclientdashboardposts('<%= pn-1 %>')" ><i class="fa fa-fw fa-angle-double-left"></i></a></li>
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
			      				<li ><a onclick="loadclientdashboardposts('<%= pn+1 %>')"><i class="fa fa-fw fa-angle-double-right"></i></a></li>
					            <li><a onclick="loadclientdashboardposts('<%=tp %>')">Last</a></li>
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
	        <div class="">
		        <table class="table no-margin" style="border: 1px solid gray;">
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
	       				<%
	       					if(postList != null && !postList.isEmpty())
	       					{
	       						int count = (pn-1)*GeneralConfig.rpp + 1 ;
	       						
	       						for(Post post : postList)
	       						{
	       							Set<Integer> cons = new HashSet(); 
	       							Set<Long> shortListed = new HashSet(); 
	       							%>
						       			<tr>
						        			<td><%= count++ %></td>
<%-- 						        			<td><%= post.getPostId() %></td> --%>
						       				<td style="float: left;" class="pre_check">
						       					<a id="<%= post.getPostId() %>" class="view_post"><%= post.getTitle() %> </a>
					       					</td>
						       				<td><%= post.getLocation() %></td>
						       				<td><%= DateFormats.ddMMMMyyyy.format(post.getCreateDate()) %></td>
						       				<td>
							       				<%
							       					Iterator<PostProfile> it = post.getPostProfile().iterator();
							       					while(it.hasNext())
							       					{
							       						PostProfile pp  = it.next();
							       						cons.add(pp.getProfile().getRegistration().getLid());
							       						if(pp.getAccepted() != null)
							       						{
							       							shortListed.add(pp.getProfile().getProfileId());
							       						}
							       					}
							       					out.println(cons.size());
							       					
							       				%>
							       				
						       				</td>
						       				<td><%= post.getPostProfile().size() %></td>
						       				<td><%= shortListed.size() %></td>
						        		</tr>
	       							<%
	       						}
	       					}
	       				%>
	       				
		        	</tbody>
		        </table>
	        </div>
	        
	      </div>
	    </div>
      
   

</body>
</html>
