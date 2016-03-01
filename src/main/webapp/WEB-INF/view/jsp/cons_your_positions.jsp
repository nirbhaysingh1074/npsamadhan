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
		if (sel_con) 
		{
			postId = $('#postsList  .active').attr("id");
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
					$('#candidate_profiles_for_cons').html(data);
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
					$('#candidate_profiles_for_cons').html("<h3 style='padding-top:28px'><b>  Please select post to show profiles</h3></b> ");
				},
				error : function(xhr, ajaxOptions, thrownError) {
					alert(xhr.status);
				}
			});
		
		}
		else
		{
			$('#postsList').html("");
			$('#candidate_profiles_for_cons').html("<h3 style='padding-top:28px'><b> Please select client and post to show profiles</b></h3>");
			
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
	<div class="container">
		<div class="new_post_info">
			<div class="left_side">
				<div class="left_menu">
					<h2>Job Positions</h2>
					<div id='cons_leftside_postlist'>
					
					</div>
				</div>
			</div>
			<div class="right_side">
				<div class="profiles_col">
					<h2 class="title">
						<span>Profiles for AVP Transition - 1051</span>
					</h2>
					<div class="rightside_in new_table">
						<div class="block consulting">
							<div class="pull-left">
								<a href="javascript:void(0)" class="btn file_btn upload_new_profile">Upload New Profile</a>
								<div class="view_id">
									<img src="images/ic_15.png" alt="img" align="middle"> <a
										href="">View JD</a>
								</div>
							</div>
							<div class="pull-right">
								<select id="selectionOfClient"
									onchange="$('#postsList > li').removeClass('active');fillPosts(this.value)">
									<option value="">Select Client</option>
									<%
										for (Registration client : clientList) 
										{
											%>
												<option value="<%=client.getUserid()%>"><%=client.getOrganizationName()%></option>
											<%
										}
									%>
								</select>
							</div>
						</div>
						<div id="candidate_profiles_for_cons">
							<h3 style='padding-top:28px'><b>  Please select client and post to show profiles</b> </h3>
							
						</div>

					</div>
				</div>
			</div>
		</div>
	</div>
</div>
