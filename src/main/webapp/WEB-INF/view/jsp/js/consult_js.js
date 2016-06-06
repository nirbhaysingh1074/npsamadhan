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
	
	
	$(document.body).on('change', '.select_jd' ,function(){
		$(this).parent().siblings("input").val($(this).val());
		
	});
	
	$(document.body).on('click', '#offerjoinedpopup' ,function(){

		var ppid =$('#postIdForAccept').val();
		var joiningDate=$('#datepicker').val();
		//var selected = $(this).parent();
		//var ppid = $(this).parent().attr("id");
	//	var data_view = $(this).parent().attr("data-view");
//		return false;
		/*alertify.confirm("Are you sure you want to join ?", function (e, str) {
		if (e) {*/
			
//			alert("offer_accept");
		pleaseWait();
			$.ajax({
				type : "GET",
				url : "consacceptoffer",
				data : {'ppid':ppid,'ppstatus':'join_accept','joiningDate':joiningDate},
				contentType : "application/json",
				success : function(data) {
					var obj = jQuery.parseJSON(data);
					
			/*		if(obj.status == "join_accept")
					{
						if(data_view != "table")
						{
							selected.parent().html("<div class='block btn_row no-margin' style='text-align: left;'><a class='btn check_btn'>Joined</a></div>")
						}
						else
						{
							selected.parent().parent().find('td:eq(7)').html("<span>Joined</span>");
							selected.html("");
						}*/
					//	alertify.success("Profile Joined Successfilly !");
					location.href="";	
					/*}
					else
					{
						alertify.error("Oops something wrong !");
					}*/
				pleaseDontWait();
				},
				error: function (xhr, ajaxOptions, thrownError) {
					alert(xhr.status);
					pleaseDontWait();
				}
			});
		/*}
		});*/
	});
	
	$(document.body).on('click', '#rejectModal .btn-ok' ,function(){

		$('#rejectModal').hide();
		var reject_type = $('.modal-body #reject_type').val();
		var reject_for = $('.modal-body #reject_for').val();
		
		var rej_reason = "";
		
		var ppstatus = "";
		if(reject_type == "join_reject")
		{
			 ppstatus = "join_reject";
			 rej_reason = $('.sel_rej_join').val();
		}
		
		var selected = $('.cons_proile_row #'+reject_for);
//		alert("selected : " + selected.html());
//		return false;
		
		var data_view = selected.attr("data-view");
//			alert("offer_accept");
		pleaseWait();
			$.ajax({
				type : "GET",
				url : "consacceptoffer",
				data : {'ppid':reject_for,'ppstatus':ppstatus,'rej_reason':rej_reason},
				contentType : "application/json",
				success : function(data) {
					var obj = jQuery.parseJSON(data);
					if(obj.status == "join_reject")
					{
						if(data_view != "table")
						{
							location.reload();
//							selected.parent().html("<div class='block btn_row no-margin' style='text-align: left;'><a class='btn check_btn'>Offer Droped</a></div>")
						}
						else
						{
							location.reload();
							selected.parent().parent().find('td:eq(7)').html("<span>Offer Droped</span>");
							selected.html("")
						}
					//	alertify.success("Profile join droped Successfilly !");
						
						
					}
					else
					{
						alertify.error("Oops something wrong !");
					}
					pleaseDontWait();
				},
				error: function (xhr, ajaxOptions, thrownError) {
					alert(xhr.status);
					pleaseDontWait();
				}
			}) ;
		
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
						row.prop('title','You have added this post to activ postions.');
				//		alertify.success("Add interest for post "+obj.jobCode);
						location.href="";
					}
					
				},
				error: function (xhr, ajaxOptions, thrownError) {
					alert(xhr.responseText);
				}
			}) ;
			
		}
		
		});
		
		
	});
	

	$(document.body).on('click', '.filter  #show_interest' ,function(){
//		alert("set Active");
		
		var val = [];
		 $('.sel_newposts:checkbox:checked').each(function(i){
	        val[i] = $(this).val();
	      });
	 
		 if(! val.length > 0)
		 {
			 alertify.error("Oops, please select any post !");
			 return false;
		 }

		 	alertify.confirm("By adding these positions to your active list, you agree to terms of condientiality of the client", function (e, str) {
				if (e) 
				{
					$.ajax({
						type : "GET",
						url : "consBulkInterest",
						data : {'pids':val.toString()},
						contentType : "application/json",
						success : function(data) {
							var obj = jQuery.parseJSON(data);
							if(obj.status == "success")
							{

					//		alertify.success("Hi, Submitted Interest Successfully !");
							location.href="";
							}
						},
						error: function (xhr, ajaxOptions, thrownError) {
					        alert(xhr.status);
					      }
				    }) ;
				}
		 	});
	});
	

	
	$(document.body).on('click', '.filter  #close_request' ,function(){
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
					url : "consBulkClose",
					data : {'pids':val.toString()},
					contentType : "application/json",
					success : function(data) {
						var obj = jQuery.parseJSON(data);
//						alert(data);
						if(obj.status == "success")
						{
				//			alertify.success("Hi, posts close request send successfully !");
							
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
		$('.view_id .view_post').attr('href',"consviewjd?pid="+pid);
		$('.view_id .view_post').attr('target','_blank');
		$('.upload_new_profile').removeClass('btn_disabled');
		
		//fillProfiles("1") ;
	});
	
	$(document.body).on('change', '#cons_db_sel_client , #cons_db_sel_loc' ,function(){
		loadconsdashboardposts("1");
	});
	
	$(document.body).on('change', '#cons_db_post_status' ,function(){
		loadconsdashboardposts("1");
	});
	
	
	$(document.body).on('change', '#selectionOfClient' ,function(){
		$('#postsList > li').removeClass('active');
		$('.view_id .view_post').addClass('btn_disabled');
		$('.view_id .view_post').attr('href','javascript:void(0)');
		$('.view_id .view_post').removeAttr('target');
		$('.upload_new_profile').addClass('btn_disabled');
		fillPosts(this.value);
	});
	

	$(document.body).on('click', '.upload_new_profile' ,function(){
		var clientId = $('#selectionOfClient').val();
		var postId = $("#postsList > .active").attr("id");
		
//	 	alert("clientId:"+clientId);
		
		if( clientId != "" && clientId != "undefined" && postId != "" && postId != undefined)
		{
			window.open("uploadprofile?pid="+postId, '_blank');
			
		}
		
		
	});
	
});


function fillPosts(clientId) 
{
//		alert("sdd;"+clientId);
	
	$('.candidate_profiles_def').show();
	$('.candidate_profiles_for_cons').html("");
	if(clientId != "")
	{
		$.ajax({
			type : "GET",
			url : "cons_leftside_postlist",
			data : {
				'clientId' : clientId
			},
			contentType : "application/json",
			success : function(data) {
				$('#cons_leftside_postlist').html(data);
				
			},
			error : function(xhr, ajaxOptions, thrownError) {
				alert(xhr.status);
			}
		});
	
	}
	else
	{
		$('#postsList').html("");
		
	}
	
}

function consCloseRequest(pids){
	

	alertify.confirm("Are you sure to close this post ?", function (e, str) {
		if (e) 
		{
			$.ajax({
				type : "GET",
				url : "consBulkClose",
				data : {'pids':pids},
				contentType : "application/json",
				success : function(data) {
					var obj = jQuery.parseJSON(data);
//					alert(data);
					if(obj.status == "success")
					{
						alertify.success("Hi, posts close request send successfully !");
						
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
	
}
function consShowInterest(pids){

 	alertify.confirm("Are you want to add  this post to your active postions?", function (e, str) {
		if (e) 
		{
			$.ajax({
				type : "GET",
				url : "consBulkInterest",
				data : {'pids':pids},
				contentType : "application/json",
				success : function(data) {
					var obj = jQuery.parseJSON(data);
					if(obj.status == "success")
					{

							alertify.success("Hi, Submitted Interest Successfully !");
					location.href="";
					}
				},
				error: function (xhr, ajaxOptions, thrownError) {
			        alert(xhr.status);
			      }
		    }) ;
		}
 	});
}