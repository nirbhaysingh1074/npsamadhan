<!DOCTYPE html>
<%@page import="java.util.List"%>
<%@page import="com.unihyr.domain.Post"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c"%>
<html dir="ltr" lang="en-US">
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>UniHyr</title>
<style type="text/css">
	.req{color: red;}
</style>
<style type="text/css">
.fileUpload {
    background: gray none repeat scroll 0 0;
    border-radius: 0 5px 5px 0;
    color: #fff;
    float: right;
    height: 27px;
    margin: -27px 0;
    overflow: hidden;
    padding: 6px;
    position: relative;
}
.fileUpload input.upload {
    
    position: absolute;
    top: 0;
    right: 0;
    margin: 0;
    padding: 0;
    font-size: 20px;
    cursor: pointer;
    opacity: 0;
    filter: alpha(opacity=0);
}
</style>

<script type="text/javascript">
	function conscheckapplicantbyemail()
	{
		var pid = $('#postId').val();
		var email = $('#email').val();
		
		if(email != "")
		{
			$.ajax({
				type : "GET",
				url : "conscheckapplicantbyemail",
				data : {'pid':pid,'email':email},
				contentType : "application/json",
				success : function(data) {
					var obj = jQuery.parseJSON(data);
					$('.email_error').html("&nbsp;");
					if(obj.status == true)
					{
						alertify.error("Profile already uploaded for this post !");
						$('.email_error').html("Profile with this email alreadt uploaded for this post !");
						$('#email').focus();
					}
				},
				error: function (xhr, ajaxOptions, thrownError) {
					alert(xhr.responseText);
				}
			}) ;
		}
	}

	function conscheckapplicantbycontact()
	{
		var pid = $('#postId').val();
		var contact = $('#contact').val();
		
		if(contact != "")
		{
			$.ajax({
				type : "GET",
				url : "conscheckapplicantbycontact",
				data : {'pid':pid,'contact':contact},
				contentType : "application/json",
				success : function(data) {
					var obj = jQuery.parseJSON(data);
					$('.contact_error').html("&nbsp;");
					if(obj.status == true)
					{
						alertify.error("Profile already uploaded for this post !");
						$('.contact_error').html("Profile with this contact already uploaded for this post !");
						$('#contact').focus();
					}
				},
				error: function (xhr, ajaxOptions, thrownError) {
					alert(xhr.responseText);
				}
			}) ;
		}
	}
	
</script>
<script type="text/javascript">
	function validateForm()
	{
// 		alert("hello to all");
		var client = $('#cleintId').val();
		var post = $('#postId').val();
		var name = $('#name').val();
		var email = $('#email').val();
		var currentRole = $('#currentRole').val();
		var noticePeriod = $('#noticePeriod').val();
		var contact = $('#contact').val();
		var currentOrganization = $('#currentOrganization').val();
		var currentCTC = $('#currentCTC').val();
		var expectedCTC = $('#expectedCTC').val();
		var resumeText = CKEDITOR.instances['resumeText'].getData(); //$('#resumeText').val();
		var select_jd = $('.select_jd').val();
		
		
		
		$('.error').html("&nbsp;");

		var valid = true;
		
		if(client == "")
		{
			$('.client_error').html("Please provide client name");
			valid = false;
		}
		if(post == "")
		{
			$('.post_error').html("Please provide post name");
			valid = false;
		}
		if(name == "")
		{
			$('.name_error').html("Please enter profile name");
			valid = false;
		}
		if(email == "" || !isEmail(email))
		{
			$('.email_error').html("Please enter valid email");
			valid = false;
		}
		if(currentRole == "")
		{
			$('.currentRole_error').html("Please enter current role");
			valid = false;
		}
		
		if(currentOrganization == "")
		{
			$('.currentOrganization_error').html("Please enter current Organization");
			valid = false;
		}
		if(noticePeriod == "")
		{
			$('.noticePeriod_error').html("Please enter notice period");
			valid = false;
		}
		if(contact == "" || contact.length != 10)
		{
			$('.contact_error').html("Please enter valid phone number");
			valid = false;
		}
		if(currentCTC == "" || isNaN(currentCTC))
		{
			$('.currentCTC_error').html("Please enter current CTC");
			valid = false;
		}
		if(expectedCTC == "" || isNaN(expectedCTC))
		{
			$('.expectedCTC_error').html("Please enter expected CTC");
			valid = false;
		}
		
		
		if(select_jd == "" && (resumeText.length ==""))
		{
			$('.resumePath_error').html("Please select resume or enter resume text");
			valid = false;
		}
		/* 
		if(resumeText == "")
		{
			$('.resumeText_error').html("Please enter resume text");
			valid = false;
		} */
		
		if(!valid)
		{
			return false;
		}
		
	}
	function isEmail(email) {
		  var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
		  return regex.test(email);
		}
	
	jQuery(document).ready(function() {
		
		$(document.body).on('change', '.select_jd' ,function(){
			var valid = true;
			
			var f=this.files[0];
// 			var size = f.size||f.fileSize;
			$('.resumePath_error').html("");
			var extension = f.name.replace(/^.*\./, '');
			if (extension == f.name) {
	            extension = '';
	        } else
			{
	            extension = extension.toLowerCase();
	        }
			switch (extension) {
		        case 'doc':
		        		break;
		        case 'docx':
		        	break;
		        case 'pdf':
		        	break;
		        default:
					$('.resumePath_error').html("Please select doc, docx or pdf file only.");
	        		$('#resumePath').val("");
		            valid = false;
	    	}
			if(valid && f.size > 2048000)
			{
				$('#resumePath').val("");
	        	$('.resumePath_error').html("Please select file less than 2 MB.");
				valid = false;
			}
			
			if(!valid)
			{
				
				$(this).val("");
			}
// 			alert(extension);
		});
	});
	
</script>

<%
	boolean quataExceed = (Boolean)request.getAttribute("quataExceed");
	if(quataExceed)
	{
		System.out.println("quataExceed");
		%>
			<script type="text/javascript">
			jQuery(document).ready(function() {
				alertify.confirm("Daily quota for this position has been exhausted please submit your profile tomorrow. Close this tab ?", function (e, str) {
					if (e) {
						window.close();
					}
				});
			});
			</script>
		<%
	}
	
	
	
%>

</head>
<body class="loading">

	<div class="mid_wrapper">
		<div class="container">
			<div class="form_cont">
				<form:form method="POST" action="uploadprofile"	commandName="uploadProfileForm"  enctype="multipart/form-data" onsubmit=" return validateForm()">
					<div class="block">
						<div class="form_col">
							<%
								String fileuploaderror = (String)request.getAttribute("fileuploaderror");
								if(fileuploaderror != null && fileuploaderror.equals("true"))
								{
									%>
									<%
									List<String> uploadMsg = (List)request.getAttribute("uploadMsg");
									if(uploadMsg != null && !uploadMsg.isEmpty())
									{
										for(String msg : uploadMsg)
										{
											%>
												<dl>
													<dd>
														<label><%=  msg%></label>
													</dd>
												</dl>
											<%
										}
									}
									%>
									
									<%
									
								}
							%>
							
							<dl>
								<dt>
									<label>Client </label>
								</dt>
								<dd>
									<form:hidden path="post.client.lid" id="cleintId"  value="${post.client.lid}"></form:hidden>
										<label>${post.client.organizationName}</label>
									
									<span class='error client_error'> &nbsp;<form:errors path="post.client.lid" /></span>
								</dd>
							</dl>
							<dl>
								<dt>
									<label>Post</label>
								</dt>
								<dd>
									<form:hidden path="post.postId" id="postId" value="${post.postId}" ></form:hidden>
										<label>${post.title}</label>
									<span class='error post_error'> &nbsp;<form:errors path="post.postId" /></span>
								</dd>
							</dl>
							
							
							<dl>
								<dt>
									<label>Name<span class="req">*</span></label>
								</dt>
								<dd>
									<form:input path="name" />
									<span class='error name_error'>&nbsp;<form:errors path="name"  /></span>
								</dd>
							</dl>

							<dl>
								<dt>
									<label>Phone<span class="req">*</span></label>
								</dt>
								<dd>
									<form:input path="contact"   onchange="conscheckapplicantbycontact()" cssStyle="padding-left:35px;" cssClass="number_only" maxlength="10" minlength="10"/>
									<span style="position: relative; padding: 5px; border-right: 1px solid rgb(212, 212, 212); float: left; margin-top: -27px;font-size: 12px;"> +91 </span>
									<span class="error contact_error">&nbsp;${profileExist_contact}<form:errors path="contact" /></span>
								</dd>
							</dl>
							<dl>
								<dt>
									<label>Email<span class="req">*</span></label>
								</dt>
								<dd>
									<form:input path="email"  onchange="conscheckapplicantbyemail()"/>
									<span class='error email_error'>&nbsp;${profileExist_email }<form:errors path="email" /></span>
								</dd>
							</dl>
							<dl>
								<dt>
									<label>Current Location<span class="req">*</span></label>
								</dt>
								<dd>
									<form:input path="currentLocation" />
									<span class='error currentLocation_error'>&nbsp;<form:errors path="currentLocation" /></span>
								</dd>
							</dl>
							
							
							<dl>
								<dt>
									<label>Current Role<span class="req">*</span></label>
								</dt>
								<dd>
									<form:input path="currentRole" />
									<span class='error currentRole_error'>&nbsp;<form:errors path="currentRole" /></span>
								</dd>
							</dl>
							
							<dl>
								<dt>
									<label>Organization<span class="req">*</span></label>
								</dt>
								<dd>
									<form:input path="currentOrganization" />
									<span class="error currentOrganization_error">&nbsp;<form:errors path="currentOrganization" /></span>
								</dd>
							</dl>
							
							<dl>
								<dt>
									<label>Current CTC<span class="req">*</span></label>
								</dt>
								<dd>
									<form:input path="currentCTC" cssClass="number_only" maxlength="5"/>
									<span style="position: relative; padding: 5px; border-left: 1px solid rgb(212, 212, 212); float: right; margin-top: -27px;"> INR (Lacs)</span>
									<span class="error currentCTC_error">&nbsp;<form:errors path="currentCTC" /></span>
								</dd>
							</dl>
							<dl>
								<dt>
									<label>Expected CTC<span class="req">*</span></label>
								</dt>
								<dd>
									<form:input path="expectedCTC" cssClass="number_only" maxlength="5"/>
									<span style="position: relative; padding: 5px; border-left: 1px solid rgb(212, 212, 212); float: right; margin-top: -27px;"> INR (Lacs)</span>
									<span class="error expectedCTC_error">&nbsp;<form:errors path="expectedCTC" /></span>
								</dd>
							</dl>
							
							<dl>
								<dt>
									<label>CTC Related Comments<span class="req">*</span></label>
								</dt>
								<dd>
									<form:textarea path="ctcComments" ></form:textarea>
									<span class="error ctcComments_error">&nbsp;<form:errors path="ctcComments" /></span>
								</dd>
							</dl>
							
							<dl>
								<dt>
									<label>Willing to Relocate<span class="req">*</span></label>
								</dt>
								<dd>
									<form:select path="willingToRelocate">
										<form:option value="Yes">Yes</form:option>
										<form:option value="No">Not applicable</form:option>
									</form:select>
									<span class='error'>&nbsp;<form:errors path="willingToRelocate" /></span>
								</dd>
							</dl>
							<dl>
								<dt>
									<label>Notice Period<span class="req">*</span></label>
								</dt>
								<dd>
									<form:input path="noticePeriod" cssClass="number_only" maxlength="2"   style="padding-right: 150px" />
									<span style="position: relative; padding: 5px; border-left: 1px solid rgb(212, 212, 212); float: right; margin-top: -27px;"> Days</span>
									<span class='error noticePeriod_error'>&nbsp;<form:errors path="noticePeriod" /></span>
								</dd>
							</dl>
							
							
							
							<dl>
								<dt>
									<label>Upload Resume</label>
								</dt>
								<dd>
									<div class="file_up" style="float: left;">
										<form:input path="resumePath" disabled = "true"/>
										<div class="fileUpload">
										    <span>Browse</span>
										    <input type="file" class="upload select_jd" name="resumeFile" />
										</div>
									    <span class="error resumePath_error">&nbsp;<form:errors path="resumePath" /></span>
									</div>
									<div style="float: left;">
						    <input style="margin-left:10px; background: #f8b910 none repeat scroll 0 0;
								    border-radius: 0 5px 5px 0;
								    float: right;
								    height: 27px;
								    overflow: hidden;
								    position: relative;padding: 5px;"  type="button" value="Upload" onclick="$('#resumeTextField').attr('display','none')" />
						</div>
								</dd>
							</dl>
							
						</div>
					</div>
				<div class="block coment_fild bottom-padding"   id="resumeTextField">
					<p>Resume<span class="req"></span></p>
					<form:textarea path="resumeText" id="resumeText" ></form:textarea>
					<span class="error resumeText_error">&nbsp;<form:errors path="resumeText" /></span>
				</div>
				<div class="block coment_fild">
					<p>Screening Notes</p>
					<form:textarea path="screeningNote" id="editor1"></form:textarea>
				</div>
				<div class="block form_submt alin_cnt">
				<%
					Post post = (Post)request.getAttribute("post");
					if(post != null && post.isActive())
					{
						%>
							<input type="${quataExceed == true ? 'button' : 'submit'}" value="Upload" class="btn yelo_btn">
						<%
					}
					else
					{
						%>
						<input type="button" value="Post is Inactive" class="btn yelo_btn" style="background-color: gray;">
						<%
					}
				%>
				</div>
				</form:form>
			</div>
		</div>
	</div>
<script src="ckeditor/ckeditor.js"></script>
<script src="ckeditor/bootstrap3-wysihtml5.all.js"></script>
<script>
      $(function () {
        // Replace the <textarea id="editor1"> with a CKEditor
        // instance, using default configuration.
//         CKEDITOR.replace('editor1');
        CKEDITOR.replace('resumeText');
        
      });
    </script>
</body>
</html>
