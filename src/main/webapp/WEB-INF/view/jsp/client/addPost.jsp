<!DOCTYPE html>
<%@page import="com.unihyr.domain.Registration"%>
<%@page import="java.util.List"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.NumberFormat"%>
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
	function validateForm()
	{
		var title = $('#title').val();
		var location = $('#location').val();
		var fun = $('#function').val();
		var noOfPosts = $('#noOfPosts').val();
		var role = $('#role').val();
		var designation = $('#designation').val();
		var exp_min = $('#exp_min').val();
		var exp_max = $('#exp_max').val();
		var ctc_min = $('#ctc_min').val();
		var ctc_max = $('#ctc_max').val();
		
// 		var workHourStartHour = $('#workHourStartHour').val().split(":");
// 		var workHourStartMin = $('#workHourStartMin').val();
// 		var workHourEndHour = $('#workHourEndHour').val().split(":");
// 		var workHourEndMin = $('#workHourEndMin').val();
		
		var additionDetail = CKEDITOR.instances['additionDetail'].getData(); //$('#additionDetail').val();
		var select_jd = $('.select_jd').val();
		
		
		$('.error').html('&nbsp;');
		var valid = true;
		
		if(title == "")
		{
			$('.title_error').html('Please enter post title')
			valid = false;
		}
		if(location == "")
		{
			$('.location_error').html('Please select post location')
			valid = false;
		}
		if(fun == "")
		{
			$('.function_error').html('Please enter post function')
			valid = false;
		}
		if(noOfPosts == ""||noOfPosts == "0")
		{
			$('.noOfPosts_error').html('Please enter no of posts')
			valid = false;
		}
		if(role == "")
		{
			$('.role_error').html('Please enter post role')
			valid = false;
		}
		if(designation == "")
		{
			$('.designation_error').html('Please enter post designation')
			valid = false;
		}
		if(exp_min == ""  || isNaN(exp_min))
		{
			$('.exp_min_error').html('Please select minimum expirence')
			valid = false;
		}
		if(exp_max == ""  || isNaN(exp_max) || exp_min >= exp_max)
		{
			$('.exp_max_error').html('Min cannot be greater than or equal to Max')
			valid = false;
		}
		if(ctc_min == ""  || isNaN(ctc_min))
		{
			$('.ctc_min_error').html('Please enter minimum ctc')
			valid = false;
		}
		if(ctc_max == ""  || isNaN(ctc_max) || ctc_min >= ctc_max)
		{
			$('.ctc_max_error').html('Min cannot be greater than or equal to Max')
			valid = false;
		}
		if(select_jd == "" && additionDetail == "")
		{
			$('.uploadjd_error').html("Please select JD or enter job description");
			valid = false;
		}
		/* if(workHourStartHour[0] >= workHourEndHour[0])
		{

			$('.workHourStartHour_error').html("Start Hour should be greator than end hour");
			valid = false;
		} */
		
		
		/* if(additionDetail == "")
		{
			$('.additionDetail_error').html('Please enter job discription')
			valid = false;
		} */
		
		

		if(!valid)
		{
			return false;
		}
		
	}

</script>
<script type="text/javascript">
jQuery(document).ready(function() {
	
	$(document.body).on('change', '.select_jd' ,function(){
		var valid = true;
		
		var f=this.files[0];
//			var size = f.size||f.fileSize;
		$('.uploadjd_error').html("");
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
				$('.uploadjd_error').html("Please select doc, docx or pdf file only.");
        		$('#select_jd').val("");
	            valid = false;
    	}
		if(valid && f.size > 2048000)
		{
			$('#select_jd').val("");
        	$('.uploadjd_error').html("Please select file less than 2 MB.");
			valid = false;
		}
		
		if(!valid)
		{
			$('.select_jd').val("");
			$(this).val("");
		}
//			alert(extension);
	});
});
</script>
</head>
<body class="loading">
<% 
Registration registration=(Registration)request.getAttribute("registration");
 %>
	<div class="mid_wrapper">
	  <div class="container">
	    <div class="form_cont">
          <form:form method="POST" action="clientaddpost" commandName="postForm" enctype="multipart/form-data" onsubmit=" return validateForm()">
	      <div class="block">
	     
	        <div class="form_col">
	          
	          <dl>
	            <dt>
	              <label>Title<span class='error'>*</span></label>
	            </dt>
	            <dd>
	              <form:input path="title"  />
	              <span class='error title_error'><form:errors path="title" /></span>
	            </dd>
	          </dl>
	          <dl>
	            <dt>
	              <label>Location<span class='error'>*</span> </label>
	            </dt>
	            <dd>
	              <form:select path="location"  multiple="multiple">
	              	<form:option value="">Select Location</form:option>
	            		<c:forEach var="item" items="${locList}">
						   <form:option value="${item.location}">${item.location}</form:option>
						</c:forEach>
	            	</form:select>
	              
					<%--  <form:input path="location" /> --%>
	              <span class='error location_error'><form:errors path="location"/></span>
	            </dd>
	          </dl>
	          <dl style="clear: both;">
	            <dt>
	              <label>Role Type<span class='error'>*</span></label>
	            </dt>
	            <dd>
	              <form:select path="function">
	                    <form:option value="Individual Contributor">Individual Contributor</form:option>
	                    <form:option value="Team Leading">Team Leading</form:option>
	            </form:select>
					<%-- 	 <form:input path="function" /> --%>
	              <span class='error function_error'><form:errors path="function"/></span>
	            </dd>
	          </dl>
	          <dl>
	            <dt>
	              <label>No of positions<span class='error'>*</span></label>
	            </dt>
	            <dd>
	              <form:input path="noOfPosts" class="number_only number_pasitive" maxlength="5" />
	              <span class='error noOfPosts_error'><form:errors path="noOfPosts"/></span>
	            </dd>
	          </dl>
	          <dl style="clear: both;">
	          
	            <dt>
	              <label>Role<span class='error'>*</span></label>
	            </dt>
	            <dd>
	              <form:input path="role" />
	              <span class='error role_error'><form:errors path="role"/></span>
	            </dd>
	          </dl>
	          <dl>
	            <dt>
	              <label>Designation<span class='error'>*</span></label>
	            </dt>
	            <dd>
	              <form:input path="designation" />
	              <span class='error designation_error'><form:errors path="designation"/></span>
	            </dd>
	          </dl>
	          <dl style="clear: both;">
	            <dt>
	              <label>Experience<span class='error'>*</span></label>
	            </dt>
	            <dd>
	              <div class="row">
	                <div class="col-md-6">
	                  <form:select path="exp_min">
	                    <form:option value="0">0 Years (Min)</form:option>
	                    <form:option value="1">1 Years</form:option>
	                    <form:option value="2">2 Years</form:option>
	                    <form:option value="3">3 Years</form:option>
	                    <form:option value="4">4 Years</form:option>
	                    <form:option value="5">5 Years</form:option>
	                    <form:option value="6">6 Years</form:option>
	                    <form:option value="7">7 Years</form:option>
	                  </form:select>
	                  <span class='error exp_min_error'><form:errors path="exp_min"/></span>
	                </div>
	                <div class="col-md-6">
	                  <form:select path="exp_max">
	                    <form:option value="0">0 Years (Max)</form:option>
	                    <form:option value="1">1 Years</form:option>
	                    <form:option value="2">2 Years</form:option>
	                    <form:option value="3">3 Years</form:option>
	                    <form:option value="4">4 Years</form:option>
	                    <form:option value="5">5 Years</form:option>
	                    <form:option value="6">6 Years</form:option>
	                    <form:option value="7">7 Years</form:option>
	                  </form:select>
	                  <span class='error exp_max_error' ><form:errors path="exp_max"/></span>
	                </div>
	              </div>
	            </dd>
	          </dl>
	          <dl>
	            <dt>
	              <label>Annual CTC<span class='error'>*</span></label>
	            </dt>
	            <dd>
	              <div class="row">
	                <div class="col-md-6">
	                  <form:input path="ctc_min" class="number_only" style="padding-right: 75px"  />
	                  <span style="position: relative; padding: 5px; border-left: 1px solid rgb(212, 212, 212); float: right; margin-top: -27px;">(Min INR Lacs)</span>
	                  <span class='error ctc_min_error'><form:errors path="ctc_min"/></span>
	                </div>
	                <div class="col-md-6">
	                  <form:input path="ctc_max" class="number_only" style="padding-right: 75px" />
	                  <span style="position: relative; padding: 5px; border-left: 1px solid rgb(212, 212, 212); float: right; margin-top: -27px;">(Max INR Lacs)</span>
	                  <span class='error ctc_max_error'><form:errors path="ctc_max"/></span>
	                </div>
	              </div>
	            </dd>
	          </dl>
	          
	          
	          
	          <dl style="display: none;">
	            <dt>
	              <label><br>Normal Work Hours<span class='error'>*</span></label>
	            </dt>
	            <dd>
	              <div class="row">
	                <div class="col-md-4">Start Time
	                  <form:select path="workHourStartHour">
	                  
	                   <%
	                   NumberFormat formatter = new DecimalFormat("00");  
	                   for(int i=00;i<=11;i++){
	                   %>
	                   <form:option value='<%=formatter.format(i)+":00 AM" %>'><%=formatter.format(i) %>:00 AM</form:option>
	                   <form:option value='<%=formatter.format(i)+":30 AM" %>'><%=formatter.format(i) %>:30 AM</form:option>
					   <%} %>
	                   <form:option value="12:00 PM">12:00 PM</form:option>
	                   <form:option value="12:30 PM">12:30 PM</form:option>
					<%
	                   for(int i=1;i<=11;i++){ %>
						
	                   <form:option value='<%=formatter.format(i)+":00 PM" %>'><%=formatter.format(i) %>:00 PM</form:option>
	                  
	                   <form:option value='<%=formatter.format(i)+":30 PM" %>'><%=formatter.format(i) %>:30 PM</form:option>
						<%} %>
	                
	                 
	                  </form:select>
	                  <span class='error workHourStartHour_error'><form:errors path="workHourStartHour"/></span>
	                </div>
	         
	                <div class="col-md-4"> End Time
	                  <form:select path="workHourEndHour">
	                  
	                   <form:option value='11:59 PM'>11:59 PM</form:option>
	                   <%
	                   NumberFormat formatter = new DecimalFormat("00");  
	                   for(int i=11;i>=1;i--){ %>
						
	                   <form:option value='<%=formatter.format(i)+":30 PM" %>'><%=formatter.format(i) %>:30 PM</form:option>
	                  
	                   <form:option value='<%=formatter.format(i)+":00 PM" %>'><%=formatter.format(i) %>:00 PM</form:option>
						<%} %>
	                     <form:option value="12:30 PM">12:30 PM</form:option>
	                  
	                   <form:option value="12:00 PM">12:00 PM</form:option>
					<%
	                   for(int i=11;i>=0;i--){ %>
						
	                   <form:option value='<%=formatter.format(i)+":30 AM" %>'><%=formatter.format(i) %>:00 AM</form:option>
	                  
	                   <form:option value='<%=formatter.format(i)+":00 AM" %>'><%=formatter.format(i) %>:00 AM</form:option>
						<%} %>
	                 
	                  </form:select>
	                  <span class='error workHourEndHour_error'><form:errors path="workHourEndHour"/></span>
	                </div>
	             
	                
	              </div>
	            </dd>
	          </dl>
	          
	       <dl   style="clear: both;">
					<dt>
						<label>Profile Quota</label>
					</dt>
					<dd>
						<form:input path="profileParDay" class="number_only"  />
						<span class="error profileParDay_error">&nbsp;<form:errors path="profileParDay" /></span>
					</dd>
			  </dl>
	          <dl>
					<dt>
						<label>Upload JD</label>
					</dt>
					<dd>
						<div class="file_up" style="float: left;">
							<form:input path="uploadjd" disabled = "true"/>
							<div class="fileUpload">
							    <span>Browse</span>
							    <input type="file" class="upload select_jd" name="uploadJdfile" />
							</div>
						    <span class="error uploadjd_error">&nbsp;<form:errors path="uploadjd" /></span>
						    
						</div>
						<div style="float: left;">
						    <input style="margin-left:10px; background: #f8b910 none repeat scroll 0 0;
    border-radius: 0 5px 5px 0;
    float: right;
    height: 27px;
    overflow: hidden;
    position: relative;padding: 2px;"  type="button" value="Upload" onclick="$('#jobDescriptionText').css('display','none')" />
					</div>
					</dd>
				</dl>
			<!-- 	<dl style="clear:both;">
					<dd>
						<input type="button" id="startRecording" value="Start" /> 
						<input type="button" id="stopRecording" value="Stop" /> 
						<span id="recordingStatus"></span> 
						<input type="hidden" id="fileUidKey" />
					</dd>
				</dl> -->
				<%
	          
					String fileuploaderror = (String)request.getAttribute("fileuploaderror");
					if(fileuploaderror != null && fileuploaderror.equals("true"))
					{
						List<String> uploadMsg = (List)request.getAttribute("uploadMsg");
						if(uploadMsg != null && !uploadMsg.isEmpty())
						{
							for(String msg : uploadMsg)
							{
								%>
									<dl style="clear: both;">
										<dd>
											<label class="error"> * <%=  msg%></label>
										</dd>
									</dl>
								<%
							}
						}
						%>
						
						<%
						
					}
				%>
	        </div>
	      </div>
	      
	      
	      
	      
	      <div class="block coment_fild"  id="jobDescriptionText">
	        <p>Job Description (please paste the JD here)</p>
	        <form:textarea path="additionDetail" id="additionDetail" ></form:textarea>
	        <span class='error additionDetail_error'><form:errors path="additionDetail"/></span>
	      </div>
	      <br>
	      <div class="block coment_fild" style="padding-top: 35px">
	        <p>Additional Comments</p>
	        <form:textarea path="comment" ></form:textarea>
             <span class='error'><form:errors path="comment"/></span>
	      </div>
	      
	      <div class="block form_submt alin_cnt">
	        <input type="submit" name="btn_response" value="Publish" class="btn yelo_btn">
	        <input type="submit" name="btn_response" value="Save" class="btn yelo_btn">
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
        CKEDITOR.replace('additionDetail');
        
      });
    </script>
</body>
</html>
