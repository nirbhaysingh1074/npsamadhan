<!DOCTYPE html>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c"%>
<html dir="ltr" lang="en-US">
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>UniHyr</title>
</head>
<body class="loading">

	<div class="breadcrumbs">
		<div class="breadcrumbs_in">
			<div class="container">
				<h2>Upload profile</h2>
			</div>
		</div>
	</div>
	<div class="mid_wrapper">
		<div class="container">
			<div class="form_cont">
				<form:form method="POST" action="uploadprofile"	commandName="uploadProfileForm"  enctype="multipart/form-data">
					<div class="block">
						<div class="form_col">
							<dl>
								<dt>
									<label>Name</label>
								</dt>
								<dd>
									<form:input path="name" />
									<span class='error'><form:errors path="name" /></span>
								</dd>
							</dl>

							<dl>
								<dt>
									<label>Email</label>
								</dt>
								<dd>
									<form:input path="email" />
									<span class='error'><form:errors path="email" /></span>
								</dd>
							</dl>
							<dl>
								<dt>
									<label>Current Role</label>
								</dt>
								<dd>
									<form:input path="currentRole" />
									<span class='error'><form:errors path="currentRole" /></span>
								</dd>
							</dl>
							<dl>
								<dt>
									<label>Willing to Relocate</label>
								</dt>
								<dd>
									<form:select path="willingToRelocate">
										<form:option value="1">Yes</form:option>
										<form:option value="0">No</form:option>
									</form:select>
									<span class='error'><form:errors
											path="willingToRelocate" /></span>
								</dd>
							</dl>
							<dl>
								<dt>
									<label>Notice Period</label>
								</dt>
								<dd>
									<form:input path="noticePeriod" />
									<span class='error'><form:errors path="noticePeriod" /></span>
								</dd>
							</dl>
						</div>
						<div class="form_col">
							<dl>
								<dt>
									<label>Phone</label>
								</dt>
								<dd>
									<form:input path="contact" />
									<span class="error"><form:errors path="contact" /></span>
								</dd>
							</dl>
							<dl>
								<dt>
									<label>Current Organization</label>
								</dt>
								<dd>
									<form:input path="currentOrganization" />
									<span class="error"><form:errors
											path="currentOrganization" /></span>
								</dd>
							</dl>
							<dl>
								<dt>
									<label>Current CTC</label>
								</dt>
								<dd>
									<form:input path="currentCTC" />
									<span class="error"><form:errors path="currentCTC" /></span>
								</dd>
							</dl>
							<dl>
								<dt>
									<label>Expected CTC</label>
								</dt>
								<dd>
									<form:input path="expectedCTC" />
									<span class="error"><form:errors path="expectedCTC" /></span>
								</dd>
							</dl>
							<dl>
								<dt>
									<label>Upload JD</label>
								</dt>
								<dd>
									<div class="file_up">
										<form:input path="jdID" />
										<span class='error'><form:errors path="jdID" /></span> <span>
											<input type="file"  name="jdFile" class="select_jd"/>
										</span>
									</div>
								</dd>
							</dl>
							<dl>
								<dt>
									<label>Upload Resume</label>
								</dt>
								<dd>
									<div class="file_up">
										<form:input path="resumePath" />
										<span class='error'><form:errors path="resumePath" /></span> <span>
											<input type="file" name="resumeFile" class="select_jd"/>
										</span>
									</div>
								</dd>
							</dl>
						</div>
					</div>
				<div class="block coment_fild">
					<p>Screening Notes</p>
					<textarea></textarea>
				</div>
				<div class="block form_submt alin_cnt">
					<input type="submit" value="Publish" class="btn yelo_btn">
					<input type="submit" value="Save" class="btn yelo_btn">
				</div>
				</form:form>
			</div>
		</div>
	</div>

</body>
</html>
