<!DOCTYPE html>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c"%>
<html dir="ltr" lang="en-US">
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>UniHyr</title>
<script type="text/javascript">
	function conscheckapplicant()
	{
		var pid = $('#postId').val();
		var email = $('#email').val();
		var contact = $('#contact').val();
		
// 		alert("pid : " +pid);
// 		alert("email : " +email);
// 		alert("contact : " +contact);
		if(email != "" && contact != "")
		{
			$.ajax({
				type : "GET",
				url : "conscheckapplicant",
				data : {'pid':pid,'email':email,'contact':contact},
				contentType : "application/json",
				success : function(data) {
					var obj = jQuery.parseJSON(data);
					if(obj.status == true)
					{
						alertify.error("Profile already uploaded for this post !");
						$('#email').focus();
					}
				},
				error: function (xhr, ajaxOptions, thrownError) {
					alert(xhr.responseText);
				}
			}) ;
		}
	}

</script>
</head>
<body class="loading">

	<div class="mid_wrapper">
		<div class="container">
			<div class="form_cont">
				<form:form method="POST" action="uploadprofile"	commandName="uploadProfileForm"  enctype="multipart/form-data">
					<div class="block">
						<div class="form_col">
							<dl>
								<dt>
									<label>Client</label>
								</dt>
								<dd>
									<form:select path="post.client.lid" id="postId" disabled="disabled">
										<form:option value="${post.client.lid}">${post.client.organizationName}</form:option>
									</form:select>
									<span class='error'><form:errors path="post.client.lid" /></span>
								</dd>
							</dl>
							<dl>
								<dt>
									<label>Post</label>
								</dt>
								<dd>
									<form:select path="post.postId" disabled="disabled">
										<form:option value="${post.postId}">${post.title}</form:option>
									</form:select>
									<span class='error'><form:errors path="post.postId" /></span>
								</dd>
							</dl>
							
							
							<dl>
								<dt>
									<label>Name</label>
								</dt>
								<dd>
									<form:input path="name" required="required"/>
									<span class='error'>&nbsp;<form:errors path="name"  /></span>
								</dd>
							</dl>

							<dl>
								<dt>
									<label>Email</label>
								</dt>
								<dd>
									<form:input path="email" type="email" required="required" onchange="conscheckapplicant()"/>
									<span class='error'>&nbsp;${profileExist }<form:errors path="email" /></span>
								</dd>
							</dl>
							<dl>
								<dt>
									<label>Current Role</label>
								</dt>
								<dd>
									<form:input path="currentRole" required="required"/>
									<span class='error'>&nbsp;<form:errors path="currentRole" /></span>
								</dd>
							</dl>
							<dl>
								<dt>
									<label>Willing to Relocate</label>
								</dt>
								<dd>
									<form:select path="willingToRelocate">
										<form:option value="Yes">Yes</form:option>
										<form:option value="No">No</form:option>
									</form:select>
									<span class='error'>&nbsp;<form:errors path="willingToRelocate" /></span>
								</dd>
							</dl>
							<dl>
								<dt>
									<label>Notice Period</label>
								</dt>
								<dd>
									<form:input path="noticePeriod" required="required"/>
									<span class='error'>&nbsp;<form:errors path="noticePeriod" /></span>
								</dd>
							</dl>
							<dl>
								<dt>
									<label>Phone</label>
								</dt>
								<dd>
									<form:input path="contact" required="required" onchange="conscheckapplicant()" cssClass="number_only"/>
									<span class="error">&nbsp;<form:errors path="contact" /></span>
								</dd>
							</dl>
							<dl>
								<dt>
									<label>Current Org</label>
								</dt>
								<dd>
									<form:input path="currentOrganization" required="required"/>
									<span class="error">&nbsp;<form:errors path="currentOrganization" /></span>
								</dd>
							</dl>
							<dl>
								<dt>
									<label>Current CTC</label>
								</dt>
								<dd>
									<form:input path="currentCTC" />
									<span class="error">&nbsp;<form:errors path="currentCTC" /></span>
								</dd>
							</dl>
							<dl>
								<dt>
									<label>Expected CTC</label>
								</dt>
								<dd>
									<form:input path="expectedCTC" />
									<span class="error">&nbsp;<form:errors path="expectedCTC" /></span>
								</dd>
							</dl>
							
							<dl>
								<dt>
									<label>Upload Resume</label>
								</dt>
								<dd>
									<div class="file_up">
										<form:input path="resumePath" />
										<span class='error'>&nbsp;<form:errors path="resumePath" /></span> <span>
											<input type="file" name="resumeFile" class="select_jd"/>
										</span>
									</div>
								</dd>
							</dl>
						</div>
					</div>
				<div class="block coment_fild">
					<p>Screening Notes</p>
					<form:textarea path="screeningNote" id="editor1"></form:textarea>
				</div>
				<div class="block form_submt alin_cnt">
					<input type="submit" value="Upload" class="btn yelo_btn">
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
        CKEDITOR.replace('editor1');
        CKEDITOR.config.toolbar =
            [{ name: 'document', items : [ 'Source'] },
             { name: 'clipboard', items : [ 'Cut','Copy','Paste','PasteText','PasteFromWord','-','Undo','Redo' ] },
                ['Bold', 'Italic', '-', 'NumberedList', 'BulletedList', '-', 'Link', 'Unlink']
            ];
      });
    </script>
</body>
</html>
