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
	
	
	$(document.body).on('change', '#selected_post' ,function(){
//		alert("Hello to aLL" + $(this).val());
		$('#cons_list > li').removeClass("active");
//		alert(" text :"+$(this).find('option:selected').text());
		var pid = $(this).val();
		$('.selected_consultantname h2').html("Profiles for All Hiring Partners");
		if(pid != "0")
		{
			$('#selected_postname').html("Profiles for "+$(this).find('option:selected').text());
		}
		else
		{
			$('#selected_postname').html("Profiles for All Posts");
		}
		$.ajax({
			type : "GET",
			url : "postConsultantList",
			data : {'pid':pid},
			contentType : "application/json",
			success : function(data) {
//				alert(data);
				var obj = jQuery.parseJSON(data);
				var consList = obj.consList;
				$('#cons_list').html("");
				$.each(consList , function(i, val) { 
//				  alert(val.conid); 
				  $('#cons_list').append("<li id='"+val.conid+"'><a>"+val.cname+"</a></li>");
				  
				});
				loadclientposts('1');
//				$('#candidate_profiles').html(data);
			},
			error: function (xhr, ajaxOptions, thrownError) {
		        alert(xhr.status);
		      }
	    }) ;
		
	});
	
	$(document.body).on('click', '#cons_list > li' ,function(){
		$('#cons_list > li').removeClass("active");
		$(this).addClass("active");
		var conid = $(this).val();
		$('.selected_consultantname h2').html($(this).find("a").html());
		loadclientposts("1");
		
	});
	
	$(document.body).on('click', '.pre_check > .view_post' ,function(){
		var pid = $(this).attr("id");
//		alert("pid " + pid);
		$.ajax({
			type : "GET",
			url : "viewPostDetail",
			data : {'pid':pid},
			contentType : "application/json",
			success : function(data) {
//				alert(data);
				$('#positions_info').hide();
				$('#post_detail').html(data);
				$('#post_detail').show();
				
				
			},
			error: function (xhr, ajaxOptions, thrownError) {
		        alert(xhr.status);
		      }
	    }) ;
	});
	$(document.body).on('click', '.page_nav  .back_list_view' ,function(){
//		alert("back");
		$('#post_detail').html("");
		$('#post_detail').hide();
		$('#positions_info').show();
	});
	
	$(document.body).on('change', '.select_jd' ,function(){
		$(this).parent().siblings("input").val($(this).val());
		
	});
	
	
	
});


