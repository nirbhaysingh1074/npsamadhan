<%@page import="com.unihyr.domain.PostConsultant"%>
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
	List<PostConsultant> postConsList = (List)request.getAttribute("postConsList");
	System.out.println(postConsList);
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
    
  
    <%-- <sec:authorize access="hasRole('ROLE_CON_MANAGER')">
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
    </sec:authorize>  --%>
    <%} %>
	
	
				<div class="profiles_col">
					<div class="rightside_in new_table" id="positions_info" style="padding-right: 0px;">
						<div class="block consulting">
							<div class="pull-left">
								<%
								boolean quataExceed=false;
								if(request.getAttribute("quataExceed")!=null){
								quataExceed = (Boolean)request.getAttribute("quataExceed");
								}
								System.out.println(post+"dfgsd"+request.getAttribute("quataExceed"));
								
								%>
								<%-- <script type="text/javascript">
									alert('<%=quataExceed%>');
								</script> --%>
								<%
									if (postConsList != null && !postConsList.isEmpty()) {

										if (post.getCloseDate() != null) {
								%>
								<a style="padding: 5px 13px;" href="javascript:void(0)"
									class="btn file_btn btn_disabled"><strong>Post
										Closed</strong></a>
								<%
									} else {
											if (post.isActive()) {
												if (quataExceed) {
								%>
								<a style="padding: 5px 13px;" href="javascript:void(0)"
									class="btn file_btn btn_disabled"><strong>Upload
										New Profile</strong></a>
								<%
									} else {
										System.out.println("ggggggggggggggggggggggggggggggggggggg");
								%>
								<a style="padding: 5px 13px;" href="javascript:void(0)"
									class="btn file_btn upload_new_profile"><strong>Upload
										New Profile</strong></a>
								<%
									}
											} else {
												System.out.println("gggddgggggggggggggggggggfggggggggggggggg");
								%>
								<a style="padding: 5px 13px;" href="javascript:void(0)"
									class="btn file_btn btn_disabled"><strong>Upload
										New Profile</strong></a>
								<%
									}
										}
									} else {
										System.out.println("gggggggggggggffgggggggggfggggggggggggggg");
								%>
								<a style="padding: 5px 13px;" href="javascript:void(0)"
									class="btn file_btn btn_disabled"><strong>Upload
										New Profile</strong></a>
								<%
								}
								%>
							</div>
							<div id="view_jd" class="view_id pre_check" style="float: left;margin-left: -9px;">
			                 	<%
								if(postConsList != null && !postConsList.isEmpty())
								{
									%>
										<a target="_blank" href="consviewjd?pid=<%=post.getPostId() %>" id="" class="btn file_btn view_post"><strong>View JD</strong></a>
									<%
								}
								else
								{
									%>
										<a href="javascript:void(0)" id="" class="btn file_btn view_post btn_disabled"><strong>View JD</strong></a>
									<%
								}
								%>
			              
			                 </div>
			                  <%

							if(quataExceed){
			               %>
			                 <p style="font-size: 10px;"><i>
			                 
											You have already exhausted your weekly upload profile quota, please submit profile later.
							</i>
							</p> 
							<%} %>
							<div class="" style="float: left;width: 65%;color: red;margin-left: 7px;line-height: 26px;">
		                 	
		                 	<%if(post!=null&&post.getUpdateInfo()!=null){
		                 		%>
		                 <marquee width="100%"><%=post.getUpdateInfo() %></marquee>
		                 	<%} %>
			                 </div>
							
						</div>
						<div class="candidate_profiles_for_cons">
							
<!-- 							--------------------           inner data ---------------------- -->
							
							<%
								if(profileList != null)
								{
								%>
								
								<div class="filter">
									<div class="col-md-6 pagi_summary">
										<span>Showing <%=cc%> of <%=totalCount%></span>
									</div>
									<div class="col-md-6">
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
									
										<tr>
											<th align="left">Name</th>
											<th align="left">Phone</th>
											<th align="left">Current Role</th>
											<th align="left">Organization</th>
											<th >Current Annual CTC (In Lacs)</th>
											<th >Notice Period (In Days)</th>
											<th align="left">Submitted</th>
											<th align="left">Status</th>
											<th style="width: 120px;" align="left">Action</th>
											<th></th>
										</tr>
									
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
// 								      				System.out.println(">>>>>>>>>>>> hello "+ unviewed);
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
						<td align="center"><%=pp.getProfile().getCurrentCTC()%></td>
									<td align="center"><%=pp.getProfile().getNoticePeriod()%></td>
									<td><%=DateFormats.ddMMMMyyyy.format(pp.getSubmitted())%></td>
						
	                  							<%
	                  							System.out.println("asddddddddddddddddddddd"+pp.getPpid());
	                  							if(pp.getWithdrawDate()!=null){
	                  								%>
				                  					<td style="text-align: left;">
														<span>Withdrawn</span>
													</td>
															
														
							                  					<td class="text-center" style="text-align: left;">
																	<span>None Required</span>
																</td>
															<%
	                  							}else if(pp.getJoinDropDate() != null)
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
																	<span>None Required</span>
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
																	<span>None Required</span>
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
																	<span>None Required</span>
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
							                  					<td class="text-center">
																	<span>Post Inactive</span>
																</td>
																
															<%
														}
														else
														{
															%> 
																<td class="text-center" style="text-align: left;">
																	<p id="<%= pp.getPpid()%>" class="profile_status" data-view="table">
																		<a style="cursor: pointer;" class="join_accept" title="Click to accept offer" 	onclick="$('#postIdForAccept').val('<%=pp.getPpid()%>')" >Join</a> 
																		 | <a style="cursor:pointer;" class="btn-open" data-type="join_reject"  title="Click to reject offer" >Offer Drop</a>
																	</p>
																</td>
																<td class="text-center" style="text-align: left;">
																	<p id="<%= pp.getPpid()%>" class="profile_status" data-view="table">
																	<a style="cursor: pointer;" onclick="setCandidatureWithdraw('<%= pp.getPpid()%>')"  class="candidate_withdraw" title="Click to withdraw candidature" >Withdraw</a> 
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
																	<p id="<%= pp.getPpid()%>" class="profile_status" data-view="table">
																	<a style="cursor: pointer;" onclick="setCandidatureWithdraw('<%= pp.getPpid()%>')"  class="candidate_withdraw" title="Click to withdraw candidature" >Withdraw</a> 
																</p>
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
																<span>In Process</span>
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
																	<a style="cursor: pointer;" onclick="setCandidatureWithdraw('<%= pp.getPpid()%>')"  class="candidate_withdraw" title="Click to withdraw candidature" >Withdraw</a> 
																</p>
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
																	<p id="<%= pp.getPpid()%>" class="profile_status" data-view="table">
																	<a style="cursor: pointer;" onclick="setCandidatureWithdraw('<%= pp.getPpid()%>')"  class="candidate_withdraw" title="Click to withdraw candidature" >Withdraw</a> 
																</p>
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
														<td colspan="10" style="width: auto;">
															<strong>No candidate submitted for this post till now</strong> 
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
		            <option value="accepted">In Process</option>
		            <option value="rejected">Rejected</option>
		            <option value="pending">Pending</option>
<!-- 		            <option value="recruited">Recruited</option> -->
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
								
							<%
							
						}
					%>
					</div>
					
					<div class="candidate_profiles_def" <%if(profileList != null){%>style="display: none"<%}    %>>
							<div class="filter">
								<div class="col-md-7 pagi_summary">
									<span>Showing 0 - 0 of 0</span>
								</div>
								<div class="col-md-5">
					                <ul class="page_nav unselectable">
										<li class="disabled"><a>First</a></li>
										<li class="disabled"><a><i class="fa fa-fw fa-angle-double-left"></i></a></li>
										<li class="active current_page"><a>1</a></li>
										<li class="disabled"><a><i class="fa fa-fw fa-angle-double-right"></i></a></li>
										<li class="disabled"><a>Last</a></li>
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
											<th>Submitted</th>
											<th>Status</th>
										</tr>
									</thead>
									
								</table>
							<div class="block tab_btm">
								<div class="pagination">
									<ul>
										<li class="disabled"><a>First</a></li>
										<li class="disabled"><a><i class="fa fa-fw fa-angle-double-left"></i></a></li>
										<li class="active current_page"><a>1</a></li>
										<li class="disabled"><a><i class="fa fa-fw fa-angle-double-right"></i></a></li>
										<li class="disabled"><a>Last</a></li>
									</ul>
								</div>
								
	        
							</div>
						
							
							
<!-- 							--------------------           inner data ---------------------- -->
							
						</div>
						<!-- <div >
						<ul  >
						<li>Shortlisted : </li>
						<li>Offer Sent : </li>
						<li>Offer Accepted :</li>
						<li>Rejected : </li>
						<li>Joined :</li>
						<li>Dropped :</li>
						</ul>
						
						</div> -->
					</div>
					<div id="post_detail" style="padding: 25px 15px;"></div>
				</div>
				