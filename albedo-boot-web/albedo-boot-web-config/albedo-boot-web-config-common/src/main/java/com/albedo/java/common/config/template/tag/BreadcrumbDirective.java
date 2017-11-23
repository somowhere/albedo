package com.albedo.java.common.config.template.tag;

import com.albedo.java.common.security.SecurityConstants;
import com.albedo.java.common.security.SecurityUtil;
import com.albedo.java.modules.sys.domain.Module;
import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.domain.Globals;
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

@Component
public class BreadcrumbDirective implements TemplateDirectiveModel {

    private final Logger log = LoggerFactory.getLogger(BreadcrumbDirective.class);

    @Override
    public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body)
            throws TemplateException, IOException {
        Writer out = env.getOut();

        List<Module> moduleList = SecurityUtil.getModuleList(), currentItemList = Lists.newArrayList();
        if (PublicUtil.isNotEmpty(SecurityConstants.getCurrentUrl())) {
            moduleList.stream().filter(item -> item.getUrl() != null && item.getUrl().equals(SecurityConstants.getCurrentUrl()))
                    .findFirst().ifPresent(currentItem -> {
                currentItemList.add(currentItem);
                Lists.newArrayList(currentItem.getParentIds().split(",")).forEach(id -> {
                    moduleList.stream().filter(item -> PublicUtil.isNotEmpty(item.getParentId()) && item.getId().equals(id)).findFirst()
                            .ifPresent(moduleTemp -> {
                                currentItemList.add(moduleTemp);
                            });
                });
            });
        }

        StringBuffer sb = new StringBuffer();
        sb.append("<ul class=\"page-breadcrumb breadcrumb\"><li><a href=\"").append(env.getCustomAttribute("adminPath"))
                .append(Globals.INDEX_URL)
                .append("\">首页</a><i class=\"fa fa-circle\"></i></li>");
        if (PublicUtil.isNotEmpty(currentItemList)) {
            for (int i = 1; i < currentItemList.size(); i++) {
                Module item = currentItemList.get(i);
                sb.append("<li><a href=\"")
                        .append(PublicUtil.isEmpty(item.getUrl()) ? "javascript:void(0)" : item.getUrl()).append("\">")
                        .append(item.getName()).append("</a><i class=\"fa fa-circle\"></i></li>");
            }
            sb.append("<li><span class=\"active\">").append(currentItemList.get(0).getName()).append("</span></li>");
        }
        sb.append("</ul>");
        out.write(sb.toString());
        if (body != null) {
            body.render(env.getOut());
        } else {
            throw new RuntimeException("标签内部至少要加一个空格");
        }

    }

}
