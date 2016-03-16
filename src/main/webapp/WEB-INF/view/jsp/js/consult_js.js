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
		
		alertify.confirm("Are you interested for this post ?", function (e, str) {
		if (e) {
		
			$.ajax({
				type : "GET",
				url : "consPostInterest",
				data : {'pid':pid},
				contentType : "application/json",
				success : function(data) {
					var obj = jQuery.parseJSON(data);
					if(obj.status == "success")
					{
						row.removeClass("post_interest");
						row.html("<img src='images/int-icon.png' alt='interested'>");
						row.prop('title','You show interest for this post');
						alertify.success("Add interest for post "+obj.jobCode);
					}
					
				},
				error: function (xhr, ajaxOptions, thrownError) {
					alert(xhr.responseText);
				}
			}) ;
			
		}
		
		});
		
		
	});
	
	$(document.body).on('click', '#postsList > li' ,function(){
		var pid=$(this).attr("id");
		$("#postsList > .active").removeClass("active");
		$(this).addClass("active");
		
		var clientId = $('#selectionOfClient').val();
		if(clientId == "")
		{
			alertify.error("Select Client first !");
			return false;
		}
		
		$('.view_id .view_post').removeClass('btn_disabled');
		$('.view_id .view_post').attr('id',pid);
		$('.upload_new_profile').removeClass('btn_disabled');
		
		fillProfiles("1") ;
	});
	
	$(document.body).on('change', '#cons_db_post_status' ,function(){
		$('#cons_db_sel_client').val("");
		loadconsdashboardposts("1");
	});
	
	$(document.body).on('change', '#cons_db_sel_client' ,function(){
		loadconsdashboardposts("1");
	});
	
	$(document.body).on('change', '#selectionOfClient' ,function(){
		$('#postsList > li').removeClass('active');
		$('.view_id .view_post').addClass('btn_disabled');
		$('.view_id .view_post').attr('id','');
		
		$('.upload_new_profile').addClass('btn_disabled');
		fillPosts(this.value);
	});
	
	
	
});


