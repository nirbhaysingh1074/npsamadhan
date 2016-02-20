<%@page import="com.unihyr.domain.Post"%>
<%@page import="com.unihyr.domain.Registration"%>
<%@page import="com.unihyr.domain.CandidateProfile"%>
<%@page import="java.util.List"%>
<%
	List<Registration> clientList = (List<Registration>) request.getAttribute("clientList");
%>
<script type="text/javascript">
	function fillProfiles(clientId,postId)
	{
		var pageNo=0;
		$.ajax({
			type : "GET",
			url : "profilelistbyconsidclientid",
			data : {
				'clientId' : clientId,
				'postId':postId,
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

function fillPosts(clientId,postId)
	{
	var pageNo=0;
		 $.ajax({
			type : "GET",
			url : "cons_leftside_postlist",
			data : {
				'clientId' : clientId,
				'postId':postId,
				'pageNo':pageNo
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
</script>
<div class="mid_wrapper">
	<div class="container">
		<div class="new_post_info">
			<div id='cons_leftside_postlist'></div>
			<div class="right_side">
				<div class="profiles_col">
					<h2 class="title">
						<span>Profiles for AVP Transition - 1051</span>
					</h2>
					<div class="rightside_in new_table">
						<div class="block consulting">
							<div class="pull-left">
								<a href="uploadprofile" class="btn file_btn">Upload New
									Profile</a>
								<div class="view_id">
									<img src="images/ic_15.png" alt="img" align="middle"> <a
										href="">View JD</a>
								</div>
							</div>
							<div class="pull-right">
								<select id="selectionOfClient" 
									onchange="fillProfiles(this.value,0);fillPosts(this.value,0)">
									<option value="1">All Clients</option>
									<%
										for (Registration client : clientList) {
									%>
									<option value="<%=client.getUserid()%>"><%=client.getOrganizationName()%></option>
									<%
										}
									%>
								</select>
							</div>
						</div>
						<div id="candidate_profiles_for_cons">
						<script type="text/javascript">
						fillProfiles('1','0');
						fillPosts('1','0')
						</script>
						
						</div>

					</div>
				</div>
			</div>
		</div>
	</div>
</div>
