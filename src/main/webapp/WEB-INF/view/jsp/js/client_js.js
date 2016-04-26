jQuery(document).ready(function() {
	
	

	/// MORE PRODUCT STARED HERE 
		
	
		$.ajax({
			type : "GET",
			url : "clientmessages",
			data : {},
			contentType : "application/json",
			success : function(data) {
				var obj = jQuery.parseJSON(data);
//				alert();
				$('.notification .noti_inner').html("");
				if(obj.mList.length > 0)
				{
					$('.notification .noti-icon').css("background-color","#F8B910");
					$.each(obj.mList , function(i, val) {
						
						$('.notification .noti_inner').append("<a href='clientapplicantinfo?ppid="+val.ppid+"'><div class='noti_row' title='"+val.message+"' postprofile='"+val.ppid+"'>" +
								"<span class='noti-cons'>"+val.cons+"</span> send a message on " +
								"<span class='post-title'>"+val.ptitle+"</span>.</div></a>");
						
					});
				}
				else
				{
					$('.notification .noti_inner').append("<p>No message available</p>");
				}
			},
			error: function (xhr, ajaxOptions, thrownError) {
		        alert(xhr.status);
		      }
	    }) ;
	
	
	
	$(".length_check").keydown(function (e) {
		alert($(this).val().length +"data-length : " + $(this).attr('data-length'));
		var val = $(this).val().length;
		var length = $(this).attr('data-length');
		if(val < length)
		{
			e.preventDefault();
		}
	});
	
	
	$(document.body).on('click', '.edit_post' ,function(){
		var pid = $(this).attr("pid");
		alertify.confirm("Are you sure to edit this post ?", function (e, str) {
			if (e) {
				
				window.location.href('clienteditpost?pid='+pid);
			}
		});
		
	});
	$(document.body).on('change', '#selected_post' ,function(){
//		alert("Hello to aLL" + $(this).val());
		
		$('#candidate_profiles').hide();
		$('#candidate_profiles_def').show();
		
		$('#cons_list > li').removeClass("active");
//		alert(" text :"+$(this).find('option:selected').text());
		var pid = $(this).val();
		if(pid != "" && pid != "0")
		{
			$('#view_jd .view_post').attr('href',"viewPostDetail?pid="+pid);
			$('#view_jd .view_post').attr('target',"_blank");
			$('#view_jd .view_post').removeClass('btn_disabled');
		}
		else
		{
			$('#view_jd .view_post').attr('href',"javascript:void(0)");
			$('#view_jd .view_post').attr('target',"");
			$('#view_jd .view_post').addClass('btn_disabled');
		}
		
		$('#view_jd .view_consultant').attr('href',"javascript:void(0)");
		$('#view_jd .view_consultant').attr('target',"");
		$('#view_jd .view_consultant').addClass('btn_disabled');

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
					if(val.submissionStatus!="")
				  $('#cons_list').append("<li title='"+val.aboutcons+"' id='"+val.conid+"'><a>"+val.cname+" <br><span style='font-size:10px;'>("+val.submissionStatus+")</span> </a></li>");
					else
						  $('#cons_list').append("<li title='"+val.aboutcons+"' id='"+val.conid+"'><a>"+val.cname+" </a></li>");
						
				});
//				loadclientposts('1');
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
			$('#view_jd .view_consultant').attr('href',"clientviewuser?uid="+$(this).attr("id"));
			$('#view_jd .view_consultant').attr('target',"_blank");
			$('#view_jd .view_consultant').removeClass('btn_disabled');
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
		var data_view = $(this).parent().attr("data-view");
		alertify.confirm("Are you sure to shortlist ?", function (e, str) {
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
						if(data_view !="table")
						{
							selected.html("<p>Status : Shortlisted - In Progress</p><button class='recruit_profile' title='Click to offer'>Offer</button><button class='btn-open' data-type='reject_recruit' title='Click to decline'>Decline</button>");
						}
						else
						{
							selected.parent().parent().find('td:eq(7)').html("<span>ShortListed</span>");
							selected.html("<button class='recruit_profile' title='Click to offer'>Offer</button><button class='btn-open' data-type='reject_recruit' title='Click to decline'>Decline</button>");
						}
						
						alertify.success("Profile shortlisted successfilly !");
						
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
	
	$(document.body).on('click', '#rejectModal .btn-ok' ,function(){
		
		$('#rejectModal').hide();
		var reject_type = $('.modal-body #reject_type').val();
		var reject_for = $('.modal-body #reject_for').val();
		
		var rej_reason = "";
		
		var ppstatus = "";
		if(reject_type == "reject_profile")
		{
			 ppstatus = "reject";
			 rej_reason = $('.sel_rej_profiel').val();
		}
		else if(reject_type == "reject_recruit")
		{
			 ppstatus = "reject_recruit";
			 rej_reason = $('.sel_rej_recruit').val();
		}
		else if(reject_type == "offer_reject")
		{
			 ppstatus = "offer_reject";
			 rej_reason = $('.sel_rej_offer').val();
		}
		
		
		var selected = $('.proile_row #'+reject_for);
//		alert(" Hello to all js " + selected.html());
		
//		return false;
//		var selected = $(this).parent();
//		var ppid = $(this).parent().attr("id");
		var data_view = selected.attr("data-view");
		
		$.ajax({
			type : "GET",
			url : "clientacceptreject",
			data : {'ppid':reject_for,'ppstatus':ppstatus,'rej_reason':rej_reason},
			contentType : "application/json",
			success : function(data) {
				var obj = jQuery.parseJSON(data);
				if(obj.status == "rejected")
				{
					
					if(data_view !="table")
					{
						location.reload();
//						selected.html("<p>Status : CV Rejected</p>");
					}
					else
					{
						selected.parent().parent().find('td:eq(7)').html("<span>CV Rejected</span>");
						selected.html("")
					}
					alertify.success("Profile rejected successfilly !");
					
				}
				else if(obj.status == "reject_recruit")
				{
					if(data_view !="table")
					{
						location.reload();
//						selected.html("<p>Status : Declined</p>");
					}
					else
					{
						selected.parent().parent().find('td:eq(7)').html("<span>Declined</span>");
						selected.html("");
					}
					alertify.success("Profile Declined Successfilly !");
					
				}
				else if(obj.status == "offer_reject")
				{
					if(data_view !="table")
					{
						location.reload();
//						selected.html("<p>Status : Offer Declined</p>");
					}
					else
					{
						selected.parent().parent().find('td:eq(7)').html("<span>Offer Declined</span>");
						selected.html("");
					}
					alertify.success("Profile Declined Successfilly !");
					
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
		
		
		
	});
	
	$(document.body).on('click', '.profile_status > .recruit_profile' ,function(){
//		alert("Hello to all accept"+$(this).parent().attr("id"));
		var selected = $(this).parent();
		var ppid = $(this).parent().attr("id");
		var data_view = $(this).parent().attr("data-view");
		alertify.confirm("Are you sure to recruit ?", function (e, str) {
		if (e) {
			
			$.ajax({
				type : "GET",
				url : "clientacceptreject",
				data : {'ppid':ppid,'ppstatus':'recruit'},
				contentType : "application/json",
				success : function(data) {
					var obj = jQuery.parseJSON(data);
					if(obj.status == "recruited")
					{
						
						if(data_view !="table")
						{
							selected.html("<p>Status : Offer </p><button class='offer_accept' title='Click to accept offer'>Offer</button><button class='btn-open' data-type='offer_reject' title='Click to reject offer'>Reject</button>");
						}
						else
						{
							selected.parent().parent().find('td:eq(7)').html("<span>Offer</span>");
							selected.html("<button class='btn-offer-open' data-type='offer_accept' title='Click to accept offer' onclick='$('#postIdForAccept').val('"+ppid+"')' >Offer Accept</button><button class='btn-open' data-type='offer_reject' title='Click to reject offer'>Reject</button>");
						}
						alertify.success("Profile send offered successfilly !");
						
						
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
	
	$(document.body).on('click', '.btn-offer-open' ,function()
	{
//		alert($(this).parent().attr("id"));
		$('#postIdForAccept').val($(this).parent().attr("id"));
	});
	
	$(document.body).on('click', '.profile_status > .reject_recruit' ,function(){
		var selected = $(this).parent();
		var ppid = $(this).parent().attr("id");
		var data_view = $(this).parent().attr("data-view");
		alertify.confirm("Are you sure to reject ?", function (e, str) {
		if (e) {
			
			$.ajax({
				type : "GET",
				url : "clientacceptreject",
				data : {'ppid':ppid,'ppstatus':'reject_recruit'},
				contentType : "application/json",
				success : function(data) {
					var obj = jQuery.parseJSON(data);
					if(obj.status == "reject_recruit")
					{
						if(data_view !="table")
						{
						}
						else
						{
							selected.parent().parent().find('td:eq(7)').html("<span>Declined</span>");
							selected.html("")
						}
//						selected.html("<h3>Declined</h3>")
						alertify.success("Profile Declined Successfilly !");
						
						/*$.ajax({
							type : "GET",
							url : "clientMailRejectRecruit",
							data : {'ppid':ppid},
							contentType : "application/json",
							success : function(data) {
								var obj = jQuery.parseJSON(data);
								if(!obj.status)
								{
									alertify.error("Oops, mail not send !");
								}
								
							},
							error: function (xhr, ajaxOptions, thrownError) {
								alertify.error("Oops, mail not send !");
							}
						}) ;*/
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
	
	$(document.body).on('click', '#offerModal .btn-ok' ,function(){
//		alert("Hello to all accept"+$(this).parent().attr("id"));
		var ppid =$('#postIdForAccept').val();
		var totalCTC=0.0;
		var billableCTC=0.0;
		var joiningDate="";
		var flag=true;
			try{
				totalCTC=$('#totalCTC').val();
				if(totalCTC==""||(!$.isNumeric(totalCTC)))
					{
					flag=false;
					$('#errorTotalCTC').html('Please enter valid value');
					$('#errorTotalCTC').css('display','block');
					}else{
						$('#errorTotalCTC').css('display','none');
					}
			}catch(e){
				flag=false;
				$('#errorTotalCTC').html('Please enter valid value');
			}
			try{
				billableCTC=$('#billableCTC').val();
				if(billableCTC==""||(!$.isNumeric(billableCTC)))
				{
					flag=false;
				$('#errorBillableCTC').html('Please enter valid value');
				$('#errorBillableCTC').css('display','block');
				}else{
					$('#errorBillableCTC').css('display','none');
				}
			}catch(e){
				flag=false;
				$('#errorBillableCTC').html('Please enter valid value');
			}
			try{
				joiningDate=$('#joiningDate').val();
				/*if(joiningDate=="")
				{
					flag=false;
				$('#errorJoiningDate').html('Please enter valid value');
				$('#errorJoiningDate').css('display','block');
				}else{
					$('#errorJoiningDate').css('display','none');
				}*/
			}catch(e){
				/*flag=false;
				$('#errorJoiningDate').html('Please enter valid date');*/
			}
		if(flag){

			$('#offerModal').hide();
		var data_view = $(this).parent().attr("data-view");
		alertify.confirm("Are you sure to send offer ?", function (e, str) {
		if (e) {
			
			$.ajax({
				type : "GET",
				url : "clientacceptreject",
				data : {'ppid':ppid,'ppstatus':'offer_accept','totalCTC':totalCTC,'billableCTC':billableCTC,'joiningDate':joiningDate},
				contentType : "application/json",
				success : function(data) {
					var obj = jQuery.parseJSON(data);
					if(obj.status == "offer_accept")
					{
						if(data_view != "table")
						{
							location.href="";
							//selected.parent().html("<div class='block btn_row no-margin' style='text-align: left;'><a class='btn check_btn'>Offered</a></div>")
						}
						else
						{
							selected.parent().parent().find('td:eq(7)').html("<span>Offered</span>");
							selected.html("")
						}
						alertify.success("Profile Offered Successfilly !");
						
						/*$.ajax({
							type : "GET",
							url : "clientMailRecruitProfile",
							data : {'ppid':ppid},
							contentType : "application/json",
							success : function(data) {
								var obj = jQuery.parseJSON(data);
								if(!obj.status)
								{
									alertify.error("Oops, mail not send !");
								}
								
							},
							error: function (xhr, ajaxOptions, thrownError) {
								alertify.error("Oops, mail not send !");
							}
						}) ;*/
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
		}
	});
	$(document.body).on('click', '.profile_status > .offer_reject' ,function(){
//		alert("Hello to all accept"+$(this).parent().attr("id"));
		var selected = $(this).parent();
		var ppid = $(this).parent().attr("id");
		var data_view = $(this).parent().attr("data-view");
		alertify.confirm("Are you sure to reject offer ?", function (e, str) {
		if (e) {
			
			$.ajax({
				type : "GET",
				url : "clientacceptreject",
				data : {'ppid':ppid,'ppstatus':'offer_reject'},
				contentType : "application/json",
				success : function(data) {
					var obj = jQuery.parseJSON(data);
					if(obj.status == "offer_reject")
					{
						if(data_view != "table")
						{
							selected.parent().html("<div class='block btn_row no-margin' style='text-align: left;'><a class='btn check_btn'>Offer Declined</a></div>")
						}
						else
						{
							selected.html("<h3>Offer Declined</h3>")
						}
						alertify.success("Profile Offer Decline Successfilly !");
						
						
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
			 alertify.error("Oops, please select any post !");
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
								alertify.success("Hi, post activate successfully !");
								
								$.ajax({
									type : "GET",
									url : "clientMailActive",
									data : {'pids':val.toString()},
									contentType : "application/json",
									success : function(data) {
										var obj = jQuery.parseJSON(data);
										if(!obj.status)
										{
											alertify.error("Oops, mail not send !");
										}
										
									},
									error: function (xhr, ajaxOptions, thrownError) {
										alertify.error("Oops, mail not send !");
									}
								}) ;
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

		var val = [];
		 $('.sel_posts:checkbox:checked').each(function(i){
	        val[i] = $(this).val();
	     
		 });
		 if(! val.length > 0)
		 {
			 alertify.error("Oops, please select any post !");
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
							alertify.success("Hi, post inactivate successfully !");
							loadclientdashboardposts($('.page_nav .current_page').attr("id"));
							
							$.ajax({
								type : "GET",
								url : "clientMailInactive",
								data : {'pids':val.toString()},
								contentType : "application/json",
								success : function(data) {
									var obj = jQuery.parseJSON(data);
									if(!obj.status)
									{
										alertify.error("Oops, mail not send !");
									}
									
								},
								error: function (xhr, ajaxOptions, thrownError) {
									alertify.error("Oops, mail not send !");
								}
							}) ;
						}
						
					},
					error: function (xhr, ajaxOptions, thrownError) {
						alert(xhr.status);
					}
				}) ;
			}
		 
		});
	});
	
	$(document.body).on('click', '.filter  #del_post' ,function(){
//		alert("set Inactive");
		
		var val = [];
		 $('.sel_posts:checkbox:checked').each(function(i){
	        val[i] = $(this).val();
	     
		 });
		 if(! val.length > 0)
		 {
			 alertify.error("Oops, please select any post !");
			 return false;
		 }
		 
		alertify.confirm("Are you sure to delete this post ?", function (e, str) {
			if (e) 
			{
				$.ajax({
					type : "GET",
					url : "clientBulkDelete",
					data : {'pids':val.toString()},
					contentType : "application/json",
					success : function(data) {
						var obj = jQuery.parseJSON(data);
						if(obj.status == "success")
						{
							alertify.success("Hi, posts deleted successfully !");
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
	
	
	$(document.body).on('click', '.page_nav  .post_inactivate' ,function(){
		var val = [];
		var pid = $(this).attr("id");
		val[0]=pid;
		alertify.confirm("Are you sure to inacivate this post ?", function (e, str) {
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
							alertify.success("Hi, posts inactivate successfully !");
							$.ajax({
								type : "GET",
								url : "clientMailInactive",
								data : {'pids':val.toString()},
								contentType : "application/json",
								success : function(data) {
									var obj = jQuery.parseJSON(data);
									if(!obj.status)
									{
										alertify.error("Oops, mail not send !");
									}
									
								},
								error: function (xhr, ajaxOptions, thrownError) {
									alertify.error("Oops, mail not send !");
								}
							}) ;
							location.reload();
						}
						
					},
					error: function (xhr, ajaxOptions, thrownError) {
						alert(xhr.status);
					}
				}) ;
			}
		 
		});
	});
	
	
	$(document.body).on('click', '.page_nav  .post_activate' ,function(){
		var val = [];
		var pid = $(this).attr("id");
		val[0]=pid;
		alertify.confirm("Are you sure to acivate this post ?", function (e, str) {
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
							alertify.success("Hi, posts activated successfully !");
							$.ajax({
								type : "GET",
								url : "clientMailActive",
								data : {'pids':val.toString()},
								contentType : "application/json",
								success : function(data) {
									var obj = jQuery.parseJSON(data);
									if(!obj.status)
									{
										alertify.error("Oops, mail not send !");
									}
									
								},
								error: function (xhr, ajaxOptions, thrownError) {
									alertify.error("Oops, mail not send !");
								}
							}) ;
							location.reload();
						}
						
					},
					error: function (xhr, ajaxOptions, thrownError) {
						alert(xhr.status);
					}
				}) ;
			}
		 
		});
	});
	
	$(document.body).on('click', '.page_nav  .post_close' ,function(){
		var val = [];
		var pid = $(this).attr("id");
		val[0]=pid;
		alertify.confirm("Are you sure to close this post ?", function (e, str) {
			if (e) 
			{
				$.ajax({
					type : "GET",
					url : "clientBulkClose",
					data : {'pids':val.toString()},
					contentType : "application/json",
					success : function(data) {
						var obj = jQuery.parseJSON(data);
						if(obj.status == "success")
						{
							alertify.success("Hi, posts closed successfully !");
							$.ajax({
								type : "GET",
								url : "clientMailClose",
								data : {'pids':val.toString()},
								contentType : "application/json",
								success : function(data) 
								{
									var obj = jQuery.parseJSON(data);
									if(!obj.status)
									{
										alertify.error("Oops, mail not send !");
									}
									
								},
								error: function (xhr, ajaxOptions, thrownError) {
									alertify.error("Oops, mail not send !");
								}
							}) ;
							
						}
						
					},
					error: function (xhr, ajaxOptions, thrownError) {
						alert(xhr.status);
					}
				}) ;
			}
		 
		});
	});
	
	$(document.body).on('click', '.page_nav  .post_delete' ,function(){
		var val = [];
		var pid = $(this).attr("id");
		val[0]=pid;
		alertify.confirm("Are you sure to delete this post ?", function (e, str) {
			if (e) 
			{
				$.ajax({
					type : "GET",
					url : "clientBulkDelete",
					data : {'pids':val.toString()},
					contentType : "application/json",
					success : function(data) {
						var obj = jQuery.parseJSON(data);
						if(obj.status == "success")
						{
							alertify.success("Hi, posts delete successfully !");
							location.reload();
						}
						
					},
					error: function (xhr, ajaxOptions, thrownError) {
						alert(xhr.status);
					}
				}) ;
			}
		 
		});
	});
	
	
	
	
	
	$(document.body).on('click', '.filter  #close_post' ,function(){
//		alert("set Inactive");
		
		var val = [];
		 $('.sel_posts:checkbox:checked').each(function(i){
	        val[i] = $(this).val();
	     
		 });
		 if(! val.length > 0)
		 {
			 alertify.error("Oops, please select any post !");
			 return false;
		 }
		 
		alertify.confirm("Are you sure to close this post ?", function (e, str) {
			if (e) 
			{
				$.ajax({
					type : "GET",
					url : "clientBulkClose",
					data : {'pids':val.toString()},
					contentType : "application/json",
					success : function(data) {
						var obj = jQuery.parseJSON(data);
//						alert(data);
						if(obj.status == "success")
						{
							alertify.success("Hi, posts close request send successfully !");
							loadclientdashboardposts($('.page_nav .current_page').attr("id"));
						}
						else
						{
							alertify.success("Oops, something wrong !");
						}
						
					},
					error: function (xhr, ajaxOptions, thrownError) {
						alert(xhr.status);
					}
				}) ;
			}
		 
		});
	});
	
	
	
	$(document.body).on('change', '.act_status #sel_act_inact' ,function(){
		var pids = [];
		var pid = $(this).parent().parent().attr("id");
		pids[0]= pid; 
		var sel_val = $(this).val();
//		alert(pid + " : Hello to alll changes : "+ $(this).val());
		var url = "";
		var msg = "";
		var mailurl = "";
		if(sel_val == "Active")
		{
			url = "clientBulkActive";
			msg = "Are you sure to active this post ?";
			mailurl="clientMailActive";
		}
		else
		{
			url = "clientBulkInactive";
			msg = "Are you sure to inactive this post ?";
			mailurl="clientMailInactive";
		}
		
		alertify.confirm(msg, function (e, str) {
			if (e) 
			{
				$.ajax({
					type : "GET",
					url : url,
					data : {'pids':pids.toString()},
					contentType : "application/json",
					success : function(data) {
//						alert(data);
						var obj = jQuery.parseJSON(data);
						if(obj.status == "success")
						{
							alertify.success("Hi, Post "+sel_val+"  successfully !");
							$.ajax({
								type : "GET",
								url : mailurl,
								data : {'pids':pids.toString()},
								contentType : "application/json",
								success : function(data) {
									var obj = jQuery.parseJSON(data);
									if(!obj.status)
									{
										alertify.error("Oops, mail not send !");
									}
									
								},
								error: function (xhr, ajaxOptions, thrownError) {
									alertify.error("Oops, mail not send !");
								}
							}) ;
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


