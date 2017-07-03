package com.albedo.java.modules.gen.domain;

import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

import javax.persistence.Column;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

/**
 * 业务表Entity
 *
 * @version 2013-10-15
 */
public class GenTableFk {

    @Column(name = "name_")
    private String name; // 名称
    @Column(name = "table_name")
    private String tableName; // 描述
    @Column(name = "table_fk")
    private String tableFk; // 外键列名
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "gen_table_id", nullable = true)
    @NotFound(action = NotFoundAction.IGNORE)
    private GenTable genTable; // 归属表

    public GenTableFk() {
        super();
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getTableName() {
        return tableName;
    }

    public void setTableName(String tableName) {
        this.tableName = tableName;
    }

    public String getTableFk() {
        return tableFk;
    }

    public void setTableFk(String tableFk) {
        this.tableFk = tableFk;
    }

    public GenTable getGenTable() {
        return genTable;
    }

    public void setGenTable(GenTable genTable) {
        this.genTable = genTable;
    }

}
