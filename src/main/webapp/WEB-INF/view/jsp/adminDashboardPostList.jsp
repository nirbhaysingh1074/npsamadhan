<%@page import="com.unihyr.domain.PostProfile"%>
<%@page import="com.unihyr.constraints.DateFormats"%>
<%@page import="com.unihyr.domain.Post"%>
<%@page import="java.util.List"%>
<%
	List<Post> postList = (List)request.getAttribute("postList");
%>
<div class="col-md-6 col-sm-12 col-xs-12">
	<div class="box box-success">
           <div class="box-header with-border bg-green">
             <h3 class="box-title">Post List</h3>

             <div class="box-tools pull-right">
               <button data-widget="collapse" class="btn btn-box-tool" type="button"><i class="fa fa-minus"></i>
               </button>
               <button data-widget="remove" class="btn btn-box-tool" type="button"><i class="fa fa-times"></i></button>
             </div>
           </div>
           <!-- /.box-header -->
           <div class="box-body no-padding">
               <table class="table posts">
				<thead class="bg-gray">
					<tr>
						<th>Job Code</th>
						<th>Post Title</th>
						<th>Client</th>
						<th>Date</th>
						<th>Status</th>
					</tr>
				</thead>
				<tbody >
					<%
						if(postList != null && !postList.isEmpty())
						{
							for(Post post : postList)
							{
								%>
									<tr>
										<td><%= post.getJobCode() %></td>
										<td><%= post.getTitle() %></td>
										<td><%= post.getClient().getOrganizationName() %></td>
										<td><%= DateFormats.ddMMMMyyyy.format(post.getCreateDate()) %></td>
										<td><% if(post.isActive()){out.println("Active");}else{out.println("Inactive");} %></td>
									</tr>
								<%
							}
						}
					%>
					
				</tbody>
			</table>
           </div>
           <!-- /.box-body -->
      </div>

	
</div>
<%
	List<PostProfile> ppList = (List)request.getAttribute("ppList");
%>
<div class="col-md-6 col-sm-12 col-xs-12">
	<div class="box box-success">
           <div class="box-header with-border bg-green">
             <h3 class="box-title">Profiles Uploaded</h3>

             <div class="box-tools pull-right">
               <button data-widget="collapse" class="btn btn-box-tool" type="button"><i class="fa fa-minus"></i>
               </button>
               <button data-widget="remove" class="btn btn-box-tool" type="button"><i class="fa fa-times"></i></button>
             </div>
           </div>
           <!-- /.box-header -->
           <div class="box-body no-padding">
               <table class="table posts">
				<thead class="bg-gray">
					<tr>
						<th>Candidate Name</th>
						<th>Current Role</th>
						<th>Post Title</th>
						<th>Submitted</th>
						
					</tr>
				</thead>
				<tbody >
					<%
						if(ppList != null && !ppList.isEmpty())
						{
							for(PostProfile pp : ppList)
							{
								%>
									<tr>
										<td><%= pp.getProfile().getName() %></td>
										<td><%= pp.getProfile().getCurrentRole() %></td>
										<td><%= pp.getPost().getTitle() %></td>
										<td><%= DateFormats.ddMMMMyyyy.format(pp.getSubmitted()) %></td>
									</tr>
								<%
							}
						}
					%>
					
				</tbody>
			</table>
           </div>
           <!-- /.box-body -->
      </div>

	
</div>

		