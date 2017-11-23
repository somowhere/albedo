package com.albedo.java.modules.gen.domain;

import com.albedo.java.common.domain.base.IdEntity;
import com.albedo.java.util.StringUtil;
import com.google.common.collect.Lists;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import org.hibernate.validator.constraints.Length;
import org.springframework.data.mybatis.annotations.Column;
import org.springframework.data.mybatis.annotations.Entity;

import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;
import java.util.List;

/**
 * 生成方案Entity
 *
 * @version 2013-10-15
 */
@XmlRootElement(name = "template")
@Entity(table = "gen_template_t")
@Data
@AllArgsConstructor
@ToString
@NoArgsConstructor
public class GenTemplate extends IdEntity {

    public static final String F_NAME = "name";
    private static final long serialVersionUID = 1L;
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

    public GenTemplate(String id) {
        super();
        this.id = id;
    }

    @XmlTransient
    public String getCategory() {
        return category;
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

}
