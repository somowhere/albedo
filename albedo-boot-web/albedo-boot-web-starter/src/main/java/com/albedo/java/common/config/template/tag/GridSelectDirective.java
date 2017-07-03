package com.albedo.java.common.config.template.tag;

import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.config.SystemConfig;
import freemarker.core.Environment;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateDirectiveModel;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.io.Writer;
import java.util.Map;

@Component
public class GridSelectDirective implements TemplateDirectiveModel {

    public final Logger log = LoggerFactory.getLogger(GridSelectDirective.class);

    public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body)
            throws TemplateException, IOException {
        Writer out = env.getOut();

        String id = PublicUtil.toStrString(params.get("id")),
                name = PublicUtil.toStrString(params.get("name")), //隐藏域名称（ID）
                value = PublicUtil.toStrString(params.get("value")),  //隐藏域值（ID）
                cssClass = PublicUtil.toStrString(params.get("cssClass")),
                labelName = PublicUtil.toStrString(params.get("labelName")), //输入框名称（Name）
                labelValue = PublicUtil.toStrString(params.get("labelValue")), //输入框值（Name）
                searchItem = PublicUtil.toStrString(params.get("searchItem")),
                operate = PublicUtil.toStrString(params.get("operate")),
                attrType = PublicUtil.toStrString(params.get("attrType")),
                title = PublicUtil.toStrString(params.get("title")), //选择框标题
                url = PublicUtil.toStrString(params.get("url")), //表格构数据地址
                checked = PublicUtil.toStrString(params.get("checked")), //是否显示复选框
                colNames = PublicUtil.toStrString(params.get("colNames")), //分页显示列名称对象
                colModel = PublicUtil.toStrString(params.get("colModel")), //分页显示列对象
                showProperty = PublicUtil.toStrString(params.get("showProperty")), //不允许选择父节点
                selectedValueFn = PublicUtil.toStrString(params.get("selectedValueFn")), //选择节点后触发的函数
                pageSize = PublicUtil.toStrString(params.get("pageSize")), //
                width = PublicUtil.toStrString(params.get("width")), //
                gridOptions = PublicUtil.toStrString(params.get("gridOptions")),

                allowClear = PublicUtil.toStrString(params.get("allowClear")), //是否允许清除
                searchFormId = PublicUtil.toStrString(params.get("searchFormId")), //查询表单Html
                height = PublicUtil.toStrString(params.get("height")), //
                disableDblClickRow = PublicUtil.toStrString(params.get("disableDblClickRow")), //是否禁用双击事件
                disabled = PublicUtil.toStrString(params.get("disabled")); //是否限制选择，如果限制，设置为disabled
        StringBuffer sb = new StringBuffer().append("<div class=\"input-group\"><input id=\"").append(id)
                .append("\" class=\"_commonGridId\" name=\"").append(name)
                .append("\" searchItem=\"").append(searchItem).append("\" attrType=\"").append(attrType).append("\" operation=\"")
                .append(operate).append("\" type=\"hidden\" value=\"").append(value).append("\" ")
                .append(SystemConfig.SYSTEM_TRUE.equals(disabled) ? "disabled=\"disable\"" : "").append("/><input id=\"")
                .append(id).append("Name\" name=\"").append(labelName)
                .append("\" onclick=\"albedoForm.gridSelect($(this), $(this).prev('input._commonGridId'));\" readonly=\"readonly\" type=\"text\" value=\"")
                .append(labelValue).append("\" ").append(SystemConfig.SYSTEM_TRUE.equals(disabled) ? "disabled=\"disable\"" : "")
                .append(" class=\"").append(cssClass)
                .append(" _commonGridInput form-control\" _showProperty=\"").append(showProperty)
                .append("\" _title=\"").append(title).append("\" _url=\"").append(url)
                .append("\" _checked=\"").append(checked)
                .append("\" _colNames=\"").append(colNames)
                .append("\" _colModel=\"").append(colModel)
                .append("\" _pageSize=\"").append(pageSize)
                .append("\" _width=\"").append(width)
                .append("\" _allowClear=\"").append(allowClear)
                .append("\" _height=\"").append(height)
                .append("\" _selectedValueFn=\"").append(selectedValueFn)
                .append("\" _gridOptions=\"").append(gridOptions)
                .append("\" _searchFormId=\"").append(searchFormId)
                .append("\"_disableDblClickRow=\"").append(disableDblClickRow)
                .append("\" /><span class=\"input-group-btn\"><button id=\"").append(id)
                .append("Button\" class=\"btn blue\" type=\"button\" onclick=\"albedoForm.gridSelect($(this).parent().prev('input._commonGridInput'), $(this).parent().prevAll('input._commonGridId'));\" >选择</button></span></div>");

        // 将模版里的数字参数转化成int类型的方法，，其它类型的转换请看freemarker文档
        out.write(sb.toString());
        if (body != null) {
            body.render(env.getOut());
        } else {
            throw new RuntimeException("标签内部至少要加一个空格");
        }
    }

}
