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

</head>
<body class="loading">
<div class="mid_wrapper">
  <div class="container">
    <div class="positions_info">

	<%
		Registration reg = (Registration)request.getAttribute("userdetails");
		if(reg != null)
		{
			
				%>
			      <div class="filter">
			        <div class="col-md-7 pagi_summary"><span> <%= reg.getUserid() %>   </span> 
			        <span style="margin-left: 10px;">(
			         	<%
							if(reg.getName() != null)
							{
								%>
									<%= reg.getName() %>
								<%
							}
							else if(reg.getOrganizationName() != null)
							{
								%>
									<%= reg.getOrganizationName() %>
								<%
							}
							else if(reg.getConsultName() != null)
							{
								%>
									<%= reg.getConsultName() %>
								<%
							}
						%>
			         )</span> 
			        </div>
			      </div>
			      <div class="positions_tab" >
			        <div class="form_cont">
				        <div class="form_col">
							
							<%
								if(reg.getName() != null)
								{
									%>
										<dl>
											<dt>
												<label>Name</label>
											</dt>
											<dd>
												<label><%= reg.getName() %></label>
												
											</dd>
										</dl>
									<%
								}
							%>
							
							<dl>
								<dt>
									<label>Email id</label>
								</dt>
								<dd>
									<label><%= reg.getUserid() %></label>
									
								</dd>
							</dl>
							<dl>
								<dt>
									<label>&nbsp;</label>
								</dt>
								<dd>
									<%
										if(reg.getLog() != null)
										{
											
											if(reg.getLog().getIsactive().equals("true"))
											{
												%>
												<sec:authorize access="hasRole('ROLE_EMP_MANAGER')">
												
													<a href="clientDisableUser?childId=<%= reg.getUserid() %>" class="btn yelo_btn">Disable User</a>
													
													</sec:authorize>
													<sec:authorize access="hasRole('ROLE_CON_MANAGER')">
													<a href="consDisableUser?childId=<%= reg.getUserid() %>" class="btn yelo_btn">Disable User</a>
													
													</sec:authorize>
												<%
											}
											else
											{
												%><sec:authorize access="hasRole('ROLE_EMP_MANAGER')">
													<a href="clientEnableUser?childId=<%= reg.getUserid() %>" class="btn yelo_btn">Enable User</a>
												
													</sec:authorize>
													<sec:authorize access="hasRole('ROLE_CON_MANAGER')">
													<a href="consEnableUser?childId=<%= reg.getUserid() %>" class="btn yelo_btn">Enable User</a>
													
													</sec:authorize>
													
													<%
											}
										}
									%>
								</dd>
							</dl>
							
							
				        </div>
				        <div class="form_col">
					        	<div class="filter bottom-margin" style="border-radius:0">
							        <div class="col-md-7 pagi_summary"><span >Change Password  ${status }</span></div>
							    </div>
					        	<form action="changeChildPassword" method="POST" autocomplete="off">
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
								    	
								    	else if(status != null && status.equals("notmatched"))
								    	{
								    		%>
								    			<dl>
													<dd>
														<h3  class="error">Re-Password not matched as new password</h3>
														<h3  class="error">Or password must be alphanumeric</h3>	
													</dd>
												</dl>
								    		<%
								    	}
								    %>
								    <div style="clear: both;"></div>
						        	<dl>
										<dt>
											<label>New Password</label>
										</dt>
										<dd>
											<input type="hidden" name="childId" value="<%= reg.getUserid()%>">
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
										</dd>
									</dl>
									
								</form>
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
