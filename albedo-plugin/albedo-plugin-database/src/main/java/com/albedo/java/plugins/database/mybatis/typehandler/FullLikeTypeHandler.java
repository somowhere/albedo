package com.albedo.java.plugins.database.mybatis.typehandler;

import com.baomidou.mybatisplus.core.enums.SqlLike;
import org.apache.ibatis.type.Alias;

/**
 * 仅仅用于like查询
 *
 * @author somewhere
 */
@Alias("fullLike")
public class FullLikeTypeHandler extends BaseLikeTypeHandler {
	public FullLikeTypeHandler() {
		super(SqlLike.DEFAULT);
	}
}
