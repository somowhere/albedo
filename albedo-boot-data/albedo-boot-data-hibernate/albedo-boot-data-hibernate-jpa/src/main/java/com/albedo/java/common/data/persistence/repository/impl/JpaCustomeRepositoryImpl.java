package com.albedo.java.common.data.persistence.repository.impl;

import com.albedo.java.common.data.persistence.repository.JpaCustomeRepository;
import com.albedo.java.common.domain.base.BaseEntity;
import com.albedo.java.common.domain.base.GeneralEntity;
import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.QueryUtil;
import com.albedo.java.util.base.Reflections;
import com.albedo.java.util.domain.*;
import com.albedo.java.util.domain.QueryCondition.Operator;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.jdbc.Work;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

@Component
@Transactional
public class JpaCustomeRepositoryImpl<T extends BaseEntity> implements JpaCustomeRepository<T> {
    protected Logger logger = LoggerFactory.getLogger(getClass());

    @PersistenceContext
    private EntityManager em;

    /*
     * (non-Javadoc)
     *
     * @see com.albedo.java.repository.data.support.Itest#getSession()
     */
    @Override
    public Session getSession() {
        return (Session) em.getDelegate();
    }

    /*
     * (non-Javadoc)
     *
     * @see com.albedo.java.repository.data.support.Itest#flush()
     */
    @Override
    public void flush() {
        getSession().flush();
    }

    /*
     * (non-Javadoc)
     *
     * @see com.albedo.java.repository.data.support.Itest#clear()
     */
    @Override
    public void clear() {
        getSession().clear();
    }

    /**
     * 自动将参数注入到Query对象中
     *
     * @param HQL
     * @param query
     * @param params
     */
    private void setParams(String HQL, Query query, Map<String, Object> params) {
        if (PublicUtil.isNotEmpty(params)) {
            logger.info("params {}", params);
            Iterator<String> keys = params.keySet().iterator();
            String key = "";
            Object val = null;
            StringBuffer sb = new StringBuffer();
            while (keys.hasNext()) {
                key = keys.next();
                val = params.get(key);
                if (!HQL.contains(PublicUtil.toAppendStr(":", key))) {
                    logger.warn("多余的参数:" + key + ",值：" + val);
                    continue;
                }
                sb.append(key).append("=").append(val).append(", ");
                query.setParameter(key, val);
            }
            logger.info(sb.toString());
        }
    }

    /*
     * (非 Javadoc) <p>Title: clearLevel2Cache</p> <p>Description: </p>
     *
     * @see com.albedo.java.common.persistence.service.impl.IBaseUtilService#
     * clearLevel2Cache()
     */
    /*
     * (non-Javadoc)
	 * 
	 * @see com.albedo.java.repository.data.support.Itest#createQuery(java.lang.
	 * String, java.lang.Object)
	 */
    @Override
    public Query createQuery(String HQL, Object... params) {
        Query query = getSession().createQuery(HQL);
        Map<String, Object> map = new Parameter(params);
        setParams(HQL, query, map);
        return query;
    }

    @Override
    public SQLQuery createSqlQuery(String SQL, Object... params) {
        SQLQuery query = getSession().createSQLQuery(SQL);
        Map<String, Object> map = new Parameter(params);
        setParams(SQL, query, map);
        return query;
    }

    /*
     * (non-Javadoc)
     *
     * @see com.albedo.java.repository.data.support.Itest#checkByProperty(T)
     */
    @Override
    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public boolean doCheckByProperty(T entity) {
        boolean rs = false;
        Map<String, Operator> maps = Maps.newHashMap();
        try {
            maps.put(BaseEntity.F_ID, Operator.ne);
            maps.put(BaseEntity.F_STATUS, Operator.ne);
            Reflections.setProperty(entity, BaseEntity.F_STATUS, GeneralEntity.FLAG_DELETE);
        } catch (Exception e) {
            logger.error(e.toString());
        }
        if (PublicUtil.isNotEmpty(entity)) {
            List<QueryCondition> conditionList = QueryUtil.convertObjectToQueryCondition(entity, maps);
            Long obj = findCountByClass(entity.getClass(), conditionList);
            if (obj == null || obj == 0) {
                rs = true;
            }
        }
        return rs;
    }

    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public Long findCountByClass(Class<?> clazz, List<QueryCondition> conditionList) {
        String hql = PublicUtil.toAppendStr("select count(*) from ", clazz.getName());
        return (Long) findObjectByHQL(hql, conditionList);
    }

    /*
     * (non-Javadoc)
     *
     * @see com.albedo.java.repository.data.support.Itest#checkByPK(T)
     */
    @Override
    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public boolean doCheckByPK(T entity) {
        boolean rs = false;
        Map<String, Operator> maps = Maps.newHashMap();
        try {
            maps.put(BaseEntity.F_STATUS, Operator.ne);
            Reflections.setProperty(entity, BaseEntity.F_STATUS, GeneralEntity.FLAG_DELETE);
        } catch (Exception e) {
            logger.error(e.toString());
        }
        if (PublicUtil.isNotEmpty(entity)) {
            List<QueryCondition> conditionList = QueryUtil.convertObjectToQueryCondition(entity, maps);
            Long obj = findCountByClass(entity.getClass(), conditionList);
            if (obj == null || obj == 0) {
                rs = true;
            }
        }
        return rs;
    }

    @Override
    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public List<ComboData> findJson(Combo combo) {
        List<ComboData> mapList = Lists.newArrayList();
        if (PublicUtil.isNotEmpty(combo) && PublicUtil.isNotEmpty(combo.getId())
                && PublicUtil.isNotEmpty(combo.getName()) && PublicUtil.isNotEmpty(combo.getModule())) {
            StringBuffer sb = new StringBuffer("select ").append(combo.getId()).append(",").append(combo.getName());
            boolean flag = PublicUtil.isNotEmpty(combo.getParentId());
            if (flag) {
                sb.append(",").append(combo.getParentId());
            }
            sb.append(" from ").append(combo.getName()).append(" where status!=").append(BaseEntity.FLAG_NORMAL);
            if (PublicUtil.isNotEmpty(combo.getWhere())) {
                sb.append(" and ").append(combo.getWhere());
            }
            List<Object[]> rsList = (List<Object[]>) findListByHQL(sb.toString());
            for (Object[] o : rsList) {
                ComboData data = new ComboData();
                data.setId(PublicUtil.toStrString(o[0]));
                data.setName(PublicUtil.toStrString(o[1]));
                Map<String, Object> map = Maps.newHashMap();
                if (flag)
                    data.setPId(PublicUtil.toStrString(o[2]));
                mapList.add(data);
            }
        }
        return mapList;
    }

    @Override
    public int execute(String HQL, Object... params) {
        Query query = createQuery(HQL, params);
        return query.executeUpdate();
    }

    /*
     * (非 Javadoc) <p>Title: executeSQL</p> <p>Description: </p>
     *
     * @param SQL
     *
     * @param params
     *
     * @return
     *
     * @see com.albedo.java.common.persistence.service.impl.IBaseUtilService#
     * executeSQL( java.lang.String, java.lang.Object)
     */
    /*
     * (非 Javadoc) <p>Title: executeSQL</p> <p>Description: </p>
	 * 
	 * @param SQL
	 * 
	 * @param params
	 * 
	 * @return
	 * 
	 * @see com.albedo.java.common.persistence.service.impl.IBaseUtilService#
	 * executeSQL( java.lang.String, java.lang.Object)
	 */
    @Override
    public int executeSQL(String SQL, Object... params) {
        Query query = createSqlQuery(SQL, params);
        return query.executeUpdate();
    }

	/*
     * (非 Javadoc) <p>Title: executeCall</p> <p>Description: </p>
	 * 
	 * @param call
	 * 
	 * @param params
	 * 
	 * @see com.albedo.java.common.persistence.service.impl.IBaseUtilService#
	 * executeCall( java.lang.String, java.lang.Object)
	 */

    @Transactional(readOnly = false, rollbackFor = Exception.class)
    public void executeCall(final String call, final Object... params) {
        getSession().doWork(new Work() {
            public void execute(Connection conn) {
                CallableStatement cstmt = null;
                try {
                    cstmt = conn.prepareCall(call);
                    if (params != null && params.length != 0) {
                        for (int i = 0; i < params.length; i++) {
                            cstmt.setObject((i + 1), params[i]);
                        }
                        // cstmt.registerOutParameter(params.length + 1,
                        // Types.INTEGER);
                        cstmt.execute();
                    }
                } catch (SQLException e) {
                    logger.error(e.getMessage());
                    throw new RuntimeException(e);
                }
            }
        });
    }

    @Override
    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public Object findByHQL(String HQL, boolean isList, List<QueryCondition> conditionList, Object... params) {
        return findByQL(HQL, false, false, isList, 0, conditionList, params);
    }

    @Override
    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public Object findByHQL(String HQL, boolean isList, int maxSize, List<QueryCondition> conditionList,
                            Object... params) {
        return findByQL(HQL, false, false, isList, maxSize, conditionList, params);
    }

    @Override
    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public List findListSizeByHQL(String HQL, int maxSize, List<QueryCondition> conditionList, Object... params) {
        return (List) findByQL(HQL, false, false, true, maxSize, conditionList, params);
    }

    @Override
    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public List findListSizeByHQL(String HQL, int maxSize, Object... params) {
        return (List) findByQL(HQL, false, false, true, maxSize, null, params);
    }

    @Override
    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public List findListByHQL(String HQL, List<QueryCondition> conditionList, Object... params) {
        return (List) findByQL(HQL, false, false, true, 0, conditionList, params);
    }

    @Override
    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public List findListByHQL(String HQL, Object... params) {
        return (List) findByQL(HQL, false, false, true, 0, null, params);
    }

    @Override
    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public List<T> findEntityListByHQL(String HQL, int maxSize, List<QueryCondition> conditionList, Object... params) {
        return (List<T>) findByQL(HQL, false, false, true, maxSize, conditionList, params);
    }

    @Override
    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public List<T> findEntityListByHQL(String HQL, int maxSize, Object... params) {
        return (List<T>) findByQL(HQL, false, false, true, maxSize, null, params);
    }

    @Override
    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public List<T> findEntityListByHQL(String HQL, List<QueryCondition> conditionList, Object... params) {
        return (List<T>) findByQL(HQL, false, false, true, 0, conditionList, params);
    }

    @Override
    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public List<T> findEntityListByHQL(String HQL, Object... params) {
        return (List<T>) findByQL(HQL, false, false, true, 0, null, params);
    }

    @Override
    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public Object findObjectByHQL(String HQL, List<QueryCondition> conditionList, Object... params) {
        return findByQL(HQL, false, false, false, 0, conditionList, params);
    }

    @Override
    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public Object findObjectByHQL(String HQL, Object... params) {
        return findByQL(HQL, false, false, false, 0, null, params);
    }

    @Override
    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public T findEntityByHQL(String HQL, List<QueryCondition> conditionList, Object... params) {
        return (T) findByQL(HQL, false, false, false, 0, conditionList, params);
    }

    @Override
    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public T findEntityByHQL(String HQL, Object... params) {
        return (T) findByQL(HQL, false, false, false, 0, null, params);
    }

    @Override
    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public Object findBySQL(String SQL, boolean isList, List<QueryCondition> conditionList, Object... params) {
        return findByQL(SQL, true, false, isList, 0, conditionList, params);
    }

    @Override
    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public Object findBySQL(String SQL, boolean isList, int maxSize, List<QueryCondition> conditionList,
                            Object... params) {
        return findByQL(SQL, true, false, isList, maxSize, conditionList, params);
    }

    @Override
    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public List findListSizeBySQL(String SQL, int maxSize, List<QueryCondition> conditionList, Object... params) {
        return (List) findByQL(SQL, true, false, true, maxSize, conditionList, params);
    }

    @Override
    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public List findListSizeBySQL(String SQL, int maxSize, Object... params) {
        return (List) findByQL(SQL, true, false, true, maxSize, null, params);
    }

    @Override
    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public List findListBySQL(String SQL, List<QueryCondition> conditionList, Object... params) {
        return (List) findByQL(SQL, true, false, true, 0, conditionList, params);
    }

    @Override
    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public List findListBySQL(String SQL, Object... params) {
        return (List) findByQL(SQL, true, false, true, 0, null, params);
    }

    @Override
    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public Object findObjectBySQL(String SQL, List<QueryCondition> conditionList, Object... params) {
        return findByQL(SQL, true, false, false, 0, conditionList, params);
    }

    @Override
    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public Object findObjectBySQL(String SQL, Object... params) {
        return findByQL(SQL, true, false, false, 0, null, params);
    }

    @Override
    @Transactional(readOnly = true, rollbackFor = Exception.class)
    public Object findByQL(String QL, boolean isSql, boolean isCache, boolean isList, int maxSize,
                           List<QueryCondition> conditionList, Object... params) {
        try {
            Map<String, Object> map = Maps.newHashMap();
            if (PublicUtil.isNotEmpty(conditionList)) {
                QL = QueryUtil.convertJsonToQueryCondition(QL, conditionList, null, map);
            }
            Query query = isSql ? createSqlQuery(QL, map, params) : createQuery(QL, map, params);
            if (isCache) {
                query.setCacheable(true);
            }
            if (isList && maxSize != 0) {
                query.setMaxResults(maxSize);
                maxSize = 0;
            }
            List lst = query.list();
            lst = parseSqlRsList(lst, isSql, QL);
            if (!isList) {
                return PublicUtil.isNotEmpty(lst) ? lst.get(0) : null;
            } else {
                return lst;
            }
        } catch (Exception e) {
            logger.error("QL------->" + QL);
            logger.error(e.getMessage());
            throw new RuntimeException(e);
        }
    }

    public List parseSqlRsList(List lst, boolean isSql, String QL) {
        if (lst != null && lst.size() > 0) {
            if (isSql && (QL.contains(" as ") || QL.contains(" AS "))) {
                int fromIndex = QueryUtil.findOuterFromIndex(QL.toUpperCase());
                String columnStr = QL.substring(7, fromIndex);
                String[] columns = QueryUtil.getColumnNames3(columnStr);
                List<Map<String, Object>> rsList = Lists.newArrayList();
                Map<String, Object> map = Maps.newHashMap();
                for (Object item : lst) {
                    map = Maps.newHashMap();
                    if (item != null && item.getClass().isArray()) {
                        Object[] items = (Object[]) item;
                        for (int i = 0; i < items.length; i++) {
                            String key = columns[i];
                            map.put((key.indexOf(",") != -1 ? key.substring(0, key.indexOf(",")) : key).replace(" ",
                                    ""), items[i]);
                        }
                    } else {
                        for (int i = 0; i < columns.length; i++) {
                            String key = columns[i];
                            map.put((key.indexOf(",") != -1 ? key.substring(0, key.indexOf(",")) : key).replace(" ",
                                    ""), item);
                        }
                    }
                    rsList.add(map);
                }
                if (rsList != null && rsList.size() > 0) {
                    lst = rsList;
                }
            }
        }
        return lst;
    }


    @Override
    public PageModel<T> findHQLPage(String QL, PageModel pm, Object... params) {
        return findQLPage(QL, pm, false, true, false, params);
    }

    @Override
    public PageModel<T> findSQLPage(String QL, PageModel pm, Object... params) {
        return findQLPage(QL, pm, true, true, false, params);
    }

    @Override
    public PageModel<T> findHQLPage(String QL, PageModel pm, boolean isCal, boolean isCache, Object... params) {
        return findQLPage(QL, pm, false, isCal, isCache, params);
    }

    @Override
    public PageModel<T> findSQLPage(String QL, PageModel pm, boolean isCal, boolean isCache, Object... params) {
        return findQLPage(QL, pm, true, isCal, isCache, params);
    }

    @Override
    public PageModel<T> findQLPage(String QL, PageModel pm, boolean isSql, boolean isCal, boolean isCache,
                                   Object... params) {
        if (pm == null) {
            return null;
        }

        List<QueryCondition> conditions = QueryUtil.convertJsonToQueryCondition(pm.getQueryConditionJson());

        if (pm.getPageNumber() < 0 || pm.getPageSize() <= 0) {
            pm.setData((List) findByQL(QL, isSql, isCache, true, 0, conditions, params));
        } else {
            pm.setRecordsTotal(findCountByQL(getCountHQL(QL), isSql, isCache, conditions, params));
            pm.setData(getPageModelData(QL, isSql, pm, isCache, isCal, conditions, params));
        }
        return pm;
    }

    @Override
    public Long findCountByQL(String QL, boolean isSql, boolean isCache,
                              List<QueryCondition> conditionList, Object... params) {
        try {
            Map<String, Object> map = Maps.newHashMap();
            if (PublicUtil.isNotEmpty(conditionList)) {
                QL = QueryUtil.convertJsonToQueryCondition(QL, conditionList, null, map);
            }
            Query query = isSql ? createSqlQuery(QL, map, params) : createQuery(QL, map, params);
            if (isCache) {
                query.setCacheable(true);
            }
            List lst = query.list();
            if (PublicUtil.isNotEmpty(lst)) {
                return PublicUtil.parseLong((lst.size() == 1 ? lst.get(0) : lst.size()), 0l);
            } else {
                return 0L;
            }
        } catch (Exception e) {
            logger.error("QL------->" + QL);
            logger.error(e.getMessage());
            throw new RuntimeException(e);
        }
    }

    /**
     * 根据原始分页HQL获取总记录条数的HQL
     *
     * @param HQL
     * @return
     */
    private String getCountHQL(String HQL) {
        StringBuffer sb = new StringBuffer();
        try {
            String temp = "", tempSql = HQL.toUpperCase();
            if (tempSql.indexOf("SELECT") != -1) {
                temp = HQL.substring(QueryUtil.findOuterFromIndex(tempSql));
            } else {
                temp = HQL;
            }
            if (tempSql.indexOf(" ORDER BY") != -1) {
                int orderIndex = temp.indexOf(" order by");
                if (orderIndex == -1) {
                    orderIndex = temp.indexOf(" ORDER BY");
                }
                temp = temp.substring(0, orderIndex);
            }
            sb.append("select count(*) ");
            sb.append(temp);

        } catch (Exception e) {
            logger.error("在根据原始分页HQL获取总记录条数的HQL时出现异常，异常SQL-->" + HQL);
            logger.error(e.getMessage());
        }
        return sb.toString();
    }

    /**
     * 获取分页的数据
     *
     * @param QL
     * @param isSql
     * @param pm
     * @param isCache
     * @param isCal
     * @param conditionList
     * @param params
     * @return
     */
    private List<T> getPageModelData(String QL, boolean isSql, PageModel pm, boolean isCache, boolean isCal,
                                     List<QueryCondition> conditionList,
                                     Object... params) {
        try {
            Map<String, Object> map = Maps.newHashMap();
            if (PublicUtil.isNotEmpty(conditionList)) {
                QL = QueryUtil.convertJsonToQueryCondition(QL, conditionList, null, map);
            }
            Query query = isSql ? createSqlQuery(QL, map, params) : createQuery(QL, map, params);
            query.setMaxResults(pm.getPageSize());
            query.setFirstResult(isCal ? (pm.getPageNumber() - 1) * pm.getPageSize() : 0);
            if (isCache) {
                query.setCacheable(true);
            }
            List lst = query.list();
            return parseSqlRsList(lst, isSql, QL);
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("在获取分页数据源的getData()出现异常，异常HQL-->" + QL);
            logger.error(e.getMessage());
        }
        return null;
    }


}
