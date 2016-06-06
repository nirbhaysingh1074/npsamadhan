<%@page import="com.unihyr.constraints.NumberUtils"%>
<%@page import="com.unihyr.constraints.DateFormats"%>
<%@page import="com.unihyr.domain.BillingDetails"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>
<body>








<div class="mid_wrapper">
  <div class="container">
	  	<div id="positions_info">
		  	<div>
				<div class="rightside_in new_table" style="padding: 10px 20px 0px;">
				  	<div class="block consulting" style="float: left; width: auto;">
				        
				    </div>
				 
         
			   </div>
		  </div>
	    <div  class="positions_info cons_new_posts">
	  <!--     <div class="filter">
	        
	        <div class="col-md-7 pagi_summary"><span>Showing 0 - 0 of 0</span></div>
	        <div class="col-md-5">
	              <ul class="page_nav unselectable">
			            <li class="disabled"><a>First</a></li>
			            <li class="disabled"><a><i class="fa fa-fw fa-angle-double-left"></i></a></li>
		            	<li class="active current_page"><a>1</a></li>
	      				<li class="disabled"><a><i class="fa fa-fw fa-angle-double-right"></i></a></li>
			            <li class="disabled"><a>Last</a></li>
	              </ul>
	            </div>
	      </div> -->
	      <div class="positions_tab">
	        	<table class="table no-margin" style="font-size: 10px;border: 1px solid gray;">
		        	<thead>
		        		<tr>
	       				<th align="left">Position</th>
	       				<th align="left">
	       					<sec:authorize access="hasRole('ROLE_EMP_MANAGER')">
												Consultant Name
											</sec:authorize>
												<sec:authorize access="hasRole('ROLE_CON_MANAGER')">
												Client Name
							</sec:authorize>
												</th>
	       				<th align="left">Location</th>
	       				<th align="left">Candidate Name</th>
	       				<th align="left">Offer Accepted Date</th>
	       				<th align="left">Expected Joining Date</th>
	       				<th align="left">Joining Date</th>
	       				<th align="left">Total CTC.</th>
	       				<th align="left">Billable CTC.</th>
	       				<th align="left">
	       				<sec:authorize access="hasRole('ROLE_CON_MANAGER')">
Commission(%)
</sec:authorize>
<sec:authorize access="hasRole('ROLE_EMP_MANAGER')">
Fee Percent(%)
</sec:authorize>
	       				</th>
	       				<th align="left">			<sec:authorize access="hasRole('ROLE_CON_MANAGER')">
Commission
</sec:authorize>
<sec:authorize access="hasRole('ROLE_EMP_MANAGER')">
Fee
</sec:authorize></th>
	       				<th align="left">Tax(%)</th>
	       				<th align="left">Total Amount</th>
	       				<th align="left">Payment Due Date</th>
	       				<th align="left">Verification Status</th>
	       				<th align="left">Action</th>
		       			</tr>
	       			</thead>
	       			<tbody >
	       				
<%
List<BillingDetails> bills=(List<BillingDetails>)request.getAttribute("bills");
for(BillingDetails bill:bills){
%>
<tr>
<td><%=bill.getPosition() %></td>
<td>
	<sec:authorize access="hasRole('ROLE_EMP_MANAGER')">
	<%=bill.getConsultantName()%> 
</sec:authorize>
	<sec:authorize access="hasRole('ROLE_CON_MANAGER')">
   
	<%=bill.getClientName()%> 
</sec:authorize>

 </td>
<td><%=bill.getLocation()%></td>
<td><%=bill.getCandidatePerson() %></td>
<td><%=DateFormats.ddMMMMyyyy.format(bill.getOfferAcceptedDate()) %></td>
<td>
<%if(bill.getExpectedJoiningDate()!=null){ %>
<%=DateFormats.ddMMMMyyyy.format(bill.getExpectedJoiningDate()) %>
<%}else{ %>
Yet to Join
<%} %>
</td>
<td>
<%
if(bill.getJoiningDate()!=null){ %>
<%=DateFormats.ddMMMMyyyy.format(bill.getJoiningDate()) %>

<%}else{ %>
Yet to Join
<%} %>

</td>
<td>
<%=NumberUtils.convertNumberToCommoSeprated(bill.getTotalCTC()) %></td>
<td><%=NumberUtils.convertNumberToCommoSeprated(bill.getBillableCTC()) %></td>
<td>
<sec:authorize access="hasRole('ROLE_CON_MANAGER')">
<%=bill.getFeePercentForClient() %>
</sec:authorize>
<sec:authorize access="hasRole('ROLE_EMP_MANAGER')">
<%=bill.getFeePercentToAdmin() %>
</sec:authorize>

</td>
<td><%=NumberUtils.convertNumberToCommoSeprated(bill.getFee()) %></td>
<td><%=bill.getTax()%></td>
<td><%=NumberUtils.convertNumberToCommoSeprated(bill.getTotalAmount()) %></td>
<td>
<%if(bill.getPaymentDueDateForAd()!=null){ %>
<%=DateFormats.ddMMMMyyyy.format(bill.getPaymentDueDateForAd()) %>
<%}else{ %>
Yet to Join
<%} %></td>
<td>

<%if(bill.getJoiningDate()!=null){ %>
<%if(bill.getVerificationStatus()==null|| (!bill.getVerificationStatus())){ 
%>
<a href="clientVerifyBillingDetails?billId=<%=bill.getBillId() %>" >Verify</a>
<%}else{ %>
<span>Verfied</span>
<%} }else{%>

<span>--</span>
<%} %>
</td>
<td >
	<sec:authorize access="hasRole('ROLE_CON_MANAGER')">

<%if(bill.getJoiningDate()!=null){ %>
<a target="_blank" href="consBillInvoice?billId=<%=bill.getBillId() %>" >Invoice</a>
<%} %>
</sec:authorize>
	<sec:authorize access="hasRole('ROLE_EMP_MANAGER')">

<%if(bill.getJoiningDate()!=null){ %>
<a target="_blank" href="clientBillInvoice?billId=<%=bill.getBillId() %>" >Invoice</a>
<%} %>
</sec:authorize>

</td>
</tr>
<%} %>
	       			</tbody>
	       		</table>
	      </div>
	      <!-- <div class="block tab_btm">
	        <div class="pagination">
	          <ul class="pagi">
		            <li class="disabled"><a>First</a></li>
		            <li class="disabled"><a><i class="fa fa-fw fa-angle-double-left"></i></a></li>
	            	<li class="active current_page"><a>1</a></li>
	   				<li class="disabled"><a><i class="fa fa-fw fa-angle-double-right"></i></a></li>
		            <li class="disabled"><a>Last</a></li>
	          </ul>
	        </div>
	      
        
	      </div> -->
	      
	      
	    </div>
    </div>
    
  </div>
</div>




</body>
</html>