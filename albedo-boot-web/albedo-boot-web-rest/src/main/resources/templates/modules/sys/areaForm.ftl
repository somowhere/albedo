<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
    <h4 class="modal-title"><#if areaVo.id??>添加<#else>编辑</#if>区域管理</h4>
</div>
<div class="modal-body">
    <div class="row">
        <div class="col-md-12 form">
            <!-- BEGIN FORM-->
            <div id="bootstrap-alerts"></div>
            <form id="ajax_form" action="${ctx}/sys/area/edit" method="post"
                  class="form-horizontal form-validation form-bordered form-label-stripped"
                  config="{rules:{
						code: {remote: '${ctx}/sys/area/checkByProperty?id=' + encodeURIComponent('${(areaVo.id)!} />')},
						},
                       messages:{
						code: {remote: '区域编码已存在'},
					   }}}">
                <div class="form-body">
                    <input type="hidden" name="id" value="${(areaVo.id)!}"/>
                    <div class="form-group">
                        <label class="control-label col-md-3">上级区域<span class="required">*</span>
                        </label>
                        <div class="col-md-5">
                        <@albedo.treeSelect id="area" cssClass="required" allowClear="true" name="parentId" value="${(areaVo.parentId)!}" labelName="parentName"
                        labelValue="${(areaVo.parentName)!}" extId="${(areaVo.id)!}" title="选择上级区域管理" url="${ctx}/sys/area/findTreeData"> </@albedo.treeSelect>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-md-3">区域名称</label>
                        <div class="col-md-5">
                            <input type="text" class="form-control " id="name" name="name" value="${(areaVo.name)!}"
                                   htmlEscape="false" maxlength="32" class="">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-md-3">区域简称</label>
                        <div class="col-md-5">
                            <input type="text" class="form-control " id="shortName" name="shortName"
                                   value="${(areaVo.shortName)!}" htmlEscape="false" maxlength="32" class="">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-md-3">序号<span class="required">*</span></label>
                        <div class="col-md-5">
                            <input type="text" class="form-control required" id="sort" name="sort"
                                   value="${(areaVo.sort)!}" htmlEscape="false" maxlength="11" class="required digits">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-md-3">区域等级</label>
                        <div class="col-md-5">
                        <@albedo.form name="level" dictCode="sys_area_type" cssClass="" boxType="select" value="${(areaVo.level)!}" > </@albedo.form>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-md-3">区域编码</label>
                        <div class="col-md-5">
                            <input type="text" class="form-control " id="code" name="code" value="${(areaVo.code)!}"
                                   htmlEscape="false" maxlength="32" class="">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-md-3">描述</label>
                        <div class="col-md-5">
                            <textarea class="form-control" name="description" rows="5" maxlength="225"
                                      class="input-xxlarge ">${(areaVo.description)! }</textarea>
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