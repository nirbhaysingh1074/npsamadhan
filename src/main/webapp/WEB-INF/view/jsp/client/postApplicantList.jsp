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
			int totalCount = Integer.parseInt(request.getAttribute("totalCount")+"");
			int pn=1;
			if(request.getParameter("pn")!=null)
			pn = Integer.parseInt(request.getParameter("pn"));
			Integer rpp =(Integer)request.getAttribute("rpp");
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

								<tr>
									<th align="left">Consultant</th>
									<th align="left">Name</th>
									<th align="left">Phone</th>
									<th align="left">Current Role</th>
									<th align="left">Organization</th>
									<th >Current Annual CTC (In Lacs)</th>
									<th >Notice Period (In Days)</th>
									<th align="left">Submitted</th>
									<th align="left">Status</th>
									<th style="width: 155px;" align="left">Action</th>
									<th></th>
								</tr>


								<%
									if (ppList != null && !ppList.isEmpty()) {
											for (PostProfile pp : ppList) {
												%>
								<tr class="proile_row" >
												
									<td><%=pp.getProfile().getRegistration().getConsultName() %></td>
									
									<td>
									<%if(pp.getViewStatus()!=null&&pp.getViewStatus()){
										 %>
									<a style="color: #1a0dab" href="clientapplicantinfo?ppid=<%=pp.getPpid()%>"><%=pp.getProfile().getName()%></a>
									<%}else{ %>
									<a href="clientapplicantinfo?ppid=<%=pp.getPpid()%>"><%=pp.getProfile().getName()%></a>
									
									<%} %>
									</td>
									<td><%=pp.getProfile().getContact()%></td>
									<td><%=pp.getProfile().getCurrentRole()%></td>
									<td><%=pp.getProfile().getCurrentOrganization()%></td>
									<td align="center"><%=pp.getProfile().getCurrentCTC()%></td>
									<td align="center"><%=pp.getProfile().getNoticePeriod()%></td>
									<td><%=DateFormats.ddMMMMyyyy.format(pp.getSubmitted())%></td>

									<%
										if (pp.getJoinDropDate() != null) {
									%>
									<td><span>Dropped</span></td>
									<td class="text-center" style="text-align: left;"><span>None Required</span></td>
									<%
										} else if (pp.getJoinDate() != null) {
									%>
									<td><span>Joined</span></td>
									<td class="text-center" style="text-align: left;"><span>None Required</span></td>
									<%
										} else if (pp.getOfferDropDate() != null) {
									%>
									<td><span>Offer Declined</span></td>
									<td class="text-center" style="text-align: left;"><span>None Required</span></td>
									<%
										} else if (pp.getOfferDate() != null) {
									%>
									<td><span>Offered</span></td>
									<td class="text-center" style="text-align: left;"><span>None Required</span></td>
									<%
										} else if (pp.getDeclinedDate() != null) {
									%>
									<td><span>Interview Reject</span></td>
									<td class="text-center" style="text-align: left;"><span>None Required</span></td>
									<%
										} else if (pp.getRecruited() != null) {
									%>
									<td><span>Offer Sent </span></td>
									<td class="text-center" style="text-align: left;">
										<p id="<%=pp.getPpid()%>" class="profile_status"
											data-view="table">
											<a  style="float: left;cursor: pointer;"  class="btn-offer-open "
												data-type="offer_accept" title="Click to accept offer"
												onclick="$('#postIdForAccept').val('<%=pp.getPpid()%>')">Offer
												Accept </a><span style="float: left;margin-right: 2px;margin-left: 2px;">|</span>
											<a  style="float: left;cursor: pointer;"  class="btn-open "
												data-type="offer_reject" title="Click to reject offer">Reject</a>
										</p>
									</td>
									<%
										}

													else if (pp.getRejected() != null) {
									%>
									<td><span>CV Rejected</span></td>
									<td class="text-center" style="text-align: left;"><span>None Required</span></td>
									<%
										} else if (pp.getAccepted() != null) {
									%>
									<td><span>ShortListed</span></td>
									<td class="text-center">
										<p id="<%=pp.getPpid()%>" class="profile_status"
											data-view="table">

											<a style="float: left;cursor: pointer;" class="recruit_profile "
												title="Click to offer">Send Offer</a><span style="float: left;margin-right: 2px;margin-left: 2px;">|</span>
											
											<a style="float: left;cursor: pointer;" class="btn-open "
												data-type="reject_recruit" title="Click to decline">Decline</a>

										</p>
									</td>
									<%
										} else {
									%>
									<td><span>Pending</span></td>
									<td class="text-center">
										<p id="<%=pp.getPpid()%>" class="profile_status"
											data-view="table">
											<a style="float: left;cursor: pointer;" class="accept_profile "
												title="Click to shortlist profile">Shortlist</a><span style="float: left;margin-right: 2px;margin-left: 2px;">|</span>
											
											<a style="float: left;cursor: pointer;"  class="btn-open "
												data-type="reject_profile" title="Click to reject profile">Reject</a>
										</p>
									</td>
									<%
										}
									%>

									<td><p style="width: 105px; border-radius: 2px;">
											<a
												style="line-height: 0.42857em; background: url(images/ic_12.png) no-repeat 3px 4px #f8b910; padding: 8px 18px 8px 18px;"
												class="btn search_btn" target="_blank"
												href="clientapplicantinfo?ppid=<%=pp.getPpid()%>">View
												Applicant</a>
										</p></td>
								</tr>

								<%
									}
										} else if (ppList.isEmpty()) {
								%>
								<tr align="left" class="bottom-margin" style="margin: 10px 0;">
									<td colspan="10" style="width: auto; font-weight: bold;">No
										candidate submitted for this role till now</td>
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
              	<%--  <%
        String sortParam=(String)request.getAttribute("sortParam");
        %>
        <script type="text/javascript">
        <%if(sortParam!=null){%>
        $("#sortParam").val('<%=sortParam%>');
        $("#sortParam option[value='<%=sortParam%>']").attr('selected','selected');
        <%}%>
        </script> --%>
            </div>
          
</body>
</html>
