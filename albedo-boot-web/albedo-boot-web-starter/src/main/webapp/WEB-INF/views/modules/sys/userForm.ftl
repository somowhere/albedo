<div class="portlet light bordered">
    <div class="portlet-title">
        <div class="caption font-blue">
            <i class="fa fa-globe font-blue"></i><#if (userVo.id)??>编辑<#else>添加</#if>用户
        </div>
        <div class="actions">
            <div class="btn-group">
                <a id="user_list" class="btn red list" href="javascript:void(0);" data-table-id="#data-table-user">
                    <i class="fa fa-list"> 用户列表</i>
                </a>
            </div>
        </div>
    </div>
    <div class="portlet-body form form-no-modal">
        <!-- BEGIN FORM-->
        <div id="bootstrap-alerts"></div>
        <form id="ajax_form" action="${ctx}/sys/user/edit" method="post"
              class="form-horizontal form-validation form-bordered form-label-stripped"
              config="{rules:{
                       loginId: {remote: '${ctx}/sys/user/checkByProperty?_statusFalse&id=' + encodeURIComponent('${(userVo.id)!}')},
                       descption:{required:true}
                       },
                       messages:{loginId:{message:'登录Id已存在'}}}">
            <div class="form-body">
                <input type="hidden" name="id" value="${(userVo.id)!}"/>
                <div class="form-group">
                    <label class="control-label col-md-3">所属组织<span
                            class="required">*</span>
                    </label>
                    <div class="col-md-5"><@albedo.treeSelect id="org"
                    cssClass="required" allowClear="true" name="orgId"
                    value="${(userVo.orgId)!}" labelName="orgName"
                    labelValue="${(userVo.orgName)!}" title="选择组织"
                    url="${ctx}/sys/org/findTreeData"> </@albedo.treeSelect></div>
                </div>
                <div class="form-group">
                    <label class="control-label col-md-3">登录Id<span class="required">*</span>
                    </label>
                    <div class="col-md-5">
                        <input type="text" name="loginId" value="${(userVo.loginId)! }"
                               maxlength="64" data-required="1" class="form-control required"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label">密码<span
                            class="required">*</span></label>
                    <div class="col-md-5">
                        <input id="newPassword" name="password" type="password" value=""
                               htmlEscape="false" maxlength="64"
                               class="form-control ${(userVo.id)!'required'}"/> <#if (userVo.id)??><span
                            class="help-inline">若不修改密码，请留空。</span></#if>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label">确认密码</label>
                    <div class="col-md-5">
                        <input name="confirmPassword" type="password" value=""
                               htmlEscape="false" maxlength="64" class="form-control"
                               equalTo="#newPassword"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label">联系电话</label>
                    <div class="col-md-5">
                        <input name="phone" value="${(userVo.phone)! }" htmlEscape="false"
                               maxlength="32" class="form-control phone"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label">邮箱</label>
                    <div class="col-md-5">
                        <input name="email" value="${(userVo.email)! }" htmlEscape="false"
                               maxlength="32" class="form-control email"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label">状态<span
                            class="required">*</span></label>
                    <div class="col-md-5"><@albedo.form name="status"
                    cssClass="required" boxType="radio" dictCode="sys_status"
                    value="${(userVo.status)! }"> </@albedo.form></div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label">角色<span
                            class="required">*</span></label>
                    <div class="col-md-8"><@albedo.form name="roleIdList"
                    cssClass="required" data="${allRoles!}" boxType="checkbox"
                    value="${(userVo.roleIds)! }"> </@albedo.form></div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label">描述</label>
                    <div class="col-md-8">
                        <textarea class="summernote form-control" name="description"
                                  rows="5">${(userVo.description)! }</textarea>
                    </div>
                </div>
                <div class="form-actions">
                    <div class="row">
                        <div class="col-md-offset-3 col-md-9">
                            <button type="button" class="btn add green">
                                <i class="fa fa-check"></i> 保存
                            </button>
                            <button type="reset" class="btn default">重置</button>
                            <button type="button" class="btn list" data-table-id="#data-table-user">返回</button>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>
<script type="text/javascript">
    $(function () {
        $('.summernote').summernote({
            height: 200
        });
    })
</script>
