<!DOCTYPE html>
<%@page import="com.unihyr.constraints.GeneralConfig"%>
<%@page import="com.artofsolving.jodconverter.openoffice.converter.OpenOfficeDocumentConverter"%>
<%@page import="com.artofsolving.jodconverter.DocumentConverter"%>
<%@page import="java.net.ConnectException"%>
<%@page import="com.artofsolving.jodconverter.openoffice.connection.SocketOpenOfficeConnection"%>
<%@page import="com.artofsolving.jodconverter.openoffice.connection.OpenOfficeConnection"%>
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
<link rel="stylesheet" type="text/css" href="css/demo.css">

<script type="text/javascript" src="js/accordion.js"></script>
</head>
<body class="loading">
<div class="mid_wrapper">
  <div class="container" >
  	<div class="new_post_info" style="margin-top: 10px">
	<%
		Post post = (Post)request.getAttribute("post");
		if(post != null)
		{
			%>
		      <div class="filter">
		        <div class="col-md-7  pagi_summary"><span><%= post.getJobCode()%> ( <%= post.getTitle() %> - <%= post.getLocation() %> )</span></div>
		        <div class="col-md-5">
		<!--           <div class="set_col"><a href=""><img src="images/ic_1.png" alt="img"> <img src="images/ic_2.png" alt="img"></a></div> -->
		          <ul class="page_nav">
		            <%

			            if(post.getDeleteDate() == null)
		            	{ 
		            		%>
		            			<li class="active" ><a href="clientpostapplicants?pid=<%=post.getPostId()%>">Applied Candidates</a></li> 
		            		<%
		            	}
		            
			           /*  if(post.getDeleteDate() == null)
		            	{ */
		            		%>
	          				<sec:authorize access="hasRole('ROLE_EMP_MANAGER')">
<%-- 		            			<li class="active post_delete" id="<%= post.getPostId()%>"><a href="javascript:void(0)">Delete</a></li> --%>
		            		<%
		            	//}
			            
		            	if(post.getCloseDate() == null)
		            	{
		            	if(post.getCloseRequestClient()!=null){
		            		%>
	            			<li class="active" id="<%= post.getPostId()%>" title="Reqeust sent already"><a href="javascript:void(0)">Close</a></li>
	            		<%
		            	}else{
		            		%>
<%-- 		            			<li class="active post_close" id="<%= post.getPostId()%>"><a href="javascript:void(0)">Close</a></li> --%>
		            		<%
		            	}}
			            
		            	if(post.isActive())
		            	{
		            		%>
		            			<li class="active post_inactivate" id="<%= post.getPostId()%>"><a href="javascript:void(0)">Inactivate</a></li>
		            		<%
		            	}
		            	else
		            	{
		            		%>
		            			<li class="active post_activate" id="<%= post.getPostId()%>"><a href="#">Activate</a></li>
		            		<%
		            	}
		            
		            
		            %>
		            
		            <li class="active"><a href="clienteditpost?pid=<%=post.getPostId() %>">Edit</a></li>
		          </sec:authorize>
		          </ul>
		        </div>
		      </div>
		      <div class="positions_tab  bottom-margin" style="border: 1px solid gray;">
		        <div class="form_cont">
			        <div class="form_col">
						<dl>
							<dt>
								<label>Job Code</label>
							</dt>
							<dd>
								<label><%= post.getJobCode() %></label>
								
							</dd>
						</dl>
						<dl>
							<dt>
								<label>Title</label>
							</dt>
							<dd>
								<label><%= post.getTitle() %></label>
								
							</dd>
						</dl>
						<dl>
							<dt>
								<label>Location</label>
							</dt>
							<dd>
								<label><%= post.getLocation() %></label>
								
							</dd>
						</dl>
						
						<dl>
							<dt>
								<label>No of posts</label>
							</dt>
							<dd>
								<label><%= post.getNoOfPosts() %></label>
								
							</dd>
						</dl>
						<dl>
							<dt>
								<label>Role</label>
							</dt>
							<dd>
								<label><%= post.getRole() %></label>
								
							</dd>
						</dl>
						<dl>
							<dt>
								<label>Designation</label>
							</dt>
							<dd>
								<label><%= post.getDesignation()%></label>
								
							</dd>
						</dl>
						<dl>
							<dt>
								<label>Role Type</label>
							</dt>
							<dd>
								<label><%= post.getFunction() %></label>
								
							</dd>
						</dl>
						
						<dl>
							<dt>
								<label>Exp.</label>
							</dt>
							<dd>
								<label><%= post.getExp_min() %> - <%= post.getExp_max() %> Year(s)</label>
								
							</dd>
						</dl>
						<dl>
							<dt>
								<label>Annual CTC</label>
							</dt>
							<dd>
								<label><%= post.getCtc_min() %> - <%= post.getCtc_max() %> Lacs</label>
								
							</dd>
						</dl>
						
						<dl>
							<dt>
								<label>Publish Status</label>
							</dt>
							<dd>
								<label>
									<%
										if(post.getPublished() != null)
										{
											%>
												<a > Published on <%= DateFormats.ddMMMMyyyyathhmm.format(post.getPublished()) %> </a>
											<%
										}
										else
										{
											%>
												<a > Not Published </a>
											<%
										}
									%>
								</label>
								
							</dd>
						</dl>
						<dl>
							<dt>
								<label>Active Status</label>
							</dt>
							<dd>
								<label>
									<%
										if(post.isActive())
										{
											%>
												<span>Active</span>
											<%
										}
										else
										{
											%>
												<span>Inactive</span>
											<%
										}
									%>
								</label>
								
							</dd>
						</dl>
						<%
							if(post.getDeleteDate() != null)
							{
								%>
									<dl>
										<dt>
											<label>Delete On</label>
										</dt>
										<dd>
											<label>
															<span><%= DateFormats.ddMMMMyyyyathhmm.format(post.getDeleteDate()) %></span>
											</label>
											
										</dd>
									</dl>
								<%
							}
						%>
						<dl>
							<dt>
								<label>Client</label>
							</dt>
							<dd>
								<label>
									<%=
										post.getClient().getOrganizationName()
										
									%>
								</label>
								
							</dd>
						</dl>
					<%-- 	<dl>
							<dt>
								<label>Profile Quota</label>
							</dt>
							<dd>
								<label><% if( post.getProfileParDay()> 0){%><%=post.getProfileParDay()%><%}else{%>NA<%} %></label>
							</dd>
						</dl> --%>
						<dl>
							<dt>
								<label>Additional Comments</label>
							</dt>
							<dd>
								<label><%= post.getComment() %></label>
								
							</dd>
						</dl>
						 <dl>
							<dt>
								<label>Profile Quata</label>
							</dt>
							<dd>
								<%
									if(post.getProfileParDay() > 0)
									{
										%>
											<label><%= post.getProfileParDay() %></label>
										<%
									}
									else
									{
										%>
											<label>No Limit</label>
										<%
									}
								%>
								
							</dd>
						</dl> 
						<%
							if(post.getEditSummary() != null)
							{
								%>
									<dl>
										<dt>
											<label>Edit Summary</label>
										</dt>
										<dd>
											<label><%= post.getEditSummary() %></label>
											
										</dd>
									</dl>
								<%
							}
						%>
				<%-- 		<%
							if(post.getUploadjd() != null)
							{
								%>
									<dl>
										<dt>
											<label><a href="data/<%= post.getUploadjd()%>">Download JD</a></label>
										</dt>
									</dl>
								<%
							}
						%> --%>
						<div class="clearfix" style="padding: 15px">
							<h3><b>Job Description</b></h3><br>
							<p><%= post.getAdditionDetail() %></p>
						</div>
			        </div>
		        </div>
		        <div id="jobDescription">
		        </div>
		      </div>
							  <%
							 if(post.getUploadjd()!=null){
					            String scheme = request.getScheme();
							    String serverName = request.getServerName();
							    int serverPort = request.getServerPort();
					            String inPath=GeneralConfig.UploadPath+ post.getUploadjd();
					         	String otp=post.getUploadjd().substring(0,post.getUploadjd().lastIndexOf("."));
					         	String outPath=GeneralConfig.UploadPath+otp+".pdf";
					        	java.io.File inputFile = new java.io.File(inPath); //
					        	java.io.File outputFile = new java.io.File(outPath); //
					        	  OpenOfficeConnection connection = new	  SocketOpenOfficeConnection("127.0.0.1",8100);
					        	  try {
					        		connection.connect();
					        	} catch (ConnectException e) {
					        		// TODO Auto-generated catch block
					        		e.printStackTrace();
					        	} // convert 
					        	  	DocumentConverter	 converter = new  OpenOfficeDocumentConverter(connection);
					        	  	converter.convert(inputFile, outputFile); // close
					        	  	connection.disconnect(); 
					        		String pathh=outputFile.getName();
					        	%>
					        			<script type="text/javascript">
					        			 	var x = document.createElement("EMBED");
					        			 	//path=path.replace(/\//g, "////");
					        			    x.setAttribute("src", "data/<%=pathh%>");
					        			    x.setAttribute("height", "600px");
					        			    x.setAttribute("width", "100%");
					        				$('#jobDescription').append(x);
					        			</script>
			<%}%> 
		<%}%> 
	</div>
</div>
</div>
</body>
</html>
