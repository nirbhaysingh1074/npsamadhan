<%@page import="com.unihyr.domain.Inbox"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.unihyr.constraints.DateFormats"%>
<%@page import="com.unihyr.domain.PostProfile"%>
<%@page import="com.unihyr.domain.PostConsultant"%>
<%@page import="com.unihyr.domain.Post"%>
<%@page import="com.unihyr.domain.Registration"%>
<%@page import="com.unihyr.domain.CandidateProfile"%>
<%@page import="java.util.List"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<script src="js/model.popup.js"></script>
<script type="text/javascript">

function fillProfiles(pageNo) 
{
	var clientId = $('#selectionOfClient').val();
	
	var sel_con = $('#postsList > li').hasClass("active");
	var postId = "";
	var posttitle = "";
	

	var sortParam=$('#sortParam').val();
	if(typeof sortParam != 'undefined'){}
	else
		sortParam='published';
	
	if (sel_con) 
	{
		postId = $('#postsList  .active').attr("id");
		posttitle = $('#postsList  .active > a').text();
	}
	if(postId != "" && clientId != "")
	{
		$.ajax({
			type : "GET",
			url : "profilelistbyconsidclientid",
			data : {
				'clientId' : clientId,
				'postId' : postId,
				'pageNo':pageNo,'sortParam':sortParam
			},
			contentType : "application/json",
			success : function(data) {
				$('.candidate_profiles_for_cons').html(data);
				$('.candidate_profiles_def').hide();
			},
			error : function(xhr, ajaxOptions, thrownError) {
				alert(xhr.status);
			}
		});
	}
	
}

</script>
<script src="js/model.popup.js"></script>
<style type="text/css">
.report_sum{padding: 5px 0;}
</style>



<%
	List<Registration> clientList = (List<Registration>) request.getAttribute("clientList");
%>

<div class="mid_wrapper">
<%
Registration sel_client = (Registration)request.getAttribute("selClient");
List<PostConsultant> postConsList = (List)request.getAttribute("postConsList");
Post post=null;
%>
	<div class="container">
		
		<%-- <sec:authorize access="hasRole('ROLE_CON_MANAGER')">
			<div style="padding-bottom: 0" class="rightside_in new_table">
		        <div class="bottom-padding" style=" border: 2px solid gray; border-radius: 5px; margin-bottom: 10px; padding: 10px;">
			        <div class="bottom-padding">
			        	
			        	<div class="col-md-4 report_sum">
				        	<div class="col-md-9">
				        		My Active Positions
				        	</div>
				        	<div class="col-md-3">
				        		${totalActive }
				        	</div>
			        	</div>
			        	<div class="col-md-4 report_sum">
				        	<div class="col-md-9">
				        		No of Profile Submitted
				        	</div>
				        	<div class="col-md-3">
				        		${totalprofiles }
				        	</div>
			        	</div>
			        	<div class="col-md-4 report_sum">
				        	<div class="col-md-9">
				        		No of Profile Shortlisted
				        	</div>
				        	<div class="col-md-3">
				        		${totalshortlist }
				        	</div>
			        	</div>
			        	
			        	<div class="col-md-4 report_sum">
				        	<div class="col-md-9">
				        		No of Candidate Joined
				        	</div>
				        	<div class="col-md-3">
				        		${totaljoin }
				        	</div>
			        	</div>
			        	<div class="col-md-4 report_sum">
				        	<div class="col-md-9">
				        		No of Clients
				        	</div>
				        	<div class="col-md-3">
				        		${totalpartner }
				        	</div>
			        	</div>
			        	
			        </div>
		        </div>
	        </div>
	    </sec:authorize> --%>
		<div class="new_post_info">
			<div class="left_side">
				<div class="left_menu">
					<select id="selectionOfClient" >
						<option value="">Select Client</option>
						<%
							System.out.println(">>>>>>>>>>>>>>>>>>> : " + sel_client);
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
					<h2 style="background: #4e4e4e none repeat scroll 0 0; border-radius: 5px 5px 0 0;color: #fff;margin-top: 5px">Job Positions</h2>
					<div id='cons_leftside_postlist'>
						<%
							
							if(postConsList != null && !postConsList.isEmpty())
							{
								%>
									<ul id="postsList">
								<%
								long postSelected = (Long)request.getAttribute("postSelected");
								for(PostConsultant pc : postConsList)
								{
									if(postSelected == pc.getPost().getPostId())
									{
										post=pc.getPost();
										%>
											<li id="<%=pc.getPost().getPostId() %>" class="active" >
												<a title="Click to view your positions" href="cons_your_positions?pid=<%= pc.getPost().getPostId()%>" ><%=pc.getPost().getTitle()%></a>
											</li>
										<%
									}
									else
									{
										%>
											<li id="<%=pc.getPost().getPostId() %>" >
												<a title="Click to view your positions" href="cons_your_positions?pid=<%= pc.getPost().getPostId()%>" ><%=pc.getPost().getTitle()%></a>
											</li>
										<%
									}
									
								}
								%>
									</ul>
								<%
							}
						
						
						%>
					</div>
				</div>
			</div>
			<div class="right_side">
				<div class="profiles_col">
					<div class="rightside_in new_table" id="positions_info">
						<div class="block consulting">
							<div class="pull-left">
								<%
								
								
								if(postConsList != null && !postConsList.isEmpty())
								{
									
									if(post.getCloseDate()!=null)
								{
										%>
										<a style="padding: 5px 13px;"  href="javascript:void(0)" class="btn file_btn btn_disabled"><strong>Post Closed</strong></a>
									<%
								}else{
									if(post.isActive()){
									%>
										<a style="padding: 5px 13px;"  href="javascript:void(0)" class="btn file_btn upload_new_profile"><strong>Upload New Profile</strong></a>
									<%
								}else{
									%>
									<a style="padding: 5px 13px;"  href="javascript:void(0)" class="btn file_btn btn_disabled"><strong>Upload New Profile</strong></a>
								<%
								}}
								}
								else
								{
									%>
										<a style="padding: 5px 13px;"  href="javascript:void(0)" class="btn file_btn btn_disabled"><strong>Upload New Profile</strong></a>
									<%
									
								}
								%>
								
								
								
							</div>
							<div id="view_jd" class="view_id pre_check" style="float: none;margin-left: -9px;">
			                 	<%
								if(postConsList != null && !postConsList.isEmpty())
								{
									%>
										<a target="_blank" href="consviewjd?pid=${postSelected}" id="" class="btn file_btn view_post"><strong>View JD</strong></a>
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
							
						</div>
						<div class="candidate_profiles_for_cons">
							
<!-- 							--------------------           inner data ---------------------- -->
							
							<%
								List<PostProfile> profileList = (List<PostProfile>) request.getAttribute("profileList");
								if(profileList != null)
								{
								
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
											<th align="left">Curent Salary (In Lacs)</th>
											<th align="left">Notice Period (In Days)</th>
											<th align="left">Submitted</th>
											<th align="left">Status</th>
											<th style="width: 120px;">Action</th>
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
						<td><%=pp.getProfile().getCurrentCTC()%></td>
						<td><%=pp.getProfile().getNoticePeriod()%></td>
						<td><%=DateFormats.ddMMMMyyyy.format(pp.getSubmitted())%></td>
						
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
															<span>	none required</span>
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
															<span>	none required</span>
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
															<span>	none required</span>
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
																	<p id="<%= pp.getPpid()%>" class="profile_status" data-view="table">
																		<button  class="join_accept profile_status_button" title="Click to accept offer" >Join</button> 
																		<button class="btn-open profile_status_button" data-type="join_reject"  title="Click to reject offer" >Offer Drop</button>
																	</p>
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
															<span>	none required</span>
																</td>
															<%
															
														}
													}
													else if(pp.getRecruited() != null)
													{
														%>
															<td>
																<span>Offer</span>
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
															<span>	none required</span>
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
															<span>	none required</span>
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
															<span>	none required</span>
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
						<div ></div>
					</div>
					<div id="post_detail" style="padding: 25px 15px;"></div>
				</div>
			</div>
		</div>
	</div>
</div>
<div id="abcModal" class="modal">
  <!-- Modal content -->
  <div class="modal-content" style="width: 50%">
    <span class="close">x</span>
    <div>
	    <div class="modal-body">
	    </div>
    	<div  class="model-footer">
	    	<button class="btn btn-cancel">Cancel</button>
	    	<button class="btn btn-ok">Ok</button>
    	</div>
    </div>
  </div>

</div>
<div id="rejectModal" class="modal">
	
  <!-- Modal content -->
  <div class="modal-content" style="width: 50%">
    <span class="close">x</span>
    <div>
	    <div class="modal-body">
	    	<p>Please select the reason of rejection</p>
		    <select class="sel_rej_join" style="margin-top: 10px;">
		    	<option value="">Select Reason </option>
		    	<option value="Got better opportunity – salary">Got better opportunity - salary</option>
		    	<option value="Got better opportunity - location">Got better opportunity - location</option>
		    	<option value="Got better opportunity - role">Got better opportunity - role</option>
		    	<option value="Got retained">Got retained</option>
		    	<option value="Unfavorable feedback on new organization/role">Unfavorable feedback on new organization/role</option>
		    	<option value="Personal Issues">Personal Issues</option>
		    	
		    </select>
		    
		    <input type="hidden" id="reject_type" value="">
		    <input type="hidden" id="reject_for" value="">
		     
	    </div>
    	<div  class="model-footer">
	    	<button class="btn btn-cancel">Cancel</button>
	    	<button class="btn btn-ok">Ok</button>
    	</div>
    	
    </div>
  </div>

</div>


<script type="text/javascript">
jQuery(document).ready(function() {
	
	$(document.body).on('click', '.btn-open' ,function(){
		var reject_type = $(this).attr("data-type");
		var reject_for = $(this).parent().attr("id");
		$('.modal-body #reject_type').val(reject_type);
		$('.modal-body #reject_for').val(reject_for);
		
		$('.modal-content select').hide();
		if(reject_type == "join_reject")
		{
			$('.sel_rej_join').show();
			$('#rejectModal').show();
		}
		
		
		
// 		alert("data-type : " + reject_type);
	})
	
// 	$(document.body).on('click', '.modal-content .btn-ok' ,function(){

// 		alert("Hello to all");
// 	})
	
});

</script>