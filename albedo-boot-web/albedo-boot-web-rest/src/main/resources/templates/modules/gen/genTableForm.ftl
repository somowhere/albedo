<div class="portlet light bordered">
    <div class="portlet-title">
        <div class="caption font-blue">
            <i class="fa fa-globe font-blue"></i><#if genTableVo.id??>编辑<#else>添加</#if>业务表
        </div>
        <div class="actions">
            <div class="btn-group">
                <a id="user_list" class="btn red list" href="javascript:void(0);" data-table-id="#data-table-genTable">
                    <i class="fa fa-list"> 业务表列表</i>
                </a>
            </div>
        </div>
    </div>
    <div class="portlet-body form form-no-modal">
        <!-- BEGIN FORM-->
        <div id="bootstrap-alerts" class="bootstrap-alerts-genTable-form"></div>
        <form id="genTable-form" action="${ctx}/gen/genTable/edit" method="post"
              class="form-horizontal form-validation form-bordered form-label-stripped" config="{rules:{
                       name: {remote: '${ctx}/gen/genTable/checkByProperty?_statusFalse&id=' + encodeURIComponent('${(genTableVo.id)!}')}},
                       messages:{name:{message:'业务表名称已存在'}}}">
            <div class="form-body">
                <input type="hidden" name="id" value="${(genTableVo.id)!}"/>
                <h3 class="form-section">基本信息</h3>
                <div class="form-group">
                    <label class="control-label col-md-3">名称<span class="required">*</span>
                    </label>
                    <div class="col-md-5">
                        <input type="text" name="name" value="${(genTableVo.name)! }" maxlength="64" data-required="1"
                               class="form-control required"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-md-3">说明<span class="required">*</span>
                    </label>
                    <div class="col-md-5">
                        <input type="text" name="comments" value="${(genTableVo.comments)! }" maxlength="64"
                               data-required="1" class="form-control required"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-md-3">类名<span class="required">*</span>
                    </label>
                    <div class="col-md-5">
                        <input type="text" name="className" value="${(genTableVo.className)! }" maxlength="64"
                               data-required="1" class="form-control required"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label">父表表名</label>
                    <div class="col-md-3">
                    <@albedo.form name="parentTable" cssClass="" value="${(genTableVo.parentTable)! }" data="${(tableList)!}" boxType="select" > </@albedo.form>
                    </div>
                    <label class="col-md-1 control-label treeRoleOrgBox">当前表外键</label>
                    <div class="col-md-3 treeRoleOrgBox">
                    <@albedo.form name="parentTableFk" cssClass="" value="${(genTableVo.parentTableFk)! }" data="${(columnList)!}" boxType="select" > </@albedo.form>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label">状态<span class="required">*</span></label>
                    <div class="col-md-5">
                    <@albedo.form name="status" cssClass="required" boxType="radio" dictCode="sys_status" value="${(genTableVo.status)! }"> </@albedo.form>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3 control-label">描述</label>
                    <div class="col-md-8">
                        <textarea class="summernote form-control" name="description"
                                  rows="5">${(genTableVo.description)! }</textarea>
                    </div>
                </div>
                <h3 class="form-section">字段列表</h3>
                <div class="form-group">
                    <table id="contentTable" class="table table-striped table-bordered table-condensed">
                        <thead>
                        <tr>
                            <th title="数据库字段名">列名</th>
                            <th title="默认读取数据库字段备注">说明</th>
                            <th title="数据库中设置的字段类型及长度">物理类型</th>
                            <th title="实体对象的属性字段类型">Java类型</th>
                            <th title="实体对象的属性字段（对象名.属性名|属性名2|属性名3，例如：用户user.id|name|loginName，属性名2和属性名3为Join时关联查询的字段）">
                                Java属性名称 <i class="icon-question-sign"></i></th>
                            <th title="是否是数据库主键">主键</th>
                            <th title="字段是否可为空值，不可为空字段自动进行空值验证">可空</th>
                            <th title="字段是否唯一，唯一空字段自动进行唯一性验证">唯一</th>
                            <th title="选中后该字段被加入到insert语句里">插入</th>
                            <th title="选中后该字段被加入到update语句里">编辑</th>
                            <th title="选中后该字段被加入到查询列表里">列表</th>
                            <th title="选中后该字段被加入到查询条件里">查询</th>
                            <th title="该字段为查询字段时的查询匹配放松">查询匹配方式</th>
                            <th title="字段在表单中显示的类型">显示表单类型</th>
                            <th title="显示表单类型设置为“下拉框、复选框、点选框”时，需设置字典的类型">字典类型</th>
                            <th>排序</th>
                        </tr>
                        </thead>
                        <tbody>
                        <#list genTableVo.columnList as column>
                        <tr<#if column.status == -1> class="error" title="已删除的列，保存之后消失！"</#if>>
                            <td nowrap>
                                <input type="hidden" name="columnFormList[${(column_index)!}].id"
                                       value="${(column.id)!}"/>
                                <input type="hidden" name="columnFormList[${(column_index)!}].status"
                                       value="${(column.status)!}"/>
                                <input type="hidden" name="columnFormList[${(column_index)!}].genTableVo.id"
                                       value="${(column.genTableVo.id)!}"/>
                                <input type="hidden" name="columnFormList[${(column_index)!}].name"
                                       value="${(column.name)!}"/>${(column.name)!}
                            </td>
                            <td>
                                <input type="text" name="columnFormList[${(column_index)!}].comments"
                                       value="${(column.comments)!}" maxlength="200"
                                       class="form-control required input-small"/>
                            </td>
                            <td nowrap>
                                <input type="hidden" name="columnFormList[${(column_index)!}].jdbcType"
                                       value="${(column.jdbcType)!}"/>${(column.jdbcType)!}
                            </td>
                            <td>
                                <@albedo.form name="columnFormList[${(column_index)!}].javaType" value="${(column.javaType)!}" cssClass="required input-mini" data="${(javaTypeList)!}" boxType="select" > </@albedo.form>
                            </td>
                            <td>
                                <input type="text" name="columnFormList[${(column_index)!}].javaField"
                                       value="${(column.javaField)!}" maxlength="200"
                                       class="required form-control input-small"/>
                            </td>
                            <td>
                                <input type="checkbox" name="columnFormList[${(column_index)!}].isPk" value="1"
                                       <#if column.isPk == 1>checked='checked'</#if>/>
                            </td>
                            <td>
                                <input type="checkbox" name="columnFormList[${(column_index)!}].isNull" value="1"
                                       <#if column.isNull == 1>checked='checked'</#if>/>
                            </td>
                            <td>
                                <input type="checkbox" name="columnFormList[${(column_index)!}].isUnique" value="1"
                                       <#if column.isUnique == 1>checked='checked'</#if>/>
                            </td>
                            <td>
                                <input type="checkbox" name="columnFormList[${(column_index)!}].isInsert" value="1"
                                       <#if column.isInsert == 1>checked='checked'</#if>/>
                            </td>
                            <td>
                                <input type="checkbox" name="columnFormList[${(column_index)!}].isEdit" value="1"
                                       <#if column.isEdit == 1>checked='checked'</#if>/>
                            </td>
                            <td>
                                <input type="checkbox" name="columnFormList[${(column_index)!}].isList" value="1"
                                       <#if column.isList == 1>checked='checked'</#if>/>
                            </td>
                            <td>
                                <input type="checkbox" name="columnFormList[${(column_index)!}].isQuery" value="1"
                                       <#if column.isQuery == 1>checked='checked'</#if>/>
                            </td>

                            <td>
                                <@albedo.form name="columnFormList[${(column_index)!}].queryType" value="${(column.queryType)!}" cssClass="required input-mini" data="${(queryTypeList)!}" boxType="select" > </@albedo.form>
                            </td>
                            <td>
                                <@albedo.form name="columnFormList[${(column_index)!}].showType" value="${(column.showType)!}" cssClass="required" data="${(showTypeList)!}" boxType="select" > </@albedo.form>
                            </td>
                            <td>
                                <input type="text" name="columnFormList[${(column_index)!}].dictType"
                                       value="${(column.dictType)!}" maxlength="200" class="input-xsmall form-control"/>
                            </td>
                            <td>
                                <input type="text" name="columnFormList[${(column_index)!}].sort"
                                       value="${(column.sort)!}" maxlength="200"
                                       class="form-control required input-mini digits"/>
                            </td>
                        </tr>
                        </#list>
                        </tbody>
                    </table>
                </div>
                </fieldset>
                <div class="form-actions">
                    <div class="row">
                        <div class="col-md-offset-3 col-md-9">
                            <button type="button" class="btn add green">
                                <i class="fa fa-check"></i> 保存
                            </button>
                            <button type="reset" class="btn default">重置</button>
                            <button type="button" class="btn list" data-table-id="#data-table-genTable">返回</button>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>
