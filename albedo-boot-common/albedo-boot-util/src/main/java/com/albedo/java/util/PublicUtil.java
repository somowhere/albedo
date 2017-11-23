package com.albedo.java.util;

import com.albedo.java.util.base.Reflections;
import com.albedo.java.util.domain.ComboData;
import com.google.common.collect.Lists;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.lang.reflect.Array;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * copyright 2014 albedo all right reserved author 李杰 created on 2014年12月12日 上午9:22:09
 */
@SuppressWarnings({"rawtypes", "unchecked"})
public class PublicUtil {
    /**
     * 日期格式：yyyy-MM-dd
     */
    public static final String DATA_FORMAT = "yyyy-MM-dd";
    /**
     * 日期格式：yyyyMMdd
     */
    public static final String DATA_FORMAT_CLEAR = "yyyyMMdd";
    /**
     * 时间格式：yyyy-MM-dd HH:mm:ss
     */
    public static final String TIME_FORMAT = "yyyy-MM-dd HH:mm:ss";
    /**
     * 时间格式：yyyy-MM-dd HH:mm:ss.sss
     */
    public static final String TIME_FORMAT_S = "yyyy-MM-dd HH:mm:ss.sss";
    protected static Logger logger = LoggerFactory.getLogger(PublicUtil.class);

    /**
     * 转换html标签
     *
     * @param str
     * @return
     */
    public static String toShowHtml(String str) {
        if (str == null)
            return null;
        String html = new String(str);
        html = replace(html, "&amp;", "&");
        html = replace(html, "&lt;", "<");
        html = replace(html, "&gt;", ">");
        html = replace(html, "&quot;", "\"");
        html = replace(html, "<br>", "\n"); // 处理换行符
        return html;
    }

    public static Boolean containsStr(String source, String str) {
        return PublicUtil.isNotEmpty(source) && source.contains(str);
    }

    /**
     * 获取字符长度，一个汉字作为 1 个字符, 一个英文字母作为 0.5 个字符
     *
     * @param text
     * @return 字符长度，如：text="中国",返回 2；text="test",返回 2；text="中国ABC",返回 4.
     */
    public static int getLength(String text) {
        int textLength = text.length();
        int length = textLength;
        for (int i = 0; i < textLength; i++) {
            if (String.valueOf(text.charAt(i)).getBytes().length > 1) {
                length++;
            }
        }
        return (length % 2 == 0) ? length / 2 : length / 2 + 1;
    }

    /**
     * 网页显示字符串 去除字符串中的空格、回车、换行符、制表符并 切割最大长度 (一个汉字作为 1 个字符, 一个英文字母作为 0.5 个字符)
     *
     * @param str
     * @return
     */
    public static String subMaxString(String str, Integer length) {
        if (PublicUtil.isNotEmpty(str) && str.length() > length) {
            Integer realLength = 0, len = str.length();
            for (int i = 0; i < len; i++) {
                if (String.valueOf(str.charAt(i)).getBytes().length > 1) {
                    realLength += 2;
                } else {
                    realLength += 1;
                }
                if (realLength > length) {
                    str = PublicUtil.toAppendStr(replaceBlank(str).substring(0, i), "...");
                    break;
                }
            }
        }
        return str;
    }

    /**
     * 去除字符串中的空格、回车、换行符、制表符
     *
     * @param str
     * @return
     */
    public static String replaceBlank(String str) {
        String dest = "";
        if (PublicUtil.isNotEmpty(str)) {
            Pattern p = Pattern.compile("\\s*|\t|\r|\n");
            Matcher m = p.matcher(str);
            dest = m.replaceAll("");
        }
        return dest;
    }

    /**
     * 功能：字符串替换，将 source 中的 oldString 全部换成 newString 参数：@param source 源字符串
     *
     * @param oldString 老的字符串
     * @param newString 新的字符串 返回值：替换后的字符串 建立日期：2004-7-12 作者：蔡华锋 最后修改： 修改人：
     */
    public static String replace(String source, String oldString, String newString) {
        StringBuffer output = new StringBuffer();

        if (source.equals("") || source == null)
            return "";
        int lengthOfSource = source.length(); // 源字符串长度
        int lengthOfOld = oldString.length(); // 老字符串长度

        int posStart = 0; // 开始搜索位置
        int pos; // 搜索到老字符串的位置

        while ((pos = source.indexOf(oldString, posStart)) >= 0) {
            output.append(source.substring(posStart, pos));

            output.append(newString);
            posStart = pos + lengthOfOld;
        }

        if (posStart < lengthOfSource) {
            output.append(source.substring(posStart));
        }

        return output.toString();
    }

    /*
     * fn-hd rem: 由于特殊字符#+*等不能用String的replaceAll方法. 取代String类的replaceAll par: newStr -- 要替换的字符串 ret: 替换完毕的字符串 sep: pub: exp: aut: 陈雀明 log: 2004-09-29 创建
     */
    public static String replaceAll(String str, String oldStr, String newStr) {
        int length = str.indexOf(oldStr);
        int j = 0;
        String temp = "";
        while (length != -1) {
            j++;
            if (j == 10)
                break;
            temp = str.substring(length + 1);
            str = str.substring(0, length);
            str = str + newStr + temp;
            length = str.indexOf(oldStr);
        }
        return str;
    }

    /**
     * author: michael.yang time: 2006-2-13
     *
     * @param value
     * @param defaultValue
     * @return the value parsed, defaultValue returned if error happens
     */
    public static int parseInt(Object value, Integer defaultValue) {
        try {
            return Integer.parseInt(String.valueOf(value));
        } catch (Exception ex) {
            return defaultValue;
        }
    }

    public static long parseLong(Object value, Long defaultValue) {
        try {
            return Long.parseLong(String.valueOf(value));
        } catch (Exception ex) {
            return defaultValue;
        }
    }

    public static Date parseDate(Object date) {
        return parseDate(String.valueOf(date));
    }

    public static Date parseDate(String date) {
        try {
            SimpleDateFormat fmt = new SimpleDateFormat(TIME_FORMAT);
            return fmt.parse(date);
        } catch (Exception ex) {
            return null;
        }
    }

    public static Date parseDate(String date, String format) {
        try {
            SimpleDateFormat fmt = new SimpleDateFormat(format);
            return fmt.parse(date);
        } catch (Exception ex) {
            return null;
        }
    }

    /**
     * author: michael.yang time: 2006-2-14
     */
    public static String parseString(Object value, String defaultValue) {
        if (null == value || "null".equals(String.valueOf(value).toLowerCase())) {
            return defaultValue;
        }

        return String.valueOf(value);
    }

    public static String getCurrentTime() {
        return getCurrentTime(TIME_FORMAT);
    }

    public static Date getCurrentDate() {
        return new Date();
    }

    /**
     * Return current time in the pattern specified by arguement 'format'.
     *
     * @param format
     * @return the formatted current time
     */
    public static String getCurrentTime(String format) {
        Date nowTime = new Date();
        SimpleDateFormat fmt = new SimpleDateFormat(format);
        return fmt.format(nowTime);
    }

    public static String getMySQLDateTimeFormat() {
        return TIME_FORMAT;
    }

    public static String fmtDate(Date date, String fmt) {
        if (null == date)
            return "";
        SimpleDateFormat f = new SimpleDateFormat(fmt);
        return f.format(date);
    }

    public static String fmtDate(Date date) {
        if (null == date)
            return "";
        SimpleDateFormat f = new SimpleDateFormat(TIME_FORMAT);
        return f.format(date);
    }

    /**
     * 获取系统唯一ID
     *
     * @return
     */
    public static String getUUID() {
        String uid = "0";
        SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
        String tempId = sf.format(new Date());
        if (Long.parseLong(uid) >= Long.parseLong(tempId))
            uid = (Long.parseLong(uid) + 1) + "";
        else
            uid = tempId;

        return uid + getRandomString(10);
    }

    public static String getRandomString(int size) {
        char[] c = {'1', '2', '3', '4', '5', '6', '7', '8', '9', '0', 'q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p', 'a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', 'z', 'x', 'c', 'v', 'b', 'n', 'm'};
        Random random = new Random();
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < size; ++i)
            sb.append(c[(Math.abs(random.nextInt()) % c.length)]);

        return sb.toString();
    }

    public static String getRandomNumber(int size) {
        char[] c = {'1', '2', '3', '4', '5', '6', '7', '8', '9', '0'};
        Random random = new Random();
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < size; ++i) {
            sb.append(c[(Math.abs(random.nextInt()) % c.length)]);
        }
        return sb.toString();
    }


    /**
     * 判断某个对象是否为空 集合类、数组做特殊处理
     *
     * @param obj
     * @return 如为不空，集合size>0|字符串不为空串|数组length>0 返回true,否则false
     * @author lijie
     */
    public static boolean isNotEmpty(Object obj) {
        return !isEmpty(obj);
    }

    /**
     * 判断某个对象是否为空 集合类、数组做特殊处理
     *
     * @param obj
     * @return 如为空，返回true,否则false
     * @author lijie
     */
    public static boolean isEmpty(Object obj) {
        if (obj == null)
            return true;
        // 如果不为null，需要处理几种特殊对象类型
        if (obj instanceof String) {
            return obj.equals("");
        } else if (obj instanceof Collection) {
            // 对象为集合
            Collection coll = (Collection) obj;
            return coll.size() == 0;
        } else if (obj instanceof Map) {
            // 对象为Map
            Map map = (Map) obj;
            return map.size() == 0;
        } else if (obj.getClass().isArray()) {
            // 对象为数组
            return Array.getLength(obj) == 0;
        } else {
            // 其他类型，只要不为null，即不为empty
            return false;
        }
    }

    /**
     * 字符串是否为数字
     *
     * @param str
     * @return
     */
    public static boolean isDigitalString(String str) {
        if (isEmpty(str)) {
            return false;
        } else {
            try {
                Double.parseDouble(str);
                return true;
            } catch (Exception e) {
                return false;
            }
        }
    }

    /**
     * 字符串是true
     *
     * @param str
     * @return
     */
    public static boolean equalsFlag(Object str) {
        try {
            if (str != null && "true".equals(str)) {
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * 字符串是否为数字
     *
     * @param str
     * @return
     */
    public static boolean isNumeric(String str) {
        try {
            if (str != null && str.matches("\\d*.?\\d*")) {
                return true;
            } else {
                return false;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * 类似如String.indexOf函数，获取对象在数组中的位置，如无，返回-1
     *
     * @param array
     * @param value
     * @return
     */
    public static int arrayIndexOf(Object array, Object value) {
        if (array == null || value == null) {
            return -1;
        }
        int len = Array.getLength(array);
        for (int i = 0; i < len; i++) {
            if (value.equals(Array.get(array, i))) {
                return i;
            }
        }
        return -1;
    }

    public static String toUtf8String(String s) {
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            if (c >= 0 && c <= 255) {
                sb.append(c);
            } else {
                byte[] b;
                try {
                    b = Character.toString(c).getBytes("utf-8");
                } catch (Exception ex) {
                    ex.printStackTrace();
                    b = new byte[0];
                }
                for (int j = 0; j < b.length; j++) {
                    int k = b[j];
                    if (k < 0)
                        k += 256;
                    sb.append("%" + Integer.toHexString(k).toUpperCase());
                }
            }
        }
        return sb.toString();
    }

    public static String sicenToComm(Object value) {
        if (value == null) {
            return null;
        } else if (value instanceof Double) {
            return sicenToCommDouble((Double) value);
        } else {
            return String.valueOf(value);
        }
    }

    // 解决科学技术法的问题，四舍五入保留两位小数
    public static String sicenToCommDouble(double value) {

        String retValue = null;

        DecimalFormat df = new DecimalFormat(); // DecimalFormat df = new
        // DecimalFormat("0.00");
        // //换成这句的话，可省略下边两句

        df.setMinimumFractionDigits(0);

        df.setMaximumFractionDigits(5);

        retValue = df.format(value);

        // System.out.println(retValue);

        retValue = retValue.replaceAll(",", "");

        return retValue;

    }

    public static String roundStr(Double value) {
        java.text.DecimalFormat df = new java.text.DecimalFormat("#.00");
        return df.format(value);
    }

    public static Double round(Double value, int count) {
        try {
            BigDecimal b = new BigDecimal(value);
            return b.setScale(count, BigDecimal.ROUND_HALF_UP).doubleValue();
        } catch (Exception e) {
            logger.warn("round double" + value);
        }
        return 0d;
    }

    public static Double round(Object value, int count) {
        return round(PublicUtil.parseDouble(value), count);
    }

    public static Double parseDouble(Object value) {
        if (value == null)
            return 0d;
        return parseDouble(String.valueOf(value));
    }

    public static Double parseDouble(String value) {
        return parseDouble(value, 0d);
    }

    public static Double parseDouble(String value, Double dafualtVal) {
        Double r = dafualtVal;
        try {
            if (value != null) {
                value = value.trim();

                if (value.endsWith("%")) {
                    value = value.substring(0, value.length() - 1);
                }
                r = Double.parseDouble(value);
            }
        } catch (Exception e) {
            logger.warn("转换失败：" + e.getMessage());
        }
        return r;
    }

    /**
     * 首字母转小写
     *
     * @param s
     * @return
     */
    public static String toLowerCaseFirstOne(String s) {
        if (Character.isLowerCase(s.charAt(0)))
            return s;
        else
            return (new StringBuilder()).append(Character.toLowerCase(s.charAt(0))).append(s.substring(1)).toString();
    }

    /**
     * 首字母转大写
     *
     * @param s
     * @return
     */
    public static String toUpperCaseFirstOne(String s) {
        if (Character.isUpperCase(s.charAt(0)))
            return s;
        else
            return (new StringBuilder()).append(Character.toUpperCase(s.charAt(0))).append(s.substring(1)).toString();
    }

    /**
     * 拼接字符串
     *
     * @param s
     * @return
     */
    public static String toAppendStr(Object... strs) {
        StringBuffer sb = new StringBuffer();
        for (Object str : strs) {
            if (isNotEmpty(str)) {
                sb.append(str);
            }
        }
        return sb.toString();
    }

    /**
     * 执行正则表达式
     *
     * @param pattern 表达式
     * @param str     待验证字符串
     * @return 返回 <b>true </b>,否则为 <b>false </b>
     */
    public static boolean match(String pattern, String str) {
        Pattern p = Pattern.compile(pattern);
        Matcher m = p.matcher(str);
        return m.find();
    }

    /**
     * 排序，必须是含parent、id属性的类
     *
     * @param list
     * @param sourcelist
     * @param parentId
     */
    public static void sortList(List list, List sourcelist, String parentId) {
        if (PublicUtil.isNotEmpty(sourcelist) && PublicUtil.isNotEmpty(parentId)) {
            Object e = null, peId = null;
            for (int i = 0; i < sourcelist.size(); i++) {
                e = sourcelist.get(i);
                if (e != null)
                    peId = Reflections.getFieldValue(e, "parentId");
                if (parentId.equals(peId)) {
                    list.add(e);
                    // 判断是否还有子节点, 有则继续获取子节点
                    for (int j = 0; j < sourcelist.size(); j++) {
                        e = sourcelist.get(i);
                        if (e != null)
                            peId = Reflections.getFieldValue(e, "parentId");
                        if (parentId.equals(peId)) {
                            sortList(list, sourcelist, String.valueOf(Reflections.getFieldValue(e, "id")));
                            break;
                        }
                    }
                }
            }
        }
    }

    public static Object getCollectionObject(Collection col, String property, Object obj) {
        if (PublicUtil.isNotEmpty(col)) {
            for (Object item : col) {
                if (item instanceof Map) {
                    Map im = (Map) item;
                    if (obj.equals(im.get(property))) {
                        return item;
                    }
                } else if (Reflections.checkClassIsBase(item.getClass().getName())) {
                    if (obj.equals(Reflections.getAccessibleField(item, property))) {
                        return item;
                    }
                } else if (obj.equals(item)) {
                    return item;
                }
            }
        }
        return null;
    }

    public static String toStrString(Object obj) {
        if (PublicUtil.isNotEmpty(obj)) {
            return String.valueOf(obj);
        }
        return "";
    }

    public static String toStrStringNull(Object obj) {
        if (PublicUtil.isNotEmpty(obj)) {
            return String.valueOf(obj);
        }
        return null;
    }

    public static Object fmtDate(ZonedDateTime val, String format) {
        return val == null ? null : val.format(DateTimeFormatter.ofPattern(format));
    }

    public static Object fmtDate(ZonedDateTime val) {
        return fmtDate(val, PublicUtil.TIME_FORMAT);
    }

    public static String convertComboDataList(List<?> dataList, String idFieldName, String nameFieldName) {
        List<ComboData> comboDataList = Lists.newArrayList();
        dataList.forEach(item -> comboDataList.add(new ComboData(PublicUtil.toStrString(Reflections.getFieldValue(item, idFieldName)),
                PublicUtil.toStrString(Reflections.invokeGetter(item, nameFieldName)))));
        return Json.toJsonString(comboDataList);
    }

}// class end
