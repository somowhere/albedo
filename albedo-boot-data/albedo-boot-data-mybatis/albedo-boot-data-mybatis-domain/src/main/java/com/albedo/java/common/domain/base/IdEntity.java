package com.albedo.java.common.domain.base;

import com.albedo.java.common.data.persistence.IdGen;
import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.annotation.SearchField;
import org.springframework.data.mybatis.annotations.*;

@MappedSuperclass
public abstract class IdEntity extends DataEntity<String> {

    private static final long serialVersionUID = 1L;
    @SearchField
    @Id(strategy = Id.GenerationType.UUID)
    @Column(name = "id_")
    protected String id; // 编号

    public IdEntity() {
        super();
    }

    @PreInssert
    public void preInssert() {
        if (PublicUtil.isEmpty(getId())) {
            setId(IdGen.uuid());
        }
    }

    @PreUpdate
    public void preUpdate() {

    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        if (PublicUtil.isNotEmpty(id)) this.id = id;
    }

}
