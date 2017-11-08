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
                    <#if SecurityUtil.hasPermission('gen_genTable_edit')>
                        <a class="btn red dialog-before" href="javascript:void(0);" <i class="fa fa-plus"> 添加业务表</i>
                        </a><a id="add-genTable" class="btn red dialog hide" href="javascript:void(0);"
                               data-url="${ctx}/gen/genTable/edit" data-modal-width="950" data-is-modal=""
                               data-table-id="#data-table-genTable">
                        <i class="fa fa-plus"> 添加业务表</i>
                    </a>
                    </#if>
                    </div>

                </div>
            </div>
            <div class="portlet-body">
                <form class="form-inline form-search" role="form">
                    <div class="form-group">
                        <label class="input-label" for="loginId">表名 </label>
                        <input type="text" class="form-control" searchItem="searchItem" id="name" name="name"
                               placeholder="..."></div>
                    <div class="form-group">
                        <label class="input-label" for="comments">说明</label>
                        <input type="text" class="form-control" searchItem="searchItem" id="comments" name="comments"
                               placeholder="..."></div>
                    <div class="form-group">
                        <label class="input-label" for="parentTable">父表名</label>
                        <input type="text" class="form-control" searchItem="searchItem" id="parentTable"
                               name="parentTable" placeholder="..."></div>
                    <div class="form-group">
                        <label class="input-label">状态</label>
                    <@albedo.form name="status" searchItem="searchItem" dictCode="sys_status" boxType="checkbox" operate="in" attrType="Integer"> </@albedo.form>
                    </div>
                    <div class="form-group form-btn">
                        <button class="btn btn-sm green btn-outline filter-submit-table-genTable margin-bottom"
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
                       id="data-table-genTable">
                    <thead>
                    <tr role="row" class="heading">
                        <th width="10%" colspan="1"> 表名</th>
                        <th width="10%" colspan="1"> 说明</th>
                        <th width="10%"> 类名</th>
                        <th width="20%"> 父表名</th>
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
        <div id="genTable-dialog-before" class="modal fade confirm-modal modal-confirm-dialog" aria-hidden="true">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                <h4 class="modal-title">选择业务表</h4>
            </div>
            <div class="modal-body">
                <div id="bootstrap-alerts"></div>
                <form id="genTable-form-before" class="form-horizontal">
                    <div class="form-group">
                        <label class="control-label col-md-2">表名</label>
                        <div class="col-md-10">
                            <div class="col-md-11">
                            <@albedo.form id="tableName" name="tableName" cssClass="required" data="${tableList!}" boxType="select" > </@albedo.form></div>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button class="btn dark btn-outline" data-dismiss="modal" aria-hidden="true">关闭</button>
                <button class="btn btn-confirm-before green">确认</button>
            </div>
        </div>
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
        var initGenTableTable = function () {
            var grid = new Datatable();
            grid.init({
                src: $("#data-table-genTable"),
                dataTable: {
                    "ajax": {
                        "url": "${ctx}/gen/genTable/page",
                        type: 'GET',
                        "dataType": 'json'
                    },
                    /*responsive: {
                        details: {
                            type: 'column'
                        }
                    },*/
                    "columns": [
                        {data: "name"}, {data: "comments"},
                        {data: "className"},
                        {data: "parentTable"},
                        {
                            data: "status", data: function (row, type, val, meta) {
                            var cssClass = (row.status == "正常" ? "info" : "warning");
                            return '<span class="label label-sm label-' + cssClass + '">' + row.status + '</span>';
                        }
                        }, {data: "lastModifiedDate"},
                        {
                            orderable: false, data: function (row, type, val, meta) {
                        return '<span class="operation">'
                        <#if SecurityUtil.hasPermission('gen_genTable_edit')>+ '<a href="javascript:void(0);" class="dialog" data-table-id="#data-table-genTable" data-url="${ctx}/gen/genTable/edit?id='+ row.id+ '" data-modal-width="950"><i class=\"fa fa-lg fa-pencil\" title=\"编辑业务表\"></i></a>'
                        + '<a href="javascript:void(0);" class="confirm" data-table-id="#data-table-genTable" data-title="你确认要操作【'+ row.name+ '】业务表吗？" data-url="${ctx}/gen/genTable/lock/'+ row.id+ '"><i class=\"fa fa-lg fa-'+ (row.status == "正常" ? "unlock" : "lock") + '  font-yellow-gold\" title=\"'+ (row.status == "正常" ? "锁定" : "解锁") + '业务表\"></i></a></span>'</#if>
                        <#if SecurityUtil.hasPermission('gen_genTable_delete')>+ '<a href="javascript:void(0);" class="confirm" data-table-id="#data-table-genTable" data-title="你确认要删除【'+ row.name+ '】业务表吗？" data-url="${ctx}/gen/genTable/delete/'+ row.id+ '"><i class=\"fa fa-lg fa-trash-o font-red-mint\" title=\"删除\"></i></a></span>';}</#if>
                        }
                    ]
                }
            });
            $(".filter-submit-table-genTable").click(function () {
                grid.submitFilter();
            })
        };
        return {
            init: function () {
                if (!jQuery().dataTable) {
                    return;
                }
                initPickers();
                initGenTableTable();
            }
        };
    }();
    jQuery(document).ready(function () {
        dataTables.init();
        $(".dialog-before").click(function () {
            $("#genTable-dialog-before").modal({width: 640});
            FormValidation.init($("#genTable-form-before"));
        })
        $(".btn-confirm-before").click(function () {
            if (FormValidation.validate()) {
                $("#genTable-dialog-before").modal("hide");
                $("#add-genTable").attr("data-url", $("#add-genTable").data("url") + "?name=" + $("#tableName").val()).trigger("click");
            }
        })

    });
</script>
