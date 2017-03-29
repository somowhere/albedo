<!DOCTYPE html>
<!--[if IE 8]> <html lang="cn" class="ie8"> <![endif]-->
<!--[if IE 9]> <html lang="cn" class="ie9"> <![endif]-->
<!--[if !IE]><!-->
<html lang="cn"> <!--<![endif]-->
<head>
    <title>${application} - 用户管理</title>
    <link rel="shortcut icon" href="${assets}/pages/img/favicon.ico"/>
    <#include "/common/meta.html" />
    <#include "/common/page-header.html" />
</head>
<body class="page-container-bg-solid page-header-fixed page-sidebar-closed-hide-logo">
<!-- BEGIN HEADER -->
<#include "/common/page-top.html">  
<!-- END HEADER -->
<!-- BEGIN HEADER & CONTENT DIVIDER -->
<div class="clearfix"></div>
<!-- END HEADER & CONTENT DIVIDER -->
<!-- BEGIN CONTAINER -->
<div class="page-container">
    <!-- BEGIN SIDEBAR -->
    <#include "/common/page-left.html">
    <!-- END SIDEBAR -->
    <!-- BEGIN CONTENT -->
    <div class="page-content-wrapper">
        <!-- BEGIN CONTENT BODY -->
        <div class="page-content">
            <!-- BEGIN PAGE HEAD-->
            <!-- BEGIN PAGE HEAD-->
            <div class="page-head">
                <!-- BEGIN PAGE TITLE -->
                <div class="page-title">
                    <h1>用户管理</h1>
                </div>
            </div>
            <@albedo.breadcrumb> </@albedo.breadcrumb>
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
                                    <#if SecurityUtil.hasPermission('sys_user_edit')><a id="add-user" class="btn red dialog" href="javascript:void(0);" 
                                    data-url="${ctx}/sys/user/edit" data-modal-width="950" data-is-modal="" data-table-id="#data-table-user">
                                        <i class="fa fa-plus"> 添加用户</i>
                                    </a></#if>
                                </div>
                            </div>
                        </div>
                        <div class="portlet-body">
                        	<form class="form-inline form-search" role="form">
		                                 <div class="form-group">
		                                     <label class="input-label" for="loginId">登录Id </label>
		                                     <input type="text" class="form-control" searchItem="searchItem" id="loginId" name="loginId" placeholder="..."> </div>
		                                 <div class="form-group">
		                                     <label class="input-label" for="email">邮箱</label>
		                                     <input type="text" class="form-control" searchItem="searchItem" id="email" name="email" placeholder="..."> </div>
		                                 <div class="form-group">
		                                     <label class="input-label" >状态</label>
		                                     <@albedo.form name="status" searchItem="searchItem" dictCode="sys_status" boxType="checkbox" operate="in" attrType="Integer"> </@albedo.form></div>
		                                 <div class="form-group form-btn">
		                                 <button class="btn btn-sm green btn-outline filter-submit-table-user margin-bottom" type="button"><i class="fa fa-search"></i> 查询</button>
		                                 <button class="btn btn-sm red btn-outline filter-cancel" type="reset"><i class="fa fa-times"></i> 重置</button>
		                                 </div>
		                             </form>
		                             <hr />
		                    <div id="bootstrap-alerts"></div>
                            <table class="table table-striped table-bordered table-hover dataTable no-footer dtr-inline" id="data-table-user">
                                <thead>
                                <tr role="row" class="heading">
                                	<th width="10%" colspan="1"> 所属组织 </th>
                                    <th width="10%" colspan="1"> 登录Id </th>
                                    <th width="10%"> 邮箱 </th>
                                    <th width="20%"> 拥有角色 </th>
                                    <th width="10%"> 状态 </th>
                                    <th width="10%"> 修改时间 </th>
                                    <th width="10%"> 操作 </th>
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
        </div>
        <!-- END CONTENT BODY -->
    </div>
    <!-- END CONTENT -->
</div>
<!-- BEGIN FOOTER -->
<#include "/common/page-footer.html">
<script src="${assets}/global/plugins/bootstrap-summernote/summernote.min.js" type="text/javascript"></script>
<script src="${assets}/pages/scripts/components-select2.js" type="text/javascript"></script>
<!-- END FOOTER -->
<!-- END PAGE BASE CONTENT -->

<script type="text/javascript">
    var dataTables = function () {
        var initTradeOrderTable = function () {
            var grid = new Datatable();
            grid.init({
                src: $("#data-table-user"),
                dataTable: {
                    "ajax": {
                        "url": "${ctx}/sys/user/page",
                        type: 'GET',
                        "dataType": 'json'
                    },
                    "columns": [
                    	{ data: "orgName" },{ data: "loginId" },
                        { data: "email" },
                        { data: "roleNames", orderable: false},
                        { data: "status", render : function(data, type, row){
                        	var cssClass = (data == "正常" ? "info" : "warning");
                        	return '<span class="label label-sm label-'+cssClass+'">'+data+'</span>';
                        }},{ data: "lastModifiedDate"},
                        { orderable: false, data: function ( row, type, val, meta ) {
                        	var data = '<span class="operation">'<#if SecurityUtil.hasPermission('sys_user_edit')>+'<a href="javascript:void(0);" class="dialog" data-table-id="#data-table-user" data-url="${ctx}/sys/user/edit?id='+row.id+'" data-modal-width="950"><i class=\"fa fa-lg fa-pencil\" title=\"编辑用户\"></i></a>'</#if>
                            <#if SecurityUtil.hasPermission('sys_user_lock')>+'<a href="javascript:void(0);" class="confirm" data-table-id="#data-table-user" data-title="你确认要操作【'+row.loginId+'】用户吗？" data-url="${ctx}/sys/user/lock/'+row.id+'"><i class=\"fa fa-lg fa-'+(row.status=="正常" ? "unlock" : "lock") +'  font-yellow-gold\" title=\"'+(row.status=="正常" ? "锁定" : "解锁") +'用户\"></i></a></span>'</#if>
                    		<#if SecurityUtil.hasPermission('sys_user_delete')>+'<a href="javascript:void(0);" class="confirm" data-table-id="#data-table-user" data-method="delete" data-title="你确认要删除【'+row.loginId+'】用户吗？" data-url="${ctx}/sys/user/delete/'+row.id+'"><i class=\"fa fa-lg fa-trash-o font-red-mint\" title=\"删除\"></i></a>'</#if>+'</span>';
                            return data;
                        }}
                    ]
                }
            });
            $(".filter-submit-table-user").click(function(){
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
    jQuery(document).ready(function() {
        dataTables.init();
    });
</script>
</body>
</html>
