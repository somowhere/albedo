package com.albedo.java.common.config.template.tag;

import com.albedo.java.common.data.persistence.repository.JpaCustomeRepository;
import com.albedo.java.modules.sys.domain.Dict;
import com.albedo.java.util.DictUtil;
import com.albedo.java.util.Json;
import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.base.Reflections;
import com.albedo.java.util.domain.Combo;
import com.albedo.java.util.domain.ComboData;
import com.albedo.java.util.spring.SpringContextHolder;
import com.google.common.collect.Lists;
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
import java.util.List;
import java.util.Map;

@SuppressWarnings("unchecked")
@Component
public class FormDirective implements TemplateDirectiveModel {

    private static final String BOX_TYPE_SELECT = "select";
    private static final String BOX_TYPE_CHECKBOX = "checkbox";
    private static final String BOX_TYPE_RADIO = "radio";
    private final Logger log = LoggerFactory.getLogger(FormDirective.class);

    public static String convertComboDataList(List<?> dataList, String idFieldName, String nameFieldName) {
        List<ComboData> comboDataList = Lists.newArrayList();
        dataList.forEach(item -> {
            comboDataList.add(new ComboData(PublicUtil.toStrString(Reflections.getFieldValue(item, idFieldName)),
                    PublicUtil.toStrString(Reflections.invokeGetter(item, nameFieldName))));
        });
        return Json.toJsonString(comboDataList);
    }

    @Override
    public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body)
            throws TemplateException, IOException {
        Writer out = env.getOut();

        String name = PublicUtil.toStrString(params.get("name")), data = PublicUtil.toStrString(params.get("data")),
                dictCode = PublicUtil.toStrString(params.get("dictCode")),
                filter = PublicUtil.toStrString(params.get("filter")),
                combo = PublicUtil.toStrString(params.get("combo"));

        String sb = null;
        if (PublicUtil.isNotEmpty(dictCode)) {
            List<Dict> dictList = DictUtil.getDictListFilterVal(dictCode, filter);
            if (PublicUtil.isEmpty(dictList)) {
                log.warn("name [{}] can not find dict code [{}] data, please check !!!", name, dictCode);
            } else {
                List<ComboData> dataList = Lists.newArrayList();
                dictList.forEach(item -> {
                    dataList.add(Reflections.createObj(ComboData.class,
                            Lists.newArrayList(ComboData.F_ID, ComboData.F_NAME), item.getVal(), item.getName()));
                });
                sb = convertMapListToString(params, dataList);
            }
        } else if (PublicUtil.isNotEmpty(data)) {
            try {
                sb = convertMapListToString(params, Json.parseArray(data, ComboData.class));
            } catch (Exception e) {
                log.warn("data error {}", e.getMessage());
            }
        } else if (PublicUtil.isNotEmpty(combo)) {
            try {
                Combo item = Json.parseObject(combo, Combo.class);
                sb = convertMapListToString(params,
                        SpringContextHolder.getBean(JpaCustomeRepository.class).findJson(item));
            } catch (Exception e) {
                log.warn("combo error {}", e.getMessage());
            }
        }

        out.write(sb);
        if (body != null) {
            body.render(env.getOut());
        } else {
            throw new RuntimeException("标签内部至少要加一个空格");
        }
    }

    private String convertMapListToString(Map params, List<ComboData> dataList) {
        StringBuffer sb = new StringBuffer();
        String name = PublicUtil.toStrString(params.get("name")),
                searchItem = PublicUtil.toStrString(params.get("searchItem")),
                operate = PublicUtil.toStrString(params.get("operate")),
                analytiColumn = PublicUtil.toStrString(params.get("analytiColumn")),
                analytiColumnPrefix = PublicUtil.toStrString(params.get("analytiColumnPrefix")),
                itemLabel = PublicUtil.toStrString(params.get("itemLabel")),
                itemValue = PublicUtil.toStrString(params.get("itemValue")),
                attrType = PublicUtil.toStrString(params.get("attrType")),
                id = PublicUtil.toStrString(params.get("id")), value = PublicUtil.toStrString(params.get("value")),
                cssClass = PublicUtil.toStrString(params.get("cssClass")),
                dataOptions = PublicUtil.toStrString(params.get("dataOptions")),
                boxType = PublicUtil.toStrString(params.get("boxType"));

        if (FormDirective.BOX_TYPE_SELECT.equals(boxType)) {
            sb.append("<select id=\"").append(id).append("\" name=\"").append(name).append("\" searchItem=\"")
                    .append(searchItem).append("\" attrType=\"").append(attrType).append("\" operate=\"")
                    .append(operate).append("\" \" analytiColumn=\"")
                    .append(analytiColumn).append("\" \" analytiColumnPrefix=\"")
                    .append(analytiColumnPrefix).append("\" class=\"form-control select2 ").append(cssClass).append("\">");

            if (!cssClass.contains("required")) {
                sb.append("<option value=\"\">请选择...</option>");
            }
            if (PublicUtil.isNotEmpty(dataList)) {

                dataList.forEach(item -> {
                    String valLabel = item.getId(), nameLabel = item.getName();
                    sb.append("<option value=\"").append(valLabel).append("\"")
                            .append(valLabel.equals(value) || value.contains(valLabel) ? "selected=\"selected\"" : "")
                            .append(">").append(nameLabel).append("</option>");
                });
            }
            sb.append("</select>");
        } else {
            sb.append("<div class=\"").append(PublicUtil.isNotEmpty(searchItem) ? "" : boxType)
                    .append("-list checkbox\">");
            if (PublicUtil.isNotEmpty(dataList))
                for (int i = 0; i < dataList.size(); i++) {
                    ComboData item = dataList.get(i);
                    String valLabel = item.getId(), nameLabel = item.getName();
                    sb.append("<label class=\"").append(boxType).append("-inline\"><input id=\"")
                            .append(PublicUtil.isEmpty(id) ? name : id).append(i + 1).append("\" name=\"").append(name)
                            .append("\" searchItem=\"").append(searchItem).append("\" attrType=\"").append(attrType)
                            .append("\" operate=\"").append(operate)
                            .append("\" analytiColumn=\"").append(analytiColumn)
                            .append("\" analytiColumnPrefix=\"").append(analytiColumnPrefix).append("\" itemLabel=\"").append(itemLabel)
                            .append("\" itemValue=\"").append(itemValue).append("\" type=\"")
                            .append(FormDirective.BOX_TYPE_RADIO.equals(boxType) ? FormDirective.BOX_TYPE_RADIO
                                    : FormDirective.BOX_TYPE_CHECKBOX)
                            .append("\" value=\"").append(valLabel).append("\" class=\"").append(cssClass).append("\" ")
                            .append(valLabel.equals(value) || value.contains(valLabel) ? "checked=\"checked\"" : "")
                            .append("data-options=\"").append(dataOptions).append("\" />").append(nameLabel)
                            .append("</label>");
                }
            sb.append("</div>");
        }
        return sb.toString();
    }

}
