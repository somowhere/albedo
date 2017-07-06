package com.albedo.java.common.config.template.tag;

import com.albedo.java.util.PublicUtil;
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
public class TreeShowDirective implements TemplateDirectiveModel {

    public final Logger log = LoggerFactory.getLogger(TreeShowDirective.class);

	
	/**/

    public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body)
            throws TemplateException, IOException {
        Writer out = env.getOut();

        String id = PublicUtil.toStrString(params.get("id")),
                title = PublicUtil.toStrString(params.get("title")), //标题
                checked = PublicUtil.toStrString(params.get("checked")), //是否显示复选框
                url = PublicUtil.toStrString(params.get("url")), // 树结构数据地址
                checkNodeFn = PublicUtil.toStrString(params.get("checkNodeFn")), //输入框值（Name）
                beforeCheckNodeFn = PublicUtil.toStrString(params.get("beforeCheckNodeFn")), //菜单checkbox / radio被勾选 或 取消勾选之前的事件回调函数，并且根据返回值确定是否允许 勾选 或 取消勾选
                cancelClickNodeFn = PublicUtil.toStrString(params.get("cancelClickNodeFn")),//菜单节点取消点击的事件回调函数
                clickNodeFn = PublicUtil.toStrString(params.get("clickNodeFn")), //菜单节点被点击的事件回调函数
                afterLoadNodeFn = PublicUtil.toStrString(params.get("afterLoadNodeFn")), //菜单加载完毕回调函数
                nodesLevel = PublicUtil.toStrString(params.get("nodesLevel")), //菜单展开层数
                selectNodeId = PublicUtil.toStrString(params.get("selectNodeId")), // 默认选择节点Id
                notAllowSelectRoot = PublicUtil.toStrString(params.get("notAllowSelectRoot")), //不允许选择根节点
                notAllowSelectParent = PublicUtil.toStrString(params.get("notAllowSelectParent")), //不允许选择父节点
                notAllowSelect = PublicUtil.toStrString(params.get("notAllowSelect")), //不允许选择节点
                allowCancelSelect = PublicUtil.toStrString(params.get("allowCancelSelect")), //允许取消选择节点
                checkShowInputId = PublicUtil.toStrString(params.get("checkShowInputId")), //树结构checked显示所有选择节点名称的文本框Id，并且仅当 cchecked为true、heckNodeFn为空时生效
                checkIdInputName = PublicUtil.toStrString(params.get("checkIdInputName")), //树结构checked存放所有选择节点Id隐藏文本框名称，并且仅当 checked为true、checkNodeFn为空时生效
                onlyCheckedProperty = PublicUtil.toStrString(params.get("onlyCheckedProperty")), //是否只允许选择叶含某个属性节点的复选框
                selectedValueFn = PublicUtil.toStrString(params.get("selectedValueFn")), //选择节点后触发的函数
                onlyCheckedChild = PublicUtil.toStrString(params.get("onlyCheckedChild")); //是否只允许选择叶子节点的复选框
        StringBuffer sb = new StringBuffer().append("<div class=\"portlet light bordered ").append(id)
                .append("-portlet\"><div class=\"portlet-title\"><div class=\"caption\"><i class=\"fa fa-gift\"></i>").append(title)
                /*<div class="portlet-input input-inline" style="width: 195px !important;">'+
                                 '<div class="input-icon right">'+
	                                 '<i class="icon-magnifier"></i>'+
	                                 '<input type="text" id="key" name="key" maxlength="50" class="form-control input-circle tree-search-input" placeholder="search..."> </div>'+
	                         '</div>*/


                .append("</div><div class=\"tools\"><a href=\"javascript:\" class=\"tree-search\" title=\"搜索\"><i class=\"fa fa-search\"></i></a><a href=\"javascript:\"  class=\"tree-refresh\" title=\"刷新\"><i class=\"fa fa-refresh\"></i></a><a href=\"javascript:\" id=\"expand_tree_").append(id)
                .append("\" expand=\"true\" title=\"展开/折叠\" class=\"tree-expand\"><i class=\"fa fa-expand\"></i></a></div></div><div class=\"portlet-body scroller albedo-treeSelect-div\" style=\"height:543px;\"><div class=\"control-group tree-search-div\" style=\"display: none; padding-bottom: 5px;\"><div class=\"portlet-input input-inline\"><div class=\"input-icon right\"><i class=\"icon-magnifier\"></i><input type=\"text\" id=\"key\" name=\"key\" maxlength=\"50\" class=\"form-control input-circle tree-search-input\" placeholder=\"请输入...\"> </div></div></div><div class=\"ztree ztree-show\" _checked=\"").append(checked)
                .append("\" id=\"tree-div-").append(id)
                .append("\" _url=\"").append(url)
                .append("\" _checkNodeFn=\"").append(checkNodeFn)
                .append("\" _beforeCheckNodeFn=\"").append(beforeCheckNodeFn)
                .append("\" _cancelClickNodeFn=\"").append(cancelClickNodeFn)
                .append("\" _clickNodeFn=\"").append(clickNodeFn)
                .append("\" _afterLoadNodeFn=\"").append(afterLoadNodeFn)
                .append("\" _nodesLevel=\"").append(nodesLevel).append("\" _selectedValueFn=\"").append(selectedValueFn)
                .append("\" _selectNodeId=\"").append(selectNodeId)
                .append("\" _notAllowSelectRoot=\"").append(notAllowSelectRoot)
                .append("\" _notAllowSelectParent=\"").append(notAllowSelectParent)
                .append("\" _notAllowSelect=\"").append(notAllowSelect)
                .append("\" _allowCancelSelect=\"").append(allowCancelSelect)
                .append("\" _checkShowInputId=\"").append(checkShowInputId)
                .append("\" _checkIdInputName=\"").append(checkIdInputName)
                .append("\" _onlyCheckedProperty=\"").append(onlyCheckedProperty)
                .append("\" _onlyCheckedChild=\"").append(onlyCheckedChild)
                .append("\"></div></div></div>");

        // 将模版里的数字参数转化成int类型的方法，，其它类型的转换请看freemarker文档
        out.write(sb.toString());
        if (body != null) {
            body.render(env.getOut());
        } else {
            throw new RuntimeException("标签内部至少要加一个空格");
        }
    }

}
