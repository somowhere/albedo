package com.albedo.java.common.config.template.tag;

import com.albedo.java.common.config.AlbedoProperties;
import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.StringUtil;
import freemarker.core.Environment;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateDirectiveModel;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.io.Writer;
import java.util.Map;

@Component
public class FileInputDirective implements TemplateDirectiveModel {
    private final Logger log = LoggerFactory.getLogger(FileInputDirective.class);
    @Autowired
    AlbedoProperties albedoProperties;

    @Override
    public void execute(Environment environment, Map map, TemplateModel[] templateModels,
                        TemplateDirectiveBody templateDirectiveBody) throws TemplateException, IOException {
        Writer out = environment.getOut();
        StringBuffer sb = new StringBuffer();
        String name = PublicUtil.toStrString(map.get("name")), type = PublicUtil.toStrString(map.get("type")),
                value = PublicUtil.toStrString(map.get("value")), disabled = PublicUtil.toStrString(map.get("disabled")),
                cssClass = PublicUtil.toStrString(map.get("cssClass")), multiple = PublicUtil.toStrString(map.get("multiple")),
                options = PublicUtil.toStrString(map.get("options"));
        sb.append("<div class=\"fileinput ")
                .append(PublicUtil.isEmpty(value) ? "fileinput-new" : "fileinput-exists").append("\" style=\"width:100%;\" data-provides=\"fileinput\">\n");
        boolean isImage = "image".equals(type), isDisabled = "disabled".equals(disabled);
        if (isImage) {//
            String img = value;
            if (isDisabled) {//
                if (PublicUtil.isNotEmpty(img))
                    if (img.contains(StringUtil.SPLIT_DEFAULT)) {
                        String[] imgs = img.split(StringUtil.SPLIT_DEFAULT);
                        for (int i = 0; i < imgs.length; i++) {
                            sb.append("<div class=\"fileinput-exists thumbnail fileinput-preview\"><img src=\"").append(albedoProperties.getStaticUrlPath(imgs[i])).append("\" alt=\"\" class=\"fileinput-img scale-img\" /></div>");
                        }
                    } else {
                        sb.append("<div class=\"fileinput-exists thumbnail fileinput-preview\"><img src=\"").
                                append(PublicUtil.isNotEmpty(value) ? albedoProperties.getStaticUrlPath(img) : img).append("\" class=\"fileinput-img scale-img\" /></div>");
                    }
                sb.append("</div>");
            } else {
                sb.append("<div class=\"fileinput-new thumbnail fileinput-empty\"><img src=\"http://www.placehold.it/200x150/EFEFEF/AAAAAA&amp;text=请上传图片\" alt=\"\" class=\"fileinput-img\"  /></div>");
                sb.append("<input type=\"hidden\" class=\"").append(cssClass).append(" filepath\" name=\"").append(name).append("\" value=\"").append(value)
                        .append("\" />");
                if (PublicUtil.isNotEmpty(img))
                    if (img.contains(StringUtil.SPLIT_DEFAULT)) {
                        String[] imgs = img.split(StringUtil.SPLIT_DEFAULT);
                        for (int i = 0; i < imgs.length; i++) {
                            sb.append("<div class=\"fileinput-exists thumbnail fileinput-preview\"><img src=\"").append(albedoProperties.getStaticUrlPath(imgs[i])).append("\" alt=\"\" class=\"fileinput-img\" img-value=\"")
                                    .append(imgs[i]).append("\" /></div>");
                        }
                    } else {
                        sb.append("<div class=\"fileinput-exists thumbnail fileinput-preview\"><img src=\"").
                                append(PublicUtil.isNotEmpty(value) ? albedoProperties.getStaticUrlPath(img) : img).append("\" alt=\"\" class=\"fileinput-img\" img-value=\"")
                                .append(img).append("\" /></div>");
                    }
            }
        } else {
            sb.append("<div class=\"input-group\" style=\"width:100%;overflow:auto;\">");
            sb.append("<input type=\"text\" class=\"form-control ").append(cssClass).append("\" ").append(isDisabled ? "disabled=\"disabled\"" : "").append("name=\"").append(name).append("\" value=\"").append(value)
                    .append("\" />");
        }
        if (!isDisabled)
            sb.append(isImage ? "<div class=\"btn-img-div\">" : "").append("<span class=\"btn blue btn-file\"><span class=\"fileinput-new\"> 选择")
                    .append(isImage ? "图片" : "文件 ").append(" </span>\n")
                    .append("<span class=\"fileinput-exists\"> 选择")
                    .append(isImage ? "图片" : "文件 ").append(" </span><input type=\"file\" name=\"uploadFile\" showType=\"").append(type).append("\" ").append(PublicUtil.isNotEmpty(multiple) ? "multiple=\"multiple\"" : "").append("\" options=\"").append(options).append("\"></span>")
                    .append("<span class=\"btn red fileinput-exists fileinput-remove\" data-dismiss=\"fileinput\"> ")
                    .append(PublicUtil.isNotEmpty(multiple) ? "全部" : "").append("移除 </span></div></div>");
        out.write(sb.toString());
        if (templateDirectiveBody != null) {
            templateDirectiveBody.render(environment.getOut());
        } else {
            throw new RuntimeException("标签内部至少要加一个空格");
        }

    }
}
