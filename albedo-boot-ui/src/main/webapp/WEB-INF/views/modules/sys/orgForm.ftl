<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
    <h4 class="modal-title"><#if orgVo.id??>添加<#else>编辑</#if>组织</h4>
</div>
<div class="modal-body">
    <div class="row">
        <div class="col-md-12 form">
            <!-- BEGIN FORM-->
            <div id="bootstrap-alerts" class="bootstrap-alerts-org-form"></div>
            <form id="ajax_form" action="${ctx}/sys/org/edit" method="post"
                  class="form-horizontal form-validation form-bordered form-label-stripped" config="{rules:{
                       name: {remote: '${ctx}/sys/org/checkByProperty?_statusFalse&id=' + encodeURIComponent('${orgVo.id!}')}},
                       messages:{name:{message:'组织名称已存在'}}}">
                <div class="form-body">
                    <input type="hidden" name="id" value="${(orgVo.id)!}"/>
                    <div class="form-group">
                        <label class="control-label col-md-3">上级组织<span class="required">*</span>
                        </label>
                        <div class="col-md-5">
                        <@albedo.treeSelect id="org" cssClass="required" allowClear="true" name="parentId" value="${(orgVo.parentId)!}" labelName="parentName"
                        labelValue="${(orgVo.parentName)!}" extId="${(orgVo.id)!}"
                        title="选择组织" url="${ctx}/sys/org/findTreeData"> </@albedo.treeSelect>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-md-3">名称<span class="required">*</span>
                        </label>
                        <div class="col-md-5">
                            <input type="text" name="name" value="${(orgVo.name)! }" maxlength="64" data-required="1"
                                   class="form-control required"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-md-3">编码
                        </label>
                        <div class="col-md-5">
                            <input type="text" name="code" value="${(orgVo.code)! }" maxlength="64" data-required="1"
                                   class="form-control"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">类型<span class="required">*</span></label>
                        <div class="col-md-5">
                        <@albedo.form name="type" id="type" cssClass="required" boxType="select" dictCode="sys_org_type" value="${(orgVo.type)! }"> </@albedo.form>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">等级<span class="required">*</span></label>
                        <div class="col-md-5">
                        <@albedo.form name="grade" id="grade" cssClass="required" boxType="select" dictCode="sys_org_grade" value="${(orgVo.grade)! }"> </@albedo.form>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-md-3">序号
                        </label>
                        <div class="col-md-5">
                            <input type="text" name="sort" value="${(orgVo.sort)! }" maxlength="10" data-required="1"
                                   class="form-control digits"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">状态<span class="required">*</span></label>
                        <div class="col-md-5">
                        <@albedo.form name="status" cssClass="required" boxType="radio" dictCode="sys_status" value="${(orgVo.status)! }"> </@albedo.form>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">描述</label>
                        <div class="col-md-8">
                            <textarea class="summernote form-control" name="description"
                                      rows="9">${(orgVo.description)! }</textarea>
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
