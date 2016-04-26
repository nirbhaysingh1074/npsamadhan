<!DOCTYPE html>
<%@page import="com.unihyr.domain.Industry"%>
<%@page import="com.unihyr.domain.Registration"%>
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
.select-wrapper {
	  background: url("images/edit.png") no-repeat;
	  background-size: cover;
	  display: block;
	  position: relative;
	  width: 33px;
	  height: 30px;
	}
	#image_src {
	  width: 26px;
	  height: 26px;
	  margin-right: 100px;
	  opacity: 0;
	  cursor: pointer;
	  filter: alpha(opacity=0); /* IE 5-7 */
	}
</style>
<script type="text/javascript">
	$(document.body).on('change', '#image_src' ,function(){
    	var defult_logo = $('#client_logo').attr("src"); 
		$('#client_logo').attr("src", "images/loading.gif");
//     	alert("hello to all");
    	var image=document.getElementById("image_src").files[0];
		var senddata=new FormData();
    	senddata.append("image", image);
    	$.ajax({
	 		  url: "${pageContext.request.contextPath}/consultant.uploadLogo",
	 		  type: "POST",
	 		  async: "false",
	 		  data: senddata,
		 		 xhr: function() {
		                var myXhr = $.ajaxSettings.xhr();
		                if(myXhr.upload){
		                    myXhr.upload.addEventListener('progress',OnProgress, false);
		                }
		                return myXhr;
		        },
	 		  processData: false,  // tell jQuery not to process the data
	 		  contentType: false,   // tell jQuery not to set contentType
	 		  success:function(response)
	 		  {
	 			  if(response != "failed")
 				  {
 				  	$('#client_logo').attr("src",response);
 				  	$('.brnad_logo img').attr("src",response);
 				  }
	 			  else
 				  {
	 				 $('#client_logo').attr("src", defult_logo); 
 				  }
	 			  
	 		  }
	 		 
	 		});
    });
    function OnProgress(e){    
        //Progress bar
    	if(e.lengthComputable){
            var max = e.total;
            var current = e.loaded;

            var Percentage = (current * 100)/max;
	        $('#status').html(parseInt(Percentage) + '%'); 
            

            if(Percentage >= 100)
            {
            	$('#status').html("Image Uploaded successfully");
            	
            }
        } 
       
    }
</script>
</head>
<body class="loading">
<div class="mid_wrapper">
  <div class="container">
    <div class="positions_info">

	<%
		Registration reg = (Registration)request.getAttribute("registration");
		if(reg != null)
		{
			if(reg.getAdmin() != null)
			{
				%>
			      <div class="filter">
			        <div class="col-md-7 pagi_summary"><span><%= reg.getConsultName() %> ( <%= reg.getName() %>)</span></div>
			      </div>
				<%

			}
			else
			{
				%>
			      <div class="filter">
			        <div class="col-md-7 pagi_summary"><span><%= reg.getConsultName() %></span></div>
			      </div>
				<%
			}
			%>
		      <div class="positions_tab" style="border: 1px solid gray;background: #fff5db none repeat scroll 0 0;">
		        <div class="form_cont">
			        <div class="form_col">
						<dl>
							<dt>
								<label>Logo</label>
							</dt>
							<dd>
								<div>
									<span class="select-wrapper" style="float: left; position: absolute;cursor: pointer;">
<!-- 										<img alt="" src="images/edit.png" width="20px"> -->
										<input type="file" id="image_src">
									 </span>
									<div style="width: 200px;margin: 10px 0; height: 100px;text-align: center;background-color: #e8e8e8;">
										<%
											if(reg.getLogo() != null && reg.getLogo().length() > 0)
											{
												%>
													<img id="client_logo"  src="<%= reg.getLogo() %>" style="max-width: 200px; max-height: 100px;">
												<%
											}
											else
											{
												%>
													<img id="client_logo" src="images/camera-icon.png" style="max-width: 200px; max-height: 100px;">
												<%
											}
										%>
									</div>
								</div>
							</dd>
						</dl>
						<%
						if(reg.getAdmin() != null)
						{
							%>
							<dl>
								<dt>
									<label>User Name</label>
								</dt>
								<dd>
									<label><%= reg.getName()%></label>
									
								</dd>
							</dl>
							<%
						}
						%>
						<dl>
							<dt>
								<label>Consultant Name</label>
							</dt>
							<dd>
								<label><%= reg.getConsultName()%></label>
								
							</dd>
						</dl>
						<dl>
							<dt>
								<label>Email id</label>
							</dt>
							<dd>
								<label><%= reg.getUserid() %></label>
								
							</dd>
						</dl>
						<%
							if(reg.getIndustries() != null)
							{
								%>
								<dl>
									<dt>
										<label>Industry</label>
									</dt>
									<dd>
										<label>
											<%
												Iterator<Industry> it = reg.getIndustries().iterator();
												while(it.hasNext())
												{
													Industry ind = it.next();
													%>
														<a ><%= ind.getIndustry() %> </a>
													<%
												}
											%>
										</label>
										
									</dd>
								</dl>
								<%
							}
						%>
						<dl>
							<dt>
								<label>Revenues</label>
							</dt>
							<dd>
								<label><%= reg.getRevenue() %></label>
								
							</dd>
						</dl>
						<dl>
							<dt>
								<label>Contact No.</label>
							</dt>
							<dd>
								<label><%= reg.getContact() %></label>
								
							</dd>
						</dl>
						<%
							if(reg.isConsultant_type())
							{
								%>
									<dl>
										<dt>
											<label>Organization Size </label>
										</dt>
										<dd>
											<label><%= reg.getNoofpeoples() %> </label>
											
										</dd>
									</dl>
								<%
							}
						%>
						<dl>
							<dt>
								<label>Address</label>
							</dt>
							<dd>
								<label><%= reg.getOfficeLocations() %> </label>
								
							</dd>
						</dl>
						
			        </div>
			        <div class="form_col">
			        	<div class="filter bottom-margin" style="border-radius:0">
					        <div class="col-md-7 pagi_summary"><span>Change Password </span></div>
					    </div>
					    <%
					    	String status = (String)request.getAttribute("status");
					    	if(status != null && status.equals("success"))
					    	{
					    		%>
					    			<dl>
										<dd>
											<h3 class="success">Password changed successfully !</h3>	
										</dd>
									</dl>
					    		<%
					    	}
					    	else if(status != null && status.equals("wrongoldpassword"))
					    	{
					    		%>
					    			<dl>
										<dd>
											<h3 class="error">Old Password not matched !</h3>	
										</dd>
									</dl>
					    		<%
					    	}
					    	else if(status != null && status.equals("notmatched"))
					    	{
					    		%>
					    			<dl>
										<dd>
											<h3  class="error">Re-Password not matched as new password</h3>	
										</dd>
									</dl>
					    		<%
					    	}
					    %>
					    <div style="clear: both;"></div>
			        	<form action="changeUserPassword" method="POST" autocomplete="off">
				        	<dl>
								<dt>
									<label>Old Password</label>
								</dt>
								<dd>
									<input type="password" name="oldPassword" autocomplete="off">
									
								</dd>
							</dl>
							<div style="clear: both;"></div>
							<dl>
								<dt>
									<label>New Password</label>
								</dt>
								<dd>
									<input type="password"  name="newPassword" >
									
								</dd>
							</dl>
							<div style="clear: both;"></div>
							<dl>
								<dt>
									<label>Re-Password</label>
								</dt>
								<dd>
									<input type="password"  name="rePassword">
								</dd>
							</dl>
							<div style="clear: both;"></div>
				        	<dl>
								<dt>
									<label>&nbsp;</label>
								</dt>
								<dd>
									<input class="btn yelo_btn" type="submit" value="Change Password" name="btn_response">
	<!-- 									<input class="btn yelo_btn" type="submit" value="Save" name="btn_response"> -->
								</dd>
							</dl>
						</form>
			        </div>
			        
			        
			        
				    <sec:authorize access="hasRole('ROLE_CON_MANAGER')">
				        <div class="form_col">
				        	<div class="filter bottom-margin" style="border-radius:0">
						        <div class="col-md-7 pagi_summary"><span>Co-Users</span></div>
						        <div class="col-md-5 pagi_summary ">
								    <div class="text-right">
								    	<a href="consnewuser" style="color: #fff;">Add New User</a>
								    </div>
								    
						        </div>
						    </div>
						    <table class="table">
						    	<thead>
						    		<tr>
						    			<th class="text-left">User Name</th>
						    			<th class="text-left">User Id</th>
						    			<th>Create Date</th>
					    			</tr>
					    		</thead>
					    		<tbody>
								    <%
								    	List<Registration> co_users = (List)request.getAttribute("co-users");
								    	if(co_users != null && ! co_users.isEmpty())
								    	{
								    		for(Registration user : co_users)
								    		{
								    			%>
									    			<tr>
									    				<td><%= user.getName() %></td>
									    				<td><%= user.getUserid() %></td>
									    				<td class="text-center"><%= DateFormats.getTimeValue(user.getRegdate()) %></td>
									    			</tr>
								    			<%
								    		}
								    	}
								    	else
								    	{
								    		%>
								    			<tr>
								    				<td colspan="3">
								    					<span>No user available</span>
								    				</td>
								    			</tr>
								    		<%
								    	}
								    %>
					    		</tbody>
						    </table>
				    	</div>
			    	</sec:authorize>
			    </div>
	        </div>
			        
			        
			        
			        
			        
			        
			        
		        </div>
		        
		      </div>
			<%
		}
				
		%>
		</div>
	</div>
</div>
</body>
</html>
