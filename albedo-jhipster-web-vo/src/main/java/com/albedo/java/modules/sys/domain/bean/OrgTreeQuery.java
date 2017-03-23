package com.albedo.java.modules.sys.domain.bean;

/**
 * Created by lijie on 2017/3/2.
 */
public class OrgTreeQuery {

    private String extId;
    private String showType;
    private Long grade;
    private String all;

    public String getExtId() {
        return extId;
    }

    public void setExtId(String extId) {
        this.extId = extId;
    }

    public String getShowType() {
        return showType;
    }

    public void setShowType(String showType) {
        this.showType = showType;
    }

    public Long getGrade() {
        return grade;
    }

    public void setGrade(Long grade) {
        this.grade = grade;
    }

    public String getAll() {
        return all;
    }

    public void setAll(String all) {
        this.all = all;
    }
}
