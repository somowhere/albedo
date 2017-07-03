package com.albedo.java.util.base;

import com.albedo.java.util.exception.Exceptions;
import freemarker.template.Configuration;
import freemarker.template.Template;
import org.springframework.core.io.DefaultResourceLoader;
import org.springframework.core.io.Resource;

import java.io.IOException;
import java.io.StringReader;
import java.io.StringWriter;
import java.util.Map;

/**
 * copyright 2014 albedo all right reserved author 李杰 created on 2015年1月28日 上午9:19:27
 */
public class FreeMarkers {

    public static String renderString(String templateString, Map<String, ?> model) {
        try {
            StringWriter result = new StringWriter();
            Template t = new Template("name", new StringReader(templateString), new Configuration());
            t.process(model, result);
            return result.toString();
        } catch (Exception e) {
            throw Exceptions.unchecked(e);
        }
    }

    public static String renderTemplate(Template template, Object model) {
        try {
            StringWriter result = new StringWriter();
            template.process(model, result);
            return result.toString();
        } catch (Exception e) {
            throw Exceptions.unchecked(e);
        }
    }

    public static Configuration buildConfiguration(String directory) throws IOException {
        Configuration cfg = new Configuration();
        Resource path = new DefaultResourceLoader().getResource(directory);
        cfg.setDirectoryForTemplateLoading(path.getFile());
        return cfg;
    }

    public static void main(String[] args) throws IOException {
        // // renderString
        // Map<String, String> model = com.google.common.collect.Maps.newHashMap();
        // model.put("userName", "calvin");
        // String result = FreeMarkers.renderString("hello ${userName}", model);
        // System.out.println(result);
        // // renderTemplate
        // Configuration cfg = FreeMarkers.buildConfiguration("classpath:/");
        // Template template = cfg.getTemplate("testTemplate.ftl");
        // String result2 = FreeMarkers.renderTemplate(template, model);
        // System.out.println(result2);

        // Map<String, String> model = com.google.common.collect.Maps.newHashMap();
        // model.put("userName", "calvin");
        // String result = FreeMarkers.renderString("hello ${userName} ${r'${userName}'}", model);
        // System.out.println(result);
    }

}
