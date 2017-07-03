<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
    <h4 class="modal-title"><#if user.id??>添加<#else>编辑</#if>用户</h4>
</div>
<div class="modal-body">
    <div class="row">
        <div class="col-md-12 form">
            <div id="bootstrap-alerts"></div>
            <form id="ajax_form" action="${ctx}/sys/user/edit" method="post"
                  class="form-horizontal form-validation form-bordered form-label-stripped" config="{rules:{
                       loginId: {remote: '${ctx}/sys/user/checkByProperty?_statusFalse&id=' + encodeURIComponent('${user.id!}')},
                       descption:{required:true}
                       },
                       messages:{loginId:{message:'登录Id已存在'}}}">
                <div class="form-body">
                    <input type="hidden" name="id" value="${(user.id)!}"/>
                    <div class="form-group">
                        <label class="control-label col-md-3">所属组织<span class="required">*</span>
                        </label>
                        <div class="col-md-5">
                        <@albedo.treeSelect id="org" cssClass="input_staff_type" allowClear="true" name="orgId" value="${(user.orgId)!}" labelName="orgName"
                        labelValue="${(user.org.name)!}"
                        title="选择组织" url="${ctx}/sys/org/findTreeData"> </@albedo.treeSelect>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-md-3">登录Id<span class="required">*</span>
                        </label>
                        <div class="col-md-5">
                            <input type="text" name="loginId" value="${(user.loginId)! }" maxlength="64"
                                   data-required="1" class="form-control required"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">密码<span class="required">*</span></label>
                        <div class="col-md-5">
                            <input id="newPassword" name="password" type="password" value="" htmlEscape="false"
                                   maxlength="64" class="form-control ${(user.id)!'required'}"/>
                        <#if (user.id)??><span class="help-inline">若不修改密码，请留空。</span></#if>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">确认密码</label>
                        <div class="col-md-5">
                            <input name="confirmPassword" type="password" value="" htmlEscape="false" maxlength="64"
                                   class="form-control" equalTo="#newPassword"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">邮箱</label>
                        <div class="col-md-5">
                            <input name="email" value="${(user.email)! }" htmlEscape="false" maxlength="32"
                                   class="form-control email"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">状态<span class="required">*</span></label>
                        <div class="col-md-5">
                        <@albedo.form name="status" cssClass="required" boxType="checkbox" dictCode="sys_status" value="${(user.status)! }"> </@albedo.form>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">角色<span class="required">*</span></label>
                        <div class="col-md-8">
                        <@albedo.form name="roleIdList" cssClass="required" data="${allRoles!}" boxType="checkbox" value="${(user.roleIds)! }"> </@albedo.form>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">描述</label>
                        <div class="col-md-8">
                            <textarea class="summernote form-control" name="description"
                                      rows="9">${(user.description)! }</textarea>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<div class="modal-footer">
    <button type="button" class="btn blue add">保存</button>
    <button type="button" class="btn default" data-dismiss="modal">取消</button>
</div>
<script type="text/javascript">
    $(function () {
        $('.summernote').summernote({height: 200});
    })
</script>
