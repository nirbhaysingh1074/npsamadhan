<!DOCTYPE html>
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
			List<CandidateProfile> profileList = (List)request.getAttribute("profileList");
			Set<Registration> consultants = new HashSet<Registration>();
			if(profileList != null && !profileList.isEmpty())
			{
				for(CandidateProfile pr : profileList)
				{
					consultants.add(pr.getRegistration());
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
            </div>
            <table width="100%" border="0" class="new_tabl">
              <tr>
                <th>Basic Information</th>
                <th>&nbsp;</th>
                <th>Status</th>
                <th>&nbsp;</th>
              </tr>
              <%
              	
              	if(profileList != null && !profileList.isEmpty())
              	{
              		for(CandidateProfile pr : profileList)
              		{
	              		%>
							<tr>
								<td>
									<h3><%=pr.getName()%></h3>
									<p>
										+91 <%=pr.getContact()%><br>
										<%= pr.getCurrentRole() %>, <%= pr.getCurrentOrganization() %><br>
										Salary: <%= pr.getCurrentCTC() %>
									</p>
								</td>
								<td>
									<h3><%=pr.getEmail()%></h3>
									<p>Relocation: <%= pr.getWillingToRelocate() %></p>
									<p>Expectation: <%=pr.getExpectedCTC() %></p>
									<p>NP: <%= pr.getNoticePeriod() %></p>
									<h3><%= pr.getRegistration().getConsultName() %></h3>
								</td>
								<td>Shortlist</td>
								<td>
									<p>
										<a href="" class="btn search_btn">View Applicant</a>
									</p><br>
									<p>
										<a href=""><img src="images/ic_14.png" alt="img"></a> 
										<a href=""><img src="images/ic_13.png" alt="img"></a>
									</p>
								</td>
							</tr>
						<%
					}
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
