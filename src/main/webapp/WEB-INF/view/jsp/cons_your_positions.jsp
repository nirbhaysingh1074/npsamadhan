<%@page import="com.unihyr.constraints.DateFormats"%>
<%@page import="com.unihyr.domain.PostProfile"%>
<%@page import="com.unihyr.domain.PostConsultant"%>
<%@page import="com.unihyr.domain.Post"%>
<%@page import="com.unihyr.domain.Registration"%>
<%@page import="com.unihyr.domain.CandidateProfile"%>
<%@page import="java.util.List"%>
<%
	List<Registration> clientList = (List<Registration>) request.getAttribute("clientList");
%>
<script type="text/javascript">
	function fillProfiles(pageNo) 
	{
		var clientId = $('#selectionOfClient').val();
		
		var sel_con = $('#postsList > li').hasClass("active");
		var postId = "";
		var posttitle = "";
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
					'pageNo':pageNo
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

	function fillPosts(clientId) 
	{
// 		alert("sdd;"+clientId);
		
		$('.candidate_profiles_def').show();
		$('.candidate_profiles_for_cons').html("");
		if(clientId != "")
		{
			$.ajax({
				type : "GET",
				url : "cons_leftside_postlist",
				data : {
					'clientId' : clientId
				},
				contentType : "application/json",
				success : function(data) {
					$('#cons_leftside_postlist').html(data);
				},
				error : function(xhr, ajaxOptions, thrownError) {
					alert(xhr.status);
				}
			});
		
		}
		else
		{
			$('#postsList').html("");
			
		}
		
	}
</script>
<script type="text/javascript">
$(document.body).on('click', '.upload_new_profile' ,function(){
	var clientId = $('#selectionOfClient').val();
	var postId = $("#postsList > .active").attr("id");
	
// 	alert("clientId:"+clientId);
	
	if( clientId != "" && clientId != "undefined" && postId != "" && postId != undefined)
	{
		window.location.href = "uploadprofile?pid="+postId;
		
	}
	
	
});
</script>

<div class="mid_wrapper">
<%
Registration sel_client = (Registration)request.getAttribute("selClient");
List<PostConsultant> postConsList = (List)request.getAttribute("postConsList");
%>
	<div class="container">
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
					<h2 style="font-weight: bold;background: #4e4e4e none repeat scroll 0 0; border-radius: 5px 5px 0 0;color: #fff;margin-top: 5px">Job Positions</h2>
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
										%>
											<li id="<%=pc.getPost().getPostId() %>" class="active" >
												<a href="javascript:void(0)"><%=pc.getPost().getTitle()%></a>
											</li>
										<%
									}
									else
									{
										%>
											<li id="<%=pc.getPost().getPostId() %>" >
												<a href="javascript:void(0)"><%=pc.getPost().getTitle()%></a>
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
								<a href="javascript:void(0)" class="btn file_btn upload_new_profile btn_disabled"><strong>Upload New Profile</strong></a>
								
							</div>
							<div id="view_jd" class="view_id pre_check" style="float: none;">
			                 	<a href="javascript:void(0)" id="" class="btn file_btn view_post btn_disabled"><strong>View JD</strong></a>
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
									<thead>
										<tr>
											<th align="left">Name</th>
											<th align="left">Phone</th>
											<th align="left">Current Role</th>
											<th align="left">Organization</th>
											<th align="left">Curent Salary</th>
											<th>Notice Period</th>
											<th>Submitted</th>
											<th>Status</th>
										</tr>
									</thead>
									<tbody>
										<%
											if (profileList != null && !profileList.isEmpty()) 
											{
												for (PostProfile pp : profileList) 
												{
													%>
													<tr>
														<td><a href="consapplicantinfo?ppid=<%=pp.getPpid()%>"><%=pp.getProfile().getName()%></a></td>
														<td><%=pp.getProfile().getContact()%></td>
														<td><%=pp.getProfile().getCurrentRole()%></td>
														<td><%=pp.getProfile().getCurrentOrganization()%></td>
														<td><%=pp.getProfile().getCurrentCTC()%></td>
														<td align="center"><%=pp.getProfile().getNoticePeriod()%></td>
														<td align="center"><%=DateFormats.ddMMMMyyyy.format(pp.getSubmitted())%></td>
														<td align="center">
															<p id="<%=pp.getPpid()%>" class="profile_status">
																<%
																	if (pp.getAccepted() != null)
																	{
																	%>
																			
																		<h3>Accepted</h3> <%
															 		}
																	else if (pp.getRejected() != null) 
																	{
															 		%>
																		<h3>Rejected</h3> <%
															 		} else 
															 		{
																	 %>
																		<h3>In Progress</h3>
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
									<div class="sort_by">
										<span>Order by</span> <select>
											<option>Recent</option>
										</select>
									</div>
								</div>
								
							<%
							
						}
					%>
					</div>
					<div class="candidate_profiles_def">
					
					<%
						if(profileList == null)
						{
							%>
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
											<th align="left">Curent Salary</th>
											<th>Notice Period</th>
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
								<div class="sort_by">
									<span>Order by</span> <select>
										<option>Recent</option>
									</select>
								</div>
							</div>
							<%
						}
						%>	
							
							
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
