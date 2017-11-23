package com.albedo.java.modules.gen.domain;

import com.albedo.java.common.domain.base.IdEntity;
import com.albedo.java.util.StringUtil;
import com.google.common.collect.Lists;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;
import org.hibernate.validator.constraints.Length;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;
import java.util.List;

/**
 * 生成方案Entity
 *
 * @version 2013-10-15
 */
@XmlRootElement(name = "template")
@Entity
@Table(name = "gen_template_t")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class GenTemplate extends IdEntity {

    private static final long serialVersionUID = 1L;
    public static final String F_NAME = "name";
    @Length(min = 1, max = 200)
    @Column(name = "name_")
    private String name; // 名称
    @Column(name = "category_")
    private String category; // 分类
    @Column(name = "file_path")
    private String filePath; // 生成文件路径
    @Column(name = "file_name")
    private String fileName; // 文件名
    @Column(name = "content_")
    private String content; // 内容

    private boolean ignoreOutput;

    public GenTemplate() {
        super();
    }

    public GenTemplate(String id) {
        super();
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    @XmlTransient
    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public List<String> getCategoryList() {
        if (category == null) {
            return Lists.newArrayList();
        } else {
            return Lists.newArrayList(StringUtil.split(category, ","));
        }
    }

    public void setCategoryList(List<String> categoryList) {
        if (categoryList == null) {
            this.category = "";
        } else {
            this.category = "," + StringUtil.join(categoryList, ",") + ",";
        }
    }

    public boolean isIgnoreOutput() {
        return ignoreOutput;
    }

    public void setIgnoreOutput(boolean ignoreOutput) {
        this.ignoreOutput = ignoreOutput;
    }

}
