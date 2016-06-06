<!DOCTYPE html>
<html dir="ltr" lang="en-US">
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Uni Hyr</title>
<style type="text/css">

.help-desk{    position: fixed;
    top: 20%;
    right: -28px;
    -ms-transform: rotate(270deg);
    -webkit-transform: rotate(270deg);
    transform: rotate(270deg);}
.help-desk .desk-header{
	padding: 10px 20px; 
	color: #000; 
	background-color: #F8B910;
	cursor: pointer;
}
.content-field{margin-top: 10px;}
.help-desk .desk-content{display: none;background-color: #CCCCCC;padding: 10px 20px;width: 325px;}
.help-desk .active {display: block;}
.desk-content{
-ms-transform: rotate(7deg);
    -webkit-transform: rotate(7deg);
    transform: rotate(90deg);
    border: 1px solid #f8b910;
}
.contant-body{
padding-right: 45px;
}
</style>
</head>
<body class="loading">
<footer class="clearfix">
  <div class="container" style="background: inherit;">
    <ul class="ft_menu">
      <li><a href="">Terms of Use</a> <span>|</span></li>
      <li><a href="">Privacy Policy</a> <span>|</span></li>
      <li><a href="">Sitemap</a> <span>|</span></li>
      <li><a href="">Work with Us</a></li>
    </ul>
  </div>
</footer>

<div class="help-desk">
	<div class="desk-header " style="top: -64px;
position: absolute;
right: 21px;
width: 103px;
background: rgb(0, 0, 0) none repeat scroll 0% 0%;
color: rgb(255, 255, 255);
font-weight: bold;height: 50px">Help Desk</div>
	<div class="desk-content">
		<div class="contant-body"  >
			<div class="content-field">
				<label>Your Name</label>
				<input type="text" name="name" class="name" />
			</div>
			<!-- <div class="content-field">
				<label>Your Email</label>
				<input type="email" name="email" class="email" />
			</div> -->
			<!-- <div class="content-field">
				<label>Contact No.</label>
				<input type="number" id="contactNo" name="contactNo" class="contactNo" required />
			</div> -->
			<div class="content-field">
				<label>Subject</label>
				<input type="text" name="subject" class="subject" />
			</div>
			<div class="content-field">
				<label>Message</label>
				<textarea name="message" class="msg"></textarea>
			</div>
			<div class="content-field">
				<button class="submit profile_status_button">Submit</button>
			</div>
		</div>
	</div>
</div>


<!--SCRIPTS-->
<!-- <script type="text/javascript" src="js/jquery.min.js"></script> -->
<script src="js/alertify.min.js"></script>
<script type="text/javascript">
$(".toggle-icon").click(function(){
  $(".toggle-icon").toggleClass("active");
});
</script>
<script type="text/javascript">
$(".help-desk .desk-header").click(function(event){
	$(".help-desk .desk-content").toggleClass("active");
	
	  
	  event.stopPropagation();
});

$(".help-desk .desk-content").click(function(event){
	event.stopPropagation();
});

$(".help-desk .submit").click(function(event){
	var name = $('.help-desk .name').val();
	var email ='';
	//var contactNo=$('#contactNo').val();
	var msg = $('.help-desk .msg').val();
	$(this).html("Sending...");
	pleaseWait();
	$.ajax({
		type : "GET",
		url : "helpDeskMessage",
		data : {'name':name,'email':email,'msg':msg},
		contentType : "application/json",
		success : function(data) {
			
			var obj = jQuery.parseJSON(data);
			if(obj.status)
			{
				$('.help-desk .name').val("");
			//	$('.help-desk .email').val("");
				$('.help-desk .msg').val("");
			//	$('#contactNo').val('');
				alertify.success("Message Send Successfully !");
				$(".help-desk .desk-content").removeClass("active");
			}
			$(".help-desk .submit").html("Submit");
			pleaseDontWait();
		},
		error: function (xhr, ajaxOptions, thrownError) {
			alert(xhr.status);
			pleaseDontWait();
		}
	}) ;
	
	
	event.stopPropagation();
});
</script>

<div class="bodyCoverWait" style="display: none;text-align: center; ">
<img style="position: relative;top: 250px;" alt="Please wait..." src="images/pwait.gif" />
</div>

<div class="firstTimeLoginPopup profileClosed1" style="top:35%;border:1px solid #f8b910;display: none;height: auto;position: fixed;max-height: 300px;" >
				<div class="login-header" style="padding: 3px 3px 3px 2px;
line-height: 30px;
height: 29px;">
					
					<a href="javascript:void(0)"><span style="padding: 0px 9px;
    top: -16px;" class="close" title="Close" onclick="$('.bodyCover').css('display','none');$('.firstTimeLoginPopup').css('display','none');"><img style="    height: 40px;" src="images/close.png" /></span></a>
				</div>
				<div class="login-wrap" style="padding: 10px;" id="profileClosed">
				
				</div>
			</div>

<div class="bodyCover profileClosed1" style="display: none;position: fixed;">

</div>
<script type="text/javascript">

function getClosedCandidates(postId){
	$.ajax({
		type : "GET",
		url : "profileClosures",
		data : {'postId':postId},
		contentType : "application/json",
		success : function(data) {
			
			$('#profileClosed').html(data);
			$('.profileClosed1').css('display','block');
			$('.profileClosed1').css('display','block');
		},
		error: function (xhr, ajaxOptions, thrownError) {
	       // alert(xhr.status);
	      }
    }) ;	

}

function pleaseWait(){

	$('.bodyCoverWait').css('display','block');
}
function pleaseDontWait(){

	$('.bodyCoverWait').css('display','none');
}
</script>
</body>
</html>
