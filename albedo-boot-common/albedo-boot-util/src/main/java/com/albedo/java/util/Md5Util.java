package com.albedo.java.util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * Created by IntelliJ IDEA. User: lj Date: 2009-8-21 Time: 16:11:20 To change
 * this template use File | Settings | File Templates.
 */
public class Md5Util {
    protected static Logger logger = LoggerFactory.getLogger(PublicUtil.class);

    /**
     * 获得字符串s的md5 hash值.
     */
    public static String getMD5(String s) {
        String md5sum = "NULL";
        try {
            MessageDigest md5 = MessageDigest.getInstance("MD5");
            byte[] hash = md5.digest(s.getBytes());
            md5sum = dumpBytes(hash);
        } catch (Exception e) {
            logger.warn(e.toString());
        }
        return md5sum;
    } // end getMD5()

    public static String generateToken(String sessionId) {

        String tokenStr = null;
        String currentTime = null;

        // 获取现在系统时间的字符串
        currentTime = System.currentTimeMillis() + "";

        // 使用MD5算法
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            // 把系统时间和sessionId都参与MD5运算
            md.update(currentTime.getBytes());

            md.update(sessionId.getBytes());

            // 获取MD5值
            byte tokenByte[] = md.digest();

            // 把MD5值转换为16进制字符串
            tokenStr = dumpBytes(tokenByte);
        } catch (NoSuchAlgorithmException e) {
            logger.warn(e.toString());
        }

        return tokenStr;
    }

    private static String dumpBytes(byte[] bytes) {
        int size = bytes.length;
        StringBuffer sb = new StringBuffer(size * 2);
        String s;
        for (int i = 0; i < size; i++) {
            s = Integer.toHexString(bytes[i]);
            if (s.length() == 8) // -128 <= bytes[i] < 0
                sb.append(s.substring(6));
            else if (s.length() == 2) // 16 <= bytes[i] < 128
                sb.append(s);
            else
                sb.append("0" + s); // 0 <= bytes[i] < 16
        }
        return sb.toString();
    }

}
