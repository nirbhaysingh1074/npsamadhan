<!DOCTYPE html>
<%@page import="com.unihyr.constraints.NumberUtils"%>
<%@page import="com.unihyr.constraints.GeneralConfig"%>
<%@page import="com.artofsolving.jodconverter.openoffice.converter.OpenOfficeDocumentConverter"%>
<%@page import="com.artofsolving.jodconverter.DocumentConverter"%>
<%@page import="java.net.ConnectException"%>
<%@page import="com.artofsolving.jodconverter.openoffice.connection.SocketOpenOfficeConnection"%>
<%@page import="com.artofsolving.jodconverter.openoffice.connection.OpenOfficeConnection"%>
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
<link rel="stylesheet" type="text/css" href="css/demo.css">

<script type="text/javascript" src="js/accordion.js"></script>
</head>
<body class="loading">
<div class="mid_wrapper">
  <div class="container" >
  	<div class="new_post_info" style="margin-top: 10px">
	<%
		Post post = (Post)request.getAttribute("post");
	Registration registration=(Registration)request.getAttribute("registration");
		if(post != null)
		{
			%>
		      <div class="filter">
		        <div class="col-md-7  pagi_summary"><span><%= post.getJobCode()%> ( <%= post.getTitle() %> - <%= post.getLocation() %> )</span></div>
		        <div class="col-md-5">
		          <sec:authorize access="hasRole('ROLE_EMP_MANAGER') or hasRole('ROLE_EMP_USER')">
		          <ul class="page_nav">
		            <li class="active"><a href="clienteditpost?pid=<%=post.getPostId() %>">Edit</a></li>
		          </ul>
		          </sec:authorize>
		          <sec:authorize access="hasRole('ROLE_CON_MANAGER')">
		          <ul class="page_nav">
		           <%if(post.getCloseDate()!=null){ %>
		          
		            <li  class="active">
		              <a href="javascript:void(0)" >Post Closed</a>
		           </li>
		           <%}else{ %>
	          		<%--   
	          		<li class="active">
		            <a href="javascript:void(0)" onclick="consCloseRequest('<%=post.getPostId() %>')" >Close Request</a>
		            </li> 
		            --%>
		             <%} 
		   			Registration reg = (Registration)request.getSession().getAttribute("registration");
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
         				%>
		            <li class="active">
		           		 <a href="cons_your_positions?pid=<%=post.getPostId() %>" >Applied Candidates</a>
		            </li>
         			<%}else{
		             %>
		            <li class="active">
		           		 <a href="javascript:void(0)" onclick="consShowInterest('<%=post.getPostId() %>')" >Add to active positions</a>
		            </li>
		            <%} %>
		          </ul>
		          </sec:authorize>
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
								<label>Function</label>
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
								<label>Expected Salary</label>
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
						<dl><p style="font-weight: bold;">Contract Info</p>
	        <table class="table no-margin" style="border: 1px solid gray;width:100%;">
	       <thead>
	        <tr style="text-align:left; ">
	        <th>Slab no.</th>
	        <th>Min Billable CTC (INR)</th>
	        <th>Max Billable CTC (INR)</th>
	        <th>Fee Percent (%)</th>
	        </tr>
	        </thead>
	        <tbody>
	        <tr >
	        
	        <td>1.</td>
	        <td><%=NumberUtils.convertNumberToCommoSeprated(registration.getCtcSlabs1Min()) %></td>
	        <td><%=NumberUtils.convertNumberToCommoSeprated(registration.getCtcSlabs1Max()) %></td>
	        <td><%=registration.getFeePercent1() %></td>
	        </tr>
	        <tr >
	        <td>2.</td>
	        <td><%=NumberUtils.convertNumberToCommoSeprated(registration.getCtcSlabs2Min()) %></td>
	        <td><%=NumberUtils.convertNumberToCommoSeprated(registration.getCtcSlabs2Max()) %></td>
	        <td><%=registration.getFeePercent2() %></td>
	        </tr>
	        <tr >
	        <td>3.</td>
	        <td><%=NumberUtils.convertNumberToCommoSeprated(registration.getCtcSlabs3Min()) %></td>
	        <td><%=NumberUtils.convertNumberToCommoSeprated(registration.getCtcSlabs3Max()) %></td>
	        <td><%=registration.getFeePercent3() %></td>
	        </tr>
	        <tr >
	        <td>4.</td>
	        <td><%=NumberUtils.convertNumberToCommoSeprated(registration.getCtcSlabs4Min()) %></td>
	        <td><%=NumberUtils.convertNumberToCommoSeprated(registration.getCtcSlabs4Max()) %></td>
	        <td><%=registration.getFeePercent4() %></td>
	        </tr>
	        <tr >
	        <td>5.</td>
	        <td><%=NumberUtils.convertNumberToCommoSeprated(registration.getCtcSlabs5Min()) %></td>
	        <td>No limit</td>
	        <td><%=registration.getFeePercent5() %></td>
	        </tr>
	        </tbody>
	        </table>
						
						</dl>
						<dl></dl>
						<dl style="clear: both;">
							<dt>
								<label>Comment</label>
							</dt>
							<dd>
								<label><%= post.getComment() %></label>
								
							</dd>
						</dl>
						
						<div class="clearfix" style="padding: 15px">
							<h3><b>Additional Description</b></h3><br>
							<p><%= post.getAdditionDetail() %></p>
						</div>
						
			        </div>
			         <div class="block coment_fild" style="padding-top: 15px;">
	        
	        <div class="form_col" >
	        
	        
	          <%-- <dl style="width: 100%;">
	          <dt  style="width: 100%;text-align: center;">
	          <strong style="font-size: 16px;">
	          Contract Info</strong> </dt>
	          </dl>
	          <dl style="width: 30%;">
	          <dt  style="width: 50%;">
	          <label>Billable CTC Slab1 : </label>
	          
	          </dt>
	          <dd style="width: 50%;">
	          <%=registration.getCtcSlabs1Min() %> to <%=registration.getCtcSlabs1Max() %> (INR)
	          </dd>
	          </dl>
	          <dl style="width: 20%;">
	          
	          <dt style="width: 50%;">
	          <label>Fee Percent : </label>
	          
	          </dt>
	          <dd style="width: 50%;">
	          <%=registration.getFeePercent1() %>
	          </dd>
	          
	          </dl>
	          <dl style="width: 30%;">
	          <dt style="width: 50%;">
	          <label>Billable CTC Slab2 : </label>
	          
	          </dt>
	          <dd style="width: 50%;">
	          <%=registration.getCtcSlabs2Min() %> to <%=registration.getCtcSlabs2Max() %> (INR)
	          </dd>
	          </dl>
	          <dl style="width: 20%;">
	          
	          <dt style="width: 50%;">
	          <label>Fee Percent : </label>
	          
	          </dt>
	          <dd style="width: 50%;">
	          <%=registration.getFeePercent2() %>
	          </dd>
	          
	          </dl>
	          <dl style="width: 30%;">
	          <dt style="width: 50%;">
	          <label>Billable CTC Slab3 : </label>
	          
	          </dt>
	          <dd style="width: 50%;">
	          <%=registration.getCtcSlabs3Min() %> to <%=registration.getCtcSlabs3Max() %> (INR)
	          </dd>
	          </dl>
	          <dl style="width: 20%;">
	          
	          <dt style="width: 50%;">
	          <label>Fee Percent : </label>
	          
	          </dt>
	          <dd style="width: 50%;">
	          <%=registration.getFeePercent3() %>
	          </dd>
	          
	          </dl>
	          <dl style="width: 30%;">
	          <dt style="width: 50%;">
	          <label>Billable CTC Slab4 : </label>
	          
	          </dt>
	          <dd style="width: 50%;">
	          <%=registration.getCtcSlabs4Min() %> to <%=registration.getCtcSlabs4Max() %> (INR)
	          </dd>
	          </dl>
	          <dl style="width: 20%;">
	          
	          <dt style="width: 50%;">
	          <label>Fee Percent : </label>
	          
	          </dt>
	          <dd style="width: 50%;">
	          <%=registration.getFeePercent4() %>
	          </dd>
	          
	          </dl>
	          <dl style="width: 30%;">
	          <dt style="width: 50%;">
	          <label>Billable CTC Slab5 : </label>
	          
	          </dt>
	          <dd style="width: 50%;">
	          <%=registration.getCtcSlabs5Min() %> to no limit (INR)
	          </dd>
	          </dl>
	          <dl style="width: 20%;">
	          
	          <dt style="width: 50%;">
	          <label>Fee Percent : </label>
	          
	          </dt>
	          <dd style="width: 50%;">
	          <%=registration.getFeePercent5() %>
	          </dd>
	          
	          </dl> --%>
	        
	        
	        </div>
	      </div> 
		        </div>
		        <div id="jobDescription">
		        
		        </div>
		      </div>
		      
		      
							<%--   <%
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
					        		e.printStackTrace();
					        	} 
					        	  DocumentConverter	 converter = new  OpenOfficeDocumentConverter(connection);
					        	  converter.convert(inputFile, outputFile); 
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
					        			
		      
		      
		      
		      
		      
			<%}%>  --%>
		      
		      
			<%
		}
		
	%>
	</div>
</div>
</div>
</body>
</html>
