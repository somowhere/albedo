package com.albedo.java.util;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.InputStreamEntity;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

public class HttpUtil {
    protected static Logger logger = LoggerFactory.getLogger(HttpUtil.class);


    /**
     * 发送GET请求，携带参数 3389
     *
     * @param url
     * @param params
     * @return
     * @throws Exception
     */
    public static HttpEntity sendGetRequest(String url, Map<String, String> params) throws Exception {
        final StringBuffer tmp = new StringBuffer(url);
        if (params != null) {
            Set<Entry<String, String>> paramset = params.entrySet();
            if (paramset.size() > 0) {
                tmp.append("?");
                int totalLen = paramset.size(), index = 0;
                for (Entry<String, String> entry : paramset) {
                    tmp.append(entry.getKey() + "=" + entry.getValue());
                    if (++index < totalLen) {
                        tmp.append("&");
                    }
                }
            }
            logger.info("Get params:" + params.toString());
        }
        HttpClient httpClient = HttpClients.createDefault();
        HttpGet httpGet = new HttpGet(tmp.toString());
        HttpResponse response = httpClient.execute(httpGet);
        return response.getEntity();
    }

    public static String sendGetRequestString(String url) {
        try {
            HttpEntity entity = sendGetRequest(url, null);
            return entityToString(entity);
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("GET请求异常:" + e.getMessage());
        }
        return "";
    }

    public static String sendGetRequestString(String url, Map<String, String> params) {
        try {
            HttpEntity entity = sendGetRequest(url, params);
            return entityToString(entity);
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("GET请求异常:" + e.getMessage());
        }
        return "";
    }

    /**
     * 发送POST请求
     *
     * @param url
     * @param instream
     * @return
     * @throws Exception
     */
    public static HttpEntity sendPostRequest(String url, InputStream instream) throws Exception {
        HttpClient httpclient = HttpClients.createDefault();
        HttpPost httpPost = new HttpPost(url);
        InputStreamEntity inputEntry = new InputStreamEntity(instream);
        httpPost.setEntity(inputEntry);
        HttpResponse reponse = httpclient.execute(httpPost);
        return reponse.getEntity();
    }


    /**
     * 发送POST请求
     *
     * @param url
     * @param params
     * @return
     * @throws Exception
     */
    public static HttpEntity sendPostRequestMapObject(String url, Map<String, Object> params) throws Exception {
        List<NameValuePair> listParams = new ArrayList<NameValuePair>();
        if (params != null) {
            Set<Entry<String, Object>> set = params.entrySet();
            for (Entry<String, Object> entry : set) {
                listParams.add(new BasicNameValuePair(entry.getKey(), PublicUtil.toStrString(entry.getValue())));
            }
        }
        return sendPostRequest(url, listParams);
    }

    public static HttpEntity sendPostRequest(String url, List<NameValuePair> listParams) throws Exception {
        HttpClient httpClient = HttpClients.createDefault();
        logger.info("Post params:" + listParams.toString());
        HttpPost httpPost = new HttpPost(url);
        httpPost.setEntity(new UrlEncodedFormEntity(listParams, "utf-8"));
        HttpResponse reponse = httpClient.execute(httpPost);

        return reponse.getEntity();
    }

    public static HttpEntity sendPostRequest(String url, Map<String, String> params) throws Exception {
        List<NameValuePair> listParams = new ArrayList<NameValuePair>();
        if (params != null) {
            Set<Entry<String, String>> set = params.entrySet();
            for (Entry<String, String> entry : set) {
                listParams.add(new BasicNameValuePair(entry.getKey(), PublicUtil.toStrString(entry.getValue())));
            }
        }

        return sendPostRequest(url, listParams);
    }

    public static String sendPostRequestString(String url, Map<String, String> params) {
        HttpEntity entity;
        try {
            entity = sendPostRequest(url, params);
            return entityToString(entity);
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("POST请求异常:" + e.getMessage());
        }
        return "";
    }

    public static String sendPostRequestString(String url, String param) {
        HttpEntity entity;
        HttpClient httpClient = HttpClients.createDefault();
        try {
            logger.info("Post params:" + param);
            HttpPost httpPost = new HttpPost(url);
            httpPost.setEntity(new StringEntity(param, "utf-8"));
            HttpResponse reponse = httpClient.execute(httpPost);
            entity = reponse.getEntity();
            return entityToString(entity);
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("POST请求异常:" + e.getMessage());
        }
        return "";
    }

    /**
     * 下载文件
     *
     * @param path     文件URL
     * @param savePath 保存路径
     * @param fileName 文件名
     */
    public static void downloadFile(String path, String savePath, String fileName) throws Exception {
        HttpClient httpClient = HttpClients.createDefault();
        HttpGet httpGet = new HttpGet(path);
        HttpResponse response = httpClient.execute(httpGet);
        File dir = new File(savePath);
        if (!dir.exists())
            dir.mkdirs();
        File saveFile = new File(dir, fileName);
        BufferedInputStream bis = new BufferedInputStream(response.getEntity().getContent());
        BufferedOutputStream bos = new BufferedOutputStream(new FileOutputStream(saveFile));
        byte tmp[] = new byte[1024];
        int len = 0;
        while ((len = bis.read(tmp)) != -1) {
            bos.write(tmp, 0, len);
        }
        bis.close();
        bos.flush();
        bos.close();
    }

    /**
     * 将输入流转换为字符串
     *
     * @param is
     * @return
     * @throws Exception
     */
    public static String inputToString(InputStream is) throws Exception {
        StringBuffer sb = new StringBuffer("");
        String line = null;
        BufferedReader br = new BufferedReader(new InputStreamReader(is));
        while ((line = br.readLine()) != null) {
            sb.append(line + "\r\n");
        }
        return sb.toString();
    }

    /**
     * 将HttpEntity对象转换为字符串
     *
     * @param entity
     * @return
     * @throws Exception
     */
    public static String entityToString(HttpEntity entity) throws Exception {
        return entity == null ? null : EntityUtils.toString(entity, "utf-8");
    }

    public static String convertStreamToString(InputStream is) {
        BufferedReader reader = new BufferedReader(new InputStreamReader(is));
        StringBuilder sb = new StringBuilder();

        String line = null;
        try {
            while ((line = reader.readLine()) != null) {
                sb.append(line + "\n");
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                is.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return sb.toString();
    }

}
