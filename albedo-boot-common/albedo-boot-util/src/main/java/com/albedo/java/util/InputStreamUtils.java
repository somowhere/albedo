package com.albedo.java.util;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;

/**
 * Created by lijie on 2017/5/8.
 */
public class InputStreamUtils {
    final static int BUFFER_SIZE = 4096;

    /**
     * @param in
     * @return String
     * @throws Exception
     */
    public static String InputStreamTOString(InputStream in) throws Exception {
        ByteArrayOutputStream outStream = new ByteArrayOutputStream();
        byte[] data = new byte[BUFFER_SIZE];
        int count = -1;
        while ((count = in.read(data, 0, BUFFER_SIZE)) != -1)
            outStream.write(data, 0, count);

        data = null;
        return new String(outStream.toByteArray());
    }

    /**
     * @param in
     * @param encoding
     * @return String
     * @throws Exception
     */
    public static String InputStreamTOString(InputStream in, String encoding) throws Exception {
        ByteArrayOutputStream outStream = new ByteArrayOutputStream();
        byte[] data = new byte[BUFFER_SIZE];
        int count = -1;
        while ((count = in.read(data, 0, BUFFER_SIZE)) != -1)
            outStream.write(data, 0, count);

        data = null;
        return new String(outStream.toByteArray(), encoding);
    }

    /**
     * @param in
     * @param encoding
     * @return InputStream
     * @throws Exception
     */
    public static InputStream StringTOInputStream(String in, String encoding) throws Exception {
        ByteArrayInputStream is = new ByteArrayInputStream(in.getBytes(encoding));
        return is;
    }

    /**
     * @param in
     * @return InputStream
     * @throws Exception
     */
    public static InputStream StringTOInputStream(String in) throws Exception {
        ByteArrayInputStream is = new ByteArrayInputStream(in.getBytes());
        return is;
    }
}
