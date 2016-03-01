jQuery(document).ready(function() {
	
	
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
	
	$(document.body).on('change', '#db_post_status ' ,function(){
		loadclientdashboardposts("1");
	});
	
	
	
	
	$(document.body).on('click', '.pre_check > .view_post' ,function(){
//		alert("pid ");
		var pid = $(this).attr("id");
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
	
	
	$(document.body).on('click', '.profile_status > .accept_profile' ,function(){
//		alert("Hello to all accept"+$(this).parent().attr("id"));
		var selected = $(this).parent();
		var ppid = $(this).parent().attr("id");
		var r = confirm("Are you sure to accept ?");
		if(r)
		{
			$.ajax({
				type : "GET",
				url : "clientacceptreject",
				data : {'ppid':ppid,'ppstatus':'accept'},
				contentType : "application/json",
				success : function(data) {
					var obj = jQuery.parseJSON(data);
					if(obj.status == "accepted")
					{
						selected.html("<h3>Accepted</h3>")
					}
					else
					{
						alert("Oops something wrong !");
					}
				},
				error: function (xhr, ajaxOptions, thrownError) {
					alert(xhr.status);
				}
			}) ;
		}
	});
	
	$(document.body).on('click', '.profile_status > .reject_profile' ,function(){
		var selected = $(this).parent();
		var ppid = $(this).parent().attr("id");
		var r = confirm("Are you sure to reject ?");
		if(r)
		{
			$.ajax({
				type : "GET",
				url : "clientacceptreject",
				data : {'ppid':ppid,'ppstatus':'reject'},
				contentType : "application/json",
				success : function(data) {
					var obj = jQuery.parseJSON(data);
					if(obj.status == "rejected")
					{
						selected.html("<h3>Rejected</h3>")
					}
					else
					{
						alert("Oops something wrong !");
					}
				},
				error: function (xhr, ajaxOptions, thrownError) {
					alert(xhr.status);
				}
			}) ;
		}
	});
	
	
	
	
});


