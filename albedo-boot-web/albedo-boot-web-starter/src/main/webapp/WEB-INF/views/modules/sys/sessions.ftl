<div class="row">
    <div class="col-md-12">
        <!-- BEGIN BASE INFO PORTLET-->
        <div class="portlet light bordered">
            <div class="portlet-title">
                <div class="caption font-blue">
                    <i class="fa fa-globe font-blue"></i>JVM 资源监控
                </div>
                <div class="actions">
                    <div class="btn-group">
                        <a id="add-user" class="btn red dialog" href="javascript:void(0);"
                           data-url="${ctx}/sys/user/edit" data-modal-width="950" data-is-modal=""
                           data-table-id="#data-table-user">
                            <i class="fa fa-plus"> 刷新</i>
                        </a>
                    </div>
                </div>
            </div>
            <div class="portlet-body">
                <div class="row">
                    <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
                        <div class="dashboard-stat2 bordered">
                            <h4 class="font-green-sharp"> 内存</h4>
                            <h5>总内存 (<span class="span-val" item-eval="gauges['jvm.memory.total.used'].value"
                                           cardinalNumber="1000000" round="2"></span>M / <span class="span-val"
                                                                                               item-eval="gauges['jvm.memory.total.max'].value"
                                                                                               cardinalNumber="1000000"
                                                                                               round="2"></span> M)</h5>
                            <div class="progress progress-striped active">
                                <div class="progress-bar progress-bar-success"
                                     value-total="gauges['jvm.memory.total.max'].value"
                                     value-used="gauges['jvm.memory.total.used'].value" role="progressbar">
                                    <span class="sr"></span>
                                </div>
                            </div>
                            <h5>堆内存 (<span class="span-val" item-eval="gauges['jvm.memory.heap.used'].value"
                                           cardinalNumber="1000000" round="2"></span>M / <span class="span-val"
                                                                                               item-eval="gauges['jvm.memory.heap.max'].value"
                                                                                               cardinalNumber="1000000"
                                                                                               round="2"></span>M)</h5>
                            <div class="progress progress-striped active">
                                <div class="progress-bar progress-bar-success"
                                     value-total="gauges['jvm.memory.heap.max'].value"
                                     value-used="gauges['jvm.memory.heap.used'].value" role="progressbar">
                                    <span class="sr"></span>
                                </div>
                            </div>
                            <h5>非堆内存 (<span class="span-val" item-eval="gauges['jvm.memory.non-heap.used'].value"
                                            cardinalNumber="1000000" round="2"></span>M / <span class="span-val"
                                                                                                item-eval="gauges['jvm.memory.non-heap.committed'].value"
                                                                                                cardinalNumber="1000000"
                                                                                                round="2"></span>M)</h5>
                            <div class="progress progress-striped active">
                                <div class="progress-bar progress-bar-success"
                                     value-total="gauges['jvm.memory.non-heap.committed'].value"
                                     value-used="gauges['jvm.memory.non-heap.used'].value" role="progressbar">
                                    <span class="sr"></span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
                        <div class="dashboard-stat2 bordered">
                            <h4 class="font-green-sharp"> 线程 (Total: <span class="span-val"
                                                                           item-eval="gauges['jvm.threads.count'].value"></span>)
                            </h4>
                            <h5>可运行 (<span class="span-val"
                                           item-eval="gauges['jvm.threads.runnable.count'].value"></span>)</h5>
                            <div class="progress progress-striped active">
                                <div class="progress-bar progress-bar-success"
                                     value-total="gauges['jvm.threads.count'].value"
                                     value-used="gauges['jvm.threads.runnable.count'].value" role="progressbar">
                                    <span class="sr"></span>
                                </div>
                            </div>
                            <h5>定时等待 (<span class="span-val"
                                            item-eval="gauges['jvm.threads.timed_waiting.count'].value"></span>)</h5>
                            <div class="progress progress-striped active">
                                <div class="progress-bar progress-bar-warning"
                                     value-total="gauges['jvm.threads.count'].value"
                                     value-used="gauges['jvm.threads.timed_waiting.count'].value" role="progressbar">
                                    <span class="sr"></span>
                                </div>
                            </div>
                            <h5>等待中 (<span class="span-val"
                                           item-eval="gauges['jvm.threads.waiting.count'].value"></span>)</h5>
                            <div class="progress progress-striped active">
                                <div class="progress-bar progress-bar-warning"
                                     value-total="gauges['jvm.threads.count'].value"
                                     value-used="gauges['jvm.threads.waiting.count'].value" role="progressbar">
                                    <span class="sr"></span>
                                </div>
                            </div>
                            <h5>阻塞中 (<span class="span-val"
                                           item-eval="gauges['jvm.threads.blocked.count'].value"></span>)</h5>
                            <div class="progress progress-striped active">
                                <div class="progress-bar progress-bar-warning"
                                     value-total="gauges['jvm.threads.count'].value"
                                     value-used="gauges['jvm.threads.blocked.count'].value" role="progressbar">
                                    <span class="sr"></span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
                        <div class="dashboard-stat2 bordered">
                            <h4 class="font-green-sharp">垃圾回收</h4>
                            <ul class="list-group">
                                <li class="list-group-item"> 标记清除次数
                                    <span class="badge badge-default span-val"
                                          item-eval="gauges['jvm.garbage.PS-MarkSweep.count'].value"></span>
                                </li>
                                <li class="list-group-item"> 标记清除耗时
                                    <span class="badge badge-success span-val"
                                          item-eval="gauges['jvm.garbage.PS-MarkSweep.time'].value"></span>
                                </li>
                                <li class="list-group-item"> 回收次数
                                    <span class="badge badge-danger span-val"
                                          item-eval="gauges['jvm.garbage.PS-Scavenge.count'].value"></span>
                                </li>
                                <li class="list-group-item"> 回收耗时
                                    <span class="badge badge-warning span-val"
                                          item-eval="gauges['jvm.garbage.PS-Scavenge.time'].value"></span>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- END BASE INFO PORTLET-->
        <!-- BEGIN SAMPLE HTTP TABLE PORTLET-->
        <div class="portlet light bordered">
            <div class="portlet-title">
                <div class="caption font-dark">
                    <i class="icon-social-dribbble font-green"></i>
                    <span class="caption-subject bold font-green uppercase">HTTP 请求 (事件 / 秒)</span>
                    <small>使用中请求: <span class="span-val"
                                        item-eval="counters['com.codahale.metrics.servlet.InstrumentedFilter.activeRequests'].count"></span>
                        - 请求总数: <span class="span-val"
                                      item-eval="timers['com.codahale.metrics.servlet.InstrumentedFilter.requests'].count"></span>
                    </small>
                </div>
                <div class="tools"></div>
            </div>
            <div class="portlet-body">
                <table class="table table-striped table-bordered table-hover dt-responsive data-table-responsive-http"
                       width="100%">
                    <thead>
                    <tr>
                        <th> 状态码</th>
                        <th> 次数</th>
                        <th> 平均数</th>
                        <th> 平均值 (1 min)</th>
                        <th> 平均值 (5 min)</th>
                        <th> 平均值 (15 min)</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>2xx (成功)</td>
                        <td>
                            <div class="progress progress-striped active">
                                <div class="progress-bar progress-bar-success"
                                     value-total="timers['com.codahale.metrics.servlet.InstrumentedFilter.requests'].count"
                                     value-used="meters['com.codahale.metrics.servlet.InstrumentedFilter.responseCodes.ok'].count"
                                     role="progressbar">
                                    <span class="sr"></span>
                                </div>
                            </div>
                        </td>
                        <td><span class="span-val"
                                  item-eval="meters['com.codahale.metrics.servlet.InstrumentedFilter.responseCodes.ok'].mean_rate"
                                  round="2"></span>
                        </td>
                        <td><span class="span-val"
                                  item-eval="meters['com.codahale.metrics.servlet.InstrumentedFilter.responseCodes.ok'].m1_rate"
                                  round="2"></span>
                        </td>
                        <td><span class="span-val"
                                  item-eval="meters['com.codahale.metrics.servlet.InstrumentedFilter.responseCodes.ok'].m5_rate"
                                  round="2"></span>
                        </td>
                        <td><span class="span-val"
                                  item-eval="meters['com.codahale.metrics.servlet.InstrumentedFilter.responseCodes.ok'].m15_rate"
                                  round="2"></span>
                        </td>
                    </tr>
                    <tr>
                        <td>4xx (请求错误)</td>
                        <td>
                            <div class="progress progress-striped active">
                                <div class="progress-bar progress-bar-success"
                                     value-total="timers['com.codahale.metrics.servlet.InstrumentedFilter.requests'].count"
                                     value-used="meters['com.codahale.metrics.servlet.InstrumentedFilter.responseCodes.notFound'].count"
                                     role="progressbar">
                                    <span class="sr"></span>
                                </div>
                            </div>
                        </td>
                        <td><span class="span-val"
                                  item-eval="meters['com.codahale.metrics.servlet.InstrumentedFilter.responseCodes.notFound'].mean_rate"
                                  round="4"></span>
                        </td>
                        <td><span class="span-val"
                                  item-eval="meters['com.codahale.metrics.servlet.InstrumentedFilter.responseCodes.notFound'].m1_rate"
                                  round="4"></span>
                        </td>
                        <td><span class="span-val"
                                  item-eval="meters['com.codahale.metrics.servlet.InstrumentedFilter.responseCodes.notFound'].m5_rate"
                                  round="4"></span>
                        </td>
                        <td><span class="span-val"
                                  item-eval="meters['com.codahale.metrics.servlet.InstrumentedFilter.responseCodes.notFound'].m15_rate"
                                  round="4"></span>
                        </td>
                    </tr>
                    <tr>
                        <td>5xx (服务器错误)</td>
                        <td>
                            <div class="progress progress-striped active">
                                <div class="progress-bar progress-bar-success"
                                     value-total="timers['com.codahale.metrics.servlet.InstrumentedFilter.requests'].count"
                                     value-used="meters['com.codahale.metrics.servlet.InstrumentedFilter.responseCodes.serverError'].count"
                                     role="progressbar">
                                    <span class="sr"></span>
                                </div>
                            </div>
                        </td>
                        <td><span class="span-val"
                                  item-eval="meters['com.codahale.metrics.servlet.InstrumentedFilter.responseCodes.serverError'].mean_rate"
                                  round="4"></span>
                        </td>
                        <td><span class="span-val"
                                  item-eval="meters['com.codahale.metrics.servlet.InstrumentedFilter.responseCodes.serverError'].m1_rate"
                                  round="4"></span>
                        </td>
                        <td><span class="span-val"
                                  item-eval="meters['com.codahale.metrics.servlet.InstrumentedFilter.responseCodes.serverError'].m5_rate"
                                  round="4"></span>
                        </td>
                        <td><span class="span-val"
                                  item-eval="meters['com.codahale.metrics.servlet.InstrumentedFilter.responseCodes.serverError'].m15_rate"
                                  round="4"></span>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
        <!-- END SAMPLE HTTP TABLE PORTLET-->
        <!-- BEGIN SAMPLE SERVICE TABLE PORTLET-->
        <div class="portlet light bordered">
            <div class="portlet-title">
                <div class="caption">
                    <i class="icon-social-dribbble font-green"></i>
                    <span class="caption-subject font-green bold uppercase">服务统计 (时间单位为毫秒)</span>
                </div>
                <div class="actions">
                </div>
            </div>
            <div class="portlet-body">
                <table class="table table-striped table-bordered table-hover dt-responsive data-table-responsive-service"
                       width="100%">
                    <thead>
                    <tr>
                        <th> 服务名称</th>
                        <th> 计数</th>
                        <th> 平均值</th>
                        <th> 最小值</th>
                        <th> p50</th>
                        <th> p75</th>
                        <th> p95</th>
                        <th> p99</th>
                        <th>最大值</th>
                    </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
        </div>
        <!-- END SAMPLE SERVICE TABLE PORTLET-->
        <!-- BEGIN SAMPLE SERVICE TABLE PORTLET-->
        <div class="portlet light bordered">
            <div class="portlet-title">
                <div class="caption">
                    <i class="icon-social-dribbble font-green"></i>
                    <span class="caption-subject font-green bold uppercase">Ehcache 统计</span>
                </div>
                <div class="actions">
                </div>
            </div>
            <div class="portlet-body">
                <table class="table table-striped table-bordered table-hover dt-responsive data-table-responsive-ehcache"
                       width="100%">
                    <thead>
                    <tr>
                        <th> 缓存名称</th>
                        <th> 对象</th>
                        <th> 缓存命中计数</th>
                        <th> 缓存遗漏计数</th>
                        <th> 收回计数</th>
                        <th> 平均读取时间 (毫秒)</th>
                    </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
        </div>
        <!-- END SAMPLE SERVICE TABLE PORTLET-->
        <!-- BEGIN SAMPLE HTTP TABLE PORTLET-->
        <div class="portlet light bordered">
            <div class="portlet-title">
                <div class="caption font-dark">
                    <i class="icon-social-dribbble font-green"></i>
                    <span class="caption-subject bold font-green uppercase">数据源统计 (时间单位为毫秒)</span>
                </div>
                <div class="tools"></div>
            </div>
            <div class="portlet-body">
                <table class="table table-striped table-bordered table-hover dt-responsive data-table-responsive-datasource"
                       width="100%">
                    <thead>
                    <tr>
                        <th> 用法 (<span class="span-val"
                                       item-eval="gauges['HikariPool-1.pool.ActiveConnections'].value"></span> /
                            <span class="span-val"
                                  item-eval="gauges['HikariPool-1.pool.TotalConnections'].value"></span>)
                        </th>
                        <th> 计数</th>
                        <th> 平均值</th>
                        <th> 最小值</th>
                        <th> p50</th>
                        <th> p75</th>
                        <th> p95</th>
                        <th> p99</th>
                        <th> 最大值</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>
                            <div class="progress progress-striped active">
                                <div class="progress-bar progress-bar-success"
                                     value-total="gauges['HikariPool-1.pool.TotalConnections'].value"
                                     value-used="gauges['HikariPool-1.pool.ActiveConnections'].value"
                                     role="progressbar">
                                    <span class="sr"></span>
                                </div>
                            </div>
                        </td>
                        <td><span class="span-val" item-eval="histograms['HikariPool-1.pool.Usage'].count"></span></td>
                        <td><span class="span-val" item-eval="histograms['HikariPool-1.pool.Usage'].mean"></span></td>
                        <td><span class="span-val" item-eval="histograms['HikariPool-1.pool.Usage'].min"></span></td>
                        <td><span class="span-val" item-eval="histograms['HikariPool-1.pool.Usage'].p50"></span></td>
                        <td><span class="span-val" item-eval="histograms['HikariPool-1.pool.Usage'].p75"></span></td>
                        <td><span class="span-val" item-eval="histograms['HikariPool-1.pool.Usage'].p95"></span></td>
                        <td><span class="span-val" item-eval="histograms['HikariPool-1.pool.Usage'].p99"></span></td>
                        <td><span class="span-val" item-eval="histograms['HikariPool-1.pool.Usage'].max"></span></td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
        <!-- END SAMPLE HTTP TABLE PORTLET-->
    </div>
</div>
<!-- END PAGE BASE CONTENT -->
<script type="text/javascript">
    var TableDatatablesResponsive = function () {

        var initHttpTable = function () {
            var table = $('.data-table-responsive-http');
            var oTable = table.dataTable({
                buttons: [
                    {extend: 'print', className: 'btn dark btn-outline', text: '打印'},
                    {extend: 'copy', className: 'btn red btn-outline', text: '复制'},
                    {extend: 'excel', className: 'btn yellow btn-outline '},
                    {extend: 'csv', className: 'btn purple btn-outline '},
                    {extend: 'colvis', className: 'btn dark btn-outline', text: '列'}
                ],
                "language": albedo.language,
                "dom": "<'row' <'col-md-12 mt-small'B><'col-md-6 col-sm-12'l><'col-md-6 col-sm-12'f>r><'table-scrollable't><'row'<'col-md-5 col-sm-12'i><'col-md-7 col-sm-12'p>>"
            });
        }
        var initServiceTable = function (data) {
            var table = $('.data-table-responsive-service');

            var tableData = [];
            if (data) {
                var tempData = data.timers;
                for (var key in tempData) {
                    tableData.push({
                        name: key,
                        count: tempData[key].count,
                        mean: Math.round(tempData[key].mean * 1000),
                        min: Math.round(tempData[key].min * 1000),
                        p50: Math.round(tempData[key].p50 * 1000),
                        p75: Math.round(tempData[key].p75 * 1000),
                        p95: Math.round(tempData[key].p95 * 1000),
                        p99: Math.round(tempData[key].p99 * 1000),
                        max: Math.round(tempData[key].max * 1000)
                    })
                }
            }
            var oTable = table.dataTable({
                // setup buttons extentension: http://datatables.net/extensions/buttons/
                buttons: [
                    {extend: 'print', className: 'btn dark btn-outline', text: '打印'},
                    {extend: 'copy', className: 'btn red btn-outline', text: '复制'},
                    {extend: 'excel', className: 'btn yellow btn-outline '},
                    {extend: 'csv', className: 'btn purple btn-outline '},
                    {extend: 'colvis', className: 'btn dark btn-outline', text: '列'}
                ],
                "language": albedo.language,
                "data": tableData,
                order: [1, 'desc'],
                "columns": [
                    {"data": "name"},
                    {"data": "count"},
                    {"data": "mean"},
                    {"data": "min"},
                    {"data": "p50"},
                    {"data": "p75"},
                    {"data": "p95"},
                    {"data": "p99"},
                    {"data": "max"}
                ],
                "lengthMenu": [[10, 20, 50, 100, -1], [10, 20, 50, 100, "全部"]],
                "pageLength": 20, // default records per page
                "dom": "<'row' <'col-md-12 mt-small'B>><'row'<'col-md-6 col-sm-12'l><'col-md-6 col-sm-12'f>r><'table-scrollable't><'row'<'col-md-5 col-sm-12'i><'col-md-7 col-sm-12'p>>"
            });
        }
        var initEhcacheTable = function (data) {
            var table = $('.data-table-responsive-ehcache');

            var tableData = [];
            if (data) {
                var tempData = data.gauges, cachesStats = {};
                for (var key in tempData) {
                    if (key.indexOf('net.sf.ehcache.Cache') !== -1) {
                        // remove gets or puts
                        var index = key.lastIndexOf('.');
                        var newKey = key.substr(0, index);
                        // Keep the name of the domain
                        cachesStats[newKey] = {
                            'name': newKey
                        };
                    }
                }
                for (var key in cachesStats) {
                    tableData.push({
                        name: key,
                        objects: tempData[key + '.objects'].value,
                        hits: tempData[key + '.hits'].value,
                        misses: tempData[key + '.misses'].value
                        ,
                        evictionCount: tempData[key + '.eviction-count'].value,
                        meanGetTime: tempData[key + '.mean-get-time'].value
                    });
                }

            }
            var oTable = table.dataTable({
                // setup buttons extentension: http://datatables.net/extensions/buttons/
                buttons: [
                    {extend: 'print', className: 'btn dark btn-outline', text: '打印'},
                    {extend: 'copy', className: 'btn red btn-outline', text: '复制'},
                    {extend: 'excel', className: 'btn yellow btn-outline '},
                    {extend: 'csv', className: 'btn purple btn-outline '},
                    {extend: 'colvis', className: 'btn dark btn-outline', text: '列'}
                ],
                "language": albedo.language,
                "data": tableData,
                order: [1, 'desc'],
                "columns": [
                    {"data": "name"},
                    {"data": "objects"},
                    {"data": "hits"},
                    {"data": "misses"},
                    {"data": "evictionCount"},
                    {"data": "meanGetTime"}
                ],
                "lengthMenu": [[10, 20, 50, 100, -1], [10, 20, 50, 100, "全部"]],
                "pageLength": 20, // default records per page
                "dom": "<'row' <'col-md-12 mt-small'B>><'row'<'col-md-6 col-sm-12'l><'col-md-6 col-sm-12'f>r><'table-scrollable't><'row'<'col-md-5 col-sm-12'i><'col-md-7 col-sm-12'p>>"
            });
        }

        var initDatasouceTable = function () {
            var table = $('.data-table-responsive-datasource');
            var oTable = table.dataTable({
                buttons: [
                    {extend: 'print', className: 'btn dark btn-outline', text: '打印'},
                    {extend: 'copy', className: 'btn red btn-outline', text: '复制'},
                    {extend: 'excel', className: 'btn yellow btn-outline '},
                    {extend: 'csv', className: 'btn purple btn-outline '},
                    {extend: 'colvis', className: 'btn dark btn-outline', text: '列'}
                ],
                "language": albedo.language,
                "dom": "<'row' <'col-md-12 mt-small'B>><'row'<'col-md-6 col-sm-12'l><'col-md-6 col-sm-12'f>r><'table-scrollable't><'row'<'col-md-5 col-sm-12'i><'col-md-7 col-sm-12'p>>"
            });
        }


        return {

            //main function to initiate the module
            init: function () {
                $.get("${ctx}/management/albedo/metrics", function (data) {
                    $(".span-val[item-eval!='']").each(function () {
                        var itemEval = $(this).attr("item-eval"), cardinalNumber = $(this).attr("cardinalNumber"),
                                round = $(this).attr("round");
                        try {
                            eval("var value=data." + itemEval);
                            $(this).text(new Number(value / (cardinalNumber && cardinalNumber > 0 ? cardinalNumber : 1)).toFixed(round && round >= 0 ? round : 0));
                        } catch (e) {
                            console && console.log(e)
                        }
                    })
                    $(".progress-bar[value-total!=''][value-used!='']").each(function () {
                        try {
                            eval("var valueTotal = data." + $(this).attr("value-total") + ", valueUserd = data." + $(this).attr("value-used") + ";")
                            if (valueTotal && valueUserd && valueTotal > 0) {
                                var scale = new Number(valueUserd * 100 / valueTotal).toFixed(2);
                                $(this).attr("aria-valuenow", valueUserd).attr("aria-valuemin", 0).attr("aria-valuemax", valueTotal).attr("style", "width: " + scale + "%").find("span.sr").text(scale + "%");
                            }
                        } catch (e) {
                            console && console.log(e)
                        }
                    });
                    if (!jQuery().dataTable) {
                        return;
                    }
                    initHttpTable();
                    initServiceTable(data);
                    initEhcacheTable(data);
                    initDatasouceTable();
                })
            }

        };

    }();
    jQuery(document).ready(function () {
        TableDatatablesResponsive.init();
    });
</script>
