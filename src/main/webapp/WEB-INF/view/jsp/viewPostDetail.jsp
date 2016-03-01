<!DOCTYPE html>
<%@page import="com.unihyr.domain.PostProfile"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.unihyr.domain.CandidateProfile"%>
<%@page import="java.util.Set"%>
<%@page import="com.unihyr.constraints.DateFormats"%>
<%@page import="com.unihyr.domain.Post"%>
<%@page import="java.util.List"%>
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

</head>
<body class="loading">
	<%
		Post post = (Post)request.getAttribute("post");
		if(post != null)
		{
			%>
		      <div class="filter">
		        <div class="col-md-7"><span><%= post.getTitle() %></span></div>
		        <div class="col-md-5">
		<!--           <div class="set_col"><a href=""><img src="images/ic_1.png" alt="img"> <img src="images/ic_2.png" alt="img"></a></div> -->
		          <ul class="page_nav">
		            <li class="active"><a class="back_list_view" > <img alt="" src="images/back-arrow.png" width="12px "> Back</a></li>
		          </ul>
		        </div>
		      </div>
		      <div class="positions_tab  bottom-margin" style="border: 1px solid gray;background: #fff5db none repeat scroll 0 0;">
		        <div class="form_cont">
			        <div class="form_col">
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
								<label>Function</label>
							</dt>
							<dd>
								<label><%= post.getFunction() %></label>
								
							</dd>
						</dl>
						<dl>
							<dt>
								<label>Criteria</label>
							</dt>
							<dd>
								<label><%= post.getCriteria() %></label>
								
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
								<label>Comment</label>
							</dt>
							<dd>
								<label><%= post.getComment() %></label>
								
							</dd>
						</dl>
						<%
							if(post.getUploadjd() != null && post.getUploadjd().trim().length() > 0)
							{
								%>
								<dl>
									<dt>
										<label>Upload JD</label>
									</dt>
									<dd>
										<label><a ><%= post.getUploadjd() %> </a></label>
										
									</dd>
								</dl>
								<%
								
							}
						
						
						%>
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
						<div class="clearfix" style="padding: 15px">
							<h3><b>Applied Candidates</b></h3><br>
							<%
			                  	Set<PostProfile> prof = post.getPostProfile();
			                  	Iterator<PostProfile> it = prof.iterator();
			                  	int i =1;
			                  	while(it.hasNext())
		                  		{
			                  		PostProfile cp = it.next();
		                  			%>
		                  				<p><%= i++ %>. 
		                  					<%= cp.getProfile().getName() %>
<%-- 		                  					<%= cp.getRegistration().getConsultName() %> --%>
		                  				</p>
		                  			<%
		                  		}
			                  
			                  %>
							
							
						</div>
			        </div>
		        </div>
		        
		      </div>
			<%
		}
		
	%>
</body>
</html>
