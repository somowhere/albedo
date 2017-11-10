package com.albedo.java.common.domain.base;

import com.albedo.java.util.annotation.SearchField;
import com.albedo.java.util.domain.QueryCondition.Operator;
import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;
import org.hibernate.validator.constraints.Length;

import javax.persistence.*;

/**
 * 数据TreeEntity类
 *
 * @author lijie version 2013-12-27 下午12:27:10
 */
@MappedSuperclass
public abstract class TreeDataEntity<T extends DataEntity> extends DataEntity {

    public static final String ROOT = "1";
    public static final String F_NAME = "name";
    public static final String F_PARENTID = "parentId";
    public static final String F_PARENTIDS = "parentIds";
    public static final String F_ISLEAF = "isLeaf";
    public static final String F_SORT = "sort";
    public static final String F_PARENT = "parent";
    private static final long serialVersionUID = 1L;
    /*** 组织名称 */
    @Length(min = 1, max = 100)
    @Column(name = "name_")
    @SearchField(op = Operator.like)
    protected String name;
    /*** 上级组织 */
    @Length(min = 0, max = 64)
    @Column(name = "parent_id")
    @SearchField
    protected String parentId;
    /*** 所有父编号 */
    @Length(min = 0, max = 2000)
    @Column(name = "parent_ids")
    @SearchField(op = Operator.like)
    protected String parentIds;
    /*** 上级组织 */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "parent_id", insertable = false, updatable = false)
    @NotFound(action = NotFoundAction.IGNORE)
    protected T parent;
    /*** 序号 */
    @Column(name = "sort_")
    protected Integer sort = 30;
    /*** 1 叶子节点 0非叶子节点 */
    @Column(name = "is_leaf")
    private boolean isLeaf = false;

    public TreeDataEntity() {
        super();
        this.sort = 30;
    }

    public T getParent() {
        return parent;
    }

    public void setParent(T parent) {
        this.parent = parent;
    }

    public String getParentIds() {
        return parentIds;
    }

    public void setParentIds(String parentIds) {
        this.parentIds = parentIds;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getSort() {
        return sort;
    }

    public void setSort(Integer sort) {
        this.sort = sort;
    }

    public String getParentId() {
        return parentId;
    }

    public void setParentId(String parentId) {
        this.parentId = parentId;
    }

    public boolean isLeaf() {
        return isLeaf;
    }

    public void setLeaf(boolean isLeaf) {
        this.isLeaf = isLeaf;
    }

    protected boolean getIsLeaf() {
        return isLeaf;
    }

}
