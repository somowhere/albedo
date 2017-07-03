package com.albedo.java.modules.gen.domain.xml;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlElementWrapper;
import javax.xml.bind.annotation.XmlRootElement;
import java.io.Serializable;
import java.util.List;

/**
 * 生成方案Entity
 *
 * @version 2013-10-15
 */
@XmlRootElement(name = "config")
public class GenConfig implements Serializable {

    private static final long serialVersionUID = 1L;
    private List<GenCategory> categoryList; // 代码模板分类

    private List<DictTemp> javaTypeList; // Java类型

    private List<DictTemp> queryTypeList; // 查询类型

    private List<DictTemp> showTypeList; // 显示类型

    private List<DictTemp> viewTypeList; // 视图类型


    public GenConfig() {
        super();
    }

    @XmlElementWrapper(name = "category")
    @XmlElement(name = "category")
    public List<GenCategory> getCategoryList() {
        return categoryList;
    }

    public void setCategoryList(List<GenCategory> categoryList) {
        this.categoryList = categoryList;
    }

    @XmlElementWrapper(name = "javaType")
    @XmlElement(name = "dict")
    public List<DictTemp> getJavaTypeList() {
        return javaTypeList;
    }

    public void setJavaTypeList(List<DictTemp> javaTypeList) {
        this.javaTypeList = javaTypeList;
    }

    @XmlElementWrapper(name = "queryType")
    @XmlElement(name = "dict")
    public List<DictTemp> getQueryTypeList() {
        return queryTypeList;
    }

    public void setQueryTypeList(List<DictTemp> queryTypeList) {
        this.queryTypeList = queryTypeList;
    }

    @XmlElementWrapper(name = "showType")
    @XmlElement(name = "dict")
    public List<DictTemp> getShowTypeList() {
        return showTypeList;
    }

    public void setShowTypeList(List<DictTemp> showTypeList) {
        this.showTypeList = showTypeList;
    }

    @XmlElementWrapper(name = "viewType")
    @XmlElement(name = "dict")
    public List<DictTemp> getViewTypeList() {
        return viewTypeList;
    }

    public void setViewTypeList(List<DictTemp> viewTypeList) {
        this.viewTypeList = viewTypeList;
    }

}