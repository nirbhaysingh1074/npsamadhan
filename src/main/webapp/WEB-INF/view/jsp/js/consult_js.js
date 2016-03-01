jQuery(document).ready(function() {
	
	$(".number_only").keydown(function (e) {
        // Allow: backspace, delete, tab, escape, enter and .
        if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 110, 190]) !== -1 ||
             // Allow: Ctrl+A, Command+A
            (e.keyCode == 65 && ( e.ctrlKey === true || e.metaKey === true ) ) || 
             // Allow: home, end, left, right, down, up
            (e.keyCode >= 35 && e.keyCode <= 40)) {
                 // let it happen, don't do anything
                 return;
        }
        // Ensure that it is a number and stop the keypress
        if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
            e.preventDefault();
        }
    });
	
	$(".length_check").keydown(function (e) {
		alert($(this).val().length +"data-length : " + $(this).attr('data-length'));
		var val = $(this).val().length;
		var length = $(this).attr('data-length');
		if(val < length)
		{
			e.preventDefault();
		}
	});
	
	
	$(document.body).on('change', '.select_jd' ,function(){
		$(this).parent().siblings("input").val($(this).val());
		
	});
	
	$(document.body).on('click', '.pre_check > .post_interest' ,function(){
//		alert("Hello to all" + $(this).attr("id"));
		var row = $(this);
		
		var pid = $(this).attr("id");
		
		var r = confirm("Are you interested for this post ?");
		if(r)
		{
			$.ajax({
				type : "GET",
				url : "consPostInterest",
				data : {'pid':pid},
				contentType : "application/json",
				success : function(data) {
					if(data == "success")
					{
//					alert(data);
						row.removeClass("post_interest");
						row.html("<img src='images/view-icon.png' alt='interested'>");
					}
					
				},
				error: function (xhr, ajaxOptions, thrownError) {
					alert(xhr.responseText);
				}
			}) ;
			
		}
		
		
	});
	
	$(document.body).on('click', '#postsList > li' ,function(){
//		alert("hello to all"+ $(this).attr("id"));
		$("#postsList > .active").removeClass("active");
		$(this).addClass("active");
		
		var clientId = $('#selectionOfClient').val();
		if(clientId == "")
		{
			alert("Select Client first !");
			return false;
		}
		
		fillProfiles("1") ;
	});
	
	$(document.body).on('change', '#cons_db_post_status' ,function(){
		loadconsdashboardposts("1");
	});
	
});


