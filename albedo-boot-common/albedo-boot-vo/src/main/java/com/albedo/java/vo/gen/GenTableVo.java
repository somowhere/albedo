package com.albedo.java.vo.gen;

import com.albedo.java.vo.base.DataEntityVo;
import lombok.Data;
import lombok.ToString;

import java.util.List;

/**
 * 业务表Entity
 *
 * @version 2013-10-15
 */
@Data
@ToString
public class GenTableVo extends DataEntityVo {

    public static final String F_NAME = "name";
    public static final String F_NAMESANDCOMMENTS = "nameAndComments";
    private static final long serialVersionUID = 1L;
    // 名称
    /*** 编码 */
    private String name;
    /*** 描述 */
    private String comments;
    /*** 实体类名称 */
    private String className;
    /*** 关联父表 */
    private String parentTable;
    /*** 关联父表外键 */
    private String parentTableFk;
    /*** 父表对象 */
    private GenTableVo parent;
    /*** 子表列表 */
    private List<GenTableVo> childList;
    private String nameAndComments;
    /*** 按名称模糊查询 */
    private String nameLike;
    /*** 当前表主键列表 */
    private List<String> pkList;

    private String category;


}
