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
			long totalCount = (Integer)request.getAttribute("totalCount");
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
		        		<tr>
		       				<th align="left">Name</th>
		       				<th align="left">Phone</th>
		       				<th align="left">Current Role</th>
		       				<th align="left">Organization</th>
		       				<th align="left">Curent Salary</th>
		       				<th align="left">Notice Period </th>
		       				<th align="left">Submitted</th>
		       				<th align="left">Status</th>
		       				<th style="width: 150px;">Action</th>
		       				<th ></th>
		       				
		       			</tr>
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
//                   				System.out.println(">>>>>>>>>>>> hello "+ unviewed);
	                  					
	                  			%>
	                  				<tr align="left">
	                  					<td>
	                  						<%= pp.getProfile().getName()%> 
	                  						<%-- <%
	                  							if(unviewed > 0)
	                  							{
	                  								%>
	                  									<span title="Unread Message"  style="padding: 0px 6px;background-color:pink; border-radius:10px;margin-right: 5px;color:#000"><%= unviewed %></span>
	                  								<%
	                  							}
	                  						%> --%>
                  						</td>
	                  					<td><%= pp.getProfile().getContact()%></td>
	                  					<td><%= pp.getProfile().getCurrentRole()%></td>
	                  					<td><%= pp.getProfile().getCurrentOrganization()%></td>
	                  					<td><%= pp.getProfile().getCurrentCTC()%></td>
	                  					<td><%= pp.getProfile().getNoticePeriod()%></td>
	                  					<td><%= DateFormats.ddMMMMyyyy.format(pp.getSubmitted())%></td>
	                  					
	                  							<%
													
													if(pp.getJoinDropDate() != null)
													{
														%>
						                  					<td>
																<span>Join Dropped</span>
															</td>
															
														<%
														if( !pp.getPost().isActive())
														{
															%>
							                  					<td class="text-center">
																	<span>Post Inactive</span>
																</td>
																
															<%
														}
														else
														{
															%>
							                  					
																<td class="text-center">
															<span>None Required</span>
																</td>
															<%
															
														}
													}
													else if(pp.getJoinDate() != null)
													{
														%>
															<td>
																<span>Joined</span>
															</td>
															
														<%
														if( !pp.getPost().isActive())
														{
															%>
							                  					<td class="text-center">
																	<span>Post Inactive</span>
																</td>
																
															<%
														}
														else
														{
															%>
							                  					
																<td class="text-center">
															<span>None Required</span>
																</td>
															<%
															
														}
													}
													else if(pp.getOfferDropDate() != null)
													{
														%>
															<td>
																<span>Offer Declined</span>
															</td>
															
														<%
														if( !pp.getPost().isActive())
														{
															%>
							                  					<td class="text-center">
																	<span>Post Inactive</span>
																</td>
																
															<%
														}
														else
														{
															%>
							                  					
																<td class="text-center">
															<span>None Required</span>
																</td>
															<%
															
														}
													}
													else if(pp.getOfferDate() != null)
													{
														%>
															<td>
																<span>Offered</span>
															</td>
															
														<%
														if( !pp.getPost().isActive())
														{
															%>
							                  					<td class="text-center">
																	<span>Post Inactive</span>
																</td>
																
															<%
														}
														else
														{
															%>
							                  					
																<td class="text-center">
															<span>None Required</span>
																</td>
															<%
															
														}
													}
													else if(pp.getDeclinedDate() != null)
													{
														%>
															<td>
																<span>Declined</span>
															</td>
															
														<%
														if( !pp.getPost().isActive())
														{
															%>
							                  					<td class="text-center">
																	<span>Post Inactive</span>
																</td>
																
															<%
														}
														else
														{
															%>
							                  					
																<td class="text-center">
															<span>None Required</span>
																</td>
															<%
															
														}
													}
													else if(pp.getRecruited() != null)
													{
														%>
															<td>
																<span>Offer   </span>
															</td>
															
														<%
														if( !pp.getPost().isActive())
														{
															%>
							                  					<td class="text-center">
																	<span>Post Inactive</span>
																</td>
																
															<%
														}
														else
														{
															%>
							                  					<td class="text-center">
																	<p id="<%= pp.getPpid()%>" class="profile_status" data-view="table">
																		<button class="btn-offer-open profile_status_button" data-type="offer_accept" title="Click to accept offer"  >Offer Accept</button>
																		<button class="btn-open profile_status_button" data-type="offer_reject" title="Click to reject offer">Reject</button>
																	</p>
																</td>
															<%
															
														}
													}
														
	                  							
													else if(pp.getRejected() != null)
													{
														%>
															<td>
																<span>CV Rejected</span>
															</td>
															
														<%
														if( !pp.getPost().isActive())
														{
															%>
							                  					<td class="text-center">
																	<span>Post Inactive</span>
																</td>
																
															<%
														}
														else
														{
															%>
							                  					
																<td class="text-center">
															<span>None Required</span>
																</td>
															<%
															
														}
														
													}
													else if(pp.getAccepted() != null)
													{
														%>
															<td>
																<span>ShortListed</span>
															</td>
														<%
														if( !pp.getPost().isActive())
														{
															%>
							                  					<td class="text-center">
																	<span>Post Inactive</span>
																</td>
																
															<%
														}
														else
														{
															%>
							                  					
																<td class="text-center">
																	<p id="<%= pp.getPpid()%>" class="profile_status" data-view="table">
																		
																		<button class="recruit_profile profile_status_button" title="Click to offer">Send Offer</button>
																		<button class="btn-open profile_status_button" data-type="reject_recruit" title="Click to decline">Decline</button>
																		
																	</p>
																</td>
															<%
															
														}
													}
													else
													{
														%>
															<td>
																<span>Pending</span>
															</td>
														<%
														if( !pp.getPost().isActive())
														{
															%>
							                  					<td class="text-center">
																	<span>Post Inactive</span>
																</td>
																
															<%
														}
														else
														{
															%>
																<td class="text-center">
																	<p id="<%= pp.getPpid()%>" class="profile_status" data-view="table">
																		<button class="accept_profile profile_status_button" title="Click to shortlist profile">Shortlist</button>
																		<button class="btn-open profile_status_button" data-type="reject_profile" title="Click to reject profile">Reject</button>
																	</p>
																</td>	
															<%
															
														}
													}
												%>
											
										<td>
											<p style="width: 105px; border-radius: 2px;">
												<a
													style="line-height: 0.42857em; background: url(images/ic_12.png) no-repeat 3px 4px #f8b910; padding: 8px 18px 8px 18px;"
													class="btn search_btn" target="_blank"
													href="clientapplicantinfo?ppid=<%=pp.getPpid()%>">View Applicant
												</a>
											</p>
										</td>
									</tr>
	                  				
	                  			<%
	                  			
	                  		}
	                  	}
	       				else if(ppList.isEmpty())
	       				{
	       					%>
	       						<tr align="left" class="bottom-margin" style="margin: 10px 0; ">
	       							<td colspan="10" style="width: auto;font-weight: bold;">No candidate submitted for this role till now</td>
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
              	  <div class="sort_by"> <span>Filter by</span>
		          <select id="sortParam"  onchange="loadclientposts('1')">
		            <option value="submitted">Submitted</option>
		            <option value="accepted">Shortlisted</option>
		            <option value="rejected">Rejected</option>
		            <option value="pending">Pending</option>
		            <option value="recruited">Recruited</option>
		          </select>
		        </div> <%
        String sortParam=(String)request.getAttribute("sortParam");
        %>
        <script type="text/javascript">
        <%if(sortParam!=null){%>
        $("#sortParam").val('<%=sortParam%>');
        $("#sortParam option[value='<%=sortParam%>']").attr('selected','selected');
        <%}%>
        </script>
            </div>
          
</body>
</html>
