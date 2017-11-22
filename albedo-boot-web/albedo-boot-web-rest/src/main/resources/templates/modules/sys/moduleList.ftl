<div class="row">
    <div class="col-md-2">
    <@albedo.treeShow id="module" title="模块" url="${ctx}/sys/module/findTreeData?all" selectNodeId="nodeId"
    clickNodeFn="clickTreeNodeModule" allowCancelSelect="true" cancelClickNodeFn="cancelClickNodeModule" nodesLevel="3"> </@albedo.treeShow>
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
                    <#if SecurityUtil.hasPermission('sys_module_edit')><a id="add-module" class="btn red dialog"
                                                                          href="javascript:void(0);"
                                                                          data-url="${ctx}/sys/module/edit"
                                                                          data-modal-width="950"
                                                                          data-reload-after="refreshTreeModule"
                                                                          data-table-id="#data-table-module">
                        <i class="fa fa-plus"> 添加模块</i>
                    </a></#if>
                    </div>
                </div>
            </div>
            <div class="portlet-body">
                <form class="form-inline form-search" module="form">
                    <input id="parentId" name="parentId" type="hidden" operate="eq" searchItem="searchItem"/>
                    <div class="form-group">
                        <label class="input-label" for="name">名称 </label>
                        <input type="text" class="form-control" searchItem="searchItem" id="name" name="name"
                               placeholder="..."></div>
                    <div class="form-group">
                        <label class="input-label" for="permission">权限 </label>
                        <input type="text" class="form-control" searchItem="searchItem" id="permission"
                               name="permission" placeholder="..."></div>
                    <div class="form-group">
                        <label class="input-label">类型</label>
                    <@albedo.form name="type" searchItem="searchItem" dictCode="sys_module_type" boxType="checkbox" operate="in" attrType="Integer"> </@albedo.form>
                    </div>
                    <div class="form-group">
                        <label class="input-label">状态</label>
                    <@albedo.form name="status" searchItem="searchItem" dictCode="sys_status" boxType="checkbox" operate="in" attrType="Integer"> </@albedo.form>
                    </div>
                    <div class="form-group form-btn">
                        <button class="btn btn-sm green btn-outline filter-submit-table-module margin-bottom"
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
                       id="data-table-module">
                    <thead>
                    <tr module="row" class="heading">
                        <th width="10%" colspan="1"> 名称</th>
                        <th width="10%"> 类型</th>
                        <th width="15%"> 权限</th>
                        <th width="10%"> 请求方法</th>
                        <th width="15%"> 链接</th>
                        <th width="10%"> 序号</th>
                        <th> 状态</th>
                        <th> 修改时间</th>
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
        var initTradeOrderTable = function () {
            var grid = new Datatable();
            grid.init({
                src: $("#data-table-module"),
                dataTable: {
                    "ajax": {
                        "url": "${ctx}/sys/module/page"
                    },
                    order: [5, 'asc'],
                    "columns": [
                        {
                            data: "name", render: function (data, type, row) {
                            <#if SecurityUtil.hasPermission('sys_module_edit')>data = '<a href="javascript:void(0);" class="dialog" data-table-id="#data-table-module" data-is-modal="" data-url="${ctx}/sys/module/edit?id=' + row.id + '" title=\"点击编辑模块\">' + data + '</a>'</#if>
                            return data;
                        }
                        },
                        {data: "type"},
                        {data: "permission"}, {data: "requestMethod"},
                        {data: "url"}, {data: "sort"},
                        {
                            data: "status", render: function (data, type, row) {
                            var cssClass = (data == "正常" ? "info" : "warning");
                            return '<span class="label label-sm label-' + cssClass + '">' + data + '</span>';
                        }
                        }, {data: "lastModifiedDate"},
                        {
                            orderable: false, data: function (row, type, val, meta) {
                            var data = '<span class="operation">'<#if SecurityUtil.hasPermission('sys_module_edit')>+ '<a href="javascript:void(0);" class="dialog" data-table-id="#data-table-module" data-url="${ctx}/sys/module/edit?id='+ row.id+ '" data-reload-after="refreshTreeModule" data-modal-width="950"><i class=\"fa fa-lg fa-pencil\" title=\"编辑机构\"></i></a>'</#if>
                                    <#if SecurityUtil.hasPermission('sys_module_lock')>+ '<a href="javascript:void(0);" class="confirm" data-table-id="#data-table-module" data-title="你确认要操作【'+ row.name+ '】模块吗？" data-url="${ctx}/sys/module/lock/'+ row.id+ '"><i class=\"fa fa-lg fa-'+ (row.status == "正常" ? "unlock" : "lock") + '  font-yellow-gold\" title=\"'+ (row.status == "正常" ? "锁定" : "解锁") + '模块\"></i></a></span>'</#if>
                                    <#if SecurityUtil.hasPermission('sys_module_delete')>+ '<a href="javascript:void(0);" class="confirm" data-table-id="#data-table-module" data-title="你确认要删除【'+ row.name+ '】模块吗？" data-reload-after="refreshTreeModule" data-url="${ctx}/sys/module/delete/'+ row.id+ '"><i class=\"fa fa-lg fa-trash-o font-red-mint\" title=\"删除\"></i></a>'</#if> + '</span>';
                            return data;
                        }
                        }
                    ]
                }
            });
            $(".filter-submit-table-module").click(function () {
                $("#data-table-module").DataTable().ajax.reload();
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
    var nodeId = albedo.getUserCookie("tree_module_select_node_id"), nodeId = (nodeId) ? nodeId : null,
            addUrl = $("#add-module").attr("data-url");
    jQuery(document).ready(function () {
        if (nodeId) $("#parentId").val(nodeId);
        dataTables.init();
    });
    function cancelClickNodeModule(event, treeId, treeNode) {
        albedo.setCookie("tree_module_select_node_id", '');
        $("#parentId").val('');
        $(".filter-submit-table-module").trigger("click");
    }
    function refreshTreeModule(re) {
        $(".module-portlet").find(".tree-refresh").trigger("click");
    }
    function clickTreeNodeModule(event, treeId, treeNode) {
        nodeId = treeNode.id;
        albedo.setCookie("tree_module_select_node_id", nodeId);
        if (addUrl) $("#add-module").attr("data-url", addUrl + (addUrl.indexOf("?") == -1 ? "?" : "&") + "parentId=" + treeNode.id);
        $("#parentId").val(treeNode.id);
        $(".filter-submit-table-module").trigger("click");
    }
</script>
