<div class="row">
    <div class="col-md-12">
        <!-- BEGIN EXAMPLE TABLE PORTLET-->
        <div class="portlet light bordered">
            <div class="portlet-title">
                <div class="caption font-blue">
                    <i class="fa fa-globe font-blue"></i>角色管理
                </div>
                <div class="actions">
                    <div class="btn-group">
                    <#if SecurityUtil.hasPermission('sys_role_edit')><a id="add_member" class="btn red dialog"
                                                                        href="javascript:void(0);"
                                                                        data-url="${ctx}/sys/role/edit"
                                                                        data-modal-width="950" data-no-modal="true"
                                                                        data-table-id="#data-table-role">
                        <i class="fa fa-plus"> 添加角色</i>
                    </a></#if>
                    </div>
                </div>
            </div>
            <div class="portlet-body">
                <form class="form-inline form-search" role="form">
                    <div class="form-group">
                        <label class="input-label" for="loginId">名称 </label>
                        <input type="text" class="form-control" searchItem="searchItem" id="name" name="name"
                               placeholder="..."></div>
                    <div class="form-group">
                        <label class="input-label">系统数据</label>
                    <@albedo.form name="sysData" searchItem="searchItem" dictCode="sys_yes_no" boxType="checkbox" operate="in" attrType="Integer"> </@albedo.form>
                    </div>
                    <div class="form-group">
                        <label class="input-label">状态</label>
                    <@albedo.form name="status" searchItem="searchItem" dictCode="sys_status" boxType="checkbox" operate="in" attrType="Integer"> </@albedo.form>
                    </div>
                    <div class="form-group form-btn">
                        <button class="btn btn-sm green btn-outline filter-submit-table-role margin-bottom"
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
                       id="data-table-role">
                    <thead>
                    <tr role="row" class="heading">
                        <th width="10%" colspan="1"> 所属组织</th>
                        <th width="10%" colspan="1"> 名称</th>
                        <th width="10%"> 是否系统数据</th>
                        <th width="10%"> 状态</th>
                        <th width="20%"> 修改时间</th>
                    <#if SecurityUtil.hasPermission('sys_role_edit,sys_role_lock,sys_role_delete')>
                        <th width="20%"> 操作</th></#if>
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
                src: $("#data-table-role"),
                dataTable: {
                    "ajax": {
                        "url": "${ctx}/sys/role/page",
                        type: 'GET',
                        "dataType": 'json'
                    },
                    "columns": [
                        {data: "orgName", name: "org.name"}, {data: "name"},
                        {
                            data: "sysData", render: function (data, type, row) {
                            var cssClass = (data == "是" ? "info" : "warning");
                            return '<span class="label label-sm label-' + cssClass + '">' + data + '</span>';
                        }
                        },

                        {
                            data: "status", render: function (data, type, row) {
                            var cssClass = (data == "正常" ? "info" : "warning");
                            return '<span class="label label-sm label-' + cssClass + '">' + data + '</span>';
                        }
                        }, {data: "lastModifiedDate"},
                    <#if SecurityUtil.hasPermission('sys_role_edit,sys_role_lock,sys_role_delete')> {
                        orderable: false, data: function (row, type, val, meta) {
                            var data = '<span class="operation">'<#if SecurityUtil.hasPermission('sys_role_edit')>+ '<a href="javascript:void(0);" class="dialog" data-table-id="#data-table-role" data-url="${ctx}/sys/role/edit?id='+ row.id+ '" data-modal-width="950"><i class=\"fa fa-lg fa-pencil\" title=\"编辑角色\"></i></a>'</#if>
                                        <#if SecurityUtil.hasPermission('sys_role_lock')>+ '<a href="javascript:void(0);" class="confirm" data-table-id="#data-table-role" data-title="你确认要操作【'+ row.name+ '】角色吗？" data-url="${ctx}/sys/role/lock/'+ row.id+ '"><i class=\"fa fa-lg fa-'+ (row.status == "正常" ? "unlock" : "lock") + '  font-yellow-gold\" title=\"'+ (row.status == "正常" ? "锁定" : "解锁") + '角色\"></i></a></span>'</#if>
                                        <#if SecurityUtil.hasPermission('sys_role_delete')>+ '<a href="javascript:void(0);" class="confirm" data-table-id="#data-table-role" data-title="你确认要删除【'+ row.name+ '】角色吗？" data-url="${ctx}/sys/role/delete/'+ row.id+ '"><i class=\"fa fa-lg fa-trash-o font-red-mint\" title=\"删除\"></i></a>'</#if> + '</span>';
                            return data;
                        }
                    }</#if>
                    ]
                }
            });
            $(".filter-submit-table-role").click(function () {
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
        dataTables.init();
    });
</script>
