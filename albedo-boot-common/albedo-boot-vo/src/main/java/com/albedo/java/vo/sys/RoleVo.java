package com.albedo.java.vo.sys;

import com.albedo.java.vo.base.DataEntityVo;
import lombok.Data;
import lombok.ToString;

import java.util.List;

/**
 * A user.
 */
@Data
@ToString
public class RoleVo extends DataEntityVo {

    public static final String F_NAME = "name";
    private static final long serialVersionUID = 1L;
    private String name;
    /*** 名称全拼 */
    private String en;
    /*** 工作流组用户组类型（security-role：管理员、assignment：可进行任务分配、user：普通用户） */
    private String type;
    /*** 组织ID */
    private String orgId;

    private String orgName;

    /*** 是否系统数据  0 是 1否*/
    private Integer sysData;
    /*** 可查看的数据范围 */
    private Integer dataScope;
    private Integer sort;
    private List<String> moduleIdList;
    private List<String> orgIdList;

}
