var COOKIE_CSRF_NAME = "CSRF-TOKEN";
(function($){
	$(document).ajaxSend(function(event, jqxhr, settings) {
		App.blockUI({
            animate: true,
            overlayColor: 'none'
        });
		settings.header={"X-CSRF-TOKEN": albedo.getCookie(COOKIE_CSRF_NAME)};
		jqxhr.setRequestHeader("X-CSRF-TOKEN", albedo.getCookie(COOKIE_CSRF_NAME));
		
		
		
	});
	$(document).ajaxComplete(function(event, xhr, settings) {
		App.unblockUI();
	});
	$(document).ajaxError(function(event, xhr, settings) {
		App.unblockUI();
		toastr && toastr.error('网络异常，请检查您的网络连接！', {closeButton:true,positionClass: 'toast-bottom-right'})
	});
    $(function(){
		$("input[name='_csrf']").val(albedo.getCookie(COOKIE_CSRF_NAME));
	})
})(jQuery);