<div class="row">
    <div class="col-md-12">
        <!-- BEGIN EXAMPLE TABLE PORTLET-->
        <div class="portlet light bordered">
            <div class="portlet-title">
                <div class="caption font-blue">
                    <i class="fa fa-globe font-blue"></i>数据列表
                </div>
                <div class="actions">
                    <div class="btn-group">
                    <#if SecurityUtil.hasPermission('sys_genScheme_edit')><a id="add_member" class="btn red dialog"
                                                                             href="javascript:void(0);"
                                                                             data-url="${ctx}/gen/genScheme/edit"
                                                                             data-modal-width="950" data-is-modal=""
                                                                             data-table-id="#data-table-genScheme">
                        <i class="fa fa-plus"> 添加生成方案</i>
                    </a></#if>
                    </div>
                </div>
            </div>
            <div class="portlet-body">
                <form class="form-inline form-search" role="form">
                    <div class="form-group">
                        <label class="input-label" for="name">名称 </label>
                        <input type="text" class="form-control" searchItem="searchItem" id="name" name="name"
                               placeholder="..."></div>
                    <div class="form-group">
                        <label class="input-label" for="genTableName">表名 </label>
                        <input type="text" class="form-control" searchItem="searchItem" id="genTableName"
                               name="genTableName" placeholder="..."></div>
                    <div class="form-group">
                        <label class="input-label" for="functionName">功能名称 </label>
                        <input type="text" class="form-control" searchItem="searchItem" id="functionName"
                               name="functionName" placeholder="..."></div>
                    <div class="form-group">
                        <label class="input-label" for="name">功能作者 </label>
                        <input type="text" class="form-control" searchItem="searchItem" id="functionAuthor"
                               name="functionAuthor" placeholder="..."></div>
                    <div class="form-group">
                        <label class="input-label">状态</label>
                    <@albedo.form name="status" searchItem="searchItem" dictCode="sys_status" boxType="checkbox" operate="in" attrType="Integer"> </@albedo.form>
                    </div>
                    <div class="form-group form-btn">
                        <button class="btn btn-sm green btn-outline filter-submit-table-genScheme margin-bottom"
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
                       id="data-table-genScheme">
                    <thead>
                    <tr role="row" class="heading">
                        <th width="10%" colspan="1"> 名称</th>
                        <th width="10%"> 表名</th>
                        <th width="10%" colspan="1"> 基础包名</th>
                        <th width="10%"> 模块</th>
                        <th width="10%"> 功能名称</th>
                        <th width="10%"> 功能作者</th>
                        <th width="10%"> 状态</th>
                        <th width="10%"> 修改时间</th>
                        <th width="20%"> 操作</th>
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
    var dataTables = function () {
        var initPickers = function () {
            //init date pickers
            $('.date-picker').datepicker({
                rtl: App.isRTL(),
                autoclose: true
            });
        };
        var initTradeOrderTable = function () {
            var grid = new Datatable();
            grid.init({
                src: $("#data-table-genScheme"),
                dataTable: {
                    "ajax": {
                        "url": "${ctx}/gen/genScheme/page",
                        type: 'GET',
                        "dataType": 'json'
                    },
                    order: [[0, 'asc']],
                    "columns": [
                        {data: "name"}, {data: "genTableName"}, {data: "packageName"},
                        {data: "moduleName"},
                        {data: "functionName", orderable: false},
                        {data: "functionAuthor"},
                        {
                            data: "status", render: function (data, type, row) {
                            var cssClass = (data == "正常" ? "info" : "warning");
                            return '<span class="label label-sm label-' + cssClass + '">' + data + '</span>';
                        }
                        }, {data: "lastModifiedDate"},
                        {
                            orderable: false, data: function (row, type, val, meta) {
                        return '<span class="operation">'
                        <#if SecurityUtil.hasPermission('sys_genScheme_edit')>+ '<a href="javascript:void(0);" class="dialog" data-table-id="#data-table-genScheme" data-url="${ctx}/gen/genScheme/edit?id='+ row.id+ '" data-modal-width="950"><i class=\"fa fa-lg fa-pencil\" title=\"编辑生成方案\"></i></a>'
                        + '<a href="javascript:void(0);" class="confirm" data-table-id="#data-table-genScheme" data-title="你确认要操作【'+ row.name+ '】生成方案吗？" data-url="${ctx}/gen/genScheme/lock/'+ row.id+ '"><i class=\"fa fa-lg fa-'+ (row.status == "正常" ? "unlock" : "lock") + '  font-yellow-gold\" title=\"'+ (row.status == "正常" ? "锁定" : "解锁") + '生成方案\"></i></a></span>'</#if>
                        <#if SecurityUtil.hasPermission('sys_genScheme_delete')>+ '<a href="javascript:void(0);" class="confirm" data-table-id="#data-table-genScheme" data-method="post" data-title="你确认要删除【'+ row.name+ '】生成方案吗？" data-url="${ctx}/gen/genScheme/delete/'+ row.id+ '"><i class=\"fa fa-lg fa-trash-o font-red-mint\" title=\"删除\"></i></a></span>';}</#if>
                        }
                    ]
                }
            });
            $(".filter-submit-table-genScheme").click(function () {
                grid.submitFilter();
            })
        };
        return {
            init: function () {
                if (!jQuery().dataTable) {
                    return;
                }
                initPickers();
                initTradeOrderTable();
            }
        };
    }();
    jQuery(document).ready(function () {
        dataTables.init();
    });
</script>
