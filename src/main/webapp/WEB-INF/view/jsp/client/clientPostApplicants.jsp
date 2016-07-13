<!DOCTYPE html>
<%@page import="com.unihyr.domain.PostConsultant"%>
<%@page import="com.unihyr.domain.Post"%>
<%@page import="com.unihyr.constraints.DateFormats"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
<%@page import="com.unihyr.domain.PostProfile"%>
<%@page import="com.unihyr.domain.Registration"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<html dir="ltr" lang="en-US">
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Uni Hyr</title>
<script src="js/model.popup.js"></script>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">

<style type="text/css">
.report_sum {
	padding: 2px 0;
}
</style>
<style type="text/css">
.error {
	color: red;
}
</style>
<script type="text/javascript">
	function  loadclientposts(pn)
	{
		var pid = $('#selected_post').val();
		
		var conid = "";
// 		var sel_con = $('#cons_list > li').hasClass("active");
// 		if(sel_con)
// 		{
// 			conid = $('#cons_list  .active').attr("id");
// 		}
		
// 		if(sel_con == "")
// 		{
// 			alertify.error("Please select consultant first !");
// 			return false;
// 		}
pleaseWait();
		var filterBy=$('#filterBy').val();
		if(typeof filterBy != 'undefined'){}
		else
			filterBy='submitted';

		
		var sortParam=$('#sortParam').val();
		var sortOrder="asc";
		
		if(typeof sortParam != 'undefined'){}
		else
			sortParam='rating';
       
		var excludeType = "";
		$('#filterDiv').css('display','block');
		$('#filterDivIncRej').css('display','none');

        $.each($("input[name='excludeType']:checked"), function(){            

        	excludeType=$(this).val();
    		$('#filterDiv').css('display','none');
    		$('#filterDivIncRej').css('display','block');
    		filterBy=$('#filterByRej').val();
    		if(typeof filterBy != 'undefined' ||filterBy!=""){}
    		else
    			filterBy='submitted';
			
        });
        
        
        sortOrder =  $("input[name='sortOrder']:checked").val();           
        	
       
		$.ajax({
			type : "GET",
			url : "postapplicantlist",
			data : {'pn':pn,'pid':pid,'sortParam':sortParam,'excludeType':excludeType,'filterBy':filterBy,'sortOrder':sortOrder},
			contentType : "application/json",
			success : function(data) {
				$('#candidate_profiles').html(data);
				$('#candidate_profiles').show();
				$('#candidate_profiles_def').hide();
			pleaseDontWait();	
			},
			error: function (xhr, ajaxOptions, thrownError) {
		      }
	    }) ;
	}
</script>
</head>
<%
	// List<PostConsultant> consList = (List)request.getAttribute("consList");
	/* 	List<PostConsultant> conslistHavingProfiles = (List) request.getAttribute("conslistHavingProfiles");
	List<PostConsultant> conslistHavingNoProfiles = (List) request.getAttribute("conslistHavingNoProfiles"); */
	List<PostProfile> ppList = (List) request.getAttribute("ppList");
	Post post = (Post) request.getAttribute("sel_post");
	
%>
<body class="loading" <% if(ppList == null){%>onload="loadclientposts('1')"  <%} %>>
	<div class="mid_wrapper">
		<div class="container">
    <%

	int pn=1;
    if(post!=null) {
    
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
    	if(request.getAttribute("pn")!=null){
		pn = (Integer) request.getAttribute("pn");
    	}
    %>
    	 <sec:authorize access="hasRole('ROLE_EMP_MANAGER')">
    <div style="padding-bottom: 0" class="rightside_in new_table">
        <div class="bottom-padding manageposthead" >
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
		        		No of Positions
		        	</div>
		        	<div class="col-md-7">
		        		<%=post.getNoOfPosts() %>
		        	</div>
	        	</div>
	        	
	        	<div class="col-md-4 report_sum" >
		        	<div class="col-md-5">
		        		Profile Received
		        	</div>
		        	<div class="col-md-7">
		        		<%=post.getPostProfile().size() %>
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
		        		Closed
		        	</div>
		        	<div class="col-md-7">
		        		<%=post.getNoOfPostsFilled() %>
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
		        		No of Partners
		        	</div>
		        	<div class="col-md-7">
		        		${totalpartner }
		        	</div>
	        	</div>
	        	
	        	<div class="col-md-4 report_sum" >
		        	<div class="col-md-5">
		        		Shortlisted
		        	</div>
		        	<div class="col-md-7">
		        		<%=shortListed.size() %>
		        	</div>
	        	</div>
	        	
	        	
	        </div>
        </div>
    </div>
    </sec:authorize> 
    <%} %>
			<div class="new_post_info">
			
				<div class="right_side" style="width: 100%;">
					<div class="profiles_col">


						<div class="block consulting" style="padding: 9px 15px 1px 15px">
							<div style="float: left;margin-right: 30px;">
								<select id="selected_post" style="margin-bottom: 7px">
									<option value="0">Select Post</option>
									<c:forEach var="item" items="${postsList}">
										<option value="${item.postId}"
											${sel_post.postId == item.postId ? 'selected="selected"' : ''}>${item.title}</option>
									</c:forEach>
								</select>
							</div>
							<%if(post!=null){ %>
							<div id="view_jd" class="view_id pre_check"
								style="float: none; margin: 0; padding: 0;">
								<%
									if (post != null) {
								%>
								<a target="_blank"
									href="viewPostDetail?pid=<%=post.getPostId()%>"
									class="btn file_btn view_post  ${sel_post != null ? '' : 'btn_disabled'} "><strong>View
										JD</strong></a>
								<%
									} else {
								%>
								<a target="_blank" href="javascript:void(0)"
									class="btn file_btn view_post  ${sel_post != null ? '' : 'btn_disabled'} "><strong>View
										JD</strong></a>
								<%
									}
								%>
								<a target="_blank" href="javascript:void(0)"
									class="btn file_btn view_consultant  btn_disabled"
									style="display: none;"><strong>About Consultant</strong></a>
							</div>
					<div  class="sort_by" style="float: right;margin-left: 20px;">
									<span>Sort by</span> <select id="sortParam"    onchange="loadclientposts('1')">
										<option value="rating">Consultant Rating</option>
										<option value="noticePeriod">Notice Period</option>
										<option value="currentCTC">Current Annual Salary</option>
										<!-- 			            <option value="accepted">Shortlisted</option> -->
									</select>
	</div>
					<div  class="sort_by" style="float: right;margin-left: 20px;">
								
									<label style="line-height: 27px;"><input type="radio" name="sortOrder" id="sortOrder" value="asc" onchange="loadclientposts('1')"/>Asc</label>
									<label style="line-height: 27px;"><input type="radio" name="sortOrder" id="sortOrder" value="desc"  onchange="loadclientposts('1')" checked="checked"   />Desc</label>
								</div>		
  				<div class="sort_by"  id="filterDiv" > <span>Filter by Status</span>
		          <select id="filterBy"  onchange="loadclientposts('1')">
		            <option value="submitted">Submitted</option>
		            <option value="pending">Pending</option>
		            
		            <option value="accepted">Shortlisted</option>
		            
		            <option value="recruited">Offer Sent</option>
		            
		            <option value="offerDate">Offer Accepted</option>
		            
		            <option value="joinDate">Joined</option>
		          </select>
		        </div>
  				<div class="sort_by" id="filterDivIncRej" style="display: none;"> <span>Filter by Status</span>
		          <select id="filterByRej"  onchange="loadclientposts('1')">
		            <option value="submitted" selected="selected">Submitted</option>
		            <option value="pending">Pending</option>
		            
		            <option value="accepted">Shortlisted</option>
		            <option value="rejected">CV Rejected</option>
		            
		            <option value="recruited">Offer Sent</option>
		            <option value="declinedDate" >Interview Reject</option>
		            
		            <option value="offerDate">Offer Accepted</option>
		            <option value="offerDropDate">Offer Declined</option>
		            
		            <option value="joinDate">Joined</option>
		            <option value="joinDropDate">Dropped</option>
		            <option value="withdrawDate">Withdrawn</option>
		          </select>
		        </div>
		       
		        <div style="float: right;margin-right: 20px;">
							<label style="line-height: 27px;"><input onchange="loadclientposts('1');" type="checkbox" name="excludeType"   value="rejected"/> Include Rejected</label>
							</div> <%} %>
						</div>
						
						
						<div id="candidate_profiles" class="rightside_in new_table "
							style="display: <%if (ppList == null) {%>none<%}%>">
							<!--           ----------------------------  inner data start --------------------- -->
							<%
								if (ppList != null) {
									Set<Registration> consultants = new HashSet<Registration>();
									if (ppList != null && !ppList.isEmpty()) {
										for (PostProfile pp : ppList) {
											consultants.add(pp.getProfile().getRegistration());
										}
									}
									int totalCount =  ((Integer)request.getAttribute("totalCount"));
									//int pn = (Integer) request.getAttribute("pn");
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
											if (pn > 1) {
										%>
										<li><a onclick="loadclientposts('1')">First</a></li>
										<li><a onclick="loadclientposts('<%=pn - 1%>')"><i
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
										<li><a onclick="loadclientposts('<%=pn + 1%>')"><i
												class="fa fa-fw fa-angle-double-right"></i></a></li>
										<li><a onclick="loadclientposts('<%=tp%>')">Last</a></li>
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
									<a style="color: purple;cursor: default;" href="javascript:void(0)"><%=pp.getProfile().getName()%></a>
									<%}else{ %>
									<a style="cursor: default;" href="javascript:void(0)"><%=pp.getProfile().getName()%></a>
									
									<%} %>
									</td>
									<td><%=pp.getProfile().getContact()%></td>
									<td><%=pp.getProfile().getCurrentRole()%></td>
									<td><%=pp.getProfile().getCurrentOrganization()%></td>
									<td align="center"><%=pp.getProfile().getCurrentCTC()%></td>
									<td align="center"><%=pp.getProfile().getNoticePeriod()%></td>
									<td><%=DateFormats.ddMMMMyyyy.format(pp.getSubmitted())%></td>
<%
												String status = "";
												if (pp.getWithdrawDate() != null) {
													status = "Withdrawn";
												} else if (pp.getJoinDropDate() != null) {
													status = "Dropped";
												} else if (pp.getJoinDate() != null) {
													status = "Joined";
												} else if (pp.getOfferDropDate() != null) {
													status = "Offer Declined";
												} else if (pp.getOfferDate() != null) {
													status = "Offered";
												} else if (pp.getDeclinedDate() != null) {
													status = "Interview Reject";
												} else if (pp.getRecruited() != null) {
													status = "Offer Sent ";
												} else if (pp.getRejected() != null) {
													status = "CV Rejected";
												} else if (pp.getAccepted() != null) {
													status = "ShortListed";
												} else {
													status = "Pending";
												}
												if (pp.getPost().getCloseDate() != null) {
									%>
									<td><span><%=status %></span></td>
									<td class="text-center" style="text-align: left;"><span>Post Closed</span></td>
									<%	
										}else if(!pp.getPost().isActive()) {
									%>
									<td><span><%=status %></span></td>
									<td class="text-center" style="text-align: left;"><span>Post Inactive</span></td>
									<%
										}else  if (pp.getWithdrawDate() != null) {
									%>
									<td><span><%=status %></span></td>
									<td class="text-center" style="text-align: left;"><span>None Required</span></td>
									<%
										}else  if (pp.getJoinDropDate() != null) {
									%>
									<td><span><%=status %></span></td>
									<td class="text-center" style="text-align: left;"><span>None Required</span></td>
									<%
										} else if (pp.getJoinDate() != null) {
									%>
									<td><span><%=status %></span></td>
									<td class="text-center" style="text-align: left;"><span>None Required</span></td>
									<%
										} else if (pp.getOfferDropDate() != null) {
									%>
									<td><span><%=status %></span></td>
									<td class="text-center" style="text-align: left;"><span>None Required</span></td>
									<%
										} else if (pp.getOfferDate() != null) {
									%>
									<td><span><%=status %></span></td>
									<td class="text-center" style="text-align: left;"><span>None Required</span></td>
									<%
										} else if (pp.getDeclinedDate() != null) {
									%>
									<td><span><%=status %></span></td>
									<td class="text-center" style="text-align: left;"><span>None Required</span></td>
									<%
										} else if (pp.getRecruited() != null) {
									%>
									<td><span><%=status %></span></td>
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
									<td><span><%=status %></span></td>
									<td class="text-center" style="text-align: left;"><span>None Required</span></td>
									<%
									} else if (pp.getAccepted() != null) {
									%>
									<td><span><%=status %></span></td>
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
									<td><span><%=status %></span></td>
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


									<td><p style="width: 90px; border-radius: 2px;">
											<a
												style="line-height: 0.42857em; background: url(images/ic_12.png) no-repeat 3px 4px #f8b910; padding: 8px 18px 8px 18px;"
												class="btn search_btn" target="_blank"
												href="clientapplicantinfo?ppid=<%=pp.getPpid()%>">View Profile</a>
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
											if (pn > 1) {
										%>
										<li><a onclick="loadclientposts('1')">First</a></li>
										<li><a onclick="loadclientposts('<%=pn - 1%>')"><i
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
										<li><a onclick="loadclientposts('<%=pn + 1%>')"><i
												class="fa fa-fw fa-angle-double-right"></i></a></li>
										<li><a onclick="loadclientposts('<%=tp%>')">Last</a></li>
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
								
						<%-- 		<%
									String sortParam = (String) request.getAttribute("sortParam");
								%>
								<script type="text/javascript">
        <%if (sortParam != null) {%>
        $("#sortParam").val('<%=sortParam%>');
        $("#sortParam option[value='<%=sortParam%>']").attr('selected', 'selected');
								<%}%>
									
								</script> --%>
							</div>

							<%
								}
							%>
						</div>
						<!--           ----------------------------  inner data end --------------------- -->

						<div class="rightside_in new_table " id="candidate_profiles_def"
							style="<%if (ppList != null) {%>display:none<%}%>">
							<!--           ----------------------------  inner data start --------------------- -->


							<div class="filter">
								<div class="col-md-6 pagi_summary">
									<span>Showing 0 - 0 of 0</span>
								</div>
								<div class="col-md-6">
									<ul class="page_nav unselectable">

										<li class="disabled"><a>First</a></li>
										<li class="disabled"><a><i
												class="fa fa-fw fa-angle-double-left"></i></a></li>

										<li class="active current_page"><a>1</a></li>

										<li class="disabled"><a><i
												class="fa fa-fw fa-angle-double-right"></i></a></li>
										<li class="disabled"><a>Last</a></li>


									</ul>
								</div>
							</div>
							<table style="border: 1px solid gray;" class="table no-margin">

								<tbody>
									<tr>
										<th align="left">Name</th>
										<th align="left">Phone</th>
										<th align="left">Current Role</th>
										<th align="left">Organization</th>
										<th align="left">Curent Salary</th>
										<th align="left">Notice Period</th>
										<th align="left">Submitted</th>
										<th align="left">Status</th>
										<th style="width: 150px;">Action</th>
										<th></th>
									</tr>



									<!-- <tr align="left" style="margin: 10px 0;" class="bottom-margin">
										<td style="width: auto; font-weight: bold;" colspan="10">Select
											post and consultant</td>
									</tr> -->


								</tbody>
							</table>
							<div class="block tab_btm">
								<div class="pagination">
									<ul>

										<li class="disabled"><a>First</a></li>
										<li class="disabled"><a><i
												class="fa fa-fw fa-angle-double-left"></i></a></li>

										<li class="active current_page"><a>1</a></li>

										<li class="disabled"><a><i
												class="fa fa-fw fa-angle-double-right"></i></a></li>
										<li class="disabled"><a>Last</a></li>

									</ul>
								</div>
							<!-- 	<div class="sort_by">
									<span>Filter by</span> <select id="sortParam">
										<option value="submitted">Submitted</option>
												            <option value="accepted">Shortlisted</option>
									</select>
								</div> -->
								<script type="text/javascript">
									
								</script>
							</div>


							<!--           ----------------------------  inner data end --------------------- -->
						</div>


					</div>
				</div>
			</div>
		</div>
	</div>
	<div id="offerModal" class="modal">

		<!-- Modal content -->
		<div class="modal-content" style="width: 50%">
			<span class="close">x</span>
			<div>
				<div class="modal-body">
					<p>Please fill all details</p>
					<br> <label>Total CTC (INR): </label>
						<span style="color: green; font-weight: bold;" id="totalCTCinWords"></span>
					<br> 
						<input type="text" id="totalCTC" onchange="getAmountInWords(this.value,'totalCTCinWords')" /> 
						<input type="hidden" id="postIdForAccept" /> 
					<br> 
						<span id="errorTotalCTC" style="display: none; color: red;"></span> 
						<label>Billable	CTC (INR): </label> 
						<span style="color: green; font-weight: bold;" id="billableCTCinWords"></span> 
						<br> 
						<input type="text" id="billableCTC"	onchange="getAmountInWords(this.value,'billableCTCinWords')" /> 
					<br>
						<span id="errorBillableCTC" style="display: none; color: red;"></span>
						<label>Joining Date : </label> 
					<br> 
						<input type="text"	id="datepicker" /> 
						<span id="errorJoiningDate"	style="display: none; color: red;"></span>
				</div>
				<div class="model-footer">
					<button class="btn btn-cancel">Cancel</button>
					<button class="btn btn-ok" id="offeracceptpopup">Ok</button>
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
					<select class="sel_rej_profiel" style="margin-top: 10px;">
						<option value="">Select Reason</option>
						<option value="Junior for the role">Junior for the role</option>
						<option value="High Salary">High Salary</option>
						<option value="Not relevant">Not relevant</option>
						<option value="Duplicate">Duplicate</option>
						<option value="Poor reference">Poor reference</option>
						<option value="Unstable">Unstable</option>
						<option value="Parity Issues">Parity Issues</option>


					</select> <select class="sel_rej_recruit" style="margin-top: 10px;">
						<option value="">Select Reason</option>
						<option value="Poor communication skills">Poor
							communication skills</option>
						<option value="Lacked in executive presence">Lacked in
							executive presence</option>
						<option value="Junior for the role">Junior for the role</option>
						<option value="Weak technical skills">Weak technical
							skills</option>
						<option value="Weak motivation">Weak motivation</option>
					</select> <select class="sel_rej_offer" style="margin-top: 10px;">
						<option value="">Select Reason</option>
						<option value="Higher salary expectations">Higher salary
							expectations</option>
						<option value="Salary proofs inadequate">Salary proofs
							inadequate</option>
						<option value="Issue with Location">Issue with Location</option>
						<option value="Issue with Designation">Issue with
							Designation</option>
						<option value="Personal Issues">Personal Issues</option>
					</select> <input type="hidden" id="reject_type" value=""> <input
						type="hidden" id="reject_for" value="">

				</div>
				<div class="model-footer">
					<button class="btn btn-cancel">Cancel</button>
					<button class="btn btn-ok">Ok</button>
				</div>

			</div>
		</div>

	</div>

	<script type="text/javascript">
		jQuery(document).ready(function() {

			$(document.body).on('click', '.btn-open', function() {
				var reject_type = $(this).attr("data-type");
				var reject_for = $(this).parent().attr("id");
				$('.modal-body #reject_type').val(reject_type);
				$('.modal-body #reject_for').val(reject_for);

				$('.modal-content select').hide();
				if (reject_type == "reject_profile") {
					$('.sel_rej_profiel').val('');
					$('.sel_rej_profiel').show();
					$('#rejectModal').show();
				}
				if (reject_type == "reject_recruit") {

					$('.sel_rej_recruit').val('');
					$('.sel_rej_recruit').show();
					$('#rejectModal').show();
				}
				if (reject_type == "offer_reject") {

					$('.sel_rej_offer').val('');
					$('.sel_rej_offer').show();
					$('#rejectModal').show();
				}

			})

			$(document.body).on('click', '.btn-offer-open', function() {
				$('#totalCTCinWords').html('');
				$('#billableCTCinWords').html('');
				$('#errorTotalCTC').html('');
				$('#billableCTCinWords').html('');
				$('#errorJoiningDate').html('');
				$('#totalCTC').val('');
				$('#billableCTC').val('');
				$('#datepicker').val('');
				$('#errorBillableCTC').html('');
				$('#offerModal').show();
				
			});

		});
	</script>


	<script type="text/javascript">
		jQuery(document).ready(function() {
			$(function() {
				$("#datepicker").datepicker({
					dateFormat : 'yy-mm-dd'
				});
			});
		});
	</script>
</body>
</html>
