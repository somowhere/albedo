<!DOCTYPE html>
<!--[if IE 8]>
<html lang="cn" class="ie8"> <![endif]-->
<!--[if IE 9]>
<html lang="cn" class="ie9"> <![endif]-->
<!--[if !IE]><!-->
<html lang="cn"> <!--<![endif]-->
<head>
    <title>${application} </title>
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
                                    <div class="desc">预付款余额( 元 )</div>
                                    <div class="number">
                                        <span data-counter="counterup" data-value="-50771.86">0</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                            <div class="dashboard-stat red">
                                <div class="col-sm-12 details">
                                    <div class="desc">近24小时销售金额( 元 )</div>
                                    <div class="number">
                                        <span data-counter="counterup" data-value="0.00">0</span>
                                    </div>
                                    <div class="compare">
                                        相比上24小时<span data-counter="counterup" data-value="0"></span>%
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                            <div class="dashboard-stat green">
                                <div class="col-sm-12 details">
                                    <div class="desc">近24小时销售单数( 单 )</div>
                                    <div class="number">
                                        <span data-counter="counterup" data-value="0">0</span>
                                    </div>
                                    <div class="compare">
                                        相比上24小时<span data-counter="counterup" data-value="0"></span>%
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                            <div class="dashboard-stat purple">
                                <div class="details">
                                    <div class="desc">近24小时增长用户( 量 )</div>
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
                                        <span class="caption-subject font-green bold uppercase">交易情况</span>
                                    </div>
                                    <div class="actions">
                                        <div class="btn-group btn-group-devided" data-toggle="buttons">
                                            <label class="btn red btn-outline btn-circle btn-sm active">
                                                <input type="radio" name="options" class="toggle"
                                                       value="findStationConsumeStatistics">销售金额</label>
                                            <label class="btn red btn-outline btn-circle btn-sm">
                                                <input type="radio" name="options" class="toggle"
                                                       value="findStationOrderStatistics">销售单数</label>
                                            <label class="btn red btn-outline btn-circle btn-sm">
                                                <input type="radio" name="options" class="toggle"
                                                       value="findStationTradeStatistics">交易人数</label>
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

        <script type="text/javascript">
            require.config({
                paths: {
                    echarts: '${assets}/global/plugins/echarts-2.2.7/build/dist'
                }
            });
            var Data = function () {
                return {
                    findStationConsumeStatistics: function () {
                        // 使用
                        require(['echarts', 'echarts/chart/line', 'echarts/chart/bar'], function (ec) {
                            var stationConsumeStatisticsOption = {
                                tooltip: {
                                    trigger: 'axis'
                                },
                                calculable: true,
                                xAxis: [
                                    {
                                        type: 'category',
                                        boundaryGap: false,
                                        data: []
                                    }
                                ],
                                yAxis: [
                                    {
                                        type: 'value',
                                        axisLabel: {
                                            formatter: '{value} 元'
                                        }
                                    }
                                ],
                                series: [
                                    {
                                        name: '销售金额',
                                        type: 'line',
                                        data: [],
                                        markPoint: {
                                            data: [
                                                {type: 'max', name: '最大值'},
                                                {type: 'min', name: '最小值'}
                                            ]
                                        },
                                        markLine: {
                                            data: [
                                                {type: 'average', name: '平均值'}
                                            ]
                                        }
                                    }
                                ]
                            };
                            $.ajax({
                                url: App.getCtxPath() + '/merchant_findStationConsumeStatistics?type=2',
                                type: "POST",
                                timeout: 60000,
                                data: {
                                    "stationId": "${(currentStation.sid)!}",
                                    "beginTime": moment().subtract(1, 'days').format('YYYY-MM-DD HH:mm:ss'),
                                    "endTime": moment().format('YYYY-MM-DD HH:mm:ss')
                                },
                                dataType: 'json',
                                success: function (re) {
                                    if (re.status == 1) {
                                        $("#trade_info_loading").hide();
                                        $("#trade_info_content").removeClass("display-none");
                                        if (re.data.length) {
                                            /*for(var i=0; i<re.data.length; i++) {
                                             stationConsumeStatisticsOption.xAxis[0].data.push(re.data[i].consumeTime);
                                             stationConsumeStatisticsOption.series[0].data.push(re.data[i].consumeMoney);
                                             }*/
                                            var temp = {};
                                            for (var i = 23; i >= 0; i--) {
                                                var consumeTime = moment().subtract(i, 'hours').format('DD日HH时');
                                                temp[consumeTime] = 0;
                                            }
                                            for (var i = 0; i < re.data.length; i++) {
                                                temp[re.data[i].consumeTime] = re.data[i].consumeMoney;
                                            }
                                            for (var key in temp) {
                                                stationConsumeStatisticsOption.xAxis[0].data.push(key);
                                                stationConsumeStatisticsOption.series[0].data.push(temp[key]);
                                            }

                                            $("#trade_info").css("height", "400px");
                                            var stationConsumeStatistics = ec.init(document.getElementById('trade_info'));
                                            stationConsumeStatistics.setOption(stationConsumeStatisticsOption);
                                        } else {
                                            $("#trade_info").css("height", "100%");
                                            $("#trade_info").text("暂无数据");
                                        }
                                    } else {
                                        toastr.warning('数据获取失败', '', {
                                            closeButton: true,
                                            positionClass: 'toast-bottom-right'
                                        })
                                    }
                                },
                                error: function (data) {
                                    toastr.error('网络异常，请检查您的网络连接！', {
                                        closeButton: true,
                                        positionClass: 'toast-bottom-right'
                                    })
                                }
                            });
                        });

                    },
                    findStationOrderStatistics: function () {
                        // 使用
                        require(['echarts', 'echarts/chart/line', 'echarts/chart/bar'], function (ec) {
                            var stationConsumeStatisticsOption = {
                                tooltip: {
                                    trigger: 'axis'
                                },
                                calculable: true,
                                xAxis: [
                                    {
                                        type: 'category',
                                        boundaryGap: false,
                                        data: []
                                    }
                                ],
                                yAxis: [
                                    {
                                        type: 'value',
                                        axisLabel: {
                                            formatter: '{value} 单'
                                        }
                                    }
                                ],
                                series: [
                                    {
                                        name: '销售单数',
                                        type: 'line',
                                        data: [],
                                        markPoint: {
                                            data: [
                                                {type: 'max', name: '最大值'},
                                                {type: 'min', name: '最小值'}
                                            ]
                                        },
                                        markLine: {
                                            data: [
                                                {type: 'average', name: '平均值'}
                                            ]
                                        }
                                    }
                                ]
                            };
                            $.ajax({
                                url: App.getCtxPath() + '/merchant_findStationOrderStatistics?type=2',
                                type: "POST",
                                timeout: 60000,
                                data: {
                                    "stationId": "${(currentStation.sid)!}",
                                    "beginTime": moment().subtract(1, 'days').format('YYYY-MM-DD HH:mm:ss'),
                                    "endTime": moment().format('YYYY-MM-DD HH:mm:ss')
                                },
                                dataType: 'json',
                                success: function (re) {
                                    if (re.status == 1) {
                                        $("#trade_info_loading").hide();
                                        $("#trade_info_content").removeClass("display-none");
                                        if (re.data.length) {
                                            /*for(var i=0; i<re.data.length; i++) {
                                             stationConsumeStatisticsOption.xAxis[0].data.push(re.data[i].consumeTime);
                                             stationConsumeStatisticsOption.series[0].data.push(re.data[i].consumeNum);
                                             }*/
                                            var temp = {};
                                            for (var i = 23; i >= 0; i--) {
                                                var consumeTime = moment().subtract(i, 'hours').format('DD日HH时');
                                                temp[consumeTime] = 0;
                                            }
                                            for (var i = 0; i < re.data.length; i++) {
                                                temp[re.data[i].consumeTime] = re.data[i].consumeNum;
                                            }
                                            for (var key in temp) {
                                                stationConsumeStatisticsOption.xAxis[0].data.push(key);
                                                stationConsumeStatisticsOption.series[0].data.push(temp[key]);
                                            }
                                            $("#trade_info").css("height", "400px");
                                            var stationConsumeStatistics = ec.init(document.getElementById('trade_info'));
                                            stationConsumeStatistics.setOption(stationConsumeStatisticsOption);
                                        } else {
                                            $("#trade_info").css("height", "100%");
                                            $("#trade_info").text("暂无数据");
                                        }
                                    } else {
                                        toastr.warning('数据获取失败', '', {
                                            closeButton: true,
                                            positionClass: 'toast-bottom-right'
                                        })
                                    }
                                },
                                error: function (data) {
                                    toastr.error('网络异常，请检查您的网络连接！', {
                                        closeButton: true,
                                        positionClass: 'toast-bottom-right'
                                    })
                                }
                            });
                        });

                    },
                    findStationTradeStatistics: function () {
                        // 使用
                        require(['echarts', 'echarts/chart/line', 'echarts/chart/bar'], function (ec) {
                            var stationTradeStatisticsOption = {
                                tooltip: {
                                    trigger: 'axis'
                                },
                                calculable: true,
                                xAxis: [
                                    {
                                        type: 'category',
                                        boundaryGap: false,
                                        data: []
                                    }
                                ],
                                yAxis: [
                                    {
                                        type: 'value',
                                        axisLabel: {
                                            formatter: '{value} 人'
                                        }
                                    }
                                ],
                                series: [
                                    {
                                        name: '交易人数',
                                        type: 'line',
                                        data: [],
                                        markPoint: {
                                            data: [
                                                {type: 'max', name: '最大值'},
                                                {type: 'min', name: '最小值'}
                                            ]
                                        },
                                        markLine: {
                                            data: [
                                                {type: 'average', name: '平均值'}
                                            ]
                                        }
                                    }
                                ]
                            };
                            $.ajax({
                                url: App.getCtxPath() + '/merchant_findStationTradeStatistics?type=2',
                                type: "POST",
                                timeout: 60000,
                                data: {
                                    "stationId": "${(currentStation.sid)!}",
                                    "beginTime": moment().subtract(1, 'days').format('YYYY-MM-DD HH:mm:ss'),
                                    "endTime": moment().format('YYYY-MM-DD HH:mm:ss')
                                },
                                dataType: 'json',
                                success: function (re) {
                                    if (re.status == 1) {
                                        $("#trade_info_loading").hide();
                                        $("#trade_info_content").removeClass("display-none");
                                        if (re.data.length) {
                                            /*for(var i=0; i<re.data.length; i++) {
                                             stationTradeStatisticsOption.xAxis[0].data.push(re.data[i].consumeTime);
                                             stationTradeStatisticsOption.series[0].data.push(re.data[i].userNumber);
                                             }*/
                                            var temp = {};
                                            for (var i = 23; i >= 0; i--) {
                                                var consumeTime = moment().subtract(i, 'hours').format('DD日HH时');
                                                temp[consumeTime] = 0;
                                            }
                                            for (var i = 0; i < re.data.length; i++) {
                                                temp[re.data[i].consumeTime] = re.data[i].userNumber;
                                            }
                                            for (var key in temp) {
                                                stationTradeStatisticsOption.xAxis[0].data.push(key);
                                                stationTradeStatisticsOption.series[0].data.push(temp[key]);
                                            }

                                            $("#trade_info").css("height", "400px");
                                            var stationTradeStatistics = ec.init(document.getElementById('trade_info'));
                                            stationTradeStatistics.setOption(stationTradeStatisticsOption);
                                        } else {
                                            $("#trade_info").css("height", "100%");
                                            $("#trade_info").text("暂无数据");
                                        }
                                    } else {
                                        toastr.warning('数据获取失败', '', {
                                            closeButton: true,
                                            positionClass: 'toast-bottom-right'
                                        })
                                    }
                                },
                                error: function (data) {
                                    toastr.error('网络异常，请检查您的网络连接！', {
                                        closeButton: true,
                                        positionClass: 'toast-bottom-right'
                                    })
                                }
                            });
                        });
                    },
                    initRecentActivity: function () {
                        var grid = new Datatable();
                        grid.init({
                            src: $("#t_recent"),
                            onSuccess: function (grid, response) {
                                // grid:        grid object
                                // response:    json object of server side ajax response
                                // execute some code after table records loaded
                            },
                            onError: function (grid) {
                                // execute some code on network or other general error
                            },
                            onDataLoad: function (grid) {
                                // execute some code on ajax data load
                            },
                            loadingMessage: '数据加载中...',
                            dataTable: {
                                "language": albedo.language,
                                "bStateSave": true,
                                "processing": true,
                                "serverSide": true,
                                responsive: true,
                                "ordering": false,
                                //"paging": false, disable pagination
                                "lengthMenu": [[10, 20, 50, 100, -1], [10, 20, 50, 100, "全部"]],
                                "pageLength": 10,
                                "pagingType": "bootstrap_full_number",
                                "dom": "<'table-scrollable't><'row'<'col-md-5 col-sm-12'i><'col-md-7 col-sm-12'p>>", // horizobtal scrollable datatable
                                // Uncomment below line("dom" parameter) to fix the dropdown overflow issue in the datatable cells. The default datatable layout
                                // setup uses scrollable div(table-scrollable) with overflow:auto to enable vertical scroll(see: assets/global/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.js).
                                // So when dropdowns used the scrollable div should be removed.
                                //"dom": "<'row' <'col-md-12'T>><'row'<'col-md-6 col-sm-12'l><'col-md-6 col-sm-12'f>r>t<'row'<'col-md-5 col-sm-12'i><'col-md-7 col-sm-12'p>>",

                                "ajax": {
                                    "url": "${ctx}/account/overview/recent?stationId=${(currentStation.sid)!}",
                                    data: function (d) {
                                        var pm = {};
                                        pm.draw = d.draw;
                                        pm.pageSize = d.length;
                                        pm.pageNo = d.start / d.length + 1;
                                        pm.queryConditionJson = albedo.parseJsonItemForm();
                                        return pm;
                                    }
                                },
                                "columns": [
                                    {data: "content"},
                                    {data: "createTime"}
                                ]
                            }
                        });
                    },
                    init: function () {
                        if (!jQuery().dataTable) {
                            return;
                        }
                        //this.initRecentActivity();
                        //this.findStationConsumeStatistics();
                    }
                };
            }();
            jQuery(document).ready(function () {
                Data.init();
            });
            $("[name='options']").on("change", function () {
                $("#trade_info_content").addClass("display-none");
                $("#trade_info_loading").show();
                eval("Data." + $(this).val() + "()");
            });
        </script>
</body>
</html>
