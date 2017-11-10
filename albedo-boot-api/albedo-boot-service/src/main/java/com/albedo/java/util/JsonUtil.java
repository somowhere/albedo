package com.albedo.java.util;

import com.albedo.java.modules.sys.domain.Dict;
import com.albedo.java.util.annotation.DictType;
import com.albedo.java.util.annotation.JsonField;
import com.albedo.java.util.base.Collections3;
import com.albedo.java.util.base.Reflections;
import com.albedo.java.util.domain.PageModel;
import com.albedo.java.util.exception.RuntimeMsgException;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONException;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.annotation.JSONField;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import org.apache.commons.beanutils.PropertyUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.beans.PropertyDescriptor;
import java.lang.reflect.Field;
import java.time.ZonedDateTime;
import java.util.*;

/**
 * json操作常用类
 *
 * @author lijie version 2014-3-12 下午4:20:24
 */
@SuppressWarnings({"unchecked", "rawtypes"})
public class JsonUtil {

    protected static Logger logger = LoggerFactory.getLogger(JsonUtil.class);
    /**
     * 允许递归的属性名称集合
     */
    private static List<String> recurrenceStrList = Lists.newArrayList();
    /*** 验证是否属于自定义类 */
    private static List<String> className = Lists.newArrayList(Reflections.classPackge.split(","));
    private static JsonUtil json = new JsonUtil();
    /*** 指定当前从数据字典检索的kindIds */
    private static List<String> kindIds = Lists.newArrayList();
    private static String dateFormart = PublicUtil.TIME_FORMAT;
    /*** 需要从数据字典中查找的key */
    private static List<String> keyCodeItems = Lists.newArrayList();
    private static JSONObject codeItemData = new JSONObject();
    private static List<String> freeFilterList = Lists.newArrayList("class", "new", "persistentState", "pkName", "pk",
            "version");

    private JsonUtil() {
    }

    private static void initConfig() {
        dateFormart = PublicUtil.TIME_FORMAT;
        freeFilterList = Lists.newArrayList("class", "new", "persistentState", "pkName", "pk", "version");
        className = Lists.newArrayList(Reflections.classPackge.split(","));
        kindIds.clear();
        recurrenceStrList.clear();
        keyCodeItems.clear();
        codeItemData.clear();
    }

    public synchronized static JsonUtil getInstance() {
        initConfig();
        return json;
    }

    /**
     * 指定数据列从数据字典中获取(注意顺序对应)
     *
     * @param kindIds      kindId,kindId
     * @param keyCodeItems
     */
    public synchronized static JsonUtil getInstance(List<String> kindIds, String... keyCodeItems) {
        initConfig();
        if (PublicUtil.isNotEmpty(kindIds)) {
            addDictItem(kindIds, keyCodeItems);
        }
        return json;
    }

    private synchronized static void addDictItem(List<String> kindIds, String... keyCodeItems) {
        if (keyCodeItems != null) {
            for (int i = 0; i < keyCodeItems.length; i++) {
                if (!JsonUtil.keyCodeItems.contains(keyCodeItems[i])) {
                    JsonUtil.keyCodeItems.add(keyCodeItems[i]);
                }
            }
        }
        JsonUtil.kindIds.addAll(kindIds);
        Map<String, Object> maps = new HashMap<String, Object>();
        Map<String, String> map;
        List<Dict> itemList;
        for (String kid : kindIds) {
            if (codeItemData.get(kid) == null) {
                itemList = DictUtil.getAllDictList(kid);
                if (PublicUtil.isNotEmpty(itemList)) {
                    map = Maps.newHashMap();
                    for (Dict code : itemList) {
                        map.put(code.getVal(), code.getName());
                    }
                    maps.put(kid, map);
                }
            }
        }


        codeItemData.putAll(maps);
    }

    public static String toJsonString(Object obj) {
        return JSON.toJSONStringWithDateFormat(obj, dateFormart, SerializerFeature.WriteDateUseDateFormat);
    }

    /**
     * @param obj
     * @param recurrenceStr staff_name,staff_loginId
     * @return
     */
    public static String toJsonString(Object obj, String recurrenceStr) {
        JSON rs = JsonUtil.getInstance().removeFreeFilterList("version").setRecurrenceStr(recurrenceStr.split(","))
                .toJsonObject(obj);
        return rs.toJSONString();
    }

    /**
     * @param obj
     * @param recurrenceStr staff_name,staff_loginId
     * @param kindIdStr     kindId:valName,kindId:valName
     * @return
     */
    public static String toJsonString(Object obj, String recurrenceStr, String kindIdStr) {
        String[] kindIds = kindIdStr.split(",");
        String[] items = new String[kindIds.length];
        List<String> listKind = Lists.newArrayList();
        for (int i = 0; i < kindIds.length; i++) {
            listKind.add(kindIds[i].substring(0, kindIds[i].indexOf(":")));
            items[i] = kindIds[i].substring(kindIds[i].indexOf(":") + 1);
        }
        JSON rs = JsonUtil.getInstance(listKind, items).removeFreeFilterList("version")
                .setRecurrenceStr(recurrenceStr.split(",")).toJsonObject(obj);
        return rs.toJSONString();
    }

    /**
     * 追加免过滤实体字段名
     *
     * @param freeFilterList
     */
    @Deprecated
    public JsonUtil setFreeFilterList(List<String> freeFilterList) {
        JsonUtil.freeFilterList.addAll(freeFilterList);
        return this;
    }

    /**
     * 追加免过滤实体字段名
     *
     * @param freeFilters
     */
    public JsonUtil setFreeFilters(String... freeFilters) {
        JsonUtil.freeFilterList.addAll(Lists.newArrayList(freeFilters));
        return this;
    }

    /**
     * 追加免过滤实体字段名
     *
     * @param key
     */
    public JsonUtil removeFreeFilterList(String key) {
        JsonUtil.freeFilterList.remove(key);
        return this;
    }

    /**
     * 设置日期格式
     *
     * @param dateFormat
     * @return
     */
    public JsonUtil setDateFormat(String dateFormat) {
        if (PublicUtil.isNotEmpty(dateFormat)) {
            JsonUtil.dateFormart = dateFormat;
        }
        return this;
    }

    /**
     * 设置 允许递归的属性名称 多级用'_' 隔开 例如 staff_loginId ------> staffLoginId
     *
     * @param properties
     * @return
     */
    public JsonUtil setRecurrenceStr(String... properties) {
        recurrenceStrList.addAll(Lists.newArrayList(properties));
        return this;
    }

    /*** 设置自定义类 */
    public JsonUtil setClassName(String... className) {
        JsonUtil.className.addAll(Lists.newArrayList(className));
        return this;
    }

    private boolean checkClassName(String name) {
        boolean flag = false;
        if (className != null && PublicUtil.isNotEmpty(name)) {
            for (String item : className) {
                if (name.contains(item)) {
                    flag = true;
                    break;
                }
            }
        }
        return flag;
    }

    /**
     * @param list
     * @param attributes id,name 注意 属性前可跟前缀(re:)， 如 id|re:name 表示name从资源文件中加载
     * @return List<Map<String, Object>>
     * @throws JSONException
     */
    public List<Object> toListMap(List<Object[]> list, String attributes) throws JSONException {
        List<Object> resultList = null;
        if (PublicUtil.isNotEmpty(list) && PublicUtil.isNotEmpty(attributes) && attributes.contains("|")) {
            resultList = Lists.newArrayList();
            Map<String, Object> map = null;
            for (Object[] items : list) {
                if (PublicUtil.isNotEmpty(items)) {
                    map = arrayToMap(items, attributes);
                    resultList.add(map);
                }
            }
        }
        return resultList;
    }

    /**
     * @param list
     * @param attributes id|name 注意 属性前可跟前缀(re:)， 如 id|re:name 表示name从资源文件中加载
     * @return JSONArray
     * @throws JSONException
     */
    public JSONArray toListJSONArray(List<Object[]> list, String attributes) throws JSONException {
        JSONArray jsonArray = null;
        if (PublicUtil.isNotEmpty(list) && PublicUtil.isNotEmpty(attributes) && attributes.contains("|")) {
            List<Object> resultList = toListMap(list, attributes);
            if (PublicUtil.isNotEmpty(resultList)) {
                jsonArray = new JSONArray(resultList);
            }
        } else {
            jsonArray = new JSONArray();
        }
        return jsonArray;
    }

    /**
     * 将对象json化
     *
     * @param obj
     * @return
     */
    public JSON toJsonObject(Object obj) {
        JSONObject jsonObj = new JSONObject();
        if (obj != null) {
            if (obj instanceof Map) {
                Map map = (Map) obj;
                if (PublicUtil.isNotEmpty(map)) {
                    Map mapItem = Maps.newHashMap();
                    for (Iterator<?> iterator = map.keySet().iterator(); iterator.hasNext(); ) {
                        Object key = (Object) iterator.next(), val = map.get(key);
                        if (val == null) {
                            continue;
                        }
                        if (val instanceof Collection) {
                            mapItem.put(key, toJsonArray((List<Object>) val));
                        } else if (checkClassName(val.getClass().getName())) {
                            mapItem.put(key, objToMap(val));
                        } else {
                            mapItem.put(key, getVal(obj, val, String.valueOf(key)));
                        }
                    }
                    jsonObj = new JSONObject(mapItem);
                }
            } else if (checkClassName(obj.getClass().getName())) {
                Map<String, Object> map = objToMap(obj);
                jsonObj = new JSONObject(map);
            } else if (obj instanceof Collection) {
                return toJsonArray((Collection) obj);
            } else {
                jsonObj.put(null, obj);
            }
        }
        return jsonObj;
    }

    public JSONArray toJsonArray(Collection col) {
        JSONArray jsonArray = new JSONArray();
        if (PublicUtil.isNotEmpty(col)) {
            Object object = col.toArray()[0];
            if (object != null && !checkClassName(object.getClass().getName())) {
                for (Object obj : col) {
                    jsonArray.add(toJsonObject(obj));
                }
            } else {
                List<Object> targert = Lists.newArrayList();
                for (Iterator<?> iterator = col.iterator(); iterator.hasNext(); ) {
                    object = (Object) iterator.next();
                    Map<String, Object> map = objToMap(object);
                    targert.add(map);
                }
                if (PublicUtil.isNotEmpty(targert)) {
                    jsonArray.addAll(targert);
                }
            }
        }
        return jsonArray;
    }

    /**
     * 将分页对象（注意 pm.data类型必须为List< Object[] > 否则请调用toJsonObject）json化
     *
     * @param pm
     * @param attributes attributes id|name 注意 属性前可跟前缀(re:)， 如 id|re:name
     *                   表示name从资源文件中加载
     * @return
     */
    public JSONObject toJsonPageObject(PageModel<?> pm, String attributes) {
        JSONObject jsonObj = null;
        if (pm != null) {
            Map<String, Object> map = objToMap(pm, false);
            List<Object> list = toListMap((List<Object[]>) map.get(PageModel.F_DATA), attributes);
            map.put(PageModel.F_DATA, list);
            jsonObj = new JSONObject(map);
        } else {
            jsonObj = new JSONObject();
        }
        return jsonObj;
    }

    /**
     * 将数组转换为map
     *
     * @param objs
     * @param attributes
     * @return
     */
    public Map<String, Object> arrayToMap(Object[] objs, String attributes) {
        Map<String, Object> maps = new HashMap<String, Object>();
        try {
            if (PublicUtil.isNotEmpty(objs)) {
                String attr = null;
                Object val = null;
                List<String> attList = StringUtil.parseStringTokenizer(attributes, "|");
                for (int i = 0; i < attList.size(); i++) {
                    attr = attList.get(i);
                    if (attr.contains(".")) {
                        attr = attr.replace(".", "_");
                    }
                    if (PublicUtil.isNotEmpty(kindIds) && PublicUtil.isNotEmpty(codeItemData)
                            && PublicUtil.isNotEmpty(keyCodeItems) && keyCodeItems.contains(attr)) {
                        val = codeItemData.getJSONObject(kindIds.get(keyCodeItems.indexOf(attr))).get((String) objs[i]);
                    } else {
                        val = objs[i];
                    }
                    if (val instanceof Date) {
                        val = PublicUtil.fmtDate((Date) val, dateFormart);
                    }
                    maps.put(attr, val);
                }
            }
        } catch (Exception e) {
            logger.error("在将数组转换成Map的arrayToMap中出现异常对象-->" + e.getMessage());
            e.printStackTrace();
        }

        return maps;
    }

    /**
     * 将obj转换为map
     *
     * @param obj
     * @param clsName 前缀 ，通常不传参
     * @return
     */
    public Map<String, Object> objToMap(Object obj, String... clsName) {
        return objToMap(obj, true, clsName);
    }

    /**
     * 将obj转换为map
     *
     * @param obj
     * @param flag    是否处理分页对象中的data
     * @param clsName 前缀 ，通常不传参
     * @return
     */
    public Map<String, Object> objToMap(Object obj, boolean flag, String... clsName) {
        Map<String, Object> maps = new HashMap<String, Object>();
        try {

            if (obj != null) {
                if (PublicUtil.isEmpty(className)) {
                    throw new RuntimeMsgException("自定义class为空,无法正常解析对象");
                }
                // Get annotation field
                PropertyDescriptor[] ps = PropertyUtils.getPropertyDescriptors(obj);
                Object val = null, objTemp = null, objVal = null;
                String key = null;
                for (PropertyDescriptor p : ps) {
                    key = p.getName();
                    if (freeFilterList != null && freeFilterList.contains(key)) {
                        continue;
                    }
                    JSONField jf = null;
                    try {
                        jf = Reflections.getAnnotation(obj, key, JSONField.class);
                        if (jf != null && !jf.serialize()) {
                            JsonField tempjf = Reflections.getAnnotation(obj, key, JsonField.class);
                            if (tempjf == null) {
                                continue;
                            }
                        }
                    } catch (Exception e) {
                    }
                    try {
                        PropertyUtils.getProperty(obj, key);
                    } catch (Exception e) {
                        continue;
                    }
                    val = PropertyUtils.getProperty(obj, key);
//					if (val instanceof PersistentBag)
//						continue;
                    if (PublicUtil.isNotEmpty(clsName)) {
                        List<String> argList = Lists.newArrayList(clsName);
                        key = PublicUtil.toAppendStr(Collections3.convertToString(argList, "_"), "_", key);
                    }
                    if (PublicUtil.isEmpty(val) && jf != null && jf.serialzeFeatures() != null) {
                        mapPutValue(maps, getKey(key, jf), val);
                    }
                    if (val instanceof Collection<?> && flag) {
                        Iterator<?> iter = ((Collection<?>) val).iterator();
                        List<Object> list = Lists.newArrayList();
                        while (iter.hasNext()) {
                            objTemp = iter.next();
                            if (checkClassName(objTemp.getClass().getName())) {
                                list.add(objToMap(objTemp));
                            } else {
                                list.add(toJsonObject(objTemp));
                            }
                        }
                        mapPutValue(maps, getKey(key, jf), list);
                    } else {
                        boolean falg = false;
                        try {
                            falg = checkClassName(p.getPropertyType().toString())
                            // || checkClassName(val.toString())
                            ;
                        } catch (Exception e) {
                            val = null;
                            continue;
                        }
                        if (falg) {
                            List<String> tempReKey = Lists.newArrayList();
                            if (PublicUtil.isNotEmpty(recurrenceStrList) && !key.contains("_")) {
                                for (String reKey : recurrenceStrList) {
                                    if (reKey.startsWith(PublicUtil.toAppendStr(key, "_"))
                                            && reKey.indexOf("_") != -1) {
                                        tempReKey.add(reKey);
                                    }
                                }
                            }
                            if (PublicUtil.isNotEmpty(tempReKey)) {
                                for (String tempKey : tempReKey) {
                                    String[] pros = tempKey.split("_");
                                    objVal = val;
                                    for (int i = 1; i < pros.length; i++) {
                                        if (objVal != null) {
                                            objVal = getFieldDictValue(objVal, pros[i]);
                                        }
                                    }
                                    mapPutValue(maps, getKey(tempKey, jf), getVal(obj, objVal, tempKey));
                                }
                            }
                            if (recurrenceStrList != null && recurrenceStrList.contains(key)) {
                                recurrenceStrList.remove(p.getName());
                                maps.putAll(objToMap(val, p.getName()));
                                recurrenceStrList.add(p.getName());
                            }
                            continue;
                        }
                        mapPutValue(maps, getKey(key, jf), getVal(obj, val, key));
                    }
                }
            }
        } catch (Exception e) {
            logger.error("在将对象转换成Map的ObjToMap中出现异常对象-->" + e.getMessage());
            e.printStackTrace();
        }
        return maps;
    }

    private Object getFieldDictValue(final Object obj, final String fieldName) {
        Field field = Reflections.getAccessibleField(obj, fieldName);

        if (field == null) {
            return null;
        }

        Object result = null;
        try {
            result = field.get(obj);
            DictType type = Reflections.getAnnotation(obj, fieldName, DictType.class);
            if (type != null) {
                String kindId = type.name();
                if (PublicUtil.isEmpty(keyCodeItems) || !keyCodeItems.contains(fieldName)) {
                    addDictItem(Lists.newArrayList(kindId), fieldName);
                }
                result = getDictVal(result, kindId, fieldName);
            }
        } catch (IllegalAccessException e) {
            logger.error("不可能抛出的异常{}", e.getMessage());
        }
        return result;
    }

    private String getKey(String key, JSONField jf) {
        try {
            if (jf != null && PublicUtil.isNotEmpty(jf.name())) {
                key = jf.name();
            }
        } catch (Exception e) {
        }
        return StringUtil.toCamelCase(key);
    }


    private JSONObject getCodeItemData(String kindId, String key) {
        JSONObject jobj = codeItemData.getJSONObject(kindId);
        if (jobj == null) {
            addDictItem(Lists.newArrayList(kindId), key);
        }
        jobj = codeItemData.getJSONObject(kindId);
        return jobj;
    }

    private Object getDictVal(Object val, String kindId, String key) {
        JSONObject jobj = getCodeItemData(kindId, key);
        if (jobj != null) {
            String valStr = val + "";
            if (valStr.contains(",")) {
                StringBuffer temp = new StringBuffer();
                String[] vals = valStr.split(",");
                for (String item : vals) {
                    if (PublicUtil.isNotEmpty(item)) {
                        temp.append(jobj.get(item)).append(",");
                    }
                }
                if (temp.length() > 0) {
                    temp.deleteCharAt(temp.length() - 1);
                }
                val = temp.toString();
            } else {
                val = jobj.get(valStr);
            }
        } else {
            logger.warn("无法查询到kindId {} val {}  的字典对象", kindId, val);
        }
        return val;
    }

    private void mapPutValue(Map<String, Object> maps, String key, Object val) {
        boolean containValAndNotEmpty = (maps.containsKey(key) && PublicUtil.isNotEmpty(val));
        if (!maps.containsKey(key) || containValAndNotEmpty) {
            maps.put(key, val);
        }
    }

    private Object getVal(Object obj, Object val, String key) {
        if (PublicUtil.isNotEmpty(kindIds) && PublicUtil.isNotEmpty(keyCodeItems) && keyCodeItems.contains(key)) {
            val = getDictVal(val, kindIds.get(keyCodeItems.indexOf(key)), key);
        } else {
            Object temp = getFieldDictValue(obj, key);
            if (temp != null) {
                val = temp;
            }
        }
        if (val instanceof Date) {
            val = PublicUtil.fmtDate((Date) val, dateFormart);
        }
        if (val instanceof ZonedDateTime) {
            val = PublicUtil.fmtDate((ZonedDateTime) val, dateFormart);
        }
        return val;
    }

}
