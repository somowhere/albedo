<div class="portlet light bordered">
    <div class="portlet-title">
        <div class="caption font-blue">
            <i class="fa fa-globe font-blue"></i><#if genSchemeVo.id??>编辑<#else>添加</#if>生成方案
        </div>
        <div class="actions">
            <div class="btn-group">
                <a id="genScheme_list" class="btn red list" href="javascript:void(0);"
                   data-table-id="#data-table-genScheme">
                    <i class="fa fa-list"> 生成方案列表</i>
                </a>
            </div>
        </div>
    </div>
    <div class="portlet-body form form-no-modal">
        <!-- BEGIN FORM-->
        <div id="bootstrap-alerts"></div>
        <form id="ajax_form" action="${ctx}/gen/genScheme/edit" method="post"
              class="form-horizontal form-validation form-bordered form-label-stripped"
              config="">
            <div class="form-body">
                <input type="hidden" name="id" value="${(genSchemeVo.id)!}"/>
                <div class="form-group">
                    <label class="control-label col-md-3">方案名称<span
                            class="required">*</span>
                    </label>
                    <div class="col-md-5">
                        <input type="text" name="name" value="${(genSchemeVo.name)! }"
                               maxlength="64" data-required="1" class="form-control required"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label">模块分类<span
                            class="required">*</span></label>
                    <div class="col-md-5"><@albedo.form name="category"
                    cssClass="required" boxType="select" data="${(categoryList)!}"
                    value="${(genSchemeVo.category)! }"> </@albedo.form>
                        <span class="help-inline">
							生成结构：{包名}/{模块名}/{分层(dao,entity,service,web)}/{子模块名}/{java类}
						</span>
                    </div>

                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label">生成包路径<span
                            class="required">*</span></label>
                    <div class="col-md-5">
                        <input name="packageName" type="text" value="${(genSchemeVo.packageName)! }"
                               htmlEscape="false"
                               class="form-control required"/> <span
                            class="help-inline">建议模块包：com.albedo.modules.模块名</span>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label">页面数据加载方式<span
                            class="required">*</span></label>
                    <div class="col-md-5">
                    <@albedo.form name="viewType"
                    cssClass="required" boxType="select" data="${(viewTypeList)!}"
                    value="${(genSchemeVo.viewType)! }"> </@albedo.form>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label">生成模块名<span
                            class="required">*</span></label>
                    <div class="col-md-5">
                        <input name="moduleName" type="text" value="${(genSchemeVo.moduleName)! }"
                               htmlEscape="false" maxlength="64"
                               class="form-control required"/> <span
                        <span class="help-inline">可理解为子系统名，例如 sys</span>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label">生成子模块名</label>
                    <div class="col-md-5">
                        <input name="subModuleName" type="text" value="${(genSchemeVo.subModuleName)! }"
                               htmlEscape="false" maxlength="64"
                               class="form-control"/> <span class="help-inline">可选，分层下的文件夹，例如 </span>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label">生成功能描述<span
                            class="required">*</span></label>
                    <div class="col-md-5">
                        <input name="functionName" type="text" value="${(genSchemeVo.functionName)! }"
                               htmlEscape="false"
                               class="form-control required"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label">生成功能名<span
                            class="required">*</span></label>
                    <div class="col-md-5">
                        <input name="functionNameSimple" type="text" value="${(genSchemeVo.functionNameSimple)! }"
                               htmlEscape="false"
                               class="form-control required"/> <span class="help-inline">用作功能提示，如：保存“某某”成功</span>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label">生成功能作者<span
                            class="required">*</span></label>
                    <div class="col-md-5">
                        <input name="functionAuthor" type="text" value="${(genSchemeVo.functionAuthor)! }"
                               htmlEscape="false"
                               class="form-control required"/> <span class="help-inline">功能开发者</span>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label">业务表名<span
                            class="required">*</span></label>
                    <div class="col-md-5">
                    <@albedo.form name="genTableId"
                    cssClass="required" boxType="select" data="${(tableList)!}"
                    value="${(genSchemeVo.genTableId)! }"> </@albedo.form>
                        <span class="help-inline">生成的数据表，一对多情况下请选择主表。</span>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label">生成选项</label>
                    <div class="col-md-3">
                        <label class="checkbox-inline"><input name="genCode" type="checkbox"
                                                              value="true"/>是否生成代码</label>
                        <label class="checkbox-inline"><input name="replaceFile" type="checkbox" value="true"/>是否替换现有文件</label>
                    </div>
                    <label class="col-md-1 control-label">同步模块</label>
                    <div class="col-md-2">
                        <label class="checkbox-inline"><input id="syncModule" name="syncModule" value="true"
                                                              type="checkbox"/>是否同步模块数据</label>
                    </div>
                </div>
                <div id="parentModule_div" class="form-group hided">
                    <label class="control-label col-md-3">上级模块<span class="required">*</span>
                    </label>
                    <div class="col-md-5">
                    <@albedo.treeSelect id="module" cssClass="" allowClear="true" name="parentModuleId" labelName="parentModuleName"
                    title="选择模块" url="${ctx}/sys/module/findTreeData?all&type=menu"> </@albedo.treeSelect>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label">状态<span
                            class="required">*</span></label>
                    <div class="col-md-5"><@albedo.form name="status"
                    cssClass="required" boxType="radio" dictCode="sys_status"
                    value="${(genSchemeVo.status)! }"> </@albedo.form></div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label">描述</label>
                    <div class="col-md-8">
						<textarea class="summernote form-control" name="description"
                                  rows="9">${(genSchemeVo.description)! }</textarea>
                    </div>
                </div>

                <div class="form-actions">
                    <div class="row">
                        <div class="col-md-offset-3 col-md-9">
                            <button type="button" class="btn add green">
                                <i class="fa fa-check"></i> 保存
                            </button>
                            <button type="reset" class="btn default">重置</button>
                            <button type="button" class="btn list" data-table-id="#data-table-genScheme">返回</button>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>
<script type="text/javascript">
    $("#syncModule").click(function () {
        $(this).is(':checked') ? $("#parentModule_div").show().find("input#parentModuleName").addClass("required") : $("#parentModule_div").hide().find("input#parentModuleName").removeClass("required");
    })

</script>
