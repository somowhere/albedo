<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
    <h4 class="modal-title"><#if dict.id??>添加<#else>编辑</#if>字典</h4>
</div>
<div class="modal-body">
    <div class="row">
        <div class="col-md-12 form">
            <!-- BEGIN FORM-->
            <div id="bootstrap-alerts" class="bootstrap-alerts-dict-form"></div>
            <form id="ajax_form" action="${ctx}/sys/dict/edit" method="post"
                  class="form-horizontal form-validation form-bordered form-label-stripped" config="{rules:{
                       code: {remote: '${ctx}/sys/dict/checkByProperty?_statusFalse&id=' + encodeURIComponent('${dict.id!}')}},
                       messages:{code:{message:'字典编码已存在'}}}">
                <div class="form-body">
                    <input type="hidden" name="id" value="${(dict.id)!}"/>
                    <div class="form-group">
                        <label class="control-label col-md-3">上级字典<span class="required">*</span>
                        </label>
                        <div class="col-md-5">
                        <@albedo.treeSelect id="dict" cssClass="required" allowClear="true" name="parentId" value="${(dict.parentId)!}" labelName="parentName"
                        labelValue="${(dict.parent.name)!}" extId="${(dict.id)!}"
                        title="选择字典" url="${ctx}/sys/dict/findTreeData"> </@albedo.treeSelect>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-md-3">名称<span class="required">*</span>
                        </label>
                        <div class="col-md-5">
                            <input type="text" name="name" value="${(dict.name)! }" maxlength="64" data-required="1"
                                   class="form-control required"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-md-3">编码<span class="required">*</span>
                        </label>
                        <div class="col-md-5">
                            <input type="text" name="code" value="${(dict.code)! }" maxlength="64" data-required="1"
                                   class="form-control"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-md-3">key</label>
                        </label>
                        <div class="col-md-5">
                            <input type="text" name="key" value="${(dict.key)! }" maxlength="64" data-required="1"
                                   class="form-control"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">值</label>
                        <div class="col-md-5">
                            <textarea class="summernote form-control" name="val" rows="5">${(dict.val)! }</textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">是否显示<span class="required">*</span></label>
                        <div class="col-md-5">
                        <@albedo.form name="isShow" cssClass="required" boxType="radio" dictCode="sys_yes_no" value="${(dict.isShow)! }"> </@albedo.form>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-md-3">序号
                        </label>
                        <div class="col-md-5">
                            <input type="text" name="sort" value="${(dict.sort)! }" maxlength="10" data-required="1"
                                   class="form-control digits"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">状态<span class="required">*</span></label>
                        <div class="col-md-5">
                        <@albedo.form name="status" cssClass="required" boxType="radio" dictCode="sys_status" value="${(dict.status)! }"> </@albedo.form>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">描述</label>
                        <div class="col-md-8">
                            <textarea class="summernote form-control" name="description"
                                      rows="5">${(dict.description)! }</textarea>
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
