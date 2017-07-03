package com.albedo.java.util.rsa;

import java.util.Map;

public class RSATester {
    static String publicKey;
    static String privateKey;

    static {
        try {
            Map<String, Object> keyMap = RSAUtil.genKeyPair();
            publicKey = RSAUtil.getPublicKey(keyMap);
            privateKey = RSAUtil.getPrivateKey(keyMap);
            System.err.println("公钥: \n\r" + publicKey);
            System.err.println("私钥： \n\r" + privateKey);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) throws Exception {

/*
 *     	Cipher cipher = Cipher.getInstance("RSA/ECB/PKCS1Padding");

    	MyEclipse工程里：

    	Cipher cipher = Cipher.getInstance("RSA/ECB/PKCS1Padding",new BouncyCastleProvider());
 * 
 * */

        test();
        testStr();
        testSign();
//        testSignStr();
    }

    static void test() throws Exception {
        System.err.println("公钥加密——私钥解密");
        String source = "1111111111111111111";
        System.out.println("\r加密前文字：\r\n" + source);
        byte[] data = source.getBytes();
        byte[] encodedData = RSAUtil.encryptByPublicKey(data, publicKey);
        System.out.println("加密后文字：\r\n" + Base64Util.encode(encodedData));
        byte[] decodedData = RSAUtil.decryptByPrivateKey(encodedData, privateKey);
        String target = new String(decodedData);
        System.out.println("解密后文字: \r\n" + target);
    }

    static void testStr() throws Exception {
        System.err.println("公钥加密——私钥解密");
        String source = "3333333333333333";
        System.out.println("\r加密前文字：\r\n" + source);
        String data = source;
        String encodedData = RSAUtil.encryptByPublicKeyStr(data, publicKey);
        System.out.println("加密后文字：\r\n" + encodedData);
        String decodedData = RSAUtil.decryptByPrivateKeyStr(encodedData, privateKey);
        System.out.println("解密后文字: \r\n" + decodedData);
    }

    //    static void testSignStr() throws Exception {
//        System.err.println("私钥加密——公钥解密");
//        String source = "2222222222222222222";
//        System.out.println("原文字：\r\n" + source);
//        String data = source;
//        String encodedData = RSAUtil.encryptByPrivateKeyStr(data, privateKey);
//        System.out.println("加密后：\r\n" + encodedData);
//        String decodedData = RSAUtil.decryptByPublicKeyStr(encodedData, publicKey);
//        System.out.println("解密后: \r\n" + decodedData);
//        System.err.println("私钥签名——公钥验证签名");
//        String sign = RSAUtil.signStr(encodedData, privateKey);
//        System.err.println("签名:\r" + sign);
//        boolean status = RSAUtil.verifyStr(encodedData, publicKey, sign);
//        System.err.println("验证结果:\r" + status);
//    }
    static void testSign() throws Exception {
        System.err.println("私钥加密——公钥解密");
        String source = "2222222222222222222";
        System.out.println("原文字：\r\n" + source);
        byte[] data = source.getBytes();
        byte[] encodedData = RSAUtil.encryptByPrivateKey(data, privateKey);
        System.out.println("加密后：\r\n" + Base64Util.encode(encodedData));
        byte[] decodedData = RSAUtil.decryptByPublicKey(encodedData, publicKey);
        String target = new String(decodedData);
        System.out.println("解密后: \r\n" + target);
        System.err.println("私钥签名——公钥验证签名");
        String sign = RSAUtil.sign(encodedData, privateKey);
        System.err.println("签名:\r" + sign);
        boolean status = RSAUtil.verify(encodedData, publicKey, sign);
        System.err.println("验证结果:\r" + status);
    }
}
