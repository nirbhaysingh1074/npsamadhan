<!DOCTYPE html>
<%@page import="java.util.Map"%>
<%@page import="java.util.TreeMap"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.unihyr.domain.Registration"%>
<%@page import="com.unihyr.domain.PostProfile"%>
<%@page import="java.util.HashSet"%>
<%@page import="com.unihyr.constraints.GeneralConfig"%>
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
		Registration sel_client = (Registration)request.getAttribute("selClient");
		List<Registration> clientList = (List<Registration>) request.getAttribute("clientList");
		Registration reg = (Registration)request.getAttribute("registration");
	
       	List<Post> postList = (List)request.getAttribute("postList");
		long totalCount = (Long)request.getAttribute("totalCount");
		int pn = (Integer) request.getAttribute("pn");
		int rpp = (Integer) request.getAttribute("rpp");
		int tp = 0;
		String cc = "";
		if(totalCount == 0)
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
      
	    <div class="positions_info ">
	      <div class="filter">
	          <%-- <div class="col-md-4">
	             <sec:authorize access="hasRole('ROLE_CON_MANAGER')">
		      	 	<button id="close_request">Close Request</button>
		      	 </sec:authorize>	
	         </div> --%>
	        <div class="col-md-6 pagi_summary"><span>Showing <%= cc %> of <%= totalCount %></span> </div>
	       
	         <div class="col-md-6">
	         
                <ul class="page_nav unselectable">
                	<%
		          		if(pn > 1)
		          		{
		          			%>
					            <li><a onclick="loadconsdashboardposts('1')">First</a></li>
					            <li><a onclick="loadconsdashboardposts('<%= pn-1 %>')" ><i class="fa fa-fw fa-angle-double-left"></i></a></li>
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
			      				<li ><a onclick="loadconsdashboardposts('<%= pn+1 %>')"><i class="fa fa-fw fa-angle-double-right"></i></a></li>
					            <li><a onclick="loadconsdashboardposts('<%=tp %>')">Last</a></li>
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
	      <div class="positions_tab">
	        <div >
		        <table class="table no-margin" style="border: 1px solid gray;">
		        	<thead>
		        		<tr>
		        			<%-- <sec:authorize access="hasRole('ROLE_CON_MANAGER')">
		       				<th align="left" width="25px"><input id="sel_all" type="checkbox"></th>
		       				</sec:authorize> --%>
		       				<th align="left" style="width: 17%;">Role</th>
		       				
		       				<th width="110px"  >No of Positions</th> 
		       				<th  width="110px"  align="left">
			       				<div style="float: left;">
						            <select id="cons_db_post_status" style="background: #e3e3e3;font-weight: bold;border: 0px;">
						            	<%
						            		String db_post_status = (String)request.getAttribute("db_post_status");
						            		%>
								               <option value="all"  >Status</option>
											   <option value="active"  <%if(db_post_status.equals("active")){%>selected="selected"<%} %> >Active</option>
											   <option value="inactive" <%if(db_post_status.equals("inactive")){%>selected="selected"<%} %>>Inactive</option>
						            		<%
					            		%>
									</select>
						          </div>
		       				</th>
		       				<th align="left">
		       				<%
// 								List<Registration> clientList = (List)request.getAttribute("clientList");
       							%>
		       				
					        	<select id="cons_db_sel_client" style="width: 80px;height: 30px;background: #e3e3e3;font-weight: bold;border: 0px;">
					        		<option value="">Client</option>
					        		<%
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
		       				</th>
		       				<th  align="left">
			       				<select id="cons_db_sel_loc" style="width: 100px;height: 30px;background: #e3e3e3;font-weight: bold;border: 0px;">
			       					<option value="">Location</option>
				       				<%
				       					String db_sel_loc = (String)request.getAttribute("db_sel_loc");
					       				
					       				
					       				List<String> locList = (List)request.getAttribute("locList");
					       				
					       				for(String loc : locList)
					       				{
					       					
					       					if(loc.equals(db_sel_loc))
					       					{
							       				%>
							       					<option value="<%=loc%>" selected="selected"><%=loc %></option>
							       				<%
					       					}
					       					else
					       					{
							       				%>
							       					<option value="<%=loc%>"><%=loc %></option>
							       				<%
					       					}
					       				}
		       						%>
	       						</select>
       						</th>
		       				<th width="80px">Posted Date</th>
		       				<th width="80px">Submitted</th>
<!-- 		       				<th width="50px">Pending</th> -->
		       				<th width="80px">In Process</th>
<!-- 		       				<th width="50px">Joined</th> -->
		       				<th width="50px">View</th>
		       			</tr>	
	       			</thead>
	       			<tbody>
	       				<%
	       					if(postList != null && !postList.isEmpty())
	       					{
	       						int count = (pn-1)*GeneralConfig.rpp + 1 ;
	       						
	       						for(Post post : postList)
	       						{
	       							
	       								%>
						       			<tr>
						       				<%-- <sec:authorize access="hasRole('ROLE_CON_MANAGER')">
						        			<td><input class="sel_posts" type="checkbox" name="selector[]" value="<%=post.getPostId() %>"></td>
						        			</sec:authorize> --%>
						       				<td>
						       					<%
						       						if(post.getPublished() != null && post.getDeleteDate() == null)
						       						{
						       							%>
									       					<a title="Click to view your positions" href="cons_your_positions?pid=<%= post.getPostId()%>" id="<%= post.getPostId() %>" class="view_post"><%= post.getTitle() %> </a>
						       							<%
						       						}
						       						else
						       						{
						       							%>
							       							<a><%= post.getTitle() %> </a>
						       							<%
						       						}
						       					%>
					       					</td>
					       					<td  align="center" <%-- style="cursor: pointer;"  onclick="getClosedCandidates(<%=post.getPostId()%>)" --%>>
						       				<%= post.getNoOfPosts() %> (<%=post.getNoOfPosts()- post.getNoOfPostsFilled() %> left)

						       				</td>
						        			<td style="padding-left: 20px;">
						        			<%
						        			if(post.getCloseDate()!=null){
						        				out.println("closed");
						        			}else{
						        					if(post.isActive())
						        					{
						        						out.println("Active");
						        					}
						        					else
						        					{
						        						out.println("Inactive");
						        					}}
												%>
											</td>
					       					<td style="padding-left: 20px;"><%= post.getClient().getOrganizationName() %></td>
						       				<td style="padding-left: 20px;"><%= post.getLocation() %></td>
						       				<td align="center"><%= DateFormats.ddMMMMyyyy.format(post.getCreateDate()) %></td>
						       				<td align="center"  title="No of profiles uploaded.">
						       					<%
						       						Iterator<PostProfile> it = post.getPostProfile().iterator();
						       						int prsub = 0;
						       						int prshort = 0;
						       						int prpending = 0;
						       						int prjoined = 0;
						       						
						       						while(it.hasNext())
						       						{
						       							PostProfile pr = it.next();
						       							
						       							//System.out.println(pr.getProfile().getRegistration().getUserid() + " VS " + reg.getUserid());
														//System.out.println(pr.getProfile().getRegistration().getUserid() + " VS admin" + reg.getAdmin().getUserid());
						       							
						       							//System.out.println(" Check user : "+ pr.getProfile().getRegistration().equals(reg));
						       							//System.out.println(" Check user in set : "+ reg.getSubuser().contains(pr.getProfile().getRegistration()));
						       									
						       							if(pr.getProfile().getRegistration().getUserid().equals(reg.getUserid()))
						       							{
						       								prsub++;
						       							}
						       							else if(reg.getAdmin() != null && pr.getProfile().getRegistration().getUserid().equals(reg.getAdmin().getUserid()))
						       							{
						       								prsub++;
						       							}
						       							else if(reg.getAdmin() == null)
						       							{
						       								Iterator<Registration> itr = reg.getSubuser().iterator();
						       								while(itr.hasNext())
						       								{
						       									if(itr.next().equals(pr.getProfile().getRegistration()))
						       									{
						       										prsub++;
						       										break;
						       									}
						       								}
						       							}
						       							
						       							if(pr.getProfile().getRegistration().getUserid().equals(reg.getUserid()) && pr.getAccepted() != null)
						       							{
						       								prshort++;
						       							}
						       							else if(reg.getAdmin() != null &&  pr.getProfile().getRegistration().getUserid().equals(reg.getAdmin().getUserid()) && pr.getAccepted() != null)
						       							{
						       								prshort++;
						       							}
						       							else if(pr.getAccepted() != null && reg.getAdmin() == null)
						       							{
						       								Iterator<Registration> itr = reg.getSubuser().iterator();
						       								while(itr.hasNext())
						       								{
						       									if(itr.next().equals(pr.getProfile().getRegistration()))
						       									{
						       										prshort++;
						       										break;
						       									}
						       								}
						       							}
						       							
						       							if(pr.getAccepted() == null && pr.getRejected() == null )
						       							{
						       								prpending++;
						       							}
						       							if(pr.getJoinDate() != null)
						       							{
							       							prjoined++;
						       								
						       							}
						       						}
						       					%>
						       					<a title="Click to view your positions" href="cons_your_positions?pid=<%= post.getPostId()%>" ><%= prsub %></a>
					       					</td>
						       				<%-- <td  align="center" title="No. of profiles In Process">
						       					<a title="Click to view your positions" href="cons_your_positions?pid=<%= post.getPostId()%>" ><%= prpending %></a>
						       				</td> --%>
					       					<td  align="center" title="No. of profiles In Process">
						       					<a title="Click to view your positions" href="cons_your_positions?pid=<%= post.getPostId()%>" ><%= prshort %></a>
						       				</td>
						       				<%-- <td  align="center" title="No. of profiles In Process">
						       					<a title="Click to view your positions" href="cons_your_positions?pid=<%= post.getPostId()%>" ><%= prjoined %></a>
						       				</td> --%>
						       				<td align="center" >
						       					<div class="pre_check" style="float: none;padding:0;">
							                		<a href="consviewjd?pid=<%= post.getPostId() %>" target="_blank" class="view_post " title="Click to view post detail">
							                			<img width="20px" alt="View" src="images/view-icon.png">
						                			</a>
							                	</div>
						       				</td>
						        		</tr>
	       							<%
	       						}
	       					}
	       				%>
	       				
		        	</tbody>
		        </table>
		        
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
	    </div>
      
   

</body>
</html>
