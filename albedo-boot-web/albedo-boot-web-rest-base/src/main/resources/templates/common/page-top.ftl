<div class="page-header navbar navbar-fixed-top">
    <!-- BEGIN HEADER INNER -->
    <div class="page-header-inner ">
        <!-- BEGIN LOGO -->
        <div class="page-logo">
            <a href="javascript:void(0)" onclick="UIExtendedModals.index()">
                <img src="${assets}/layouts/layout4/img/logo-light.png" alt="logo" class="logo-default">
            </a>
            <div class="menu-toggler sidebar-toggler">
                <!-- DOC: Remove the above "hide" to enable the sidebar toggler button on header -->
            </div>
        </div>
        <!-- END LOGO -->
        <!-- BEGIN RESPONSIVE MENU TOGGLER -->
        <a href="javascript:;" class="menu-toggler responsive-toggler" data-toggle="collapse"
           data-target=".navbar-collapse"> </a>
        <!-- END RESPONSIVE MENU TOGGLER -->
        <!-- BEGIN PAGE ACTIONS -->
        <!-- DO# Remove "hide" class to enable the page header actions -->
        <div class="page-actions">
            <div class="btn-group">
                <button type="button" class="btn red-haze btn-sm dropdown-toggle" data-toggle="dropdown"
                        data-hover="dropdown" data-close-others="true">
                    <span class="hidden-sm hidden-xs">管理平台</span>
                    <i class="fa fa-angle-down"></i>
                </button>
                <ul class="dropdown-menu" role="menu"
                    style="max-height: 500px;overflow-y:auto; overflow-x:hidden; min-width:190px;">
                    <li>
                        <a title="" href="javascript:changeStation('');"> 子平台 </a>
                    </li>
                </ul>
            </div>
        </div>
        <div class="page-top">
            <div class="top-menu">
                <ul class="nav navbar-nav pull-right">
                    <li class="dropdown dropdown-extended dropdown-notification dropdown-dark">
                        <a href="javascript:void(0);" class="dropdown-toggle">${(loginId)!}  您好!</a>
                    </li>
                    <li class="separator"></li>
                    <li class="dropdown dropdown-extended quick-sidebar-toggler">
                        <a class="logout" href="javascript:void()" onclick="albedo.removeCookie(COOKIE_JWT_NAME);albedo.goTo('${ctx}/logout')">退出</a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>