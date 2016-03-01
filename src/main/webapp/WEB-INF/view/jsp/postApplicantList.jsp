<!DOCTYPE html>
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
              <div class="col-md-7"><span>Showing <%= cc %> of <%= totalCount %></span> </div>
              <div class="col-md-5">
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
            <table class="new_tabl">
              <tr>
                <th>Basic Information</th>
                <th>&nbsp;</th>
                <th>Status</th>
                <th>&nbsp;</th>
              </tr>
              <%
              	
              	if(ppList != null && !ppList.isEmpty())
              	{
              		for(PostProfile pp : ppList)
              		{
	              		%>
							<tr>
								<td>
									<h3><%=pp.getProfile().getName()%></h3>
									<p>
										+91 <%=pp.getProfile().getContact()%><br>
										<%= pp.getProfile().getCurrentRole() %>, <%= pp.getProfile().getCurrentOrganization() %><br>
										Salary: <%= pp.getProfile().getCurrentCTC() %>
									</p>
								</td>
								<td>
									<h3><%=pp.getProfile().getEmail()%></h3>
									<p>Relocation: <%= pp.getProfile().getWillingToRelocate() %></p>
									<p>Expectation: <%=pp.getProfile().getExpectedCTC() %></p>
									<p>NP: <%= pp.getProfile().getNoticePeriod() %></p>
									<h3><%= pp.getProfile().getRegistration().getConsultName() %></h3>
								</td>
								<td>
									<h3> <%=pp.getPost().getTitle() %></h3>
									<p><%= pp.getPost().getLocation() %></p>
									<p><%= pp.getPost().getExp_min() %> - <%= pp.getPost().getExp_max() %> Years </p>
									<p><%= pp.getPost().getCtc_min() %> - <%= pp.getPost().getCtc_max() %> Lacs</p>
									<p><%= DateFormats.ddMMMMyyyyathhmm.format(pp.getSubmitted()) %></p>
								</td>
								<td>
									<p>
										<a href="" class="btn search_btn">View Applicant</a>
									</p><br>
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
													<a  class="accept_profile"><img src="images/accept-icon.png" alt="img"></a> 
													<a  class="reject_profile"><img src="images/cancel.png" alt="img"></a>
												<%
											}
										%>
									</p>
								</td>
							</tr>
						<%
					}
				}
              	else
              	{
              		%><tr>
              			<td>
              				<h3>No Record is available</h3>
              			</td>
           				</tr>
              		<%
              	}
			%>
              
              
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
