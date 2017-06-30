<!DOCTYPE html>
<!--[if IE 8]>
<html lang="cn" class="ie8"> <![endif]-->
<!--[if IE 9]>
<html lang="cn" class="ie9"> <![endif]-->
<!--[if !IE]><!-->
<html lang="cn"> <!--<![endif]-->
<head>
    <title>${application}</title>
    <link rel="shortcut icon" href="${assets}/pages/img/favicon.ico"/>
<#include "/common/meta.ftl" />
<#include "/common/page-header.ftl" />
    <style type="text/css">
        .dashboard-stat .details {
            position: inherit;
            right: auto;
            padding-bottom: 25px;
            padding-top: 25px;
        }

        .dashboard-stat.blue .details, .dashboard-stat.purple .details {
            padding-bottom: 44px;
        }

        .dashboard-stat .details .number, .dashboard-stat .details .desc {
            text-align: center;
            font-weight: normal;
        }

        .dashboard-stat .details .number {
            padding-top: 5px;
            padding-bottom: 5px;
            font-size: 28px;
        }

        .dashboard-stat .details .desc {
            font-size: 14px;
        }

        .dashboard-stat .details .compare {
            text-align: center;
            color: #fff;
        }

        .dashboard-stat .details .compare span {
            margin-left: 40px;
        }

        .dashboard-stat .details .number span {
            font-size: 26px;
        }
    </style>
</head>
<body class="page-container-bg-solid page-header-fixed page-sidebar-closed-hide-logo">
<!-- BEGIN HEADER -->
<#include "/common/page-top.ftl">
<!-- END HEADER -->
<!-- BEGIN HEADER & CONTENT DIVIDER -->
<div class="clearfix"></div>
<!-- END HEADER & CONTENT DIVIDER -->
<!-- BEGIN CONTAINER -->
<div class="page-container">
    <!-- BEGIN SIDEBAR -->
<#include "/common/page-left.ftl">
    <!-- END SIDEBAR -->
    <!-- BEGIN CONTENT -->
    <div class="page-content-wrapper">
        <div id="bootstrap-alerts"></div>
        <!-- BEGIN CONTENT BODY -->
        <div class="page-content">
            <!-- BEGIN PAGE HEAD-->
            <div class="page-head">
                <!-- BEGIN PAGE TITLE -->
                <div class="page-title">
                    <h1>账户概览</h1>
                </div>
            </div>
            <!-- END PAGE HEAD-->
            <!-- BEGIN PAGE BASE CONTENT -->
            <!-- BEGIN DASHBOARD STATS 1-->
            <div class="row">
                <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                    <div class="dashboard-stat blue">
                        <div class="col-sm-12 details">
                            <div class="desc">X1</div>
                            <div class="number">
                                <span data-counter="counterup" data-value="-50771.86">0</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                    <div class="dashboard-stat red">
                        <div class="col-sm-12 details">
                            <div class="desc">X1</div>
                            <div class="number">
                                <span data-counter="counterup" data-value="0.00">0</span>
                            </div>
                            <div class="compare">
                                <span data-counter="counterup" data-value="0"></span>%
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                    <div class="dashboard-stat green">
                        <div class="col-sm-12 details">
                            <div class="desc">X1</div>
                            <div class="number">
                                <span data-counter="counterup" data-value="0">0</span>
                            </div>
                            <div class="compare">
                                <span data-counter="counterup" data-value="0"></span>%
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                    <div class="dashboard-stat purple">
                        <div class="details">
                            <div class="desc">X1</div>
                            <div class="number"><span data-counter="counterup" data-value="0">0</span></div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="clearfix"></div>
            <!-- END DASHBOARD STATS 1-->
            <div class="row">
                <div class="col-md-6 col-sm-6">
                    <!-- BEGIN PORTLET-->
                    <div class="portlet light bordered">
                        <div class="portlet-title">
                            <div class="caption">
                                <i class="icon-bar-chart font-green"></i>
                                <span class="caption-subject font-green bold uppercase">XZ</span>
                            </div>
                            <div class="actions">
                                <div class="btn-group btn-group-devided" data-toggle="buttons">
                                    <label class="btn red btn-outline btn-circle btn-sm active">
                                        <input type="radio" name="options" class="toggle"
                                               value="findStationConsumeStatistics">XZ</label>
                                    <label class="btn red btn-outline btn-circle btn-sm">
                                        <input type="radio" name="options" class="toggle"
                                               value="findStationOrderStatistics">XZ</label>
                                    <label class="btn red btn-outline btn-circle btn-sm">
                                        <input type="radio" name="options" class="toggle"
                                               value="findStationTradeStatistics">XZ</label>
                                </div>
                            </div>
                        </div>
                        <div class="portlet-body">
                            <div id="trade_info_loading">
                                <img src="${assets}/global/img/loading.gif" alt="loading"/></div>
                            <div id="trade_info_content" class="display-none">
                                <div id="trade_info" class="chart" style="width: 100%;"></div>
                            </div>
                        </div>
                    </div>
                    <!-- END PORTLET-->
                </div>
                <div class="col-md-6 col-sm-6">
                    <div class="portlet light bordered">
                        <div class="portlet-title">
                            <div class="caption">
                                <i class="icon-share font-blue"></i>
                                <span class="caption-subject font-blue bold uppercase">消息通知</span>
                            </div>
                            <div class="actions">

                            </div>
                        </div>
                        <div class="portlet-body portlet-empty">
                            <table class="table table-striped table-hover table-light" id="t_recent">
                                <thead>
                                <tr>
                                    <th width="60%"> 内容</th>
                                    <th width="40%"> 时间</th>
                                </tr>
                                </thead>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <!-- END PAGE BASE CONTENT -->
        </div>
        <!-- END CONTENT BODY -->
    </div>
    <!-- END CONTENT -->
</div>
<#include "/common/page-footer.ftl">
<!-- BEGIN PAGE LEVEL PLUGINS -->
<!-- END PAGE LEVEL PLUGINS -->


</body>
</html>
