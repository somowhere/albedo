package com.albedo.java.common.config.template;

import com.albedo.java.common.base.BaseInterface;
import com.albedo.java.common.config.AlbedoProperties;
import com.albedo.java.common.config.template.tag.CustomTags;
import com.albedo.java.common.security.SecurityUtil;
import com.albedo.java.util.DictUtil;
import com.albedo.java.util.PublicUtil;
import com.google.common.collect.Maps;
import freemarker.ext.beans.BeansWrapper;
import freemarker.ext.beans.BeansWrapperBuilder;
import freemarker.template.TemplateException;
import freemarker.template.TemplateHashModel;
import freemarker.template.TemplateModelException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;

import javax.annotation.PostConstruct;
import java.util.Map;

@Configuration
public class FreeMarkerConfig implements BaseInterface {

    private final Logger log = LoggerFactory.getLogger(FreeMarkerConfig.class);

    @Autowired
    protected freemarker.template.Configuration configuration;
    @Autowired
    protected org.springframework.web.servlet.view.freemarker.FreeMarkerViewResolver resolver;
    @Autowired
    AlbedoProperties albedoProperties;
    BeansWrapperBuilder builder = new BeansWrapperBuilder(freemarker.template.Configuration.VERSION_2_3_25);
    @Autowired
    private CustomTags customTags;

    @PostConstruct
    public void setSharedVariable() {

        configuration.setDateFormat("yyyy/MM/dd");
        configuration.setDateTimeFormat("yyyy-MM-dd HH:mm:ss");
        configuration.setNumberFormat("#");
        // 自定义标签，在这里把标签注入到共享变量中去就可以在模板中直接调用了
        configuration.setSharedVariable("albedo", customTags);

        /**
         * setting配置
         */
        try {
            configuration.setSetting("template_update_delay", "1");
            configuration.setSetting("default_encoding", "UTF-8");
        } catch (TemplateException e) {
            e.printStackTrace();
        }
        configuration.setCustomAttribute("adminPath", albedoProperties.getAdminPath());
        configuration.setCustomAttribute("application", albedoProperties.getApplication());
        try {
            configuration.setSharedVariable("application", albedoProperties.getApplication());
        } catch (TemplateModelException e) {
            e.printStackTrace();
        }

        resolver.setCache(true); // 是否缓存模板
        resolver.setRequestContextAttribute("request"); // 为模板调用时，调用request对象的变量名
        resolver.setOrder(0);
    }

    public TemplateHashModel useStaticPackage(Class<?> clz) {
        try {
            BeansWrapper wrapper = builder.build();
            TemplateHashModel staticModels = wrapper.getStaticModels();
            TemplateHashModel fileStatics = (TemplateHashModel) staticModels.get(clz.getName());
            return fileStatics;
        } catch (Exception e) {
            log.warn("useStaticPackage {}", e);
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public void init() {
        Map<String, Object> map = Maps.newHashMap();
        map.put(SecurityUtil.class.getSimpleName(), useStaticPackage(SecurityUtil.class));
        map.put(PublicUtil.class.getSimpleName(), useStaticPackage(PublicUtil.class));
        map.put(DictUtil.class.getSimpleName(), useStaticPackage(DictUtil.class));
        resolver.setAttributesMap(map);
    }
}
