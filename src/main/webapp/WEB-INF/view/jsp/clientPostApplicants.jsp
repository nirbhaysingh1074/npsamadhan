<!DOCTYPE html>
<%@page import="com.unihyr.constraints.DateFormats"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
<%@page import="com.unihyr.domain.PostProfile"%>
<%@page import="com.unihyr.domain.Registration"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html dir="ltr" lang="en-US">
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Uni Hyr</title>
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
		$.ajax({
			type : "GET",
			url : "postapplicantlist",
			data : {'pn':pn,'pid':pid,'conid':conid},
			contentType : "application/json",
			success : function(data) {
//				alert(data);
				$('#candidate_profiles').html(data);
			},
			error: function (xhr, ajaxOptions, thrownError) {
		        alert(xhr.status);
		      }
	    }) ;
	}
</script>
</head>
<%
	List<Registration> consList = (List)request.getAttribute("consList");
	List<PostProfile> ppList = (List)request.getAttribute("ppList");
%>
<body class="loading" <% if(ppList == null){%>onload="loadclientposts('1')"  <%} %>>
<div class="mid_wrapper">
  <div class="container">
    <div class="new_post_info">
      <div class="left_side">
        <div class="left_menu">
          <select id="selected_post" >
               <option value="0">Select Post</option>
               <c:forEach var="item" items="${postsList}">
				   <option value="${item.postId}"  ${sel_post.postId == item.postId ? 'selected="selected"' : ''} >${item.title}</option>
				</c:forEach>
           </select>
          <h2 style="font-weight: bold;background: #4e4e4e none repeat scroll 0 0; border-radius: 5px 5px 0 0;color: #fff;margin-top: 5px">Hiring Partners</h2>
          <ul id="cons_list">
            <%
            	if(consList != null && !consList.isEmpty())
            	{
            		for(Registration con : consList)
            		{
            			%>
				            <li id="<%= con.getUserid()%>"><a><%= con.getConsultName() %></a></li>
            			<%		
            		}
            	}
            %>
          </ul>
        </div>
      </div>
      <div class="right_side">
        <div class="profiles_col">
          <div id="candidate_profiles" class="rightside_in new_table ">
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
		        	<thead>
		        		<tr>
		       				<th align="left">Name</th>
		       				<th align="left">Phone</th>
		       				<th align="left">Current Role</th>
		       				<th align="left">Organization</th>
		       				<th align="left">Curent Salary</th>
		       				<th>Notice Period </th>
		       				<th>Submitted</th>
		       				<th>Status</th>
		       			</tr>
	       			</thead>
	       			<tbody>
	       				<%
	       				if(ppList != null && !ppList.isEmpty())
	                  	{
	                  		for(PostProfile pp : ppList)
	                  		{
	                  			%>
	                  				<tr>
	                  					<td><a href="clientapplicantinfo?ppid=<%= pp.getPpid() %>" ><%= pp.getProfile().getName()%></a></td>
	                  					<td><%= pp.getProfile().getContact()%></td>
	                  					<td><%= pp.getProfile().getCurrentRole()%></td>
	                  					<td><%= pp.getProfile().getCurrentOrganization()%></td>
	                  					<td><%= pp.getProfile().getCurrentCTC()%></td>
	                  					<td><%= pp.getProfile().getNoticePeriod()%></td>
	                  					<td><%= DateFormats.ddMMMMyyyy.format(pp.getSubmitted())%></td>
	                  					<td>
	                  						<p id="<%= pp.getPpid()%>" class="profile_status">
												<%
													if(pp.getAccepted() != null)
													{
														%>
															<h3>Accepted</h3>
														<%
													}
													else if(pp.getRejected() != null)
													{
														%>
															<h3>Rejected</h3>
														<%
													}
													else
													{
														%>
															<a  class="accept_profile"><img title="Click to accept profile" src="images/accept-icon.png" alt="Accept" style="width: 20px;"></a> 
															<a  class="reject_profile"><img title="Click to reject profile" src="images/cancel.png" alt="Reject" style="width: 20px;"></a>
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
	              <div class="sort_by"> <span>Order by</span>
	                <select>
	                  <option>Recent</option>
	                </select>
	              </div>
	            </div>
	            
	            <%
				}
			
            %>
<!--           ----------------------------  inner data end --------------------- -->
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

</body>
</html>
