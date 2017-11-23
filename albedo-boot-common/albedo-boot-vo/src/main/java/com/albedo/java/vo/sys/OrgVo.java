package com.albedo.java.vo.sys;

import com.albedo.java.vo.base.TreeEntityVo;
import lombok.Data;
import lombok.ToString;

/**
 * Created by lijie on 2017/8/1.
 */
@Data
@ToString
public class OrgVo extends TreeEntityVo {

    private static final long serialVersionUID = 1L;
    private String code;
    /*** 拼音简码 */
    private String en;
    /*** 机构类型（1：公司；2：部门；3：小组） */
    private String type;
    /*** 机构等级（1：一级；2：二级；3：三级；4：四级） */
    private String grade;
}
