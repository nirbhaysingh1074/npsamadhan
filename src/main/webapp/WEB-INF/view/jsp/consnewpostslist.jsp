<!DOCTYPE html>
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
		Registration reg = (Registration)request.getSession().getAttribute("registration");
		long totalCount = (Long)request.getAttribute("totalCount");
       	List<Post> postList = (List)request.getAttribute("postList");
		int pn = (Integer) request.getAttribute("pn");
		int rpp = (Integer) request.getAttribute("rpp");
		int tp = 0;
		String cc = "";
		if(totalCount % rpp == 0)
		{
			tp = (int)totalCount/rpp;
			cc = ((pn-1)*rpp)+1 + " - " + ((pn)*rpp);
		}
		else
		{
			tp = (int)(totalCount/rpp)+1;
			if((pn)*rpp < totalCount)
			{
				cc = ((pn-1)*rpp)+1 + " - " + ((pn)*rpp);
			}
			else
			{
				cc = ((pn-1)*rpp)+1 + " - " + totalCount;
			}
		}
		
	%>
      <div class="filter">
        <div class="col-md-7"><span>Showing <%= cc %> of <%= totalCount %></span></div>
        <div class="col-md-5">
<!--           <div class="set_col"><a href=""><img src="images/ic_1.png" alt="img"> <img src="images/ic_2.png" alt="img"></a></div> -->
         <!--  <ul class="page_nav">
            <li class="active"><a href="clientaddpost"> Add New Post</a></li>
          </ul> -->
        </div>
      </div>
      <div class="positions_tab">
        <div class="tab_tp">
          <div class="tab_col">Job ID</div>
          <div class="tab_col">Summary</div>
        </div>
        <ul>
        <%
             	if(postList != null && !postList.isEmpty())
             	{
             		for(Post post : postList)
             		{
             			
             			%>
             				<li>
					            <div class="col_first">
					              <div class="pre_namr"><%= post.getPostId() %></div>
					              <div class="pre_namr"><%= post.getTitle() %></div>
					              <div class="pre_namr"><%= DateFormats.ddMMMMyyyy.format(post.getCreateDate()) %></div>
					            </div>
					            <div class="col_first">
					              <div class="summry_col">
					                <div class="pre_col">
					                  <p><span>Loc:</span> <span><%= post.getLocation()  %></span></p>
					                  <p><span>Comp Range:</span> <span><%= post.getCtc_min()%> to <%= post.getCtc_max()  %> lac CTC</span></p>
					                  <p><span>Exp. Range: </span> <span><%= post.getExp_min() %> to <%= post.getExp_max() %> years</span></p>
					                </div>
					              </div>
					            </div>
					            <div class="col_first">
					              <div class="last_summry">
					                <div class="block">
					                  	<div class="pre_check">
					                  		<%
					                  			Iterator<PostConsultant> it = post.getPostConsultants().iterator();
					                  			
					                  			PostConsultant pocl = null;
					                  			while(it.hasNext())
					                  			{
					                  				PostConsultant pc = it.next();
					                  				if(pc.getConsultant().getUserid().equals(reg.getUserid()))
					                  				{
					                  					pocl = pc;
					                  				}
					                  			}
					                  			
					                  			if(pocl != null)
					                  			{
					                  				%>
					                  					<a href="#" ><img src="images/view-icon.png" alt="interested"></a>
					                  				<%
					                  			}
					                  			else
					                  			{
					                  				%>
									                	<a href="#" id="<%= post.getPostId()%>" class="post_interest"><img src="images/ic_4.png" alt="img"></a>
					                  				<%
					                  			}
					                  		%>
					                	</div>
					                </div>
					              </div>
					            </div>
					          </li>
             			
             				
             			<%	
             		}
             	}
             
             %>
        
          
        </ul>
      </div>
      <div class="block tab_btm">
        <div class="pagination">
          <ul class="pagi">
          	<%
          		if(pn > 1)
          		{
          			%>
			            <li><a onclick="consnewposts('1')">First</a></li>
			            <li><a onclick="consnewposts('<%= pn-1 %>')" ><i class="fa fa-fw fa-angle-double-left"></i></a></li>
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
	      				<li ><a onclick="consnewposts('<%= pn+1 %>')"><i class="fa fa-fw fa-angle-double-right"></i></a></li>
			            <li><a onclick="consnewposts('<%=tp %>')">Last</a></li>
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
        <div class="sort_by"> <span>Sort by</span>
          <select>
            <option>Recent Posts</option>
          </select>
        </div>
      </div>
   

</body>
</html>
