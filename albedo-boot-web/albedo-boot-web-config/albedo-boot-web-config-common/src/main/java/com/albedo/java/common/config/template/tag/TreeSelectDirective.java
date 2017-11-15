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
public class TreeSelectDirective implements TemplateDirectiveModel {

    public final Logger log = LoggerFactory.getLogger(TreeSelectDirective.class);

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
                url = PublicUtil.toStrString(params.get("url")), //树结构数据地址
                checked = PublicUtil.toStrString(params.get("checked")), //是否显示复选框
                extId = PublicUtil.toStrString(params.get("extId")), // 排除掉的编号（不能选择的编号）
                notAllowSelectRoot = PublicUtil.toStrString(params.get("notAllowSelectRoot")), //不允许选择根节点
                notAllowSelectParent = PublicUtil.toStrString(params.get("notAllowSelectParent")), //不允许选择父节点
                module = PublicUtil.toStrString(params.get("module")), //过滤栏目模型（只显示指定模型，仅针对CMS的Category树）
                selectScopeModule = PublicUtil.toStrString(params.get("selectScopeModule")), //选择范围内的模型（控制不能选择公共模型，不能选择本栏目外的模型）（仅针对CMS的Category树）
                allowClear = PublicUtil.toStrString(params.get("allowClear")), //是否允许清除
                nodesLevel = PublicUtil.toStrString(params.get("nodesLevel")), //菜单展开层数
                nameLevel = PublicUtil.toStrString(params.get("nameLevel")), //返回名称关联级别
                selectedValueFn = PublicUtil.toStrString(params.get("selectedValueFn")), //选择节点后触发的函数
                disabled = PublicUtil.toStrString(params.get("disabled")); //是否限制选择，如果限制，设置为disabled
        StringBuffer sb = new StringBuffer().append("<div class=\"input-group\"><input id=\"").append(id)
                .append("Id\" class=\"_commonTreeId\" name=\"").append(name)
                .append("\" searchItem=\"").append(searchItem).append("\" attrType=\"").append(attrType).append("\" operation=\"")
                .append(operate).append("\" type=\"hidden\" value=\"").append(value).append("\" ")
                .append(SystemConfig.SYSTEM_TRUE.equals(disabled) ? "disabled=\"disable\"" : "").append("/><input id=\"")
                .append(id).append("Name\" name=\"").append(labelName)
                .append("\" onclick=\"albedoForm.treeSelect($(this), $(this).prev('input._commonTreeId'));\" readonly=\"readonly\" type=\"text\" value=\"")
                .append(labelValue).append("\" ").append(SystemConfig.SYSTEM_TRUE.equals(disabled) ? "disabled=\"disable\"" : "")
                .append(" class=\"").append(cssClass)
                .append(" _commonTreeInput form-control\" _nameLevel=\"").append(nameLevel)
                .append("\" _url=\"").append(url)
                .append("\" _checked=\"").append(checked)
                .append("\" _extId=\"").append(extId)
                .append("\" _module=\"").append(module)
                .append("\" _nodesLevel=\"").append(nodesLevel)
                .append("\" _title=\"").append(title).append("\" _selectedValueFn=\"").append(selectedValueFn)
                .append("\" _allowClear=\"").append(allowClear)
                .append("\" _notAllowSelectParent=\"").append(notAllowSelectParent)
                .append("\" _notAllowSelectRoot=\"").append(notAllowSelectRoot)
                .append("\"_selectScopeModule=\"").append(selectScopeModule)
                .append("\" /><span class=\"input-group-btn\"><button id=\"").append(id)
                .append("Button\" class=\"btn blue\" type=\"button\" onclick=\"albedoForm.treeSelect($(this).parent().prev('input._commonTreeInput'), $(this).parent().prevAll('input._commonTreeId'));\" >选择</button></span></div>");

        // 将模版里的数字参数转化成int类型的方法，，其它类型的转换请看freemarker文档
        out.write(sb.toString());
        if (body != null) {
            body.render(env.getOut());
        } else {
            throw new RuntimeException("标签内部至少要加一个空格");
        }
    }

}
