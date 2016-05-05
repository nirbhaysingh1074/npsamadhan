<%@page import="com.unihyr.constraints.DateFormats"%>
<%@page import="java.text.DateFormat"%>
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
<link rel='stylesheet' type='text/css' href='css/style.css' />
<script src="js/jquery.min.js"></script>
<style type="text/css">
table { border-collapse: collapse; }

#header { height: 15px; width: 100%; margin: 20px 0; background: #222; text-align: center; color: white; font: bold 15px Helvetica, Sans-Serif; text-decoration: uppercase; letter-spacing: 20px; padding: 8px 0px; }

#address { width: 250px; height: 150px; float: left; }
#customer { overflow: hidden; }

#logo { text-align: right; float: right; position: relative; margin-top: 25px; border: 1px solid #fff; max-width: 540px; max-height: 100px; overflow: hidden; }
#logo:hover, #logo.edit { border: 1px solid #000; margin-top: 0px; max-height: 125px; }
#logoctr { display: none; }
#logo:hover #logoctr, #logo.edit #logoctr { display: block; text-align: right; line-height: 25px; background: #eee; padding: 0 5px; }
#logohelp { text-align: left; display: none; font-style: italic; padding: 10px 5px;}
#logohelp input { margin-bottom: 5px; }
.edit #logohelp { display: block; }
.edit #save-logo, .edit #cancel-logo { display: inline; }
.edit #image, #save-logo, #cancel-logo, .edit #change-logo, .edit #delete-logo { display: none; }
#customer-title { font-size: 20px; font-weight: bold; float: left; }

#meta { margin-top: 1px; width: 300px; float: right; }
#meta td { text-align: right;  }
#meta td.meta-head { text-align: left; background: #eee; }
#meta td textarea { width: 100%; height: 20px; text-align: right; }

#items { clear: both; width: 100%; margin: 30px 0 0 0; border: 1px solid black; }
#items th { background: #eee; }
#items textarea { width: 80px; height: 50px; }
#items tr.item-row td { border: 0; vertical-align: top; }
#items td.description { width: 300px; }
#items td.item-name { width: 175px; }
#items td.description textarea, #items td.item-name textarea { width: 100%; }
#items td.total-line { border-right: 0; text-align: right; }
#items td.total-value { border-left: 0; padding: 10px; }
#items td.total-value textarea { height: 20px; background: none; }
#items td.balance { background: #eee; }
#items td.blank { border: 0; }

#terms { text-align: center; margin: 20px 0 0 0; }
#terms h5 { text-transform: uppercase; font: 13px Helvetica, Sans-Serif; letter-spacing: 10px; border-bottom: 1px solid black; padding: 0 0 8px 0; margin: 0 0 8px 0; }
#terms textarea { width: 100%; text-align: center;}

textarea:hover, textarea:focus, #items td.total-value textarea:hover, #items td.total-value textarea:focus, .delete:hover { background-color:#EEFF88; }
#hiderow,
.delete {
  display: none;
}
.delete-wpr { position: relative; }
.delete { display: block; color: #000; text-decoration: none; position: absolute; background: #EEEEEE; font-weight: bold; padding: 0px 3px; border: 1px solid; top: -6px; left: -22px; font-family: Verdana; font-size: 12px; } 

</style>
</head>
<body   id="genpdf">
	<%
BillingDetails bill=(BillingDetails)request.getAttribute("bill");
	String clientId=(String)request.getAttribute("clientId");
	if(!clientId.equals(bill.getClientId())){
		out.println("No invoice");
	}else{
%>
<div id="page-wrap">
	<div class="mid_wrapper">
		<div class="container">
			<div class="new_post_info" style="margin-top: 10px">

				<div class="filter">
					<div class="col-md-5">
							<a id="sdfg"	href="javascript:void(0)">Print</a>
								<button onclick="createpdf()">Create Pdf</button>
					</div>
				</div>
					<div class="positions_tab  bottom-margin"
						style="border: 1px solid gray; font-size: 12px; margin: 0px auto; font-weight: normal; font-family: sans-serif;"
						id="genpdf">
						<div class="form_cont">
							<div class="form_col">
								<table style="width: 100%;">
									<tbody>
										<tr>
											<td style="width: 5%"></td>
											<td style="width: 40%">
												 <img style="width: 160px;" 	src="images/logo.png" alt="logo" /> 
											</td>
											<td colspan="2" style="width: 17%">
																					<img alt="invoice" src="images/invoice.png"></td> 
										</tr>
										<tr>
											<td style="width: 5%"></td>
											<td style="width: 40%"><strong>UniHyr</strong><br>
												<span style="padding-right: 240px; word-wrap: break-word;"><%=bill.getClientAddress() %></span></td>
											<td colspan="2" style="width: 17%"></td>
										</tr>
								</table>
								<table style="width: 100%">
									<tr>
										<td style="width: 25%"></td>
										<td style="width: 25%"></td>

										<td>Date Of Invoice:</td>
										<td><%=DateFormats.getTimeValue(bill.getJoiningDate())%></td>
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
								</table>
								<table style="width: 100%">
									<tr>
										<td style="width: 8%;"></td>
										<td style="width: 40%;"><strong>To</strong></td>
										<td style="width: 40%;"></td>
										<td style="width: 10%;"></td>
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
								<br> <br>
								<%
								Double total=bill.getFee()+(GeneralConfig.TAX*bill.getFee())/100+(GeneralConfig.CESS*bill.getFee())/100;
							%>
								<table style="border: 0.5px solid; width: 90%; margin: auto;">
									<tr style="border: 1px solid; height: 30px;">

										<th align="center" style="border: 1px solid; width: 81%">Description</th>
										<th align="left"
											style="width: 15%; border: 1px solid; width: 75%; text-align: right;">Amount
											(in Rs.)</th>

									</tr>
									<tr>

										<td style="height: 25px; padding-left: 10px;">Position :
											<%=bill.getPosition() %><br>
										</td>
										<td style="text-align: right; padding-right: 10px;"><%=NumberUtils.convertNumberToCommoSeprated(new Double(bill.getFee()).intValue()+"") %></td>

									</tr>
									<tr>

										<td style="height: 25px; padding-left: 10px;">Candidate
											Hired : <%=bill.getCandidatePerson() %></td>
										<td style="text-align: right; padding-right: 10px;"></td>

									</tr>
									<tr>

										<td style="height: 25px; padding-left: 10px;">Servic Tax
											@ <%=GeneralConfig.TAX %>
										</td>
										<td style="text-align: right; padding-right: 10px;"><%=NumberUtils.convertNumberToCommoSeprated(new Double((GeneralConfig.TAX*bill.getFee())/100).intValue()+"") %></td>

									</tr>
									<tr>

										<td style="height: 25px; padding-left: 10px;">Swatch
											Bharat Cess @ <%=GeneralConfig.CESS %>
										</td>
										<td style="text-align: right; padding-right: 10px;"><%=NumberUtils.convertNumberToCommoSeprated(new Double((GeneralConfig.CESS*bill.getFee())/100).intValue()+"") %></td>

									</tr>
									<tr style="border: 1px solid; height: 30px;">

										<th align="center" style="border: 1px solid">Total</th>
										<th align="right" style="padding-right: 10px;"><%=NumberUtils.convertNumberToCommoSeprated(total.intValue()+"") %></th>

									</tr>

								</table>
								<br>
								<table style="width: 90%; margin: auto;">
									<tr style="height: 25px;">
										<td style="width: 40%;"><strong>Amount in words
												:</strong></td>
										<td style="width: 60%;"></td>
									</tr>
									<tr style="height: 25px;">
										<td><%=numbertowordindian.numToWordIndian(total.intValue()+"") %>
											Only</td>
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
										<td><span style="font-size: 10px;">Please make
												cheques payable to UniHyr</span></td>
										<td></td>
									</tr>

									<tr>
										<td><span style="font-size: 9px;">This is computer
												generated invoice, hence does not require any signature</span></td>
										<td></td>
									</tr>
								</table>
							</div>
						</div>

					</div>

				</div>
		</div>
	</div></div>
	
	<div id="content"></div>
	<%} %>
</body>
<script>
 $(function () {
    $('#sdfg').click(function () {
    	window.print();

         return true;
    });}); 
    
    
    
</script>






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



<script type="text/javascript">
	var doc = new jsPDF();          
	var elementHandler = {
	  /* '#ignorePDF': function (element, renderer) {
	    return true;
	  } */
	};
	doc.setFontSize(2);
	function createpdf()
	{
		var source = window.document.getElementById("genpdf");
		doc.fromHTML(
		    source,
		    15,
		    15,
		    {
		      'width': 580,'font-size':11
		    });
		doc.output("dataurlnewwindow");
	}
	

</script>

</html>