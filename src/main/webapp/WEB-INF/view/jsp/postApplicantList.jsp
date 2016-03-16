<!DOCTYPE html>
<%@page import="com.unihyr.domain.Inbox"%>
<%@page import="com.unihyr.constraints.DateFormats"%>
<%@page import="com.unihyr.domain.PostProfile"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.unihyr.domain.Registration"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
<%@page import="com.unihyr.domain.CandidateProfile"%>
<%@page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html dir="ltr" lang="en-US">
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Uni Hyr</title>
</head>
<body class="loading">

			<%
			List<PostProfile> ppList = (List)request.getAttribute("ppList");
			Set<Registration> consultants = new HashSet<Registration>();
			if(ppList != null && !ppList.isEmpty())
			{
				for(PostProfile pp : ppList)
				{
					consultants.add(pp.getProfile().getRegistration());
				}
			}
			long totalCount = (Long)request.getAttribute("totalCount");
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
              <div class="col-md-6 pagi_summary"><span>Showing <%= cc %> of <%= totalCount %></span> </div>
              <div class="col-md-6">
                <ul class="page_nav unselectable">
                	<%
		          		if(pn > 1)
		          		{
		          			%>
					            <li><a onclick="loadclientposts('1')">First</a></li>
					            <li><a onclick="loadclientposts('<%= pn-1 %>')" ><i class="fa fa-fw fa-angle-double-left"></i></a></li>
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
			      				<li ><a onclick="loadclientposts('<%= pn+1 %>')"><i class="fa fa-fw fa-angle-double-right"></i></a></li>
					            <li><a onclick="loadclientposts('<%=tp %>')">Last</a></li>
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
            <table class="table no-margin" style="border: 1px solid gray;">
		        	<thead>
		        		<tr>
		       				<th align="left">Name</th>
		       				<th align="left">Phone</th>
		       				<th align="left">Current Role</th>
		       				<th align="left">Organization</th>
		       				<th align="left">Curent Salary</th>
		       				<th>Notice Period </th>
		       				<th>Submitted</th>
		       				<th>Status</th>
		       			</tr>
	       			</thead>
	       			<tbody>
	       				<%
	       				if(ppList != null && !ppList.isEmpty())
	                  	{
	       					
	                  		for(PostProfile pp : ppList)
	                  		{
	                  			
	                  			Iterator<Inbox> it = pp.getMessages().iterator();
	                  			int unviewed = 0;
	                  			while(it.hasNext())
	                  			{
	                  				Inbox msg = it.next();
		                  			if(msg.getClient()== null && !msg.isViewed())
		                  			{
		                  				unviewed++;
		                  			}
		                  			
	                  			}
                  				System.out.println(">>>>>>>>>>>> hello "+ unviewed);
	                  					
	                  			%>
	                  				<tr>
	                  					<td>
	                  						<%
	                  							if(unviewed > 0)
	                  							{
	                  								%>
	                  									<span style="padding: 0px 6px;background-color:pink; border-radius:10px;margin-right: 5px;color:#000"><%= unviewed %></span>
	                  								<%
	                  							}
	                  						%>
	                  						<a href="clientapplicantinfo?ppid=<%= pp.getPpid() %>" ><%= pp.getProfile().getName()%> </a>
                  						</td>
	                  					<td><%= pp.getProfile().getContact()%></td>
	                  					<td><%= pp.getProfile().getCurrentRole()%></td>
	                  					<td><%= pp.getProfile().getCurrentOrganization()%></td>
	                  					<td><%= pp.getProfile().getCurrentCTC()%></td>
	                  					<td><%= pp.getProfile().getNoticePeriod()%></td>
	                  					<td><%= DateFormats.ddMMMMyyyy.format(pp.getSubmitted())%></td>
	                  					<td align="center">
	                  						<p id="<%= pp.getPpid()%>" class="profile_status">
												<%
													if(pp.getAccepted() != null)
													{
														%>
															<h3>Accepted</h3>
														<%
													}
													else if(pp.getRejected() != null)
													{
														%>
															<h3>Rejected</h3>
														<%
													}
													else
													{
														%>
															<a  class="accept_profile"><img title="Click to accept profile" src="images/accept-icon.png" alt="Accept" style="width: 20px;"></a> 
															<a  class="reject_profile"><img title="Click to reject profile" src="images/cancel.png" alt="Reject" style="width: 20px;"></a>
														<%
													}
												%>
											</p>
	                  					</td>
	                  					
	                  				</tr>
	                  				
	                  			<%
	                  			
	                  		}
	                  	}
	       				%>
	       			</tbody>
       		</table>
            <div class="block tab_btm">
              <div class="pagination">
                <ul>
					<%
		          		if(pn > 1)
		          		{
		          			%>
					            <li><a onclick="loadclientposts('1')">First</a></li>
					            <li><a onclick="loadclientposts('<%= pn-1 %>')" ><i class="fa fa-fw fa-angle-double-left"></i></a></li>
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
			      				<li ><a onclick="loadclientposts('<%= pn+1 %>')"><i class="fa fa-fw fa-angle-double-right"></i></a></li>
					            <li><a onclick="loadclientposts('<%=tp %>')">Last</a></li>
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
              <div class="sort_by"> <span>Order by</span>
                <select>
                  <option>Recent</option>
                </select>
              </div>
            </div>
          
</body>
</html>
