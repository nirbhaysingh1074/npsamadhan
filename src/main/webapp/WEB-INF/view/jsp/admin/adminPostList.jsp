<%@page import="com.unihyr.domain.PostProfile"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
<%@page import="com.unihyr.domain.Post"%>
<%@page import="com.unihyr.constraints.DateFormats"%>
<%@page import="com.unihyr.domain.Registration"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

</head>
<body class="hold-transition skin-blue sidebar-mini" onload="load_admin_post(); load_admin_profile(); load_admin_client(); load_admin_consultant();">
  
      <!-- Content Wrapper. Contains page content -->
      <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
          <h1>
            List of Posts
            <small>Clients and consultant</small>
          </h1>
          <ol class="breadcrumb">
            <li><a href="admindashboard"><i class="fa fa-dashboard"></i> Dashboard</a></li>
            <li class="active">posts</li>
          </ol>
        </section>

        <!-- Main content -->
        <section class="content">
			<div class="row">
				<div class="col-md-3" style="margin-bottom: 10px;">
					<select class="form-control">
						<option value="Today">Today</option>
						<option value="Week">Last Week</option>
						<option value="Month">Last Month</option>
						<option value="Year">Last Year</option>
						<option value="All">All Posts</option>
						
					</select>
				</div>
			</div>
			<div class="row">
				<div class="col-md-12">  
				  <div class="box box-success" style="min-height: 200px">
		           <div class="box-header with-border bg-green">
		             <h3 class="box-title">List of Posts</h3>
		
		             <div class="box-tools pull-right">
		               <button class="text-green" type="button" onclick="javascript:location.reload()"><i class="fa fa-fw fa-refresh"></i></button>
		               <button data-widget="collapse" class="btn btn-box-tool" type="button"><i class="fa fa-minus"></i>
		               </button>
<!-- 		               <button data-widget="remove" class="btn btn-box-tool" type="button"><i class="fa fa-times"></i></button> -->
		             </div>
		           </div>
		           <!-- /.box-header -->
		           <div class="box-body no-padding">
		             <table class="table posts">
						<thead class="bg-gray">
							<tr>
								<th>Job Id</th>
								<th>Title</th>
								<th>Location</th>
								<th>No of posts</th>
								<th>Role</th>
								<th>Experience</th>
								<th>Status</th>
								<th>Received</th>
								<th>Shortlisted</th>
								<th>Posted</th>
								<th>Verified</th>
								<th>Action</th>
							</tr>
						</thead>
						<tbody  id="load_admin_consultant">
							<%
								List<Post> pList = (List)request.getAttribute("pList");
								if(pList != null && !pList.isEmpty())
								{
									for(Post post : pList)
									{
										Set<Integer> cons = new HashSet(); 
		       							Set<Long> shortListed = new HashSet();
		       							Iterator<PostProfile> it = post.getPostProfile().iterator();
		       							while(it.hasNext())
		       							{
		       								PostProfile pp = it.next();
		       								if(pp.getAccepted() != null)
		       								{
		       									shortListed.add(pp.getPpid());
		       								}
		       							}
										
										%>
											<tr>
												<td>
													<a target="_blank" href="adminviewjd?pid=<%= post.getPostId()%>"><%= post.getJobCode()%></a>
												</td>
												<td><a target="_blank" href="adminviewjd?pid=<%= post.getPostId()%>"><%= post.getTitle() %></a></td>
												<td><%= post.getLocation()%></td>
												<td class="text-center"><%= post.getNoOfPosts()%></td>
												<td><%= post.getRole()%></td>
												<td class="text-center"><%= post.getExp_min() +" - " + post.getExp_max()%> Years</td>
												<td>
													<%
														if(post.getCloseDate() != null)
														{
															%><span class="label label-danger" title='Closed on <%=  DateFormats.ddMMMMyyyy.format(post.getCloseDate()) %>' >Closed</span><%
														}
														else if(post.isActive())
														{
															%><span class="label label-success">Active</span><%
														}
														else
														{
															%><span class="label label-danger">Inactive</span><%
														}
													%>
												</td>
												
												<td style="text-align: center;"><%= post.getPostProfile().size() %></td>
						       					<td style="text-align: center;"><%= shortListed.size() %></td>
						       					<td  class="text-center"><%= DateFormats.ddMMMMyyyy.format(post.getCreateDate()) %></td>
												<td><% if(post.getVerifyDate() != null){%><span class="label label-success">Verified</span><%}else{%><span class="label label-danger">Not Verified</span><%} %></td>
												<td>
													<%
													if(post.getCloseDate() != null)
													{
														out.println("no action");
													}
													else
													{
														if(post.getCloseRequestClient()!=null||post.getCloseRequestConsultant()!=null)
														{ 
															%>
																<button onclick="acceptPostCloseRequest('<%=post.getPostId()%>')">Close</button>
															<%
														}
													} 
													%>
												</td>
											</tr>
										<%
									}
								}
							
							%>
							
						</tbody>
					</table>
		           </div>
		           <div class="overlay">
		              <i class="fa fa-refresh fa-spin"></i>
		            </div>
		           <!-- /.box-body -->
	      		</div>
	          </div>  
	        </div>  
        </section><!-- /.content -->
      </div><!-- /.content-wrapper -->
<script type="text/javascript">
jQuery(document).ready(function() {
	$('.overlay').hide();
});
</script>    
  </body>
</html>