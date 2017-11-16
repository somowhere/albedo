<!DOCTYPE html>
<html>
<head>
    <title>
        <sitemesh:write property="title"/>
    </title>
    <sitemesh:write property='head'/>
</head>
<body class="page-container-bg-solid page-header-fixed page-sidebar-closed-hide-logo">
<!-- BEGIN HEADER -->
<#include "page-header.html" />
<!-- END HEADER -->
<!-- BEGIN HEADER & CONTENT DIVIDER -->
<div class="clearfix"></div>
<!-- END HEADER & CONTENT DIVIDER -->
<!-- BEGIN CONTAINER -->
<sitemesh:write property='body'/>
<!-- BEGIN FOOTER -->
<#include "page-footer.html">
<!-- END FOOTER -->
</body>
</html>