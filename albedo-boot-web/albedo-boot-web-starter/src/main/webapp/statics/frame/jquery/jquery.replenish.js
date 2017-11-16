var COOKIE_JWT_NAME = "Authorization";
(function ($) {
    $(document).ajaxSend(function (event, jqxhr, settings) {
        App.blockUI({
            animate: true,
            overlayColor: 'none'
        });
        settings.header = {"Authorization": albedo.getCookie(COOKIE_JWT_NAME)};
        jqxhr.setRequestHeader("Authorization", albedo.getCookie(COOKIE_JWT_NAME));


    });
    $(document).ajaxComplete(function (event, xhr, settings) {
        App.unblockUI();
    });
    $(document).ajaxError(function (event, xhr, settings) {
        App.unblockUI();
        try {
            toastr && toastr.error('网络异常，请检查您的网络连接！', {closeButton: true, positionClass: 'toast-bottom-right'})
        } catch (e) {
        }
    });
    $(function () {
        $("input[name='_JWT']").val(albedo.getCookie(COOKIE_JWT_NAME));
    })
})(jQuery);