package com.albedo.java.modules.sys.domain.bean;

/**
 * Created by lijie on 2017/3/2.
 */
public class AreaTreeQuery {

    private String all;
    private String parentId; 
    private String extId;
    private Integer ltLevel; 
    private Integer level;

    public String getAll() {
        return all;
    }

    public void setAll(String all) {
        this.all = all;
    }

    public String getParentId() {
        return parentId;
    }

    public void setParentId(String parentId) {
        this.parentId = parentId;
    }

    public String getExtId() {
        return extId;
    }

    public void setExtId(String extId) {
        this.extId = extId;
    }

    public Integer getLtLevel() {
        return ltLevel;
    }

    public void setLtLevel(Integer ltLevel) {
        this.ltLevel = ltLevel;
    }

    public Integer getLevel() {
        return level;
    }

    public void setLevel(Integer level) {
        this.level = level;
    }
}
