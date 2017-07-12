package com.albedo.java.common.config.template.tag;

import freemarker.template.Configuration;
import freemarker.template.DefaultObjectWrapperBuilder;
import freemarker.template.SimpleHash;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;

/**
 * Created by zyw on 15/7/28.
 */
@Component
public class CustomTags extends SimpleHash {

    private static final long serialVersionUID = 1L;

    @Autowired
    FormDirective formDirective;
    @Autowired
    GridSelectDirective gridSelectDirective;
    @Autowired
    TreeSelectDirective treeSelectDirective;
    @Autowired
    TreeShowDirective treeShowDirective;
    @Autowired
    BreadcrumbDirective breadcrumbDirective;
    @Autowired
    private FileInputDirective fileInputDirective;


    public CustomTags() {
        super(new DefaultObjectWrapperBuilder(Configuration.VERSION_2_3_22).build());
    }

    @PostConstruct
    public void setSharedVariable() {
        put("form", formDirective);
        put("treeSelect", treeSelectDirective);
        put("girdSelect", gridSelectDirective);
        put("treeShow", treeShowDirective);
        put("breadcrumb", breadcrumbDirective);
        put("fileInput", fileInputDirective);
    }

}
