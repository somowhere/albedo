<div class="portlet light bordered">
    <div class="portlet-title">
        <div class="caption font-blue">
            <i class="fa fa-globe font-blue"></i><#if moduleVo.id??>编辑<#else>添加</#if>模块
        </div>
        <div class="actions">
            <div class="btn-group">
                <a id="user_list" class="btn red list" href="javascript:void(0);" data-table-id="#data-table-module">
                    <i class="fa fa-list"> 模块列表</i>
                </a>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12 form form-no-modal">
            <!-- BEGIN FORM-->
            <div id="bootstrap-alerts" class="bootstrap-alerts-module-form"></div>
            <form id="ajax_form" action="${ctx}/sys/module/edit" method="post"
                  class="form-horizontal form-validation form-bordered form-label-stripped" config="{rules:{
                       permission: {remote: '${ctx}/sys/module/checkByProperty?_statusFalse&id=' + encodeURIComponent('${moduleVo.id!}')}},
                       messages:{permission:{message:'权限名称已存在'}}}">
                <div class="form-body">
                    <input type="hidden" name="id" value="${(moduleVo.id)!}"/>
                    <div class="form-group">
                        <label class="control-label col-md-3">上级模块<span class="required">*</span>
                        </label>
                        <div class="col-md-5">
                        <@albedo.treeSelect id="module" cssClass="required" allowClear="true" name="parentId" value="${(moduleVo.parentId)!}" labelName="parentName"
                        labelValue="${(moduleVo.parentName)!}" extId="${(moduleVo.id)!}"
                        title="选择模块" url="${ctx}/sys/module/findTreeData"> </@albedo.treeSelect>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-md-3">名称<span class="required">*</span>
                        </label>
                        <div class="col-md-5">
                            <input type="text" name="name" value="${(moduleVo.name)! }" maxlength="64" data-required="1"
                                   class="form-control required"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-md-3">服务名称
                        </label>
                        <div class="col-md-5">
                            <input type="text" name="microservice" value="${(moduleVo.microservice)! }" maxlength="64" data-required="1"
                                   class="form-control"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-md-3">类型<span class="required">*</span>
                        </label>
                        <div class="col-md-5">
                        <@albedo.form name="type" cssClass="required" boxType="select" dictCode="sys_module_type" value="${(moduleVo.type)! }"> </@albedo.form>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-md-3">图标
                        </label>
                        <div class="col-md-5">
                            <input type="text" name="iconCls" value="${(moduleVo.iconCls)! }" maxlength="64"
                                   data-required="1" class="form-control"/>
                            <span class="help-inline"><a href="${ctx}/sys/module/ico" target="_blank">选择图标</a></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-md-3">权限<span class="required">*</span>
                        </label>
                        <div class="col-md-5">
                            <input type="text" name="permission" value="${(moduleVo.permission)! }" maxlength="64"
                                   data-required="1" class="form-control"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-md-3">操作目标
                        </label>
                        <div class="col-md-5">
                            <input type="text" name="target" value="${(moduleVo.target)! }" maxlength="64"
                                   data-required="1" class="form-control"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-md-3">链接
                        </label>
                        <div class="col-md-5">
                            <input type="text" name="url" value="${(moduleVo.url)! }" maxlength="255" data-required="1"
                                   class="form-control "/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-md-3">请求方法 </label>
                        <div class="col-md-5">
                        <@albedo.form name="requestMethod" cssClass="" boxType="checkbox" dictCode="sys_request_method" value="${(moduleVo.requestMethod)! }"> </@albedo.form>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-md-3">序号
                        </label>
                        <div class="col-md-5">
                            <input type="text" name="sort" value="${(moduleVo.sort)! }" maxlength="10" data-required="1"
                                   class="form-control digits"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">状态<span class="required">*</span></label>
                        <div class="col-md-5">
                        <@albedo.form name="status" cssClass="required" boxType="radio" dictCode="sys_status" value="${(moduleVo.status)! }"> </@albedo.form>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-3 control-label">描述</label>
                        <div class="col-md-8">
                            <textarea class="summernote form-control" name="description"
                                      rows="4">${(moduleVo.description)! }</textarea>
                        </div>
                    </div>
                    <div class="form-actions">
                        <div class="row">
                            <div class="col-md-offset-3 col-md-9">
                                <button type="button" class="btn add green">
                                    <i class="fa fa-check"></i> 保存
                                </button>
                                <button type="reset" class="btn default">重置</button>
                                <button type="button" class="btn list" data-table-id="#data-table-module">返回</button>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
