package com.albedo.java.modules.gen.domain;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

/**
 * 业务表Entity
 *
 * @version 2013-10-15
 */
@Data
@AllArgsConstructor
@ToString
@NoArgsConstructor
@TableName("gen_table_fk")
public class TableFk {

	@TableField("name")
	private String name; // 名称
	@TableField("table_name")
	private String tableName; // 描述
	@TableField("table_fk")
	private String tableFk; // 外键列名
	@TableField("table.id")
	private Table table; // 归属表


}
