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
                        <label class="input-label" for="userLoginId">用户</label>
                        <input type="text" class="form-control" searchItem="searchItem" id="userLoginId"
                               name="user.loginId" htmlEscape="false" maxlength="254" placeholder="...">
                    </div>
                    <div class="form-group">
                        <label class="input-label" for="ipAddress">ip</label>
                        <input type="text" class="form-control" searchItem="searchItem" id="ipAddress" name="ipAddress"
                               htmlEscape="false" maxlength="254" placeholder="...">
                    </div>
                    <div class="form-group form-btn">
                        <button class="btn btn-sm green btn-outline filter-submit-table-persistentToken margin-bottom"
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
                       id="data-table-persistentToken">
                    <thead>
                    <tr role="row" class="heading">
                        <th width="10%"> 用户</th>
                        <th width="10%"> IP 位址</th>
                        <th width="10%"> 用户代理</th>
                        <th width="10%"> 创建日期</th>
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
    var dataPersistentTokenTables = function () {
        var initTradeOrderTable = function () {
            var grid = new Datatable();
            grid.init({
                src: $("#data-table-persistentToken"),
                dataTable: {
                    "ajax": {
                        "url": "${ctx}/sys/persistentToken/page",
                        type: 'GET',
                        "dataType": 'json'
                    },
                    "columns": [
                        {
                            data: 'userLoginId'
                        }
                        , {
                            data: 'ipAddress'
                        }
                        , {
                            data: 'userAgent'
                        }
                        , {
                            data: 'tokenDate'
                        },
                        {
                            orderable: false, data: function (row, type, val, meta) {
                            var data = '<span class="operation"><a href="javascript:void(0);" class="confirm" data-table-id="#data-table-persistentToken" data-method="delete" data-title="你确认要删除【' + row.userLoginId + '】的回话吗？" data-url="${ctx}/sys/persistentToken/delete/' + row.id + '"><i class=\"fa fa-lg fa-trash-o font-red-mint\" title=\"删除\"></i></a></span>';
                            return data;
                        }
                        }]
                }
            });
            $(".filter-submit-table-persistentToken").click(function () {
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
        dataPersistentTokenTables.init();
    });
</script>