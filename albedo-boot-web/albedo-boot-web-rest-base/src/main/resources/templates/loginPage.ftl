<!DOCTYPE html>
<!--[if IE 8]>
<html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]>
<html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="cn">
<!--<![endif]-->
<!-- BEGIN HEAD -->
<head>
    <meta charset="utf-8"/>
    <title> ${application} | 登录 </title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1" name="viewport"/>
    <meta content="albedo" name="description"/>
    <meta content="" name="author"/>
    <!-- BEGIN GLOBAL MANDATORY STYLES -->
    <link href="${assets}/global/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>
    <link href="${assets}/global/plugins/simple-line-icons/simple-line-icons.min.css" rel="stylesheet" type="text/css"/>
    <link href="${assets}/global/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <link href="${assets}/global/plugins/uniform/css/uniform.default.css" rel="stylesheet" type="text/css"/>
    <link href="${assets}/global/plugins/bootstrap-switch/css/bootstrap-switch.min.css" rel="stylesheet"
          type="text/css"/>
    <!-- END GLOBAL MANDATORY STYLES -->
    <!-- BEGIN PAGE LEVEL PLUGINS -->
    <link href="${assets}/global/plugins/select2/css/select2.min.css" rel="stylesheet" type="text/css"/>
    <link href="${assets}/global/plugins/select2/css/select2-bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <!-- END PAGE LEVEL PLUGINS -->
    <!-- BEGIN THEME GLOBAL STYLES -->
    <link href="${assets}/global/css/components.min.css" rel="stylesheet" id="style_components" type="text/css"/>
    <link href="${assets}/global/css/plugins.min.css" rel="stylesheet" type="text/css"/>
    <!-- END THEME GLOBAL STYLES -->
    <!-- BEGIN PAGE LEVEL STYLES -->
    <link href="${assets}/pages/css/login.min.css" rel="stylesheet" type="text/css"/>
    <!-- END PAGE LEVEL STYLES -->
    <!-- BEGIN THEME LAYOUT STYLES -->
    <!-- END THEME LAYOUT STYLES -->
    <link rel="shortcut icon" href="${assets}/pages/img/favicon.ico"/>
</head>
<style type="text/css">.login .content {
    margin: 130px auto 10px;
    background: rgba(255, 255, 255, 0.8);
    border-radius: 5px !important;
}</style>
<!-- END HEAD -->

<body class=" login">
<!-- BEGIN LOGO -->
<!--<div class="logo">
    <a href="index.html"><img src="${assets}/pages/img/logo-big.png" alt="" /></a>
</div>-->
<!-- END LOGO -->
<!-- BEGIN LOGIN -->
<div class="content">
    <!-- BEGIN LOGIN FORM -->
    <form class="login-form" action="${ctx}/authenticate" method="post">
        <h3 class="form-title font-green text-center">${application}</h3>
        <div class="alert alert-danger display-hide">
            <button class="close" data-close="alert"></button>
            <span></span>
        </div>
        <div class="form-group">
            <!--ie8, ie9 does not support html5 placeholder, so we just show field title for that-->
            <label class="control-label visible-ie8 visible-ie9">用户名</label>
            <div class="input-icon">
                <i class="fa fa-user"></i>
                <input class="form-control placeholder-no-fix" type="text" autocomplete="off" placeholder="用户名"
                       name="username"/></div>
        </div>
        <div class="form-group">
            <label class="control-label visible-ie8 visible-ie9">密码</label>
            <div class="input-icon">
                <i class="fa fa-lock"></i>
                <input class="form-control placeholder-no-fix" type="password" autocomplete="off" placeholder="密码"
                       name="password"/></div>
        </div>
        <div class="form-actions">
            <button type="submit" class="btn green uppercase">登录</button>
            <label class="rememberme check hide">
                <input type="checkbox" name="remember-me" value="true"/>记住我 </label>
            <a href="javascript:;" id="forget-password" class="forget-password hide">忘记密码?</a>
        </div>
    </form>
    <!-- END LOGIN FORM -->
</div>
<!-- END LOGIN -->
<!-- BEGIN COPYRIGHT -->
<div class="copyright"> 2016 © albedo 客服电话:<strong>400-000-0000</strong></div>
<!-- END COPYRIGHT -->
<!--[if lt IE 9]>
<script src="${assets}/global/plugins/respond.min.js"></script>
<script src="${assets}/global/plugins/excanvas.min.js"></script>
<![endif]-->
<!-- BEGIN CORE PLUGINS -->
<script src="${assets}/global/plugins/jquery.min.js" type="text/javascript"></script>
<script src="${assets}/global/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<script src="${assets}/global/plugins/js.cookie.min.js" type="text/javascript"></script>
<script src="${assets}/global/plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown.min.js"
        type="text/javascript"></script>
<script src="${assets}/global/plugins/jquery-slimscroll/jquery.slimscroll.min.js" type="text/javascript"></script>
<script src="${assets}/global/plugins/jquery.blockui.min.js" type="text/javascript"></script>
<script src="${assets}/global/plugins/uniform/jquery.uniform.min.js" type="text/javascript"></script>
<script src="${assets}/global/plugins/jquery.form.js" type="text/javascript"></script>
<script src="${assets}/global/plugins/bootstrap-switch/js/bootstrap-switch.min.js" type="text/javascript"></script>
<!-- END CORE PLUGINS -->
<!-- BEGIN PAGE LEVEL PLUGINS -->
<script src="${assets}/global/plugins/jquery-validation/js/jquery.validate.min.js" type="text/javascript"></script>
<script src="${assets}/global/plugins/jquery-validation/js/additional-methods.min.js" type="text/javascript"></script>
<script src="${assets}/global/plugins/select2/js/select2.full.min.js" type="text/javascript"></script>
<script src="${assets}/global/plugins/backstretch/jquery.backstretch.min.js" type="text/javascript"></script>
<!-- END PAGE LEVEL PLUGINS -->
<!-- BEGIN THEME GLOBAL SCRIPTS -->
<script src="${assets}/js/app.min.js" type="text/javascript"></script>
<!-- END THEME GLOBAL SCRIPTS -->
<!-- BEGIN PAGE LEVEL SCRIPTS -->
<script src="${assets}/pages/scripts/login-4.js" type="text/javascript"></script>
<!-- END PAGE LEVEL SCRIPTS -->
<script src="${ctxStatic}/common/albedo.js" type="text/javascript"></script>
<script src="${ctxStatic}/jquery/jquery.replenish.js" type="text/javascript"></script>
<!-- BEGIN THEME LAYOUT SCRIPTS -->
<!-- END THEME LAYOUT SCRIPTS -->
<script type="text/javascript">
    var ctx = "${ctx}";
</script>
</body>

</html>
