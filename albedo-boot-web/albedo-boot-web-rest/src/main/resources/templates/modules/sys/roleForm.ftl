<div class="portlet light bordered">
    <div class="portlet-title">
        <div class="caption font-blue">
            <i class="fa fa-globe font-blue"></i><#if roleVo.id??>编辑<#else>添加</#if>角色
        </div>
        <div class="actions">
            <div class="btn-group">
                <a id="user_list" class="btn red list" href="javascript:void(0);" data-table-id="#data-table-role">
                    <i class="fa fa-list"> 角色列表</i>
                </a>
            </div>
        </div>
    </div>
    <div class="portlet-body form form-no-modal">
        <!-- BEGIN FORM-->
        <div id="bootstrap-alerts" class="bootstrap-alerts-role-form"></div>
        <form id="ajax_form" action="${ctx}/sys/role/edit" method="post"
              class="form-horizontal form-validation form-bordered form-label-stripped" config="{rules:{
                       name: {remote: '${ctx}/sys/role/checkByProperty?_statusFalse&id=' + encodeURIComponent('${roleVo.id!}')}},
                       messages:{name:{message:'角色名称已存在'}}}" validateFun="submitRoleFormHandler">
            <div class="form-body">
                <input type="hidden" name="id" value="${(roleVo.id)!}"/>
                <div class="form-group">
                    <label class="control-label col-md-3">所属组织<span class="required">*</span>
                    </label>
                    <div class="col-md-5">
                    <@albedo.treeSelect id="org" cssClass="input_staff_type" allowClear="true" name="orgId" value="${(roleVo.orgId)!}" labelName="orgName"
                    labelValue="${(roleVo.orgName)!}"
                    title="选择组织" url="${ctx}/sys/org/findTreeData"> </@albedo.treeSelect>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-md-3">名称<span class="required">*</span>
                    </label>
                    <div class="col-md-5">
                        <input type="text" name="name" value="${(roleVo.name)! }" maxlength="64" data-required="1"
                               class="form-control required"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label">系统数据<span class="required">*</span></label>
                    <div class="col-md-5">
                    <@albedo.form name="sysData" cssClass="required" boxType="radio" dictCode="sys_yes_no" value="${(roleVo.sysData)! }"> </@albedo.form>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label">状态<span class="required">*</span></label>
                    <div class="col-md-5">
                    <@albedo.form name="status" cssClass="required" boxType="radio" dictCode="sys_status" value="${(roleVo.status)! }"> </@albedo.form>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label">数据权限<span class="required">*</span></label>
                    <div class="col-md-5">
                    <@albedo.form name="dataScope" id="dataScope" cssClass="required" boxType="select" dictCode="sys_role_scope" value="${(roleVo.dataScope)! }"> </@albedo.form>
                    </div>
                </div>
                <div class="form-group moduleIdList-div">
                    <label class="col-md-3 control-label">操作权限<span class="required">*</span></label>
                    <div class="col-md-2">
                    <#list (roleVo.moduleIdList)! as item><input id="moduleId" name="moduleIdList" type="hidden"
                                                               value="${item}"/></#list>
                        <div id="treeRoleModule" class="ztree"></div>
                    </div>
                    <label class="col-md-1 control-label treeRoleOrgBox hided">机构权限<span
                            class="required">*</span></label>
                    <div class="col-md-3 treeRoleOrgBox hided">
                    <#list (roleVo.orgIdList)! as item><input id="orgId" name="orgIdList" type="hidden"
                                                            value="${item}"/></#list>
                        <div id="treeRoleOrg" class="ztree"></div>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label">描述</label>
                    <div class="col-md-8">
                        <textarea class="summernote form-control" name="description"
                                  rows="5">${(roleVo.description)! }</textarea>
                    </div>
                </div>
                <div class="form-actions">
                    <div class="row">
                        <div class="col-md-offset-3 col-md-9">
                            <button type="button" class="btn add green">
                                <i class="fa fa-check"></i> 保存
                            </button>
                            <button type="reset" class="btn default">重置</button>
                            <button type="button" class="btn list" data-table-id="#data-table-role">返回</button>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>

<script type="text/javascript">
    var treeRoleModule, treeRoleOrg, data, setting = {
        view: {selectedMulti: false}, check: {enable: true, nocheckInherit: true},
        data: {key:{name:'label'},simpleData: {enable: true,idKey:'id',pIdKey: 'pid'}}
    };
    $(document).ready(function () {
        $.get("${ctx}/sys/module/findTreeData", function (rs) {
            if (rs && rs.status != 1) {
                toastr.warning(rs.message);
                return;
            }
            data = rs.data;
            // 初始化树结构
            treeRoleModule = $.fn.zTree.init($("#treeRoleModule"), setting, data);
            var nodes = treeRoleModule.expandAll(true);
            // 默认选择节点
            $("input[name='moduleIdList']").each(function () {
                var node = treeRoleModule.getNodeByParam("id", $(this).val());
                if (node) treeRoleModule.checkNode(node, true, false, false);
            });
        });
        $.get("${ctx}/sys/org/findTreeData", function (rs) {
            if (rs && rs.status != 1) {
                toastr.warning(rs.message);
                return;
            }
            data = rs.data;
            // 初始化树结构
            treeRoleOrg = $.fn.zTree.init($("#treeRoleOrg"), setting, data);
            var nodes = treeRoleOrg.expandAll(true);
            // 默认选择节点
            $("input[name='orgIdList']").each(function () {
                var node = treeRoleOrg.getNodeByParam("id", $(this).val());
                if (node) treeRoleOrg.checkNode(node, true, true, false);
            });
        });
        // 刷新（显示/隐藏）机构
        refreshOrgTree();
        $("#dataScope").on("select2:select", function () {
            refreshOrgTree();
        });
        function refreshOrgTree() {
            $("#dataScope").val() == 5 ? $(".treeRoleOrgBox").show() : $(".treeRoleOrgBox").hide();
        }
    });
    function submitRoleFormHandler() {
        var treeRoleModule = $.fn.zTree.getZTreeObj("treeRoleModule");
        if (treeRoleModule) {
            var nodes = treeRoleModule.getCheckedNodes();
            console.log(nodes);
            $('input[name=\'moduleIdList\']').remove();
            for (var o in nodes) {
                $('#treeRoleModule').before($('<input type=\'hidden\' name=\'moduleIdList\' />').val(nodes[o].id));
            }
        }
        var treeRoleOrg = $.fn.zTree.getZTreeObj("treeRoleOrg");
        if ($('#dataScope').val() == 5 && treeRoleOrg) {
            var nodes = treeRoleOrg.getCheckedNodes();
            $('input[name=\'orgIdList\']').remove();
            for (var i = 0; i < nodes.length; i++) {
                if (!nodes[i].getCheckStatus().half) //排除半选中状态
                    $('#treeRoleModule').before($('<input type=\'hidden\' name=\'orgIdList\' />').val(nodes[i].id));
            }
        }
        if (!$('input[name=\'moduleIdList\']').val()) {
            App.alert({
                container: $('.bootstrap-alerts-role-form'),
                closeInSeconds: 8,
                message: '请重新选择操作权限！',
            });
            return false;
        } else {
            return true;
        }
    }
</script>
