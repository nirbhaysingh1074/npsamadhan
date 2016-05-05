<!DOCTYPE html>
<html dir="ltr" lang="en-US">
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Uni Hyr</title>
<style type="text/css">

.help-desk{position: fixed; bottom: 0; right: 10px;}
.help-desk .desk-header{
	padding: 10px 20px; 
	color: #000; 
	background-color: #F8B910;
	
	cursor: pointer;
}
.content-field{margin-top: 10px;}
.help-desk .desk-content{display: none;background-color: #CCCCCC;padding: 10px 20px;width: 325px;}
.help-desk .active {display: block;}

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
	<div class="desk-header ">Help Desk</div>
	<div class="desk-content">
		<div class="contant-body" >
			<div class="content-field">
				<label>Name</label>
				<input type="text" name="name" class="name">
			</div>
			<div class="content-field">
				<label>Email</label>
				<input type="email" name="email" class="email">
			</div>
			<div class="content-field">
				<label>Message</label>
				<textarea name="email" class="msg"> </textarea>
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
	var email = $('.help-desk .email').val();
	var msg = $('.help-desk .msg').val();
	$(this).html("Sending...");
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
				$('.help-desk .email').val("");
				$('.help-desk .msg').val("");
				alertify.success("Message Send Successfully !");
				$(".help-desk .desk-content").removeClass("active");
			}
			$(".help-desk .submit").html("Submit");
		},
		error: function (xhr, ajaxOptions, thrownError) {
			alert(xhr.status);
		}
	}) ;
	
	
	event.stopPropagation();
});
</script>

</body>
</html>
