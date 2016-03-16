<!DOCTYPE html>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Collections"%>
<%@page import="com.unihyr.domain.Inbox"%>
<%@page import="com.unihyr.constraints.Roles"%>
<%@page import="com.unihyr.domain.PostProfile"%>
<%@page import="com.unihyr.domain.Registration"%>
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

.tab-content 
{
    padding: 20px;
    display: none;
    max-height: 520px;
}
.tab_content .active{display: block;}
/* #tab-1 { */
/*  display: block;    */
/* } */
</style>

<script type="text/javascript">
$(document).ready(function() {
    $(".tabs-menu a").click(function(event) {
        event.preventDefault();
        $(this).parent().addClass("active");
        $(this).parent().siblings().removeClass("active");
        var tab = $(this).attr("href");
        $(".tab-content").addClass("active");
        $(".tab-content").not(tab).removeClass("active");
    });
});
</script>
</head>
<body class="loading" >
<div class="mid_wrapper">
<%
	PostProfile pp = (PostProfile)request.getAttribute("postProfile");
	if(pp != null)
	{
		int unviewed = 0;
		%>
<sec:authorize access="hasRole('ROLE_CON_MANAGER') or hasRole('ROLE_CON_USER')">
<%
Iterator<Inbox> it = pp.getMessages().iterator();
while(it.hasNext())
{
	Inbox msg = it.next();
	if(msg.getClient()== null && !msg.isViewed())
	{
		System.out.print("Client side count " + msg.getMessage());
		unviewed++;
	}
	System.out.print("Client side count " + unviewed);
}

%>
</sec:authorize>
<sec:authorize access="hasRole('ROLE_EMP_MANAGER') or hasRole('ROLE_EMP_USER')">
<%
Iterator<Inbox> it = pp.getMessages().iterator();
while(it.hasNext())
{
	Inbox msg = it.next();
	if(msg.getConsultant()== null && !msg.isViewed())
	{
		System.out.print("Client side count " + msg.getMessage());
		unviewed++;
	}
}
System.out.print("Consultant side count " + unviewed);
unviewed=0;
%>
</sec:authorize>

			<div class="container">
			  	<div class="applicant_info">
			      <div class="row">
			        <div class="col-md-4">
			          <div class="left_bar">
			            <div class="tp_title">
			              <h2>Applicant Info <span>Export</span></h2>
			            </div>
			            <div class="bar_in">
			              <div class="tp_row">
			                <h2><%= pp.getProfile().getName() %></h2>
			                <p>+91 <%= pp.getProfile().getContact() %>,</p>
			                <a href="#"><%= pp.getProfile().getEmail() %></a> </div>
			              <p>Revised : <%= DateFormats.getTimeValue(pp.getSubmitted()) %></p>
			              <p>Position : <%= pp.getPost().getClient().getOrganizationName() %></p>
			              <p>Source : <%= pp.getProfile().getRegistration().getConsultName() %></p>
			              <sec:authorize access="hasRole('ROLE_EMP_MANAGER') or hasRole('ROLE_EMP_USER')">
			              <div class="rate_plicant">
			                <p>Rate this Aplicant</p>
			                <p><img src="images/star_ic.png" alt="img"></p>
			              </div>
			              </sec:authorize>
			              	<%
			              		if(pp.getAccepted() != null)
			              		{
			              			%>
			              				<div class="block btn_row">
			              					<a class="btn check_btn"><img src='images/ic_17.png' alt=''> Accepted</a>
			              				</div>
		              				<%
			              		}
			              		else if(pp.getRejected() != null)
			              		{
			              			%>
			              				<div class="block btn_row">
			              					<a class="btn check_btn"><img src='images/ic_16.png' alt=''> Rejected</a>
		              					</div>
		              					<%
			              		}
			              		else
			              		{
			              			%>
			              				<sec:authorize access="hasRole('ROLE_EMP_MANAGER') or hasRole('ROLE_EMP_USER')">
							              <div class="unch_check">
							                <div id="<%= pp.getPpid() %>" class="profile_status">
							                	<a class="accept_profile" style="float: left;"><img src="images/ic_7.png" alt="img"> <p>Shortlist</p></a>
							                	<a class="reject_profile" style="float: left;padding-left: 35px;"><img src="images/ic_8.png" alt="img"> <p>Reject</p></a>
							                </div>
							              </div>
						                </sec:authorize>
						                <sec:authorize access="hasRole('ROLE_CON_MANAGER') or hasRole('ROLE_CON_USER')">
						                	<div class="block btn_row">
								            	<a class="btn check_btn"><img src="images/clock-icon.png" alt="" align="top" width="20px"> In Progress</a> 
								            </div>
								        </sec:authorize>
			              			<%
			              		}
			              	%>
			            </div>
			          </div>
			        </div>
			        <div class="col-md-8">
			          <div class="md_bar">
			            <div class="tab_nav">
			              <ul class="tabs-menu">
			                <li class="active"><a href="#tab-1">Resume</a></li>
			                <li><a href="#tab-2">Notes</a></li>
			                <li id="inbox_tab">
			                	<%
			                		if(false)
			                		{
			                			%>
						                	<a href="#tab-3" style="background-color: pink;">
						                	Inbox
						                	</a>
			                			<%
			                		}
			                		else
			                		{
			                			%>
						                	<a href="#tab-3">
						                	Inbox
						                	</a>
			                			<%
			                		}
			                	%>
		                	</li>
			              </ul>
			            </div>
			            <div class="tab_content tab" id="inbox_msg">
			              <div id="tab-1" class="tab-content resume_col active">
			                <p><%=  pp.getProfile().getScreeningNote()%></p>
			              </div>
			              <div id="tab-2" class="tab-content resume_col">
			                <h2>tab 2</h2>
			                <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. I</p>
			                <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. I</p>
			                <h2>Professional Experience</h2>
			                <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. I</p>
			              </div>
			              <div id="tab-3" class="tab-content resume_col" >
			                <div class="inbox_col" >
								<%
									List<Inbox> msgList = (List) request.getAttribute("msgList");
									Collections.reverse(msgList);
									if(msgList != null && !msgList.isEmpty())
									{
										for(Inbox inbox : msgList)
										{
											if(inbox.getClient() != null && inbox.getClient().equals(pp.getPost().getClient().getUserid()))
											{
												%>
													<div class="mag msg_sender">
														<h2><%= inbox.getClient() %></h2>
														<p>
															 <%= inbox.getMessage() %><span>(<%= DateFormats.getTimeValue(inbox.getCreateDate()) %>)</span>
														</p>
														
													</div>
												<%	
											}
											else if(inbox.getConsultant() != null && inbox.getConsultant().equals(pp.getProfile().getRegistration().getUserid()))
											{
												%>
													<div class="mag msg_receiver">
														<h2><%=inbox.getConsultant()%></h2>
														<p>
															<%= inbox.getMessage() %><span>(<%= DateFormats.getTimeValue(inbox.getCreateDate()) %>)</span> 
														</p>
														
													</div>
																	
												<%
											}
											
										}
									}
								
								%>
								

								
							</div>
							<div style="">
								<div style=" float: left;width: 100%;margin-bottom: 10px;">
									<textarea id="msg_text" rows="2" cols="" style="height: 30px;width: 85%;"></textarea>
									<div style="float: right; " class="applicant_msg">
										<button id="<%= pp.getPpid() %>" class="btn yelo_btn send_msg">Send</button>
									</div>
								</div>
							</div>
			              </div>
			            </div>
			          </div>
			        </div>
			      </div>
			    </div>
			    
			  </div>
		<%
	}
%>
<script type="text/javascript">
jQuery(document).ready(function() {
	$(document.body).on('click', '.tabs-menu > #inbox_tab' ,function(){
		var objDiv = document.getElementById("inbox_msg");
		objDiv.scrollTop = objDiv.scrollHeight;
	});
});
	
	


</script>
  
</div>
</body>
</html>
