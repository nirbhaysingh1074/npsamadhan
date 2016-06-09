<%@page import="com.unihyr.constraints.DateFormats"%>
<%@page import="com.unihyr.constraints.numbertowordindian"%>
<%@page import="com.unihyr.constraints.NumberUtils"%>
<%@page import="com.unihyr.constraints.GeneralConfig"%>
<%@page import="com.unihyr.domain.BillingDetails"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>
<body>
	<%
BillingDetails bill=(BillingDetails)request.getAttribute("bill");
	String clientId=(String)request.getAttribute("clientId");
	if(!clientId.equals(bill.getClientId())){
		out.println("No invoice");
	}else{
%>
	<div class="mid_wrapper">
		<div class="container">
			<div class="new_post_info" style="margin-top: 10px">

				<div class="filter">
					<div class="col-md-7  pagi_summary">
						<span>Bill Invoice</span>
					</div>
					<div class="col-md-5">
						<ul class="page_nav">
							<li class="active post_activated" id="sdfg"><a
								href="javascript:void(0)">Print</a>
								<button onclick="createpdf()">Create Pdf</button></li>
						</ul>
					</div>
				</div>
				<div class="positions_tab  bottom-margin"
					style="border: 1px solid gray;"  id="genpdf"  >
					<div class="form_cont">
						<div class="form_col">
							<table style="width: 100%;">
								<tbody>
									<tr>
										<td style="width: 10%"></td>
										<td style="width: 40%"><img style="width: 140px;"
											src="images/logo.png" alt="logo" /></td>
										<td colspan="2" style="width: 20%">
										<img alt="invoice" src="images/invoice.png"></td>
									</tr>
									<tr>
										<td colspan="2"><pre> </pre></td>

										<td></td>
										<td></td>
									</tr>
									
									<tr>
										<td colspan="2"><pre> </pre></td>

										<td></td>
										<td></td>
									</tr>
									<tr>
										<td style="padding-left: 5%;" "  colspan="2"><strong>UniHyr</strong><br>
											<span style="width: 9px;">XXXXXXXXXXXXXXXXXXXXXXXXXXX</span>

										</td>

										<td></td>
										<td></td>
									</tr>
									
									<tr>
										<td colspan="2"><pre> </pre></td>

										<td></td>
										<td></td>
									</tr>
									<tr>
										<td colspan="2"></td>

										<td>Date Of Invoice:</td>
										<td><%=DateFormats.ddMMMMyyyy.format(bill.getJoiningDate())%></td>
									</tr>
									<tr>
										<td></td>
										<td></td>
										<td>Invoice# :</td>
										<td><%=bill.getBillId() %></td>
									</tr>
									<tr>
										<td></td>
										<td></td>
										<td>Pan No :</td>
										<td>XXXXXXXXXXXXXX</td>
									</tr>
									<tr>
										<td></td>
										<td></td>
										<td>Service Tax Reg No :</td>
										<td>XXXXXXXXXXXXXX</td>
									</tr>
									<tr>
										<td style="padding-left: 5%;" colspan="2"><strong>To</strong><br>

										</td>
										<td></td>
										<td></td>
									</tr>
									<tr>
										<td></td>
										<td><%=bill.getClientName() %></td>
										<td></td>
										<td></td>
									</tr>
									<tr>
										<td></td>
										<td>
											<p style="width: 50%"><%=bill.getClientAddress() %></p>
										</td>
										<td></td>
										<td></td>
									</tr>
								</tbody>

							</table>
							<br>
							<br>
							<%
								Double total=bill.getFee()+(GeneralConfig.TAX*bill.getFee())/100+(GeneralConfig.CESS*bill.getFee())/100;
							%>
							<table style="border: 0.5px solid; width: 90%; margin: auto;">
								<tr style="border: 1px solid; height: 30px;">

									<th align="center" style="border: 1px solid; width: 85%">Description</th>
									<th align="left" style="width: 15%;">Amount in Rs.</th>

								</tr>
								<tr>

									<td style="height: 25px; padding-left: 10px;">Position : <%=bill.getPosition() %><br></td>
									<td style="text-align: right; padding-right: 10px;"><%=bill.getFee() %></td>

								</tr>
								<tr>

									<td style="height: 25px; padding-left: 10px;">Candidate
										Hired : <%=bill.getCandidatePerson() %></td>
									<td style="text-align: right; padding-right: 10px;"></td>

								</tr>
								<tr>

									<td style="height: 25px; padding-left: 10px;">Servic Tax @
										<%=GeneralConfig.TAX %>
									</td>
									<td style="text-align: right; padding-right: 10px;"><%=(GeneralConfig.TAX*bill.getFee())/100 %></td>
									
								</tr>
								<tr>

									<td style="height: 25px; padding-left: 10px;">Swatch
										Bharat Cess @ <%=GeneralConfig.CESS %>
									</td>
									<td style="text-align: right; padding-right: 10px;"><%=(GeneralConfig.CESS*bill.getFee())/100 %></td>

								</tr>
									<tr style="border: 1px solid;height: 30px;">
						
						<th align="center" style="border: 1px solid">Total</th>
						<th align="right"  style="padding-right: 10px;"><%=total.intValue() %></th>
						
						</tr>
								
							</table>
							<br>
							<table style="width: 90%; margin: auto;">
								<tr style="height: 25px;">
									<td style="width: 40%;"><strong>Amount in words :</strong></td>
									<td style="width: 60%;"></td>
								</tr>
								<tr style="height: 25px;">
									<td><%=numbertowordindian.numToWordIndian(total.intValue()+"") %> Only</td>
									<td></td>
								</tr>
								<tr>
									<td><pre> </pre></td>
									<td></td>
								</tr>
								<tr style="height: 25px;">
									<td>Account Details for electronic transfer</td>
									<td></td>
								</tr>

								<tr style="height: 25px;">
									<td>Account Name</td>
									<td>UniHyr</td>
								</tr>
								<tr style="height: 25px;">
									<td>Current A/C No :</td>
									<td>xxxxxxxxxxx</td>
								</tr>
								<tr style="height: 25px;">
									<td>IFSC /RTGS Code :</td>
									<td>xxxxxxxxxxxx</td>
								</tr>

								<tr>
									<td><pre> </pre></td>
									<td></td>
								</tr>
								<tr>
									<td><span style="font-size: 8px;">Please make
											cheques payable to UniHyr</span></td>
									<td></td>
								</tr>

								<tr>
									<td><pre> </pre></td>
									<td></td>
								</tr>
								<tr>
									<td><span style="font-size: 7px;">This is computer
											generated invoice, hence does not require any signature</span></td>
									<td></td>
								</tr>
							</table>
						</div>
					</div>

				</div>

			</div>
		</div>
	</div>
	<%} %>
</body>






<script src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/script.js"></script>


<script type="text/javascript" src="js/jspdf/jspdf.js"></script>

<script type="text/javascript" src="js/jspdf/acroform.js"></script>
<script type="text/javascript" src="js/jspdf/addhtml.js"></script>
<script type="text/javascript" src="js/jspdf/addimage.js"></script>
<script type="text/javascript" src="js/jspdf/annotations.js"></script>
<script type="text/javascript" src="js/jspdf/autoprint.js"></script>
<script type="text/javascript" src="js/jspdf/canvas.js"></script>
<script type="text/javascript" src="js/jspdf/cell.js"></script>
<script type="text/javascript" src="js/jspdf/context2d.js"></script>
<script type="text/javascript" src="js/jspdf/from_html.js"></script>
<script type="text/javascript" src="js/jspdf/javascript.js"></script>
<script type="text/javascript" src="js/jspdf/outline.js"></script>
<script type="text/javascript" src="js/jspdf/png_support.js"></script>
<script type="text/javascript" src="js/jspdf/prevent_scale_to_fit.js"></script>

<script type="text/javascript" src="js/jspdf/split_text_to_size.js"></script>
<script type="text/javascript" src="js/jspdf/standard_fonts_metrics.js"></script>
<script type="text/javascript" src="js/jspdf/svg.js"></script>
<script type="text/javascript" src="js/jspdf/total_pages.js"></script>

<script type="text/javascript" src="js/jspdf/png.js"></script>
<script type="text/javascript" src="js/jspdf/zlib.js"></script>
<script>
$(function () {
    $('#sdfg').click(function () {
    	 var mywindow = window.open('', 'my div', 'height=400,width=700');
         mywindow.document.write('<html><head><title>my div</title>');
         /*optional stylesheet*/ //mywindow.document.write('<link rel="stylesheet" href="main.css" type="text/css" />');
         mywindow.document.write('</head><body >');
         mywindow.document.write($('.form_col').html());
         mywindow.document.write('</body></html>');

         mywindow.document.close(); // necessary for IE >= 10
         mywindow.focus(); // necessary for IE >= 10

         mywindow.print();
         mywindow.close();

         return true;
    });});
    
    
    
</script>


<script type="text/javascript">
	var doc = new jsPDF();          
	var elementHandler = {
	  /* '#ignorePDF': function (element, renderer) {
	    return true;
	  } */
	};
	doc.setFontSize(7);
	function createpdf()
	{
		var source = window.document.getElementById("genpdf");
		doc.fromHTML(
		    source,
		    15,
		    15,
		    {
		      'width': 180,'font-size':11/* ,'elementHandlers': elementHandler */
		    });
		
		doc.output("dataurlnewwindow");
		
	}
	

</script>
</html>
