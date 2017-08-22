package com.albedo.java.vo.sys;

import com.albedo.java.vo.base.GeneralEntityVo;
import lombok.Data;
import lombok.ToString;

/**
 * Created by lijie on 2017/8/1.
 */
@Data
@ToString
public class OrgResult extends GeneralEntityVo {

    private static final long serialVersionUID = 1L;
    /*** 组织名称 */
    protected String name;
    /*** 上级组织 */
    protected String parentId;
    /*** 序号 */
    protected Integer sort;
    private String id;
    private String parentName;
    private String code;
    /*** 拼音简码 */
    private String en;
    /*** 机构类型（1：公司；2：部门；3：小组） */
    private String type;
    /*** 机构等级（1：一级；2：二级；3：三级；4：四级） */
    private String grade;
}
