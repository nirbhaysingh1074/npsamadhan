<!DOCTYPE html>
<%@page import="com.unihyr.domain.Registration"%>
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
		Registration sel_client = (Registration)request.getAttribute("selClient");
		List<Registration> clientList = (List<Registration>) request.getAttribute("clientList");
		Registration reg = (Registration)request.getSession().getAttribute("registration");
	
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
	        <div class="col-md-3">
	        	<select id="cons_db_sel_client" style="padding: 2px; border-radius:0;font-size: 14px">
	        		<option value="">All Clients</option>
	        		<%
						for (Registration client : clientList) 
						{
							if(sel_client != null && sel_client.getUserid().equals(client.getUserid()))
							{
								%>
									<option value="<%=client.getUserid()%>" selected="selected"><%=client.getOrganizationName()%></option>
								<%
							}
							else
							{
								%>
									<option value="<%=client.getUserid()%>"><%=client.getOrganizationName()%></option>
								<%
							}
						}
					%>
	        	</select>
	        </div>
	        <div class="col-md-4 pagi_summary"><span>Showing <%= cc %> of <%= totalCount %></span></div>
	         <div class="col-md-5	">
                <ul class="page_nav unselectable">
                	<%
		          		if(pn > 1)
		          		{
		          			%>
					            <li><a onclick="loadconsdashboardposts('1')">First</a></li>
					            <li><a onclick="loadconsdashboardposts('<%= pn-1 %>')" ><i class="fa fa-fw fa-angle-double-left"></i></a></li>
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
			      				<li ><a onclick="loadconsdashboardposts('<%= pn+1 %>')"><i class="fa fa-fw fa-angle-double-right"></i></a></li>
					            <li><a onclick="loadconsdashboardposts('<%=tp %>')">Last</a></li>
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
		       				<th align="left"><input id="sel_all" type="checkbox"></th>
		       				<th align="left">Status</th>
		       				<th align="left">Position</th>
		       				<th align="left">Client</th>
		       				<th align="left">Location</th>
		       				<th>Posted Date</th>
		       				<th>Submitted</th>
		       				<th>Shortlisted</th>
		       				<th>Action</th>
		       			</tr>
	       			</thead>
	       			<tbody>
	       				<%
	       					if(postList != null && !postList.isEmpty())
	       					{
	       						int count = (pn-1)*GeneralConfig.rpp + 1 ;
	       						
	       						for(Post post : postList)
	       						{
	       							
	       							%>
						       			<tr>
						        			<td><input class="sel_posts" type="checkbox" name="selector[]" value="<%=post.getPostId() %>"></td>
						        			<td><%
						        					if(post.isActive())
						        					{
						        						out.println("Active");
						        					}
						        					else
						        					{
						        						out.println("Inactive");
						        					}
												%>
											</td>
						       				<td>
						       					<%
						       						if(post.getPublished() != null && post.getDeleteDate() == null)
						       						{
						       							%>
									       					<a title="Click to view your positions" href="cons_your_positions?pid=<%= post.getPostId()%>" id="<%= post.getPostId() %>" class="view_post"><%= post.getTitle() %> </a>
						       							<%
						       						}
						       						else
						       						{
						       							%>
							       							<a><%= post.getTitle() %> </a>
						       							<%
						       						}
						       					%>
					       					</td>
					       					<td><%= post.getClient().getOrganizationName() %></td>
						       				<td><%= post.getLocation() %></td>
						       				<td align="center"><%= DateFormats.ddMMMMyyyy.format(post.getCreateDate()) %></td>
						       				<td align="center"  title="No of profiles uploaded.">
						       					<%
						       						Iterator<PostProfile> it = post.getPostProfile().iterator();
						       						int prsub = 0;
						       						int prshort = 0;
						       						
						       						while(it.hasNext())
						       						{
						       							PostProfile pr = it.next();
						       							if(pr.getProfile().getRegistration().getUserid().equals(reg.getUserid()))
						       							{
						       								prsub++;
						       							}
						       							if(pr.getProfile().getRegistration().getUserid().equals(reg.getUserid()) && pr.getAccepted() != null)
						       							{
						       								prshort++;
						       							}
						       							
						       						}
						       						out.println(prsub);
						       					%>
					       					</td>
					       					<td  align="center" title="No. of profiles shortlisted">
						       					<%= prshort %>
						       				</td>
						       				<td align="center" >
						       					<div class="pre_check" style="float: none;padding:0;">
							                		<a id="<%= post.getPostId() %>" class="view_post " title="Click to view post detail">
							                			<img width="30px" alt="View" src="images/view-icon.png">
						                			</a>
							                	</div>
						       				</td>
						       				
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
