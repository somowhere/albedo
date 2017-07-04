package com.albedo.java.common.data.persistence.repository;

import com.albedo.java.common.domain.base.BaseEntity;
import com.albedo.java.util.domain.Combo;
import com.albedo.java.util.domain.ComboData;
import com.albedo.java.util.domain.PageModel;
import com.albedo.java.util.domain.QueryCondition;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;

import java.util.List;

public interface JpaCustomeRepository<T extends BaseEntity> {

    /* (非 Javadoc)
    * <p>Title: getSession</p>
    * <p>Description: </p>
    * @return
    * @see com.albedo.java.common.persistence.service.impl.IBaseUtilService#getSession()
    */
    Session getSession();

    /**
     * 强制与数据库同步
     */
    void flush();

    /**
     * 清除缓存数据
     */
    void clear();

    /* (非 Javadoc)
    * <p>Title: clearLevel2Cache</p>
    * <p>Description: </p>
    * @see com.albedo.java.common.persistence.service.impl.IBaseUtilService#clearLevel2Cache()
    */
    Query createQuery(String HQL, Object... params);

    SQLQuery createSqlQuery(String SQL, Object... params);

    Object findByHQL(String HQL, boolean isList, List<QueryCondition> conditionList, Object... params);

    Object findByHQL(String HQL, boolean isList, int maxSize, List<QueryCondition> conditionList, Object... params);

    List findListSizeByHQL(String HQL, int maxSize, List<QueryCondition> conditionList, Object... params);

    List findListSizeByHQL(String HQL, int maxSize, Object... params);

    List findListByHQL(String HQL, List<QueryCondition> conditionList, Object... params);

    List findListByHQL(String HQL, Object... params);

    List<T> findEntityListByHQL(String HQL, int maxSize, List<QueryCondition> conditionList, Object... params);

    List<T> findEntityListByHQL(String HQL, int maxSize, Object... params);

    List<T> findEntityListByHQL(String HQL, List<QueryCondition> conditionList, Object... params);

    List<T> findEntityListByHQL(String HQL, Object... params);


    Object findObjectByHQL(String HQL, List<QueryCondition> conditionList, Object... params);

    Object findObjectByHQL(String HQL, Object... params);

    T findEntityByHQL(String HQL, List<QueryCondition> conditionList, Object... params);

    T findEntityByHQL(String HQL, Object... params);


    Object findBySQL(String SQL, boolean isList, List<QueryCondition> conditionList, Object... params);

    Object findBySQL(String SQL, boolean isList, int maxSize, List<QueryCondition> conditionList, Object... params);

    List findListSizeBySQL(String SQL, int maxSize, List<QueryCondition> conditionList, Object... params);

    List findListSizeBySQL(String SQL, int maxSize, Object... params);

    List findListBySQL(String SQL, List<QueryCondition> conditionList, Object... params);

    List findListBySQL(String SQL, Object... params);

    Object findObjectBySQL(String SQL, List<QueryCondition> conditionList, Object... params);

    Object findObjectBySQL(String SQL, Object... params);


    Object findByQL(String QL, boolean isSql, boolean isCache, boolean isList, int maxSize, List<QueryCondition> conditionList, Object... params);

    boolean doCheckByProperty(T entity);

    boolean doCheckByPK(T entity);

    List<ComboData> findJson(Combo combo);

    /*
     * (非 Javadoc) <p>Title: execute</p> <p>Description: </p>
     * @param HQL
     * @param params
     * @return
     * @see com.albedo.java.common.persistence.service.impl.IBaseUtilService#execute(java.lang.String, java.lang.Object)
     */
    int execute(String HQL, Object... params);

    /*
     * (非 Javadoc) <p>Title: executeSQL</p> <p>Description: </p>
     * @param SQL
     * @param params
     * @return
     * @see com.albedo.java.common.persistence.service.impl.IBaseUtilService#executeSQL(java.lang.String, java.lang.Object)
     */
    int executeSQL(String SQL, Object... params);

    /*
     * (非 Javadoc) <p>Title: executeCall</p> <p>Description: </p>
     * @param call
     * @param params
     * @see com.albedo.java.common.persistence.service.impl.IBaseUtilService#executeCall(java.lang.String, java.lang.Object)
     */
    void executeCall(String call, Object... params);

    public PageModel<?> findHQLPage(String QL, PageModel<?> pm, Object... params);

    public PageModel<?> findSQLPage(String QL, PageModel<?> pm, Object... params);

    public PageModel<?> findHQLPage(String QL, PageModel<?> pm, boolean isCal, boolean isCache, Object... params);

    public PageModel<?> findSQLPage(String QL, PageModel<?> pm, boolean isCal, boolean isCache, Object... params);

    public PageModel<?> findQLPage(String QL, PageModel<?> pm, boolean isSql, boolean isCal, boolean isCache,
                                   Object... params);

    public Long findCountByQL(String QL, boolean isSql, boolean isCache,
                              List<QueryCondition> conditionList, Object... params);

}
