<div class="row">
    <div class="col-md-2">
    <@albedo.treeShow id="area_" title="区域管理" selectNodeId="nodeId" url="${ctx}/sys/area/findTreeData?all"
    clickNodeFn="clickTreeNodeArea" allowCancelSelect="true" cancelClickNodeFn="cancelClickNodeArea" nodesLevel="1"> </@albedo.treeShow>
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
                    <#if SecurityUtil.hasPermission('sys_area_edit')><a id="add-area" class="btn red dialog"
                                                                        href="javascript:void(0);"
                                                                        data-url="${ctx}/sys/area/edit"
                                                                        data-reload-after="refreshTreeArea"
                                                                        data-is-modal="true" data-modal-width="950"
                                                                        data-table-id="#data-table-area">
                        <i class="fa fa-plus"> 添加区域管理</i>
                    </a></#if>
                    </div>
                </div>
            </div>
            <div class="portlet-body">
                <form class="form-inline form-search" area="form">
                    <input id="parentId" name="parentId" type="hidden" operate="eq" searchItem="searchItem"/>
                    <div class="form-group">
                        <label class="input-label" for="name">区域名称</label>
                        <input type="text" class="form-control" searchItem="searchItem" id="name" name="name"
                               value="${(area.name)!}" operation="like" htmlEscape="false" maxlength="32"
                               placeholder="...">
                    </div>
                    <div class="form-group">
                        <label class="input-label" for="code">区域编码</label>
                        <input type="text" class="form-control" searchItem="searchItem" id="code" name="code"
                               value="${(area.code)!}" operation="like" htmlEscape="false" maxlength="32"
                               placeholder="...">
                    </div>
                    <div class="form-group form-btn">
                        <button class="btn btn-sm green btn-outline filter-submit-table-area margin-bottom"
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
                       id="data-table-area">
                    <thead>
                    <tr area="row" class="heading">
                        <th class=""> 区域名称</th>
                        <th class=""> 编码</th>
                        <th class=""> 区域简称</th>
                        <th class=""> 序号</th>
                        <th class=""> 区域等级</th>
                        <th class=""> 区域编码</th>
                        <th> 状态</th>
                    <#if SecurityUtil.hasPermission('sys_area_edit,sys_area_delete,sys_area_lock')>
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
    var dataAreaTables = function () {
        var initTradeOrderTable = function () {
            var grid = new Datatable();
            grid.init({
                src: $("#data-table-area"),
                dataTable: {
                    "ajax": {
                        "url": "${ctx}/sys/area/page",
                        type: 'GET',
                        "dataType": 'json'
                    },
                    "columns": [
                        {
                            data: 'name'
                            , render: function (data, type, row) {
                            <#if SecurityUtil.hasPermission('sys_area_edit')>data = '<a href="javascript:void(0);" class="dialog" data-table-id="#data-table-area" data-is-modal="true" data-url="${ctx}/sys/area/edit?id=' + row.id + '" title=\"点击编辑区域管理\">' + data + '</a>'</#if>
                            return data;
                        }
                        }, {
                            data: 'id'
                        }
                        , {
                            data: 'shortName'
                        }
                        , {
                            data: 'sort'
                        }
                        , {
                            data: 'level'
                        }
                        , {
                            data: 'code'
                        }
                        , {
                            data: 'status', render: function (data, type, row) {
                                var temp = '<span class="label label-sm label-' + (data == "正常" ? "info" : "warning") + '">' + data + '</span>';
                                <#if SecurityUtil.hasPermission('sys_area_lock')>temp = '<a href="javascript:void(0);" class="confirm" data-table-id="#data-table-area" data-method="delete" data-title="你确认要操作选中的区域管理吗？" data-url="${ctx}/sys/area/lock/' + row.id + '" title=\"' + (row.status == "正常" ? "锁定" : "解锁") + '区域管理\">' + temp + '</a></span>';</#if>
                                return temp;
                            }
                        }
                    <#if SecurityUtil.hasPermission('sys_area_edit,sys_area_delete,sys_area_lock')>,
                        {
                            orderable: false, data: function (row, type, val, meta) {
                            var data = '<span class="operation">'<#if SecurityUtil.hasPermission('sys_area_edit')>+ '<a href="javascript:void(0);" class="dialog" data-table-id="#data-table-area" data-reload-after="refreshTreeArea" data-is-modal="true" data-modal-width="950" data-url="${ctx}/sys/area/edit?id='+ row.id+ '"><i class=\"fa fa-lg fa-pencil\" title=\"编辑区域管理\"></i></a>'</#if>
                                        <#if SecurityUtil.hasPermission('sys_area_lockOrUnLock')>+ '<a href="javascript:void(0);" class="confirm" data-table-id="#data-table-area" data-title="你确认要操作选中的区域管理吗？" data-url="${ctx}/sys/area/lock/'+ row.id+ '"><i class=\"fa fa-lg fa-'+ (row.status == "正常" ? "unlock" : "lock") + '  font-yellow-gold\" title=\"'+ (row.status == "正常" ? "锁定" : "解锁") + '区域管理\"></i></a></span>'</#if>
                                        <#if SecurityUtil.hasPermission('sys_area_delete')>+ '<a href="javascript:void(0);" class="confirm" data-table-id="#data-table-area" data-reload-after="refreshTreeArea" data-title="你确认要删除选中的区域管理吗？" data-url="${ctx}/sys/area/delete/'+ row.id+ '"><i class=\"fa fa-lg fa-trash-o font-red-mint\" title=\"删除\"></i></a></span>'</#if> + '<\span>';
                            return data;
                        }
                        }</#if>
                    ]
                }
            });
            $(".filter-submit-table-area").click(function () {
                $("#data-table-area").DataTable().ajax.reload();
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
    var nodeId = albedo.getUserCookie("tree_area_select_node_id"), nodeId = (nodeId) ? nodeId : 1,
            addUrl = $("#add-area").attr("data-url");
    ;
    jQuery(document).ready(function () {
        dataAreaTables.init();
    });
    function cancelClickNodeArea(event, treeId, treeNode) {
        albedo.setCookie("tree_area_select_node_id", '');
        $("#parentId").val('');
        $(".filter-submit-table-area").trigger("click");
    }
    function refreshTreeArea(re) {
        $(".tree-refresh").trigger("click");
    }
    function clickTreeNodeArea(event, treeId, treeNode) {
        nodeId = treeNode.id;
        albedo.setCookie("tree_area_select_node_id", nodeId);
        if (addUrl) $("#add-area").attr("data-url", addUrl + (addUrl.indexOf("?") == -1 ? "?" : "&") + "parentId=" + treeNode.id);
        $("#parentId").val(treeNode.id);
        $(".filter-submit-table-area").trigger("click");
    }
</script>
</body>
</html>