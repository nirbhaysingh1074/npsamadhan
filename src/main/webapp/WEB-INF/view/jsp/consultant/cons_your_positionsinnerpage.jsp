<%@page import="java.util.Set"%>
<%@page import="java.util.HashSet"%>
<%@page import="com.unihyr.domain.Inbox"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.unihyr.constraints.DateFormats"%>
<%@page import="com.unihyr.domain.PostProfile"%>
<%@page import="com.unihyr.domain.Post"%>
<%@page import="com.unihyr.domain.Registration"%>
<%@page import="com.unihyr.domain.CandidateProfile"%>
<%@page import="java.util.List"%>
<%
	List<PostProfile> profileList = (List<PostProfile>) request.getAttribute("profileList");
	Post post=(Post)request.getAttribute("selectedPost");
	long totalCount = (Long) request.getAttribute("totalCount");
	int pn = (Integer) request.getAttribute("pn");
	int rpp = (Integer) request.getAttribute("rpp");
	int tp = 0;
	String cc = "";
	if (totalCount == 0) {
		cc = "0 - 0";
	} else if (totalCount % rpp == 0) {
		tp = (int) totalCount / rpp;
		cc = ((pn - 1) * rpp) + 1 + " - " + ((pn) * rpp);
	} else {
		tp = (int) (totalCount / rpp) + 1;
		if ((pn) * rpp < totalCount) {
			cc = ((pn - 1) * rpp) + 1 + " - " + ((pn) * rpp);
		} else {
			cc = ((pn - 1) * rpp) + 1 + " - " + totalCount;
		}
	}
%>
    <%if(post!=null) {
    
    	Set<Integer> cons = new HashSet(); 
		Set<Long> shortListed = new HashSet();
		Iterator<PostProfile> it = post.getPostProfile().iterator();
		int countRead=0;
		while(it.hasNext())
		{
			PostProfile pp = it.next();
			if(pp.getAccepted() != null)
			{
				shortListed.add(pp.getPpid());
			}
			if(pp.getViewStatus()==null||(!pp.getViewStatus())){
				countRead++;
			}
		}
    
    %>
    
    
    
    	 <sec:authorize access="hasRole('ROLE_CON_MANAGER')">
    <div style="padding-bottom: 0" class="rightside_in new_table">
        <div class="bottom-padding" style=" border: 2px solid gray; border-radius: 5px; margin-bottom: 10px;  padding: 10px;">
	        <div class="bottom-padding">
	        	
	        	<div class="col-md-4 report_sum" >
		        	<div class="col-md-5">
		        		Post ID
		        	</div>
		        	<div class="col-md-7">
		        		<%=post.getJobCode() %>
		        	</div>
	        	</div>
	        	<div class="col-md-4 report_sum" >
		        	<div class="col-md-5">
		        		Total Opening 
		        	</div>
		        	<div class="col-md-7">
		        		<%=post.getNoOfPosts() %>
		        	</div>
	        	</div>
	        	<div class="col-md-4 report_sum" >
		        	<div class="col-md-5">
		        		Total no of Shortlisted
		        	</div>
		        	<div class="col-md-7">
		        		<%=shortListed.size() %>
		        	</div>
	        	</div>
	        	<div class="col-md-4 report_sum" >
		        	<div class="col-md-5">
		        		Posted Date
		        	</div>
		        	<div class="col-md-7">
		        		<%=DateFormats.getTimeValue(post.getPublished()) %>
		        	</div>
	        	</div>
	        	<div class="col-md-4 report_sum" >
		        	<div class="col-md-5">
		        		Openings Left
		        	</div>
		        	<div class="col-md-7">
		        		<%=post.getNoOfPosts()-post.getNoOfPostsFilled() %>
		        	</div>
	        	</div>
	        	<div class="col-md-4 report_sum" >
		        	<div class="col-md-5">
		        		Unread Profiles
		        	</div>
		        	<div class="col-md-7">
		        		<%=countRead %>
		        	</div>
	        	</div>
	        	<div class="col-md-4 report_sum" >
		        	<div class="col-md-5">
		        		Location
		        	</div>
		        	<div class="col-md-7">
		        		<%=post.getLocation() %>
		        	</div>
	        	</div>
	        	<div class="col-md-4 report_sum" >
		        	<div class="col-md-5">
		        		Total Profile Recieved
		        	</div>
		        	<div class="col-md-7">
		        		<%=post.getPostProfile().size() %>
		        	</div>
	        	</div>
	        	<div class="col-md-4 report_sum" >
		        	<div class="col-md-5">
		        		No of Partners
		        	</div>
		        	<div class="col-md-7">
		        		${totalpartner }
		        	</div>
	        	</div>
	        	
	        </div>
        </div>
    </div>
    </sec:authorize> 
    <%} %>
	
	
<div class="filter">
	<div class="col-md-7 pagi_summary">
		<span>Showing <%=cc%> of <%=totalCount%></span>
	</div>
			<div class="col-md-5">
                <ul class="page_nav unselectable">
                	<%
		          		if(pn > 1)
		          		{
		          			%>
					            <li><a onclick="fillProfiles('1')">First</a></li>
					            <li><a onclick="fillProfiles('<%= pn-1 %>')" ><i class="fa fa-fw fa-angle-double-left"></i></a></li>
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
			      				<li ><a onclick="fillProfiles('<%= pn+1 %>')"><i class="fa fa-fw fa-angle-double-right"></i></a></li>
					            <li><a onclick="fillProfiles('<%=tp %>')">Last</a></li>
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
											<th align="left">Curent Salary (In Lacs)</th>
											<th align="left">Notice Period (In Days)</th>
											<th align="left">Submitted</th>
											<th align="left">Status</th>
											<th style="width: 120px;">Action</th>
											<th></th>
										</tr>
	</thead>
	<tbody>
		<%
			if (profileList != null && !profileList.isEmpty()) 
			{
				for (PostProfile pp : profileList) 
				{
					Iterator<Inbox> it = pp.getMessages().iterator();
          			int unviewed = 0;
          			while(it.hasNext())
          			{
          				Inbox msg = it.next();
              			if(msg.getConsultant()== null && !msg.isViewed())
              			{
              				unviewed++;
              			}
              			
          			}
//       				System.out.println(">>>>>>>>>>>> hello "+ unviewed);
          				
					
					%>
						<tr class="cons_proile_row">
						<td>
							
							<%=pp.getProfile().getName()%>
						<%-- 	<%
       							if(unviewed > 0)
       							{
       								%>
       									<span title="Unread Message" style="padding: 0px 6px;background-color:pink; border-radius:10px;margin-right: 5px;color:#000"><%= unviewed %></span>
       								<%
       							}
       						%> --%>
       						
       						</td>
						<td><%=pp.getProfile().getContact()%></td>
						<td><%=pp.getProfile().getCurrentRole()%></td>
						<td><%=pp.getProfile().getCurrentOrganization()%></td>
						<td><%=pp.getProfile().getCurrentCTC()%></td>
						<td><%=pp.getProfile().getNoticePeriod()%></td>
						<td><%=DateFormats.ddMMMMyyyy.format(pp.getSubmitted())%></td>
						
	                  							<%
													if(pp.getJoinDropDate() != null)
													{
														%>
						                  					<td style="text-align: left;">
																<span>Join Dropped</span>
															</td>
															
														<%
														if( !pp.getPost().isActive())
														{
															%>
							                  					<td class="text-center" style="text-align: left;">
																	<span>Post Inactive</span>
																</td>
																
															<%
														}
														else
														{
															%>
							                  					
																<td class="text-center" style="text-align: left;">
															<span>	none required</span>
																</td>
															<%
															
														}
													}
													else if(pp.getJoinDate() != null)
													{
														%>
															<td style="text-align: left;">
																<span>Joined</span>
															</td>
															
														<%
														if( !pp.getPost().isActive())
														{
															%>
							                  					<td class="text-center" style="text-align: left;">
																	<span>Post Inactive</span>
																</td>
																
															<%
														}
														else
														{
															%>
							                  					
																
																<td class="text-center" style="text-align: left;">
															<span>	none required</span>
																</td>
															<%
															
														}
													}
													else if(pp.getOfferDropDate() != null)
													{
														%>
															<td style="text-align: left;">
																<span>Offer Declined</span>
															</td>
															
														<%
														if( !pp.getPost().isActive())
														{
															%>
							                  					<td class="text-center" style="text-align: left;">
																	<span>Post Inactive</span>
																</td>
																
															<%
														}
														else
														{
															%>
							                  					
																<td class="text-center" style="text-align: left;">
															<span>	none required</span>
																</td>
															<%
															
														}
													}
													else if(pp.getOfferDate() != null)
													{
														%>
															<td style="text-align: left;">
																<span>Offered</span>
															</td>
														<%
														if( !pp.getPost().isActive())
														{
															%>
							                  					<td class="text-center" style="text-align: left;">
																	<span>Post Inactive</span>
																</td>
																
															<%
														}
														else
														{
															%>
																<td class="text-center" style="text-align: left;">
																	<p id="<%= pp.getPpid()%>" class="profile_status" data-view="table">
																		<a style="cursor: pointer;"  class="join_accept" title="Click to accept offer" >Join</a> 
																		<a style="cursor: pointer;" class="btn-open" data-type="join_reject"  title="Click to reject offer" >Offer Drop</a>
																	</p>
																</td>
															<%
															
														}
													}
													else if(pp.getDeclinedDate() != null)
													{
														%>
															<td style="text-align: left;">
																<span>Declined</span>
															</td>
															
														<%
														if( !pp.getPost().isActive())
														{
															%>
							                  					<td class="text-center" style="text-align: left;">
																	<span>Post Inactive</span>
																</td>
																
															<%
														}
														else
														{
															%>
							                  					
																
																<td class="text-center" style="text-align: left;">
															<span>	none required</span>
																</td>
															<%
															
														}
													}
													else if(pp.getRecruited() != null)
													{
														%>
															<td style="text-align: left;">
																<span>Offer</span>
															</td>
															
														<%
														if( !pp.getPost().isActive())
														{
															%>
							                  					<td class="text-center" style="text-align: left;">
																	<span>Post Inactive</span>
																</td>
																
															<%
														}
														else
														{
															%>
							                  					
																
																<td class="text-center" style="text-align: left;">
															<span>	none required</span>
																</td>
															<%
															
														}
													}
													
													else if(pp.getRejected() != null)
													{
														%>
															<td style="text-align: left;">
																<span>CV Rejected</span>
															</td>
															
														<%
														if( !pp.getPost().isActive())
														{
															%>
							                  					<td class="text-center" style="text-align: left;">
																	<span>Post Inactive</span>
																</td>
																
															<%
														}
														else
														{
															%>
							                  					
																
																<td class="text-center" style="text-align: left;">
															<span>	none required</span>
																</td>
															<%
															
														}
													}
													else if(pp.getAccepted() != null)
													{
														%>
															<td style="text-align: left;">
																<span>ShortListed</span>
															</td>
															
														<%
														if( !pp.getPost().isActive())
														{
															%>
							                  					<td class="text-center" style="text-align: left;">
																	<span>Post Inactive</span>
																</td>
																
															<%
														}
														else
														{
															%>
							                  					
																
																<td class="text-center" style="text-align: left;">
															<span>	none required</span>
																</td>
															<%
															
														}
													}
													else
													{
														%>
															<td style="text-align: left;">
																<span>Pending</span>
															</td>
																
														<%
														if( !pp.getPost().isActive())
														{
															%>
							                  					<td class="text-center" style="text-align: left;">
																	<span>Post Inactive</span>
																</td>
																
															<%
														}
														else
														{
															%>
							                  					
																
																<td class="text-center" style="text-align: left;">
															<span>	none required</span>
																</td>
															<%
															
														}
													}
												%>
						<td>
							<p style="width: 105px; border-radius: 2px;">
								<a style="line-height: 0.42857em; background: url(images/ic_12.png) no-repeat 3px 4px #f8b910; padding: 8px 18px 8px 18px;"
								class="btn search_btn"  target="_blank" href="consapplicantinfo?ppid=<%=pp.getPpid()%>">View
								Applicant</a>
							</p>
						</td>
					</tr>
			
					<%
				}
			}
			else
			{
				%>
					<tr>
						<td colspan="8" style="width: auto;">
							<strong>No candidate submitted for this  role till now</strong> 
						</td>
					</tr>
				<%
			}
		%>
	</tbody>
</table>
<div class="block tab_btm">
	<div class="pagination">
		<ul>
			<%
				if (pn > 1) {
			%>
			<li><a onclick="fillProfiles('1')">First</a></li>
			<li><a onclick="fillProfiles('<%=pn - 1%>')"><i
					class="fa fa-fw fa-angle-double-left"></i></a></li>
			<%
				} else {
			%>
			<li class="disabled"><a>First</a></li>
			<li class="disabled"><a><i
					class="fa fa-fw fa-angle-double-left"></i></a></li>
			<%
				}
			%>
			<li class="active current_page"><a><%=pn%></a></li>
			<%
				if (pn < tp) {
			%>
			<li><a onclick="fillProfiles('<%=pn + 1%>')"><i
					class="fa fa-fw fa-angle-double-right"></i></a></li>
			<li><a onclick="fillProfiles('<%=tp%>')">Last</a></li>
			<%
				} else {
			%>
			<li class="disabled"><a><i
					class="fa fa-fw fa-angle-double-right"></i></a></li>
			<li class="disabled"><a>Last</a></li>
			<%
				}
			%>
		</ul>
	</div>
	  <div class="sort_by"> <span>Filter by</span>
		          <select id="sortParam"  onchange="fillProfiles('1')">
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

