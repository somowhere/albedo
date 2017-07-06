package com.albedo.java.modules.gen.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import org.springframework.data.mybatis.annotations.Column;
import org.springframework.data.mybatis.annotations.JoinColumn;
import org.springframework.data.mybatis.annotations.ManyToOne;

/**
 * 业务表Entity
 *
 * @version 2013-10-15
 */
@Data
@AllArgsConstructor
@ToString
@NoArgsConstructor
public class GenTableFk {

    @Column(name = "name_")
    private String name; // 名称
    @Column(name = "table_name")
    private String tableName; // 描述
    @Column(name = "table_fk")
    private String tableFk; // 外键列名
    @ManyToOne
    @JoinColumn(name = "gen_table_id")
    private GenTable genTable; // 归属表


}
