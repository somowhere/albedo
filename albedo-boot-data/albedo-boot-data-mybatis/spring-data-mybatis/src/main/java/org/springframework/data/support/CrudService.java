package org.springframework.data.support;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;

import java.io.Serializable;
import java.util.List;

/**
 * CRUD SERVICE BASE INTERFACE.
 *
 * @param <T>  entity type
 * @param <ID> primary key type
 * @author Jarvis Song
 * @since 15/9/30
 */
public interface CrudService<T, ID extends Serializable> {


    /**
     * Get a entity or a domain by primary key. Usually it's called id.
     *
     * @param id primary key's value
     * @return 带关联的实体
     */
    T get(ID id);

    /**
     * 根据主键获取一个不带关联的实体.
     *
     * @param id 主键
     * @return 不带关联的实体
     */
    T getBasic(ID id);

    /**
     * Save a entity or a domain. It can be judged to update or insert by checking the id is or not null.
     */
    void save(T entity);

    void saveIgnoreNull(T entity);

    void insert(T entity);

    void update(T entity);

    void updateIgnore(T entity);

    /**
     * Delete a entity or a domain with its primary key.
     */
    void delete(ID id);

    /**
     * Delete some entities by a condition.
     *
     * @param condition 条件
     * @param <X>       继承自实体的类型,一般为DTO
     */
    <X extends T> void delete(X condition);

    /**
     * 查询分页内容信息.
     *
     * @param pageable  分页参数
     * @param condition 查询条件
     * @param columns   要查询的字段
     * @param <X>       继承自实体的类型,一般为DTO
     * @return 分页内容
     */
    <X extends T> Page<T> findAll(Pageable pageable, X condition, String... columns);

    /**
     * 根据条件查询信息.
     *
     * @param condition 查询条件
     * @param columns   要查询的字段
     * @param <X>       继承自实体的类型,一般为DTO
     * @return 查询结果
     */
    <X extends T> List<T> findAll(X condition, String... columns);

    /**
     * 可指定排序的查询.
     *
     * @param sort      排序
     * @param condition 查询条件
     * @param columns   要查询的字段
     * @param <X>       继承自实体的类型,一般为DTO
     * @return 查询结果
     */
    <X extends T> List<T> findAll(Sort sort, X condition, String... columns);

    /**
     * 查找一条记录.
     *
     * @param condition 查询条件
     * @param columns   要查询的字段
     * @param <X>       继承自实体的类型,一般为DTO
     * @return 查询结果
     */
    <X extends T> T findOne(X condition, String... columns);

    /**
     * 分页查询基础信息（不含关联表）.
     *
     * @param pageable  分页参数
     * @param condition 查询条件
     * @param columns   要查询的字段
     * @param <X>       继承自实体的类型,一般为DTO
     * @return 查询结果
     */
    <X extends T> Page<T> findBasicAll(Pageable pageable, X condition, String... columns);

    /**
     * 查询基础信息（不含关联表）.
     *
     * @param condition 查询条件
     * @param columns   要查询的字段
     * @param <X>       继承自实体的类型,一般为DTO
     * @return 查询结果
     */
    <X extends T> List<T> findBasicAll(X condition, String... columns);

    /**
     * 查询基础信息（不含关联表）.
     *
     * @param sort      排序
     * @param condition 查询条件
     * @param columns   要查询的属性,为空则代表查询所有.
     * @param <X>       继承自实体的类型,一般为DTO
     * @return 查询结果
     */
    <X extends T> List<T> findBasicAll(Sort sort, X condition, String... columns);

    /**
     * 查找一条基础记录.
     *
     * @param condition 查询条件
     * @param columns   要查询的字段
     * @param <X>       继承自实体的类型,一般为DTO
     * @return 查询结果
     */
    <X extends T> T findBasicOne(X condition, String... columns);

    /**
     * 统计基础记录.
     *
     * @param condition 查询条件
     * @param <X>       继承自实体的类型,一般为DTO
     * @return 统计总数
     */
    <X extends T> Long countBasicAll(X condition);

    /**
     * 统计总数.
     *
     * @param condition 查询条件
     * @param <X>       继承自实体的类型,一般为DTO
     * @return 统计总数
     */
    <X extends T> Long countAll(X condition);

}
