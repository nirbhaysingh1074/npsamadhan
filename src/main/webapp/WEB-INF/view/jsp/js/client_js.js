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
//		if(pid == "" || pid == "0")
//		{
//			$('#cons_list').html("");
//			return false;
//		}
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
		var selected_post = $('#selected_post').val();
		if(selected_post != "" && selected_post != "0")
		{
			$(this).addClass("active");
			loadclientposts("1");
		}
		else
		{
			alertify.error("Select post first !");
		}
	});
	
	$(document.body).on('change', '#db_post_status ' ,function(){
		loadclientdashboardposts("1");
	});
	
	
	
	
	
	$(document.body).on('change', '.select_jd' ,function(){
		$(this).parent().siblings("input").val($(this).val());
		
	});
	
	
	$(document.body).on('click', '.profile_status > .accept_profile' ,function(){
//		alert("Hello to all accept"+$(this).parent().attr("id"));
		var selected = $(this).parent();
		var ppid = $(this).parent().attr("id");
		
		alertify.confirm("Are you sure to accept ?", function (e, str) {
		if (e) {
			
			$.ajax({
				type : "GET",
				url : "clientacceptreject",
				data : {'ppid':ppid,'ppstatus':'accept'},
				contentType : "application/json",
				success : function(data) {
					var obj = jQuery.parseJSON(data);
					if(obj.status == "accepted")
					{
						selected.html("<h3><img src='images/ic_17.png' alt='' width='20px' align='top'> Accepted</h3>")
						alertify.success("Profile accepted successfilly !");
					}
					else
					{
						alertify.error("Oops something wrong !");
					}
				},
				error: function (xhr, ajaxOptions, thrownError) {
					alert(xhr.status);
				}
			}) ;
		
		}
		});
	});
	
	$(document.body).on('click', '.profile_status > .reject_profile' ,function(){
		var selected = $(this).parent();
		var ppid = $(this).parent().attr("id");
		
		alertify.confirm("Are you sure to reject ?", function (e, str) {
		if (e) {
			
			$.ajax({
				type : "GET",
				url : "clientacceptreject",
				data : {'ppid':ppid,'ppstatus':'reject'},
				contentType : "application/json",
				success : function(data) {
					var obj = jQuery.parseJSON(data);
					if(obj.status == "rejected")
					{
						selected.html("<h3><img src='images/ic_16.png' alt='' width='20px' align='top'> Rejected</h3>")
						alertify.success("Profile rejected successfilly !");
					}
					else
					{
						alertify.error("Oops something wrong !");
					}
				},
				error: function (xhr, ajaxOptions, thrownError) {
					alert(xhr.status);
				}
			}) ;
		
		}
		});
		
	});
	
	
	$(document.body).on('click', '.status > .st_published' ,function(){
		var sel_img = $(this);
		var pid = $(this).parent().parent().attr("id");
		alertify.confirm("Are you sure to unpublish ?", function (e, str) {
		if (e) {
			
			$.ajax({
				type : "GET",
				url : "clientunpublishpost",
				data : {'pid':pid},
				contentType : "application/json",
				success : function(data) {
					var obj = jQuery.parseJSON(data);
					if(obj.status == "success")
					{
						sel_img.removeClass("st_published");
						sel_img.addClass("st_unpublished");
						sel_img.attr("src","images/cloud-gray.png");
						alertify.success("Post unpublished successfilly !");
					}
					else
					{
						alertify.error("Oops something wrong !");
					}
				},
				error: function (xhr, ajaxOptions, thrownError) {
					alert(xhr.status);
				}
			}) ;
			
		}
		});
	});
	
	
	$(document.body).on('click', '.status > .st_unpublished' ,function(){
		var sel_img = $(this);
		var pid = $(this).parent().parent().attr("id");
		alertify.confirm("Are you sure to publish ?", function (e, str) {
		if (e) {
			
			$.ajax({
				type : "GET",
				url : "clientpublishpost",
				data : {'pid':pid},
				contentType : "application/json",
				success : function(data) {
					var obj = jQuery.parseJSON(data);
					if(obj.status == "success")
					{
						sel_img.attr("src","images/check-cloud.png");
						sel_img.removeClass("st_unpublished");
//						sel_img.addClass("st_published");
						alertify.success("Hi, You posted "+obj.jobCode+" successfully !");
					}
					else
					{
						alertify.error("Oops something wrong !");
					}
				},
				error: function (xhr, ajaxOptions, thrownError) {
					alert(xhr.status);
				}
			}) ;
			
		}
		});
	});
	
	
	$(document.body).on('click', '.filter  #act_post' ,function(){
//		alert("set Active");
		
		var val = [];
		 $('.sel_posts:checkbox:checked').each(function(i){
	        val[i] = $(this).val();
	      });
	 
		 if(! val.length > 0)
		 {
		 
//			 alert("length ;"+ val.length);
			 return false;
		 }

		 	alertify.confirm("Are you sure to active this post ?", function (e, str) {
				if (e) 
				{
					$.ajax({
						type : "GET",
						url : "clientBulkActive",
						data : {'pids':val.toString()},
						contentType : "application/json",
						success : function(data) {
							var obj = jQuery.parseJSON(data);
							if(obj.status == "success")
							{
								loadclientdashboardposts($('.page_nav .current_page').attr("id"));
							}
						},
						error: function (xhr, ajaxOptions, thrownError) {
					        alert(xhr.status);
					      }
				    }) ;
				}
		 	});
	});
	
	
	$(document.body).on('click', '.filter  #inact_post' ,function(){
//		alert("set Inactive");
		
		var val = [];
		 $('.sel_posts:checkbox:checked').each(function(i){
	        val[i] = $(this).val();
	     
		 });
		 if(! val.length > 0)
		 {
		 
//			 alert("length ;"+ val.length);
			 return false;
		 }
		 
		alertify.confirm("Are you sure to inactive this post ?", function (e, str) {
			if (e) 
			{
				$.ajax({
					type : "GET",
					url : "clientBulkInactive",
					data : {'pids':val.toString()},
					contentType : "application/json",
					success : function(data) {
						var obj = jQuery.parseJSON(data);
						if(obj.status == "success")
						{
							loadclientdashboardposts($('.page_nav .current_page').attr("id"));
						}
						
					},
					error: function (xhr, ajaxOptions, thrownError) {
						alert(xhr.status);
					}
				}) ;
			}
		 
		});
	});
});


