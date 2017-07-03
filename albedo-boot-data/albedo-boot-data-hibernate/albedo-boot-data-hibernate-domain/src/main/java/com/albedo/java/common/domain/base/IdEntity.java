package com.albedo.java.common.domain.base;

import com.albedo.java.common.domain.base.pk.IdGen;
import com.albedo.java.util.annotation.SearchField;

import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.MappedSuperclass;
import javax.persistence.PrePersist;

@MappedSuperclass
public class IdEntity extends DataEntity {

    private static final long serialVersionUID = 1L;
    @Id
    @Column(name = "id_")
    @SearchField
    protected String id; // 编号

    public IdEntity() {
        super();
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
}
