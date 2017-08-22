package com.albedo.java.vo.sys;

import com.albedo.java.util.annotation.DictType;
import com.albedo.java.util.annotation.SearchField;
import com.albedo.java.vo.base.GeneralEntityVo;
import com.alibaba.fastjson.annotation.JSONField;
import com.google.common.collect.Sets;
import lombok.Data;
import lombok.ToString;
import org.springframework.data.annotation.Transient;
import org.springframework.data.mybatis.annotations.*;

import java.time.ZonedDateTime;
import java.util.List;
import java.util.Set;

/**
 * A user.
 */
@Data
@ToString
public class RoleResult extends GeneralEntityVo {

    private static final long serialVersionUID = 1L;
    private String id;
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
    private Integer status;
    private List<String> moduleIdList;
    private List<String> orgIdList;

}
