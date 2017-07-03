package com.albedo.java.common.domain.base;

import com.albedo.java.common.domain.base.pk.IdGen;
import com.albedo.java.util.annotation.SearchField;
import com.alibaba.fastjson.annotation.JSONField;

import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.MappedSuperclass;
import javax.persistence.PrePersist;

/**
 * 数据TreeEntity类
 *
 * @author lijie version 2013-12-27 下午12:27:10
 */
@MappedSuperclass
public abstract class TreeEntity<T extends DataEntity> extends TreeDataEntity<T> {

    /*** ID */
    public static final String F_ID = "id";
    private static final long serialVersionUID = 1L;
    @Id
    @Column(name = "id_")
    @SearchField
    protected String id; // 编号

    public TreeEntity() {
        super();
    }

    public static boolean isRoot(String id) {
        return id != null && id.equals("1");
    }

    @PrePersist
    public void prePersist() {
        if (this.id != TreeEntity.ROOT) {
            this.id = IdGen.uuid();
        }
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @JSONField(serialize = false)
    public boolean isRoot() {
        return isRoot(this.id);
    }
}
