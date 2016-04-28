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
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html dir="ltr" lang="en-US">
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Uni Hyr</title>
<script src="js/model.popup.js"></script>


<style type="text/css">
.report_sum{padding: 5px 0;}
</style>
<style type="text/css">
	.error{color: red;}
</style>
<script type="text/javascript">
	function  loadclientposts(pn)
	{
		var pid = $('#selected_post').val();
		
		var sel_con = $('#cons_list > li').hasClass("active");
		var conid = "";
		if(sel_con)
		{
			conid = $('#cons_list  .active').attr("id");
		}
		
		if(sel_con == "")
		{
			alertify.error("Please select consultant first !");
			return false;
		}
		
		var sortParam=$('#sortParam').val();
		if(typeof sortParam != 'undefined'){}
		else
			sortParam='published';
		
		
		$.ajax({
			type : "GET",
			url : "postapplicantlist",
			data : {'pn':pn,'pid':pid,'conid':conid,'sortParam':sortParam},
			contentType : "application/json",
			success : function(data) {
//				alert(data);
				$('#candidate_profiles').html(data);
				$('#candidate_profiles').show();
				$('#candidate_profiles_def').hide();
				
			},
			error: function (xhr, ajaxOptions, thrownError) {
		        alert(xhr.status);
		      }
	    }) ;
	}
</script>
</head>
<%
	List<PostConsultant> consList = (List)request.getAttribute("consList");
	List<PostProfile> ppList = (List)request.getAttribute("ppList");
	Post post=(Post) request.getAttribute("sel_post");
%>
<body class="loading">
<div class="mid_wrapper">
  <div class="container">
  <%-- <sec:authorize access="hasRole('ROLE_EMP_MANAGER')">
    <div style="padding-bottom: 0" class="rightside_in new_table">
        <div class="bottom-padding" style=" border: 2px solid gray; border-radius: 5px; margin-bottom: 10px;  padding: 10px;">
	        <div class="bottom-padding">
	        	
	        	<div class="col-md-4 report_sum" >
		        	<div class="col-md-9">
		        		Active Positions
		        	</div>
		        	<div class="col-md-3">
		        		${totalActive}
		        	</div>
	        	</div>
	        	<div class="col-md-4 report_sum" >
		        	<div class="col-md-9">
		        		InActive Positions
		        	</div>
		        	<div class="col-md-3">
		        		${totalposts - totalActive}
		        	</div>
	        	</div>
	        	<div class="col-md-4 report_sum" >
		        	<div class="col-md-9">
		        		No of Profile Recieved
		        	</div>
		        	<div class="col-md-3">
		        		${totalprofiles }
		        	</div>
	        	</div>
	        	<div class="col-md-4 report_sum" >
		        	<div class="col-md-9">
		        		No of Profile Shortlisted
		        	</div>
		        	<div class="col-md-3">
		        		${totalshortlist }
		        	</div>
	        	</div>
	        	<div class="col-md-4 report_sum" >
		        	<div class="col-md-9">
		        		No of Candidate Joined
		        	</div>
		        	<div class="col-md-3">
		        		${totaljoin }
		        	</div>
	        	</div>
	        	<div class="col-md-4 report_sum" >
		        	<div class="col-md-9">
		        		No of Partners
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
          <select id="selected_post" style="margin-bottom: 7px">
               <option value="0">Select Post</option>
               <c:forEach var="item" items="${postsList}">
				   <option value="${item.postId}"  ${sel_post.postId == item.postId ? 'selected="selected"' : ''} >${item.title}</option>
				</c:forEach>
           </select>
          <h2 style="background: #4e4e4e none repeat scroll 0 0; border-radius: 5px 5px 0 0;color: #fff;margin-top: 5px">Hiring Partners</h2>
          <ul id="cons_list">
            <%
            	if(consList != null && !consList.isEmpty())
            	{
            		for(PostConsultant pp : consList)
            		{
            			%>
				            <li id="<%= pp.getConsultant().getUserid()%>"><a><%= pp.getConsultant().getConsultName() %></a></li>
            			<%		
            		}
            	}
            %>
          </ul>
          
        </div>
      </div>
      <div class="right_side">
        <div class="profiles_col">
            <div class="block consulting" style="padding: 10px 20px 0px 12px">
				<div  id="view_jd" class="view_id pre_check" style="float: none;margin:0;padding: 0;">
	                	<%
	                	if(post!=null){
	                	%>
	                	
	                	
	                	<a target="_blank" href="viewPostDetail?pid=<%=post.getPostId()%>" class="btn file_btn view_post  ${sel_post != null ? '' : 'btn_disabled'} "><strong>View JD</strong></a>
	                	
	                <%}else{ %>
	                  	
	                	<a target="_blank" href="javascript:void(0)" class="btn file_btn view_post  ${sel_post != null ? '' : 'btn_disabled'} "><strong>View JD</strong></a>
	             
	                <%} %>
	                
	                <a target="_blank" href="javascript:void(0)" class="btn file_btn view_consultant  btn_disabled" style="display: none;"><strong>About Consultant</strong></a>
	             
	                </div>
				
			</div>
          <div id="candidate_profiles" class="rightside_in new_table " style="display: <% if(ppList == null){%>none<%}  %>">
<!--           ----------------------------  inner data start --------------------- -->
			<%
			if(ppList != null)
			{
				
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
		       				<th></th>
		       			</tr>
	       			
	       			
	       				<%
	       				if(ppList != null && !ppList.isEmpty())
	                  	{
	                  		for(PostProfile pp : ppList)
	                  		{
	                  			%>
	                  				<tr class="proile_row">
	                  					<td><a href="clientapplicantinfo?ppid=<%= pp.getPpid() %>" ><%= pp.getProfile().getName()%></a></td>
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
															<td class="text-center">
															<span>None Required</span>
															</td>
														<%
													}
													else if(pp.getJoinDate() != null)
													{
														%>
															<td>
																<span>Joined</span>
															</td>
															<td class="text-center">
															<span>None Required</span>
															</td>
														<%
													}
													else if(pp.getOfferDropDate() != null)
													{
														%>
															<td>
																<span>Offer Declined</span>
															</td>
															<td class="text-center">
															<span>None Required</span>
															</td>
														<%
													}
													else if(pp.getOfferDate() != null)
													{
														%>
															<td>
																<span>Offered</span>
															</td>
															<td class="text-center">
															<span>None Required</span>
															</td>
														<%
													}
													else if(pp.getDeclinedDate() != null)
													{
														%>
															<td>
																<span>Declined</span>
															</td>
															<td class="text-center">
															<span>None Required</span>
															</td>
														<%
													}
													else if(pp.getRecruited() != null)
													{
														%>
															<td>
																<span>Offer   </span>
															</td>
															<td class="text-center">
																<p id="<%= pp.getPpid()%>" class="profile_status" data-view="table">
																	<button class="btn-offer-open profile_status_button" data-type="offer_accept" title="Click to accept offer" onclick="$('#postIdForAccept').val('<%=pp.getPpid() %>')" >Offer Accept</button>
																	<button class="btn-open profile_status_button" data-type="offer_reject" title="Click to reject offer">Reject</button>
																</p>
															</td>
														<%
													}
														
	                  							
													else if(pp.getRejected() != null)
													{
														%>
															<td>
																<span>CV Rejected</span>
															</td>
															<td class="text-center">
															<span>None Required</span>
															</td>
														<%
													}
													else if(pp.getAccepted() != null)
													{
														%>
															<td>
																<span>ShortListed</span>
															</td>
															<td class="text-center">
																<p id="<%= pp.getPpid()%>" class="profile_status" data-view="table">
																	
																	<button class="recruit_profile profile_status_button" title="Click to offer">Offer</button>
																	<button class="btn-open profile_status_button" data-type="reject_recruit" title="Click to decline">Decline</button>
																	
																</p>
															</td>
														<%
													}
													else
													{
														%>
															<td>
																<span>Pending</span>
															</td>
															<td class="text-center">
																<p id="<%= pp.getPpid()%>" class="profile_status" data-view="table">
																	<button class="accept_profile profile_status_button" title="Click to shortlist profile">Shortlist</button>
																	<button class="btn-open profile_status_button" data-type="reject_profile" title="Click to reject profile">Reject</button>
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
			          <select id="sortParam" >
			            <option value="submitted">Submitted</option>
<!-- 			            <option value="accepted">Shortlisted</option> -->
			          </select>
			        </div>
		         <%
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
<!--           ----------------------------  inner data end --------------------- -->

			<div class="rightside_in new_table " id="candidate_profiles_def" style="<%if(ppList != null){%>display:none<%} %>">
<!--           ----------------------------  inner data start --------------------- -->
			
			
	            <div class="filter">
	              <div class="col-md-6 pagi_summary"><span>Showing 0 - 0 of 0</span> </div>
	              <div class="col-md-6">
	                <ul class="page_nav unselectable">
	                	
						            <li class="disabled"><a>First</a></li>
						            <li class="disabled"><a><i class="fa fa-fw fa-angle-double-left"></i></a></li>
				      			
					            <li class="active current_page"><a>1</a></li>
			          		
				      				<li class="disabled"><a><i class="fa fa-fw fa-angle-double-right"></i></a></li>
						            <li class="disabled"><a>Last</a></li>
				      			
	                
	                </ul>
	              </div>
	            </div>
	            <table style="border: 1px solid gray;" class="table no-margin">
		        	
		        		<tbody><tr>
		       				<th align="left">Name</th>
		       				<th align="left">Phone</th>
		       				<th align="left">Current Role</th>
		       				<th align="left">Organization</th>
		       				<th align="left">Curent Salary</th>
		       				<th align="left">Notice Period </th>
		       				<th align="left">Submitted</th>
		       				<th align="left">Status</th>
		       				<th style="width: 150px;">Action</th>
		       				<th></th>
		       			</tr>
	       			
	       			
	       				
  						<tr align="left" style="margin: 10px 0; " class="bottom-margin">
  							<td style="width: auto;font-weight: bold;" colspan="10">Select post and consultant</td>
  						</tr>
  					
	       			
       		</tbody></table>
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
	              <div class="sort_by"> <span>Filter by</span>
		          <select id="sortParam">
		            <option value="submitted">Submitted</option>
<!-- 		            <option value="accepted">Shortlisted</option> -->
		          </select>
		        </div> 
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
	    	<p>Please fill all details</p><br>
		    <label>Total CTC : </label>
		    <br><input type="text" id="totalCTC" /><input type="hidden" id="postIdForAccept" />
		     <span id="errorTotalCTC" style="display: none;color: red;"></span>
		    <label>Billable CTC : </label>
		    <br> <input type="text" id="billableCTC" />
		     <span id="errorBillableCTC" style="display: none;color: red;"></span>
		     <label>Joining Date : </label>
		     <br><input type="text" id="joiningDate" />
		     <span id="errorJoiningDate" style="display: none;color: red;"></span>
	    </div>
    	<div  class="model-footer">
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
		    	<option value="">Select Reason </option>
		    	<option value="Junior for the role">Junior for the role</option>
		    	<option value="High Salary">High Salary</option>
		    	<option value="Not relevant">Not relevant</option>
		    	<option value="Duplicate">Duplicate</option>
		    	<option value="Poor reference">Poor reference</option>
		    	<option value="Unstable">Unstable</option>
		    	<option value="Parity Issues">Parity Issues</option>
		    	
		    	
		    </select>
		    <select class="sel_rej_recruit" style="margin-top: 10px;">
		    	<option value="">Select Reason </option>
		    	<option value="Poor communication skills">Poor communication skills</option>
		    	<option value="Lacked in executive presence">Lacked in executive presence</option>
		    	<option value="Junior for the role">Junior for the role</option>
		    	<option value="Weak technical skills">Weak technical skills</option>
		    	<option value="Weak motivation">Weak motivation</option>
		    </select>
		    <select class="sel_rej_offer" style="margin-top: 10px;">
		    	<option value="">Select Reason </option>
		    	<option value="Higher salary expectations">Higher salary expectations</option>
		    	<option value="Salary proofs inadequate">Salary proofs inadequate</option>
		    	<option value="Issue with Location">Issue with Location</option>
		    	<option value="Issue with Designation">Issue with Designation</option>
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
		if(reject_type == "reject_profile")
		{
			$('.sel_rej_profiel').show();
			$('#rejectModal').show();
		}
		if(reject_type == "reject_recruit")
		{
			
			$('.sel_rej_recruit').show();
			$('#rejectModal').show();
		}
		if(reject_type == "offer_reject")
		{
			
			$('.sel_rej_offer').show();
			$('#rejectModal').show();
		}
		
		
		
// 		alert("data-type : " + reject_type);
	})


	$(document.body).on('click', '.btn-offer-open' ,function(){
		$('#offerModal').show();
	});
	
	
	
});

</script>
</body>
</html>
