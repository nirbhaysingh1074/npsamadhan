function acceptPostCloseRequest(postId)
{	alertify.confirm("Are you sure want to close this post ?", function (e, str) {
	if (e) 
	{
	$.ajax({
		type : "GET",
		url : "acceptPostCloseRequest",
		data : {'postId':postId},
		contentType : "application/json",
		success : function(data) {
			alertify.success(data);
		},
		error: function (xhr, ajaxOptions, thrownError) {
	        alert(xhr.status);
	      }
    }) ;	
	}
	});
}

jQuery(document).ready(function() {
	
	$(document.body).on('click', '.user_account  .change_password' ,function(){
		var userid = $('.user_account  #userid').val();
		var password = $('.user_account  #password').val();
		var repassword = $('.user_account  #repassword').val();
		if( userid != "" && password != "" && repassword != "" && password == repassword)
		{
			if(!checkComplexity(password))
			{
				alertify.error("Please use atleast one  alphabet and number !");
				return false;
			}
			$.ajax({
				type : "GET",
				url : "adminreatpassword",
				data : {'userid':userid,'password':password,'repassword':repassword},
				contentType : "application/json",
				success : function(data) {
					var obj = jQuery.parseJSON(data);
					if(obj.status)
					{
						alertify.success("Password changed for "+userid+" successfully !");
						$('.user_account  #password').val("");
						$('.user_account  #repassword').val("");
					}
					
				},
				error: function (xhr, ajaxOptions, thrownError) {
			        alert(xhr.status);
			      }
		    }) ;	
		}
		else if(password != "" && repassword != "" && password != repassword)
		{
			alertify.error("Please re enter password same as password");
		}
		
		
	});
	
	
	$(document.body).on('click', '.disable_user  .btn-disable' ,function(){
		var userid = $('.user_account  #userid').val();
		
		if( userid != "" )
		{
			alertify.confirm("Are you sure to disable this user ?", function (e, str) {
				if (e) 
				{
					$.ajax({
						type : "GET",
						url : "admindisableuser",
						data : {'userid':userid},
						contentType : "application/json",
						success : function(data) {
//							alert("Userid + " + data);
							
							var obj = jQuery.parseJSON(data);
							if(obj.status)
							{
								alertify.success("User "+userid+" disabled successfully !");
								$('.disable_user  .btn-disable').html("Enable User");
								$('.disable_user  .btn-disable').addClass("btn-enable");
								$('.disable_user  .btn-disable').addClass("btn-success");
								$('.disable_user  .btn-disable').removeClass("btn-danger");
								$('.disable_user  .btn-disable').removeClass("btn-disable");
								
							}
							
						},
						error: function (xhr, ajaxOptions, thrownError) {
					        alert(xhr.status);
					      }
				    }) ;	
				}
			});
			
		}
		
		
	});
	
	
	
	$(document.body).on('click', '.disable_user  .btn-enable' ,function(){
		var userid = $('.user_account  #userid').val();
		if( userid != "" )
		{
				alertify.confirm("Are you sure to enable this user ?", function (e, str) {
				if (e) 
				{
					$.ajax({
						type : "GET",
						url : "adminenableuser",
						data : {'userid':userid},
						contentType : "application/json",
						success : function(data) {
							
							var obj = jQuery.parseJSON(data);
							if(obj.status)
							{
								alertify.success("User "+userid+" enabled successfully !");
								$('.disable_user  .btn-enable').html("Disable User");
								$('.disable_user  .btn-enable').addClass("btn-disable");
								$('.disable_user  .btn-enable').addClass("btn-danger");
								$('.disable_user  .btn-enable').removeClass("btn-success");
								$('.disable_user  .btn-enable').removeClass("btn-enable");
							}
							
						},
						error: function (xhr, ajaxOptions, thrownError) {
					        alert(xhr.status);
					      }
				    }) ;	
				}
			});

		
	}
	});
	
	$(document.body).on('click', '#admin_user_list  .btn_disable' ,function(){
//		alert("userid " + $(this).parent().parent().attr("id"));
		var userid = $(this).parent().parent().attr("id");
		if( userid != "" )
		{
				alertify.confirm("Are you sure to disable this user ?", function (e, str) {
				if (e) 
				{
					$.ajax({
						type : "GET",
						url : "admindisableuser",
						data : {'userid':userid},
						contentType : "application/json",
						success : function(data) {
							
							var obj = jQuery.parseJSON(data);
							if(obj.status)
							{
								location.reload();
							}
							else
							{
								alertify.error("Oops, Something wrong !");
							}
						},
						error: function (xhr, ajaxOptions, thrownError) {
					        alert(xhr.status);
					      }
				    }) ;	
				}
			});
		}
	});
	$(document.body).on('click', '#admin_user_list  .btn_enable' ,function(){
//		alert("userid " + $(this).parent().parent().attr("id"));
		var userid = $(this).parent().parent().attr("id");
		if( userid != "" )
		{
				alertify.confirm("Are you sure to enable this user ?", function (e, str) {
				if (e) 
				{
					$.ajax({
						type : "GET",
						url : "adminenableuser",
						data : {'userid':userid},
						contentType : "application/json",
						success : function(data) {
							
							var obj = jQuery.parseJSON(data);
							if(obj.status)
							{
								location.reload();
							}
							else
							{
								alertify.error("Oops, Something wrong !");
							}
						},
						error: function (xhr, ajaxOptions, thrownError) {
					        alert(xhr.status);
					      }
				    }) ;	
				}
			});
		}
	});
	
	
	
	$(document.body).on('click', '.verify_status .btn_verify' ,function(){
		var pid= $(this).attr("verify-post");
		$.ajax({
			type : "GET",
			url : "adminvarifypost",
			data : {'pid':pid},
			contentType : "application/json",
			success : function(data) {
				var obj = jQuery.parseJSON(data);
				if(obj.status)
				{
					alertify.success("Post verified successfully!");
					location.reload();
				}
				else
				{
					alertify.error("Oops, Something wrong !");
				}
			},
			error: function (xhr, ajaxOptions, thrownError) {
		        alert(xhr.status);
		      }
	    }) ;	
		
		
	});
	
	
	
});


function contractSignUp(){
	var userid = $('.user_account  #userid').val();
	var contractNo = $('.user_account  #contractNo').val();
	var paymentDays = $('.user_account  #paymentDays').val();
	var emptyField = $('.user_account  #emptyField').val();
	
/*	var ctcSlabs1Min = $('#ctcSlabs1Min').val();
	var ctcSlabs1Max = $('#ctcSlabs1Max').val();
	var ctcSlabs2Min = $('#ctcSlabs2Min').val();
	var ctcSlabs2Max = $('#ctcSlabs2Max').val();
	var ctcSlabs3Min = $('#ctcSlabs3Min').val();
	var ctcSlabs3Max = $('#ctcSlabs3Max').val();
	var ctcSlabs4Min = $('#ctcSlabs4Min').val();
	var ctcSlabs4Max = $('#ctcSlabs4Max').val();
	var ctcSlabs5Min = $('#ctcSlabs5Min').val();*/

	var feePercent1 = $('#feePercent1').val();
	var feePercent2 = $('#feePercent2').val();
	var feePercent3 = $('#feePercent3').val();
	var feePercent4 = $('#feePercent4').val();
	var feePercent5 = $('#feePercent5').val();
	var slab1 = $('#slab1').val();
	var slab2 = $('#slab2').val();
	var slab3 = $('#slab3').val();
	var slab4 = $('#slab4').val();
	var slab5 = $('#slab5').val();
	

							if (feePercent1 == ""  ||(!$.isNumeric(feePercent1)) || 
//								feePercent2 == ""  ||
//								feePercent3 == ""  ||
//								feePercent4 == ""  ||
//								feePercent5 == ""  ||
								(feePercent2 != ""&&!$.isNumeric(feePercent2)) || 
								(feePercent3 != ""&&!$.isNumeric(feePercent3)) || 
								(feePercent4 != ""&&!$.isNumeric(feePercent4)) || 
								(feePercent5 != ""&&!$.isNumeric(feePercent5)) ||
								slab1 == ""  ||
//								slab2 == ""  ||
//								slab3 == ""  ||
//								slab4 == ""  ||
//								slab5 == ""  ||
							    paymentDays == ""  ||(!$.isNumeric(paymentDays)) ) {
		
			alertify.error("Please fill all fields correctly !!");
			return false;
	}else{
	
	return true;
}


}
function onBlueZero(){

	var feePercent1 = $('#feePercent1').val();
	var feePercent2 = $('#feePercent2').val();
	var feePercent3 = $('#feePercent3').val();
	var feePercent4 = $('#feePercent4').val();
	var feePercent5 = $('#feePercent5').val();
	if(feePercent1 == ""||!$.isNumeric(feePercent1)) {
		$('#feePercent1').val('0');
	} 
	if(feePercent2 == ""||!$.isNumeric(feePercent2)) {

		$('#feePercent2').val('0');
	} 
	if(feePercent3 == ""||!$.isNumeric(feePercent3)) {

		$('#feePercent3').val('0');
	} 
	if(feePercent4 == ""||!$.isNumeric(feePercent4)) {

		$('#feePercent4').val('0');
	} 
	if(feePercent5 == ""||!$.isNumeric(feePercent5)) {

		$('#feePercent5').val('0');
	}
	
}

function checkComplexity(password)
{
	var strongRegex = new RegExp("^(?=.{6,})(((?=.*[A-Z])(?=.*[a-z]))|((?=.*[A-Z])(?=.*[0-9]))|((?=.*[a-z])(?=.*[0-9]))).*$", "g");
	return strongRegex.test(password)
}
function validateLocationForm(){
	var location = $('#location').val();
	$.ajax({
		type : "GET",
		url : "adminCheckLocationDup",
		data : {'location':location},
		contentType : "application/json",
		success : function(data) {
			var obj = jQuery.parseJSON(data);
			if(obj.status)
			{
				alertify.success("Post verified successfully!");
				location.reload();
			}
			else
			{
				alertify.error("Oops, Something wrong !");
			}
		},
		error: function (xhr, ajaxOptions, thrownError) {
	        alert(xhr.status);
	      }
    }) ;	
	
	
	
	
}