<!DOCTYPE html>
<%@page import="com.unihyr.domain.Industry"%>
<%@page import="com.unihyr.domain.Registration"%>
<%@page import="com.unihyr.domain.PostConsultant"%>
<%@page import="com.unihyr.domain.PostProfile"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.unihyr.domain.CandidateProfile"%>
<%@page import="java.util.Set"%>
<%@page import="com.unihyr.constraints.DateFormats"%>
<%@page import="com.unihyr.domain.Post"%>
<%@page import="java.util.List"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html dir="ltr" lang="en-US">
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Uni Hyr</title>
<style type="text/css">
	.error{color: red;}
</style>

</head>
<body class="loading">
	<%
		Registration reg = (Registration)request.getSession().getAttribute("registration");
		long totalCount = (Long)request.getAttribute("totalCount");
       	List<Post> postList = (List)request.getAttribute("postList");
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
        <div class="col-md-4 pagi_summary">
	      	 	<sec:authorize access="hasRole('ROLE_CON_MANAGER')">
	      	 	<button id="show_interest" class="profile_status_button">Add to Active Postions</button>
	      	 	</sec:authorize>
	      	 	<sec:authorize access="hasRole('ROLE_CON_USER')">
	      	 		<span >New Posts</span>
	      	 	</sec:authorize>
	      	 </div>
       
      </div> 
      <div class="positions_tab">
        	<table class="table no-margin" style="border: 1px solid gray;">
	        	<thead>
	        		<tr>
	       				<sec:authorize access="hasRole('ROLE_CON_MANAGER')">
	       					<th align="left"><input id="sel_allnewPost" type="checkbox"></th>
	       				</sec:authorize>
	       				<th align="left">Position</th>
<!-- 	       				<th align="left">Org</th> -->
	       				<th align="left">Industry</th>
	       				<th align="left">Job Id</th>
	       				<th align="left">Posted Date</th>
	       				<th align="left">Location</th>
	       				<th align="left">Exp. Range</th>
	       				<th align="left">Comp. Range</th>
	       				<!-- <th>View JD</th> -->
	       			</tr>
       			</thead>
       			<tbody>
       				<%
		             	if(postList != null && !postList.isEmpty())
		             	{
		             		for(Post post : postList)
		             		{
		             			
		             		 	Registration regis=post.getClient();
		             			Set<Industry> industries=regis.getIndustries();
		             			Iterator<Industry> in=industries.iterator();
		             			Industry inds=null;
		             			while(in.hasNext()){
		             				inds=in.next();
		             			} 
		             			Iterator<PostConsultant> it = post.getPostConsultants().iterator();
	                  			
	                  			PostConsultant pocl = null;
	                  			while(it.hasNext())
	                  			{
	                  				PostConsultant pc = it.next();
	                  				if(pc.getConsultant().getUserid().equals(reg.getUserid()) || (reg.getAdmin() != null && pc.getConsultant().getUserid().equals(reg.getAdmin().getUserid())  ) )
	                  				{
	                  					pocl = pc;
	                  				}
	                  			}
	                  			
	                  			if(pocl != null)
	                  			{
	                  			}else{
		             			%>
		             				<tr>
			             				<sec:authorize access="hasRole('ROLE_CON_MANAGER')">
			             					<td><input class="sel_newposts" type="checkbox" name="newpostselector[]" value="<%=post.getPostId() %>" ></td>
						       			</sec:authorize>		
		             					<td>
		             						<div class="pre_check" style="float: none;padding: 0;">
						                	<a  href="consviewjd?pid=<%= post.getPostId() %>" target="_blank" class="view_post " title="Click to view post detail"><%= post.getTitle() %></a></div>
					                	</td>
		             					
<%-- 		             					<td><a href="consviewuser?uid=<%= post.getClient().getUserid()%>"><%= post.getClient().getOrganizationName() %></a></td> --%>
		             					 <td ><%= inds.getIndustry() %></td> 
		             					<td style="font-size: 10px;"><%= post.getJobCode() %></td>
		             					<td><%= DateFormats.ddMMMMyyyy.format(post.getPublished()) %></td>
		             					<td><%= post.getLocation()%></td>
		             					<td><%= post.getExp_min()%> to <%= post.getExp_max()  %> Yr </td>
		             					<td><%= post.getCtc_min()%> to <%= post.getCtc_max()  %> Lacs </td>
		             					<%--  <td class="text-center">
		             						<div class="pre_check" style="float: none;padding: 0;">
						                		<a id="<%= post.getPostId() %>" class="view_post " title="Click to view post detail">
						                			<img width="35px" alt="View" src="images/view-icon.png">
					                			</a>
						                	</div>
		             					</td>  --%>
		             					
		             					
		             				</tr>
		             				<%
						                  			
						                  			}
						                  			
						                  				
		             		}
		             	}
		             	
             			
           			%>
       			</tbody>
       		</table>
        
      </div>
      <%-- <div class="block tab_btm">
        <div class="pagination">
          <ul class="pagi">
          	<%
          		if(pn > 1)
          		{
          			%>
			            <li><a onclick="consnewposts('1')">First</a></li>
			            <li><a onclick="consnewposts('<%= pn-1 %>')" ><i class="fa fa-fw fa-angle-double-left"></i></a></li>
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
	      				<li ><a onclick="consnewposts('<%= pn+1 %>')"><i class="fa fa-fw fa-angle-double-right"></i></a></li>
			            <li><a onclick="consnewposts('<%=tp %>')">Last</a></li>
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
        <div class="sort_by"> <span>Sort by</span>
          <select id="sortParam" onchange="consnewposts('1')">
            <option value="published">Recent Posts</option>
            <option value="location">Location(A-Z)</option>
            <option value="title">Job Post(A-Z)</option>
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
      </div> --%>
   

</body>
</html>
