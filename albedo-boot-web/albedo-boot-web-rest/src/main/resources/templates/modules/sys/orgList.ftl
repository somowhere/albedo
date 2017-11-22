<div class="row">
    <div class="col-md-2">
    <@albedo.treeShow id="org_" title="组织机构" selectNodeId="nodeId" url="${ctx}/sys/org/findTreeData?all"
    clickNodeFn="clickTreeNodeOrg" allowCancelSelect="true" cancelClickNodeFn="cancelClickNodeOrg" nodesLevel="3"> </@albedo.treeShow>
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
                    <#if SecurityUtil.hasPermission('sys_org_edit')><a id="add-org" class="btn red dialog"
                                                                       href="javascript:void(0);"
                                                                       data-url="${ctx}/sys/org/edit"
                                                                       data-modal-width="950"
                                                                       data-reload-after="refreshTreeOrg"
                                                                       data-is-modal="true"
                                                                       data-table-id="#data-table-org">
                        <i class="fa fa-plus"> 添加组织</i>
                    </a></#if>
                    </div>
                </div>
            </div>
            <div class="portlet-body">
                <form class="form-inline form-search" org="form">
                    <input id="parentId" name="parentId" type="hidden" operate="eq" searchItem="searchItem"/>
                    <div class="form-group">
                        <label class="input-label" for="loginId">登录Id </label>
                        <input type="text" class="form-control" searchItem="searchItem" id="name" name="name"
                               placeholder="..."></div>
                    <div class="form-group">
                        <label class="input-label">状态</label>
                    <@albedo.form name="status" searchItem="searchItem" dictCode="sys_status" boxType="checkbox" operate="in" attrType="Integer"> </@albedo.form>
                    </div>
                    <div class="form-group form-btn">
                        <button class="btn btn-sm green btn-outline filter-submit-table-org margin-bottom"
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
                       id="data-table-org">
                    <thead>
                    <tr org="row" class="heading">
                        <th width="10%" colspan="1"> 名称</th>
                        <th width="10%"> 编码</th>
                        <th width="10%"> 类型</th>
                        <th width="10%"> 等级</th>
                        <th width="10%"> 序号</th>
                        <th width="10%"> 状态</th>
                        <th width="10%"> 修改时间</th>
                    <#if SecurityUtil.hasPermission('sys_org_edit,sys_org_lock,sys_org_delete')>
                        <th width="10%"> 操作</th></#if>
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
                src: $("#data-table-org"),
                dataTable: {
                    "ajax": {
                        "url": "${ctx}/sys/org/page",
                        type: 'GET',
                        "dataType": 'json'
                    },
                    "columns": [
                        {data: "name"}, {data: "code"},
                        {data: "type"},
                        {data: "grade"}, {data: "sort"},
                        {
                            data: "status", render: function (data, type, row) {
                            var cssClass = (data == "正常" ? "info" : "warning");
                            return '<span class="label label-sm label-' + cssClass + '">' + data + '</span>';
                        }
                        }, {data: "lastModifiedDate"},
                        <#if SecurityUtil.hasPermission('sys_org_edit,sys_org_lock,sys_org_delete')>{
                            orderable: false, data: function (row, type, val, meta) {
                            var data = '<span class="operation">'<#if SecurityUtil.hasPermission('sys_org_edit')>+ '<a href="javascript:void(0);" class="dialog" data-table-id="#data-table-org" data-reload-after="refreshTreeOrg" data-url="${ctx}/sys/org/edit?id='+ row.id+ '" data-is-modal="true" data-modal-width="950"><i class=\"fa fa-lg fa-pencil\" title=\"编辑机构\"></i></a>'</#if>
                                        <#if SecurityUtil.hasPermission('sys_org_lock')>+ '<a href="javascript:void(0);" class="confirm" data-table-id="#data-table-org" data-title="你确认要操作【'+ row.name+ '】机构吗？" data-url="${ctx}/sys/org/lock/'+ row.id+ '"><i class=\"fa fa-lg fa-'+ (row.status == "正常" ? "unlock" : "lock") + '  font-yellow-gold\" title=\"'+ (row.status == "正常" ? "锁定" : "解锁") + '机构\"></i></a></span>'</#if>
                                        <#if SecurityUtil.hasPermission('sys_org_delete')>+ '<a href="javascript:void(0);" class="confirm" data-table-id="#data-table-org" data-title="你确认要删除【'+ row.name+ '】机构吗？" data-url="${ctx}/sys/org/delete/'+ row.id+ '"><i class=\"fa fa-lg fa-trash-o font-red-mint\" title=\"删除\"></i></a>'</#if> + '</span>';
                            return data;
                        }
                        }</#if>
                    ]
                }
            });
            $(".filter-submit-table-org").click(function () {
                $("#data-table-org").DataTable().ajax.reload();
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
    var nodeId = albedo.getUserCookie("tree_org_select_node_id"), nodeId = (nodeId) ? nodeId : 1;
    jQuery(document).ready(function () {
        $("#add-org").attr("data-url-temp", $("#add-org").attr("data-url"));
        dataTables.init();
    });
    function cancelClickNodeOrg(event, treeId, treeNode) {
        albedo.setCookie("tree_org_select_node_id", '');
        $("#parentId").val('');
        $(".filter-submit-table-org").trigger("click");
    }
    function refreshTreeOrg(re) {
        $(".tree-refresh").trigger("click");
    }
    function clickTreeNodeOrg(event, treeId, treeNode) {
        var addUrl = $("#add-org").attr("data-url-temp");
        if (addUrl) $("#add-org").attr("data-url", addUrl + (addUrl.indexOf("?") == -1 ? "?" : "&") + "parentId=" + treeNode.id);
        nodeId = treeNode.id;
        albedo.setCookie("tree_org_select_node_id", nodeId);
        $("#parentId").val(treeNode.id);
        $(".filter-submit-table-org").trigger("click");
    }
</script>
