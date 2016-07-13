<!DOCTYPE html>
<%@page import="com.unihyr.constraints.GeneralConfig"%>
<%@page import="java.util.Arrays"%>
<%@page import="com.unihyr.domain.Industry"%>
<%@page import="com.unihyr.domain.Location"%>
<%@page import="java.util.List"%>
<%@page import="com.unihyr.model.ConsultRegModel"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">

<title>UniHyr</title>

<link href="css/fonts.css" type="text/css" media="all" rel="stylesheet" />
<link rel="stylesheet" href="css/media.css" media="screen" />
<link rel="stylesheet" href="css/style.css" media="screen" />
<link rel="stylesheet" href="css/font-awesome.css" media="screen" />
<link href="css/main.css" type="text/css" media="all" rel="stylesheet" />
<style type="text/css">
input[type="text"], input[type="password"], input[type="tel"], input[type="search"],
	input[type="email"], textarea, select {
	margin-top: 10px;
}

.req {
	color: red;
}

select option:hover {
	background: rgba(0, 0, 0, 0.3);
	color: #fff;
}

.consultant_type_label label{padding-left: 5px;margin-right: 25px;}
</style>
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/client_js.js"></script>
<script type="text/javascript" src="js/common_js.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	
	$('input:radio[name=consultant_type]').change(function () {
		
		var aa = $(this).val();
	    if(aa == 'true') 
     	{
	    	$('#noofpeoples').removeAttr('disabled');
	    }
	    else
	    {
	    	$('#noofpeoples').val("0");
	    	$('#noofpeoples').attr('disabled','disabled');
	    } 
	});
	
});

</script>
<script type="text/javascript">
	$(document).ready(function() {
		$(".btn_submit").click(function() {
			var valid = true;
			var cons = $('#consultName').val();
			var userid = $('#userid').val();
			var password = $('#password').val();
			var repassword = $('#repassword').val();
			var revenue = $('#revenue').val();
			var yearsInIndusrty = $('#yearsInIndusrty').val();
			var industries = $('#industries').val();
			var noofpeoples = $('#noofpeoples').val();
			var contact = $('#contact').val();
			var officeLocations = $('#officeLocations').val();
			
			$('.error').html('&nbsp;');
			
			if(cons == "")
			{
				$('.cons_error').html('Please enter consultant name ')
				valid = false;
			}
			
			if(userid == "" || !isEmail(userid))
			{
				$('.userid_error').html("Please enter a valid email")
				valid = false;
			}
			
			if(revenue == "" || revenue == "0")
			{
				$('.revenue_error').html("Please enter revenue in millions INR")
				valid = false;
			}
			
			if(yearsInIndusrty == "" || yearsInIndusrty == "0")
			{
				$('.yearsInIndusrty_error').html("Please enter no of years in industry")
				valid = false;
			}
			
			var aa = $('input:radio[name=consultant_type]:checked').val();

			if(aa == 'true' && (noofpeoples == "" || noofpeoples == "0"))
			{
				$('.noofpeoples_error').html("Please enter no of peoples")
				valid = false;
			}
			
			if(industries == null || industries=='' || industries.length > 5)
			{
				if(industries != null && industries.length > 5)
				{
					$('.industry_error').html("You can select max 5 industries")
					valid = false;
				}
				$('.industry_error').html("Please select atleast one industry")
				valid = false;
			}
			if(contact == "" || contact.length != 10 )
			{
				$('.contact_error').html("Please enter a valid phone number")
				valid = false;
			}
			
			if(officeLocations == null || officeLocations == "")
			{
				$('.officeLocations_error').html("Please select contact address")
				valid = false;
			}
			
			if(!valid)
			{
				return false;
			}
			
		});
	});

	
	function isEmail(email) {
		  var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
		  return regex.test(email);
		}
	function isUrlValid(url) {
	    return /^(https?|s?ftp):\/\/(((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:)*@)?(((\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5]))|((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?)(:\d*)?)(\/((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)+(\/(([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)*)*)?)?(\?((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|[\uE000-\uF8FF]|\/|\?)*)?(#((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|\/|\?)*)?$/i.test(url);
	}

	function checkUserExistance()
	{
		$('.userid_error').html("&nbsp;");
		var userid = $('#userid').val();
		if(!isEmail(userid))
		{
			$('.userid_error').html("Please enter a valid email.");
			$('#userid').focus();
			return false;
		}
		$.ajax({
			type : "GET",
			url : "checkUserExistance",
			data : {'userid':userid},
			contentType : "application/json",
			success : function(data) {
				var obj = jQuery.parseJSON(data);
				if(obj.uidexist)
				{
					$('.userid_error').html("This email already registered.");
					$('#userid').focus();
				}
				
			},
			error: function (xhr, ajaxOptions, thrownError) {
		      }
	    }) ;
	}
	

	function checkConsultantNameExistance()
	{
		$('.cons_error').html("&nbsp;");
		var organizationName = $('#consultName').val();
		if(organizationName=="")
		{
			$('.cons_error').html("Please enter consultant name.");
			$('#consultName').focus();
			return false;
		}
		$.ajax({
			type : "GET",
			url : "checkUserNameExistance",
			data : {'userName':organizationName},
			contentType : "application/json",
			success : function(data) {
				var obj = jQuery.parseJSON(data);
				if(obj.uNameexist)
				{
					$('.cons_error').html("This consultant name already registered.");
					$('#consultName').focus();
				}
				
			},
			error: function (xhr, ajaxOptions, thrownError) {
		      }
	    }) ;
	}
	</script> 

</head>
<body style="background: #EDEDED;">
<!-- <body style="background-image: url('images/bg-image.png')"> -->
	<%
		String uidex = (String) request.getAttribute("uidex");
		String usermsg = "";
		if (uidex != null && uidex.equals("exist")) {
			usermsg = "user aleady registered !";
		}
		
		String uNamedex = (String)request.getAttribute("uNamedex");
		String orgmsg = ""; 

		System.out.println(uNamedex);
		if(uNamedex != null && uNamedex.equals("exist"))
		{
			orgmsg = "Consultant name aleady registered !";
		}
	%>


	<section>
		<div class="container reg_page" style="margin: 50px auto;">
			<a href="home"><span class="close" title="Home Page"><img style="    height: 40px;" src="images/close.png" /></span></a>
			<div class="reg-form">
				<form:form method="POST" action="admineditconsultant"
					commandName="regForm">
					<div class="reg-header bottom-padding">
						<a href="home"><img alt="" src="images/logo.png"></a>
						<h2 style="float: right;">Registration for Consultant</h2>
					</div>

					<div class="reg-wrap">
						<div>
							<label>Consultant Name<span class="req">*</span></label>
							<form:input path="consultName" onchange="checkConsultantNameExistance()" />
							<span class="error cons_error">&nbsp;<form:errors
									path="consultName" /><%=orgmsg %></span>
						</div>
					</div>
					<div class="reg-wrap">
						<div>
							<label>Email Id<span class="req">*</span></label>
							<form:input path="userid" type="email"
								onchange="checkUserExistance()" />
							<span class="error userid_error">&nbsp;<form:errors
									path="userid" /> <%=usermsg%></span>
						</div>
					</div>
					
					<div class="clearfix"></div>
					<div class="reg-wrap">
						<div>
							<label>Revenue<span class="req">*</span></label>
							<form:input path="revenue" cssClass="number_only" maxlength="10"
								style="padding-right: 150px" />
							<span
								style="position: relative; padding: 5px; border-left: 1px solid rgb(212, 212, 212); float: right; margin-top: -27px;">
								INR (Millions)</span> <span class="error revenue_error">&nbsp;<form:errors
									path="revenue" /></span>
						</div>
					</div>
					<div class="reg-wrap">
						<div>
							<label>Years of existence</label>
							<form:input path="yearsInIndusrty" cssClass="number_only" />
							<span class="error yearsInIndusrty_error">&nbsp;<form:errors
									path="yearsInIndusrty" /></span>
						</div>
					</div>
					<div class="clearfix"></div>
					<div class="reg-wrap">
						<div>
							<label>Consultant Type<span class="req">*</span></label><br>
							<div style="margin-top: 10px" class="consultant_type_label">
								<form:radiobutton path="consultant_type" class="cons_type" value="true" label="Consultant"/>
								<form:radiobutton path="consultant_type" class="cons_type" value="false" label="Freelancer"/> 
							</div>
						</div>
					</div>
					<div class="reg-wrap">
						<div>
							<label>Organization Size<span class="req">*</span></label>
							<form:input path="noofpeoples" cssClass="number_only"
								maxlength="10" />
							<span class="error noofpeoples_error">&nbsp;<form:errors
									path="noofpeoples" /></span>
						</div>
					</div>
					<div class="clearfix"></div>
					<div class="reg-wrap">
						<div>
							<label>Contact No.<span class="req">*</span></label>
							<form:input path="contact" cssStyle="padding-left:35px;"
								cssClass="number_only" maxlength="10" minlength="10" />
							<span
								style="position: relative; padding: 5px; border-right: 1px solid rgb(212, 212, 212); float: left; margin-top: -27px; font-size: 12px;">
								+91 </span> <span class="error contact_error">&nbsp;<form:errors
									path="contact" /></span>
						</div>
					</div>
					<div class="reg-wrap">
						<div>
							<label>Type of firm<span class="req">*</span></label>
							<form:select path="firmType" >
<%-- 								<form:option value="">Select Firm Type</form:option> --%>
								<form:option value="Pvt Limited">Pvt Limited</form:option>
								<form:option value="Partnership">Partnership</form:option>
								<form:option value="Proprietor">Proprietor</form:option>
							</form:select>
							
						</div>
					</div>
					<%
						ConsultRegModel model = (ConsultRegModel) request.getAttribute("regForm");
							List<Location> locList = (List) request.getAttribute("locList");
							List<Industry> industryList = (List) request.getAttribute("industryList");
							String[] aa = (String[]) request.getAttribute("sel_inds");
							List<String> sel_inds = null;
							if (aa != null) {
								sel_inds = Arrays.asList(aa);
							}
							System.out.println("<<<<<<<<<<<<<<< : " + sel_inds);
					%>
					<div class="clearfix"></div>
					<div class="reg-wrap">
						<div>
							<label>Industry<span class="req">*</span><span
								style="font-size: 9px;">(press CTRL to select multiple)</span></label> <select
								name="industries" id="industries" multiple="multiple" size="5">
								<%
									if (industryList != null && !industryList.isEmpty()) {
											for (Industry ind : industryList) {
												if (sel_inds != null && sel_inds.contains(String.valueOf(ind.getId()))) {
								%>
								<option value="<%=ind.getId()%>" selected="selected"><%=ind.getIndustry()%></option>
								<%
									} else {
								%>
								<option value="<%=ind.getId()%>"><%=ind.getIndustry()%></option>
								<%
									}
									}
									}
								%>
							</select> <span class="error industry_error">&nbsp; ${industry_req }</span>
						</div>
					</div>
					<div class="reg-wrap">
						<div style="padding-bottom: 10px;" class='clearfix'>
							<label>Office Locations<span class="req">*</span>
							<span style="font-size: 9px;">
							(press CTRL to select multiple)
							</span>
							</label>
							<form:select path="officeLocations" multiple="multiple" size="5">
								<%
	              				List<String> locList1=GeneralConfig.topLocations;
	              				for(String loc:locList1){
	              					%>
						   				<form:option value="<%=loc %>"><%=loc %></form:option>
	              					<%
	              				}
	              				%>
								
			            		<%
			            			if(locList != null && !locList.isEmpty())
			            			{
			            				for(Location loc : locList)
			            				{
			            					if(model.getOfficeLocations() != null && model.getOfficeLocations().contains(loc.getLocation()) )
			            					{
			            						if(!locList1.contains(loc.getLocation())){
			            						%>
			            							<form:option value="<%= loc.getLocation() %>" selected = "selected"><%= loc.getLocation() %></form:option>
			            						<%
			            					}}
			            					else
			            					{
			            						if(!locList1.contains(loc.getLocation())){
			            						%>
			            							<form:option value="<%= loc.getLocation() %>"><%= loc.getLocation() %></form:option>
			            						<%
			            						}
			            					}
			            				}
			            			}
			            		%>
							</form:select>
							<span class="error officeLocations_error">&nbsp;<form:errors
									path="officeLocations" /></span>
						</div>
					</div>
					<div class="reg-wrap">
						<div style="padding-bottom: 10px;" class='clearfix'>
							<label>Office Address</label>
							<form:textarea path="officeAddress"  rows="4"/>
							<span class="error officeAddress_error">&nbsp;<form:errors path="officeAddress" /></span>
						</div>
					</div>
					<div class="reg-wrap">
						<div style="padding-bottom: 10px;" class='clearfix'>
							<label>About Company</label>
							<form:textarea path="about"  rows="4"/>
							<span class="error about_error">&nbsp;<form:errors path="about" /></span>
						</div>
					</div>
					
					<div class="reg-wrap">
						<div style="padding-bottom: 10px;" class='clearfix'>
							<label>Your Name<span class="req">*</span></label>
							<form:input path="name" />
							<span class="error name_error">&nbsp;<form:errors path="name" /></span>
						</div>
					</div>
					<div class="clearfix"></div>
					<div class="login-footer bottom-padding clearfix">
						<div class="form_submt bottom-padding10">
							<button type="submit" class=" btn-login btn yelo_btn btn_submit">Sign up</button>
						</div>
						<a href="login"> Already have an account ?</a>
					</div>
				</form:form>
			</div>
		</div>

	</section>

	<script src="js/jquery.min.js"></script>
	<script type="text/javascript" src="js/script.js"></script>
</body>
</html>