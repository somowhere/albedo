<div class="row">
    <div class="col-md-2">
    <@albedo.treeShow id="dict_" title="字典" selectNodeId="nodeId" url="${ctx}/sys/dict/findTreeData?all"
    clickNodeFn="clickTreeNodeDict" allowCancelSelect="true" cancelClickNodeFn="cancelClickNodeDict" nodesLevel="1"> </@albedo.treeShow>
    </div>
    <div class="col-md-10">
        <!-- BEGIN EXAMPLE TABLE PORTLET-->
        <div class="portlet light bordered">
            <div class="portlet-title">
                <div class="caption font-blue">
                    数据列表
                </div>
                <div class="actions">
                    <div class="btn-group">
                    <#if SecurityUtil.hasPermission('sys_dict_edit')><a id="add-dict" class="btn red dialog"
                                                                        href="javascript:void(0);"
                                                                        data-url="${ctx}/sys/dict/edit"
                                                                        data-modal-width="950"
                                                                        data-reload-after="refreshTreeDict"
                                                                        data-is-modal="true"
                                                                        data-table-id="#data-table-dict">
                        <i class="fa fa-plus"> 添加字典</i>
                    </a></#if>
                    </div>
                </div>
            </div>
            <div class="portlet-body">
                <form class="form-inline form-search" dict="form">
                    <input id="parentId" name="parentId" type="hidden" operate="eq" searchItem="searchItem"/>
                    <div class="form-group">
                        <label class="input-label" for="loginId">名称 </label>
                        <input type="text" class="form-control" searchItem="searchItem" id="name" name="name"
                               placeholder="..."></div>
                    <div class="form-group">
                        <label class="input-label" for="loginId">编码 </label>
                        <input type="text" class="form-control" searchItem="searchItem" id="code" name="code"
                               placeholder="..."></div>
                    <div class="form-group">
                        <label class="input-label" for="loginId">key </label>
                        <input type="text" class="form-control" searchItem="searchItem" id="code" name="key"
                               placeholder="..."></div>
                    <div class="form-group">
                        <label class="input-label">状态</label>
                    <@albedo.form name="status" searchItem="searchItem" dictCode="sys_status" boxType="checkbox" operate="in" attrType="Integer"> </@albedo.form>
                    </div>
                    <div class="form-group form-btn">
                        <button class="btn btn-sm green btn-outline filter-submit-table-dict margin-bottom"
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
                       id="data-table-dict">
                    <thead>
                    <tr dict="row" class="heading">
                        <th width="10%" colspan="1"> 上级名称</th>
                        <th width="10%" colspan="1"> 名称</th>
                        <th width="10%"> 编码</th>
                        <th width="10%"> key</th>
                        <th width="10%"> 值</th>
                        <th width="10%"> 是否显示</th>
                        <th width="10%"> 序号</th>
                        <th width="10%"> 状态</th>
                        <th width="10%"> 修改时间</th>
                        <th width="10%"> 操作</th>
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
                src: $("#data-table-dict"),
                dataTable: {
                    "ajax": {
                        "url": "${ctx}/sys/dict/page",
                        type: 'GET',
                        "dataType": 'json'
                    }, order: [6, 'asc'],
                    "columns": [
                        {data: "parentName", name: "parent.name"}, {data: "name"},
                        {data: "code"}, {data: "key"},
                        {
                            data: "val", render: function (data, type, row) {
                            return albedo.subMaxStr(data, 20);
                        }
                        }, {data: "isShow"}, {data: "sort"},
                        {
                            data: "status", render: function (data, type, row) {
                            var cssClass = (data == "正常" ? "info" : "warning");
                            return '<span class="label label-sm label-' + cssClass + '">' + data + '</span>';
                        }
                        }, {data: "lastModifiedDate"},
                        {
                            orderable: false, data: function (row, type, val, meta) {
                            var data = '<span class="operation">'<#if SecurityUtil.hasPermission('sys_dict_edit')>+ '<a href="javascript:void(0);" class="dialog" data-table-id="#data-table-dict" data-reload-after="refreshTreeDict" data-is-modal="true" data-url="${ctx}/sys/dict/edit?id='+ row.id+ '" data-modal-width="950"><i class=\"fa fa-lg fa-pencil\" title=\"编辑字典\"></i></a>'</#if>
                                    <#if SecurityUtil.hasPermission('sys_dict_lock')>+ '<a href="javascript:void(0);" class="confirm" data-table-id="#data-table-dict" data-reload-after="refreshTreeDict" data-title="你确认要操作【'+ row.name+ '】字典吗？" data-url="${ctx}/sys/dict/lock/'+ row.id+ '"><i class=\"fa fa-lg fa-'+ (row.status == "正常" ? "unlock" : "lock") + '  font-yellow-gold\" title=\"'+ (row.status == "正常" ? "锁定" : "解锁") + '字典\"></i></a></span>'</#if>
                                    <#if SecurityUtil.hasPermission('sys_dict_delete')>+ '<a href="javascript:void(0);" class="confirm" data-table-id="#data-table-dict" data-reload-after="refreshTreeDict" data-title="你确认要删除【'+ row.name+ '】字典吗？" data-url="${ctx}/sys/dict/delete/'+ row.id+ '"><i class=\"fa fa-lg fa-trash-o font-red-mint\" title=\"删除\"></i></a>'</#if> + '</span>';
                            return data;
                        }
                        }
                    ]
                }
            });
            $(".filter-submit-table-dict").click(function () {
                $("#data-table-dict").DataTable().ajax.reload();
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
    var nodeId = albedo.getUserCookie("tree_dict_select_node_id"), nodeId = (nodeId) ? nodeId : 1,
            addUrl = $("#add-dict").attr("data-url");
    jQuery(document).ready(function () {
        dataTables.init();
    });
    function cancelClickNodeDict(event, treeId, treeNode) {
        albedo.setCookie("tree_dict_select_node_id", '');
        $("#parentId").val('');
        $(".filter-submit-table-dict").trigger("click");
    }
    function refreshTreeDict(re) {
        $(".tree-refresh").trigger("click");
    }
    function clickTreeNodeDict(event, treeId, treeNode) {
        nodeId = treeNode.id;
        albedo.setCookie("tree_dict_select_node_id", nodeId);
        if (addUrl) $("#add-dict").attr("data-url", addUrl + (addUrl.indexOf("?") == -1 ? "?" : "&") + "parentId=" + treeNode.id);
        $("#parentId").val(treeNode.id);
        $(".filter-submit-table-dict").trigger("click");
    }
</script>
