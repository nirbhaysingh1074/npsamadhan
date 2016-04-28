<%@page import="com.unihyr.constraints.DateFormats"%>
<%@page import="com.unihyr.domain.Registration"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script type="text/javascript">
jQuery(document).ready(function() {
	
	$(document.body).on('change', '.user_list  #sel_all_user' ,function(){
// 		alert("Hello to all");
		if($('#sel_all_user').attr('checked'))
		{
			$('.sel_user:checkbox').attr('checked','checked')
		}
		else
		{
			$('.sel_user:checkbox').removeAttr('checked')
		}
		
	});
	
	
});
</script>
</head>
<body class="hold-transition skin-blue sidebar-mini">
  
      <!-- Content Wrapper. Contains page content -->
      <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
          <h1>
            List of User
            <small>Clients and consultant</small>
          </h1>
          <ol class="breadcrumb">
            <li><a href="admindashboard"><i class="fa fa-dashboard"></i> Dashboard</a></li>
            <li class="active">users</li>
          </ol>
        </section>

        <!-- Main content -->
        <section class="content">
			<div class="row">
				<div class="col-md-12" style="margin-bottom: 20px;">
					<a href="clientregistration"><button class="btn btn-primary ">Add New Client</button></a>
					<a href="consultantregistration"><button class="btn btn-primary ">Add New Consultant</button></a>
					 
				</div>
				<div class="col-md-12">  
				  <div class="box box-success" style="min-height: 200px">
		           <div class="box-header with-border bg-green">
		             <h3 class="box-title">List of Users</h3>
		
		             <div class="box-tools pull-right">
		               <button class="text-green" type="button" onclick="javascript:location.reload()"><i class="fa fa-fw fa-refresh"></i></button>
		               <button data-widget="collapse" class="btn btn-box-tool" type="button"><i class="fa fa-minus"></i>
		               </button>
<!-- 		               <button data-widget="remove" class="btn btn-box-tool" type="button"><i class="fa fa-times"></i></button> -->
		             </div>
		           </div>
		           <!-- /.box-header -->
		           <div class="box-body no-padding">
		             <table class="table posts user_list">
						<thead class="bg-gray">
							<tr>
								<th width="30px"><input type="checkbox" id="sel_all_user" class="no-margin "></th>
								<th>User Type</th>
								<th>Email</th>
								<th>Location</th>
								<th>Contact</th>
								<th>Registered</th>
								<th class="text-center">Action</th>
								
							</tr>
						</thead>
						<tbody  id="admin_user_list">
							<%
								List<Registration> regList = (List)request.getAttribute("regList");
								if(regList != null && !regList.isEmpty())
								{
									for(Registration reg : regList)
									{
										%>
											<tr id="<%= reg.getUserid() %>">
												
												<td><input type="checkbox"  class="sel_user" value="<%= reg.getUserid()%>" name="selector[]"></td>
												<td>
												<%if(reg.getConsultName()!=null){ %>
												Consultant
												<%}else{ %>
												Client
												<%} %>
												</td>
												<td><a target="_blank" href="adminuserderail?userid=<%= reg.getUserid()%>"><%= reg.getUserid() %></a></td>
												<td>
													<%= reg.getOfficeLocations()%>
												</td>
												<td><%= reg.getContact() %></td>
												<td><%= DateFormats.ddMMMMyyyy.format(reg.getRegdate()) %></td>
												<td class="text-center">
													<%
														if(reg.getLog() != null )
														{
															if(reg.getLog().getIsactive().equals("true"))
															{
																%>
<!-- 																	<button class="btn btn-sm btn-danger btn_disable">Disable User</button> -->
																<%
															}
															else
															{
																%>
<!-- 																	<button class="btn btn-sm btn-success btn_enable">enable User</button> -->
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