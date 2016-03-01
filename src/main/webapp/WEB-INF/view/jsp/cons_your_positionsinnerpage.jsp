<%@page import="com.unihyr.domain.PostProfile"%>
<%@page import="com.unihyr.domain.Post"%>
<%@page import="com.unihyr.domain.Registration"%>
<%@page import="com.unihyr.domain.CandidateProfile"%>
<%@page import="java.util.List"%>
<%
	List<PostProfile> profileList = (List<PostProfile>) request.getAttribute("profileList");

	long totalCount = (Long) request.getAttribute("totalCount");
	int pn = (Integer) request.getAttribute("pn");
	int rpp = (Integer) request.getAttribute("rpp");
	int tp = 0;
	String cc = "";
	if (totalCount == 0) {
		cc = "0 - 0";
	} else if (totalCount % rpp == 0) {
		tp = (int) totalCount / rpp;
		cc = ((pn - 1) * rpp) + 1 + " - " + ((pn) * rpp);
	} else {
		tp = (int) (totalCount / rpp) + 1;
		if ((pn) * rpp < totalCount) {
			cc = ((pn - 1) * rpp) + 1 + " - " + ((pn) * rpp);
		} else {
			cc = ((pn - 1) * rpp) + 1 + " - " + totalCount;
		}
	}
%>

<div class="filter">
	<div class="col-md-7">
		<span>Showing <%=cc%> of <%=totalCount%></span>
	</div>
			<div class="col-md-5">
                <ul class="page_nav unselectable">
                	<%
		          		if(pn > 1)
		          		{
		          			%>
					            <li><a onclick="fillProfiles('1')">First</a></li>
					            <li><a onclick="fillProfiles('<%= pn-1 %>')" ><i class="fa fa-fw fa-angle-double-left"></i></a></li>
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
			      				<li ><a onclick="fillProfiles('<%= pn+1 %>')"><i class="fa fa-fw fa-angle-double-right"></i></a></li>
					            <li><a onclick="fillProfiles('<%=tp %>')">Last</a></li>
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
<table width="100%" border="0" class="new_tabl">
	<tr>
		<th>Basic Information</th>
		<th>&nbsp;</th>
		<th>Status</th>
		<th>&nbsp;</th>
	</tr>
	<%
	
		if(profileList != null && !profileList.isEmpty())
		{
			for (PostProfile pp : profileList) 
			{
				%>
			
				<tr>
					<td>
						<h3><%=pp.getProfile().getName()%></h3>
						<p><%=pp.getProfile().getContact()%>, <br>
							<%=pp.getProfile().getCurrentRole()%>,
							<%=pp.getProfile().getCurrentOrganization()%><br>
							Salary:<%=pp.getProfile().getCurrentCTC()%> Lacs
						</p></td>
					<td>
						<p>
							Relocation:	<%=pp.getProfile().getWillingToRelocate()%>
							
						</p>
						<p>Location: <%= pp.getProfile().getCurrentOrganization() %></p>
						<p>NP:	<%=pp.getProfile().getNoticePeriod()%></p>
						<p>Exp. CTC:	<%=pp.getProfile().getExpectedCTC()%> Lacs</p>
					</td>
					<td><a href=""><img src="images/ic_17.png" alt="img"
							align="top"></a> Shortlist/Inprogress</td>
					<td><p>
							<a href="" class="btn search_btn">View Applicant</a>
						</p>
				</tr>
			
				<%
			}
		}
	%>


</table>
<div class="block tab_btm">
	<div class="pagination">
		<ul>
			<%
				if (pn > 1) {
			%>
			<li><a onclick="fillProfiles('1')">First</a></li>
			<li><a onclick="fillProfiles('<%=pn - 1%>')"><i
					class="fa fa-fw fa-angle-double-left"></i></a></li>
			<%
				} else {
			%>
			<li class="disabled"><a>First</a></li>
			<li class="disabled"><a><i
					class="fa fa-fw fa-angle-double-left"></i></a></li>
			<%
				}
			%>
			<li class="active current_page"><a><%=pn%></a></li>
			<%
				if (pn < tp) {
			%>
			<li><a onclick="fillProfiles('<%=pn + 1%>')"><i
					class="fa fa-fw fa-angle-double-right"></i></a></li>
			<li><a onclick="fillProfiles('<%=tp%>')">Last</a></li>
			<%
				} else {
			%>
			<li class="disabled"><a><i
					class="fa fa-fw fa-angle-double-right"></i></a></li>
			<li class="disabled"><a>Last</a></li>
			<%
				}
			%>
		</ul>
	</div>
	<div class="sort_by">
		<span>Order by</span> <select>
			<option>Recent</option>
		</select>
	</div>
</div>