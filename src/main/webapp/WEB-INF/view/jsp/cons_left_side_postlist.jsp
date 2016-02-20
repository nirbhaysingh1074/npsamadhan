<%@page import="com.unihyr.domain.Post"%>
<%@page import="java.util.List"%>
<%

	List<Post> postList = (List<Post>) request.getAttribute("postList");
%>

<div class="left_side">
				<div class="left_menu">
					<h2>Job Positions</h2>
					<ul id="postsList">
						<%
						int i=0;
							for (Post post : postList) {
						if(i==0){
						%>
						<li onclick="fillProfiles($('#selectionOfClient').val(),'<%=post.getPostId() %>');fillPosts($('#selectionOfClient').val(),'<%=post.getPostId() %>')" class="active">
						<a href="javascript:void(0)"><%=post.getTitle()%></a></li>
						<%
						i++;
						}else{
							%>
						<li  onclick="fillProfiles($('#selectionOfClient').val(),'<%=post.getPostId() %>');fillPosts($('#selectionOfClient').val(),'<%=post.getPostId() %>')" >
						<a href="javascript:void(0)"><%=post.getTitle()%></a></li>
							<%
						}
							}
						%>
					</ul>
				</div>
			</div>