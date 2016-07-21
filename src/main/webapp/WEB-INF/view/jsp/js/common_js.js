jQuery(document).ready(function() {
	
	
	$(document.body).on('click','.noti-icon',function(event){
	      
		if($('.user_noti_content').css('display')=='none')
		{
			$('.user_noti_content').css('display','block');
		}
		/*else 
		{
			$('.user_noti_content').css('display','none');
		}*/
		event.stopPropagation();
			
	});

	$('html').click(function(e) {  
		
		$('.user_noti_content').css('display','none');
		$(".help-desk .desk-content").removeClass("active");
		e.stopPropagation();
	});
	
	$(document.body).on('click','.user_noti_content',function(event){
		event.stopPropagation();
	});
			
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
	
	$(document.body).on('change', '.number_pasitive' ,function(){
		
		if($(this).val() < 0)
		{
			$(this).val('0'); 
		}
	});
	$(document.body).on('click', '.pre_check > .1view_post' ,function(){
		var pid = $(this).attr("id");
		if(pid != "")
		{
			$.ajax({
				type : "GET",
				url : "clientPostDetail",
				data : {'pid':pid},
				contentType : "application/json",
				success : function(data) {
					$('#positions_info').hide();
					$('#post_detail').html(data);
					$('#post_detail').show();
				},
				error: function (xhr, ajaxOptions, thrownError) {
				}
			}) ;
		}
	});
	

	$(document.body).on('click', '.page_nav  .back_list_view' ,function(){
		$('#post_detail').html("");
		$('#post_detail').hide();
		$('#positions_info').show();
	});
	
	
	$(document.body).on('click', '.applicant_msg .send_msg' ,function(){
		var msg_text = $('#msg_text').val();
		
		
		var ppid = $(this).attr("id");
		$('#msg_text').val('');
		if(msg_text != "")
		{
			$.ajax({
				type : "GET",
				url : "sendInboxMsg",
				data : {'ppid':ppid,'msg_text':msg_text},
				contentType : "application/json",
				success : function(data) {
					var obj = jQuery.parseJSON(data);
					if(obj.status)
					{
						$('.inbox_col').append(obj.msg_text);
						var objDiv = document.getElementById("inbox_msg");
						objDiv.scrollTop = objDiv.scrollHeight;
					}
					
				},
				error: function (xhr, ajaxOptions, thrownError) {
				}
			}) ;
		}
	});
	
});

function setFirstTimeFalse(regid){
	$.ajax({
		type : "GET",
		url : "setFirstTimeFalse",
		data : {'regid':regid},
		contentType : "application/json",
		success : function(data) {
			
			
		},
		error: function (xhr, ajaxOptions, thrownError) {
		}
	}) ;
}