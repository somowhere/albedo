<div class="row">
    <div class="col-md-12">
        <!-- BEGIN EXAMPLE TABLE PORTLET-->
        <div class="portlet light bordered">
            <div class="portlet-title">
                <div class="caption font-blue">
                    <i class="fa fa-globe font-blue"></i>数据列表
                </div>
                <div class="actions">
                </div>
            </div>
            <div class="portlet-body">
                <form class="form-inline form-search" role="form">
                    <div class="form-group">
                        <label class="input-label" for="loggerName">名称</label>
                        <input type="text" class="form-control" searchItem="searchItem" id="loggerName"
                               name="loggerName" value="${(loggingEvent.loggerName)!}" attrType="String" operation="eq"
                               htmlEscape="false" maxlength="254" placeholder="...">
                    </div>
                    <div class="form-group">
                        <label class="input-label" for="levelString">级别</label>
                    <@albedo.form name="levelString" searchItem="searchItem" dictCode="sys_log_level" boxType="checkbox" value="${(loggingEvent.levelString)!}" operate="eq" attrType="String"> </@albedo.form>
                    </div>
                    <div class="form-group">
                        <label class="input-label" for="referenceFlag">引用标识</label>
                    <@albedo.form name="referenceFlag" searchItem="searchItem" dictCode="sys_yes_no" boxType="checkbox" value="${(loggingEvent.referenceFlag)!}" operate="eq" attrType="String"> </@albedo.form>
                    </div>
                    <div class="form-group form-btn">
                        <button class="btn btn-sm green btn-outline filter-submit-table-loggingEvent margin-bottom"
                                type="button"><i class="fa fa-search"></i> 查询
                        </button>
                        <button class="btn btn-sm red btn-outline filter-cancel" type="reset"><i
                                class="fa fa-times"></i> 重置
                        </button>
                    </div>
                </form>
                <hr/>
                <div id="bootstrap-alerts"></div>
                <table class="table table-striped table-bordered table-hover dataTable no-footer dt-responsive"
                       id="data-table-loggingEvent">
                    <thead>
                    <tr role="row" class="heading">
                        <th width="10%"> 创建时间</th>
                        <th width="10%"> 名称</th>
                        <th width="10%"> 级别</th>
                        <th width="10%"> 线程</th>
                        <th width="10%"> 引用标识</th>
                        <th width="10%"> 操作文件</th>
                        <th width="10%"> 操作方法</th>
                        <th width="10%"> 操作行</th>
                        <th width="10%"> 内容</th>
                        <th width="10%"> 参数0</th>
                        <th width="10%"> 参数1</th>
                        <th width="10%"> 参数2</th>
                        <th width="10%"> 参数3</th>
                    </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
        </div>
        <!-- END EXAMPLE TABLE PORTLET-->
    </div>
</div>
<!-- END PAGE BASE CONTENT -->
<script type="text/javascript">
    var dataloggingEventTables = function () {
        var initTradeOrderTable = function () {
            var grid = new Datatable();
            grid.init({
                src: $("#data-table-loggingEvent"),
                dataTable: {
                    "ajax": {
                        "url": "${ctx}/sys/loggingEvent/page",
                        type: 'GET',
                        "dataType": 'json'
                    }, order: [0, 'desc'],
                    "columns": [
                        {
                            data: 'timestmp', render: function (data, type, row) {
                            return new Date(data).format('yyyy-MM-dd hh:mm:ss');
                        }
                        }
                        , {
                            data: 'loggerName'
                        }
                        , {
                            data: 'levelString', render: function (data, type, row) {
                                return "<span class='label label-" + (data == "INFO" ? "info" : data == "ERROR" ? "danger" : data == "WARN" ? "warning" : "default") + "'>" + data + "</span>";
                            }
                        }
                        , {
                            data: 'threadName'
                        }
                        , {
                            data: 'referenceFlag'
                        }

                        , {
                            data: 'callerFilename'
                        }
                        , {
                            data: 'callerMethod'
                        }
                        , {
                            data: 'callerLine', render: function (data, type, row) {
                                return "<span class='badge badge-info'>" + data + "</span>";
                            }
                        }, {data: 'formattedMessage'}, {
                            data: 'arg0'
                        }
                        , {
                            data: 'arg1'
                        }
                        , {
                            data: 'arg2'
                        }
                        , {
                            data: 'arg3'
                        }
                    ]
                }
            });
            $(".filter-submit-table-loggingEvent").click(function () {
                grid.submitFilter();
            })
        };
        return {
            init: function () {
                if (!jQuery().dataTable) {
                    return;
                }
                initTradeOrderTable();
            }
        };
    }();
    jQuery(document).ready(function () {
        dataloggingEventTables.init();
    });
</script>