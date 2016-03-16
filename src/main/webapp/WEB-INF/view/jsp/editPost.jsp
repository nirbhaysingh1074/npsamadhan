<!DOCTYPE html>
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
<link rel="stylesheet" href="ckeditor/bootstrap3-wysihtml5.css">
</head>
<body class="loading">

	<div class="mid_wrapper">
	  <div class="container">
	    <div class="form_cont">
          <form:form method="POST" action="clienteditpost" commandName="postForm" enctype="multipart/form-data">
	      <div class="block">
	        <div class="form_col">
	          <dl>
	            <dt>
	              <label>Title</label>
	            </dt>
	            <dd>
	              <form:input path="title" />
	              <form:hidden path="postId"/>
	              
	              <span class='error'><form:errors path="title" /></span>
	            </dd>
	          </dl>
	          <dl>
	            <dt>
	              <label>Location </label>
	            </dt>
	            <dd>
	              <form:input path="location" />
	              <span class='error'><form:errors path="location"/></span>
	            </dd>
	          </dl>
	          <dl>
	            <dt>
	              <label>Function</label>
	            </dt>
	            <dd>
	              <form:input path="function" />
	              <span class='error'><form:errors path="function"/></span>
	            </dd>
	          </dl>
	          <dl>
	            <dt>
	              <label>Criteria</label>
	            </dt>
	            <dd>
	              <form:select path="criteria">
	                <form:option value="">Select Criteria</form:option>
	                <form:option value="ABC">ABC</form:option>
	                
	              </form:select>
	                <span class='error'><form:errors path="criteria"/></span>
	            </dd>
	          </dl>
	          <dl>
	            <dt>
	              <label>Experience (In Years)</label>
	            </dt>
	            <dd>
	              <div class="row">
	                <div class="col-md-6">
	                  <form:select path="exp_min">
	                    <form:option value="0">0 year</form:option>
	                    <form:option value="1">1 year</form:option>
	                    <form:option value="2">2 year</form:option>
	                    <form:option value="3">3 year</form:option>
	                    <form:option value="4">4 year</form:option>
	                    <form:option value="5">5 year</form:option>
	                    <form:option value="6">6 year</form:option>
	                    <form:option value="7">7 year</form:option>
	                  </form:select>
	                  <span class='error'><form:errors path="exp_min"/></span>
	                </div>
	                <div class="col-md-6">
	                  <form:select path="exp_max">
	                    <form:option value="0">0 year</form:option>
	                    <form:option value="1">1 year</form:option>
	                    <form:option value="2">2 year</form:option>
	                    <form:option value="3">3 year</form:option>
	                    <form:option value="4">4 year</form:option>
	                    <form:option value="5">5 year</form:option>
	                    <form:option value="6">6 year</form:option>
	                    <form:option value="7">7 year</form:option>
	                  </form:select>
	                  <span class='error'><form:errors path="exp_max"/></span>
	                </div>
	              </div>
	            </dd>
	          </dl>
	          <dl>
	            <dt>
	              <label>Compensation (In Lacs)</label>
	            </dt>
	            <dd>
	              <div class="row">
	                <div class="col-md-6">
	                  <form:input path="ctc_min" class="number_only"/>
	                  <span class='error'><form:errors path="ctc_min"/></span>
	                </div>
	                <div class="col-md-6">
	                  <form:input path="ctc_max" class="number_only"/>
	                  <span class='error'><form:errors path="ctc_max"/></span>
	                </div>
	              </div>
	            </dd>
	          </dl>
	          
	        </div>
	      </div>
	      <div class="block coment_fild">
	        <p>Additional Description</p>
	        <form:textarea path="additionDetail" id="editor1"></form:textarea>
	        <span class='error'><form:errors path="additionDetail"/></span>
	      </div>
	      <br>
	      <div class="block coment_fild" style="padding-top: 35px">
	        <p>comments</p>
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
<script>
      $(function () {
    	  
        CKEDITOR.replace('editor1',{
            toolbar : 'Simple'
        });
        
      });
    </script>
</body>
</html>
