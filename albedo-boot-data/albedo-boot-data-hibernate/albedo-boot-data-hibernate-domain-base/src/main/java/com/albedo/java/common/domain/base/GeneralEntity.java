package com.albedo.java.common.domain.base;

import javax.persistence.MappedSuperclass;
import java.io.Serializable;

/**
 * 通常的数据基类 copyright 2014 albedo all right reserved author 李杰 created on 2014年12月31日 下午1:57:09
 */
@MappedSuperclass
public abstract class GeneralEntity implements Serializable {

    /*** 状态 审核 */
    public static final Integer FLAG_AUDIT = 1;
    /*** 状态 正常 */
    public static final Integer FLAG_NORMAL = 0;
    /*** 状态 停用 */
    public static final Integer FLAG_UNABLE = -1;
    /*** 状态 已删除 */
    public static final Integer FLAG_DELETE = -2;
    /**
     * 状态（-2：删除；-1：停用 0：正常 1:审核）
     */
    public static final String F_STATUS = "status";
    /*** ID */
    public static final String F_ID = "id";
    public static final String F_CREATEDBY = "createdBy";
    public static final String F_CREATOR = "creator";
    public static final String F_CREATEDDATE = "createdDate";
    public static final String F_LASTMODIFIEDBY = "lastModifiedBy";
    public static final String F_MODIFIER = "modifier";
    public static final String F_LASTMODIFIEDDATE = "lastModifiedDate";
    public static final String F_VERSION = "version";
    public static final String F_DESCRIPTION = "description";
    private static final long serialVersionUID = 1L;


}
