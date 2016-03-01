<%@page import="com.unihyr.domain.PostConsultant"%>
<%@page import="com.unihyr.domain.Post"%>
<%@page import="java.util.List"%>
<%

	List<PostConsultant> postList = (List<PostConsultant>) request.getAttribute("postConsList");
	String postSelected=(String)request.getAttribute("postSelected");
%>


	<ul id="postsList">
		<%
		int i=0;
		for (PostConsultant pc : postList)
		{
				
			%>
				<li id="<%=pc.getPost().getPostId() %>">
				<a href="javascript:void(0)"><%=pc.getPost().getTitle()%></a></li>
			<%
			
		}
		%>
	</ul>