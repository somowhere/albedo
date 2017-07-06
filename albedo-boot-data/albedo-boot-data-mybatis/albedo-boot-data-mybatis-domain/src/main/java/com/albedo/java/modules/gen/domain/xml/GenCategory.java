package com.albedo.java.modules.gen.domain.xml;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlElementWrapper;
import javax.xml.bind.annotation.XmlRootElement;
import java.util.List;

/**
 * 生成方案Entity
 *
 * @version 2013-10-15
 */
@XmlRootElement(name = "category")
public class GenCategory extends DictTemp {

    private static final long serialVersionUID = 1L;
    public static String CATEGORY_REF = "category-ref:";
    private List<String> template; // 主表模板
    private List<String> childTableTemplate;// 子表模板

    public GenCategory() {
        super();
    }

    @XmlElement(name = "template")
    public List<String> getTemplate() {
        return template;
    }

    public void setTemplate(List<String> template) {
        this.template = template;
    }

    @XmlElementWrapper(name = "childTable")
    @XmlElement(name = "template")
    public List<String> getChildTableTemplate() {
        return childTableTemplate;
    }

    public void setChildTableTemplate(List<String> childTableTemplate) {
        this.childTableTemplate = childTableTemplate;
    }

}
