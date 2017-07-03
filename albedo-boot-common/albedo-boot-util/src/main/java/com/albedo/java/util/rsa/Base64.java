package com.albedo.java.util.rsa;

import java.io.*;

public class Base64 {
    public static String encode(String paramString)
            throws RuntimeException {
        byte[] arrayOfByte1 = paramString.getBytes();
        byte[] arrayOfByte2 = encode(arrayOfByte1);
        try {
            return new String(arrayOfByte2, "ASCII");
        } catch (UnsupportedEncodingException localUnsupportedEncodingException) {
            throw new RuntimeException("ASCII is not supported!", localUnsupportedEncodingException);
        }
    }

    public static String encode(String paramString1, String paramString2)
            throws RuntimeException {
        byte[] arrayOfByte1;
        try {
            arrayOfByte1 = paramString1.getBytes(paramString2);
        } catch (UnsupportedEncodingException localUnsupportedEncodingException1) {
            throw new RuntimeException("Unsupported charset: " + paramString2, localUnsupportedEncodingException1);
        }
        byte[] arrayOfByte2 = encode(arrayOfByte1);
        try {
            return new String(arrayOfByte2, "ASCII");
        } catch (UnsupportedEncodingException localUnsupportedEncodingException2) {
            throw new RuntimeException("ASCII is not supported!", localUnsupportedEncodingException2);
        }
    }

    public static String decode(String paramString)
            throws RuntimeException {
        byte[] arrayOfByte1;
        try {
            arrayOfByte1 = paramString.getBytes("ASCII");
        } catch (UnsupportedEncodingException localUnsupportedEncodingException) {
            throw new RuntimeException("ASCII is not supported!", localUnsupportedEncodingException);
        }
        byte[] arrayOfByte2 = decode(arrayOfByte1);
        return new String(arrayOfByte2);
    }

    public static String decode(String paramString1, String paramString2)
            throws RuntimeException {
        byte[] arrayOfByte1;
        try {
            arrayOfByte1 = paramString1.getBytes("ASCII");
        } catch (UnsupportedEncodingException localUnsupportedEncodingException1) {
            throw new RuntimeException("ASCII is not supported!", localUnsupportedEncodingException1);
        }
        byte[] arrayOfByte2 = decode(arrayOfByte1);
        try {
            return new String(arrayOfByte2, paramString2);
        } catch (UnsupportedEncodingException localUnsupportedEncodingException2) {
            throw new RuntimeException("Unsupported charset: " + paramString2, localUnsupportedEncodingException2);
        }
    }

    public static byte[] encode(byte[] paramArrayOfByte)
            throws RuntimeException {
        return encode(paramArrayOfByte, 0);
    }

    public static byte[] encode(byte[] paramArrayOfByte, int paramInt)
            throws RuntimeException {
        ByteArrayInputStream localByteArrayInputStream = new ByteArrayInputStream(paramArrayOfByte);
        ByteArrayOutputStream localByteArrayOutputStream = new ByteArrayOutputStream();
        try {
            encode(localByteArrayInputStream, localByteArrayOutputStream, paramInt);
            return localByteArrayOutputStream.toByteArray();
        } catch (IOException localIOException) {
            throw new RuntimeException("Unexpected I/O error", localIOException);
        } finally {
            try {
                localByteArrayInputStream.close();
            } catch (Throwable localThrowable3) {
            }
            try {
                localByteArrayOutputStream.close();
            } catch (Throwable localThrowable4) {
            }
        }
    }

    public static byte[] decode(byte[] paramArrayOfByte)
            throws RuntimeException {
        ByteArrayInputStream localByteArrayInputStream = new ByteArrayInputStream(paramArrayOfByte);
        ByteArrayOutputStream localByteArrayOutputStream = new ByteArrayOutputStream();
        try {
            decode(localByteArrayInputStream, localByteArrayOutputStream);
            return localByteArrayOutputStream.toByteArray();
        } catch (IOException localIOException) {
            throw new RuntimeException("Unexpected I/O error", localIOException);
        } finally {
            try {
                localByteArrayInputStream.close();
            } catch (Throwable localThrowable3) {
            }
            try {
                localByteArrayOutputStream.close();
            } catch (Throwable localThrowable4) {
            }
        }
    }

    public static void encode(InputStream paramInputStream, OutputStream paramOutputStream)
            throws IOException {
        encode(paramInputStream, paramOutputStream, 0);
    }

    public static void encode(InputStream paramInputStream, OutputStream paramOutputStream, int paramInt)
            throws IOException {
        Base64OutputStream localBase64OutputStream = new Base64OutputStream(paramOutputStream, paramInt);
        copy(paramInputStream, localBase64OutputStream);
        localBase64OutputStream.commit();
    }

    public static void decode(InputStream paramInputStream, OutputStream paramOutputStream)
            throws IOException {
        copy(new Base64InputStream(paramInputStream), paramOutputStream);
    }

    public static void encode(File paramFile1, File paramFile2, int paramInt)
            throws IOException {
        FileInputStream localFileInputStream = null;
        FileOutputStream localFileOutputStream = null;
        try {
            localFileInputStream = new FileInputStream(paramFile1);
            localFileOutputStream = new FileOutputStream(paramFile2);
            encode(localFileInputStream, localFileOutputStream, paramInt);
            return;
        } finally {
            if (localFileOutputStream != null) {
                try {
                    localFileOutputStream.close();
                } catch (Throwable localThrowable3) {
                }
            }
            if (localFileInputStream != null) {
                try {
                    localFileInputStream.close();
                } catch (Throwable localThrowable4) {
                }
            }
        }
    }

    public static void encode(File paramFile1, File paramFile2)
            throws IOException {
        FileInputStream localFileInputStream = null;
        FileOutputStream localFileOutputStream = null;
        try {
            localFileInputStream = new FileInputStream(paramFile1);
            localFileOutputStream = new FileOutputStream(paramFile2);
            encode(localFileInputStream, localFileOutputStream);
            return;
        } finally {
            if (localFileOutputStream != null) {
                try {
                    localFileOutputStream.close();
                } catch (Throwable localThrowable3) {
                }
            }
            if (localFileInputStream != null) {
                try {
                    localFileInputStream.close();
                } catch (Throwable localThrowable4) {
                }
            }
        }
    }

    public static void decode(File paramFile1, File paramFile2)
            throws IOException {
        FileInputStream localFileInputStream = null;
        FileOutputStream localFileOutputStream = null;
        try {
            localFileInputStream = new FileInputStream(paramFile1);
            localFileOutputStream = new FileOutputStream(paramFile2);
            decode(localFileInputStream, localFileOutputStream);
            return;
        } finally {
            if (localFileOutputStream != null) {
                try {
                    localFileOutputStream.close();
                } catch (Throwable localThrowable3) {
                }
            }
            if (localFileInputStream != null) {
                try {
                    localFileInputStream.close();
                } catch (Throwable localThrowable4) {
                }
            }
        }
    }

    private static void copy(InputStream paramInputStream, OutputStream paramOutputStream)
            throws IOException {
        byte[] arrayOfByte = new byte['?'];
        int i;
        while ((i = paramInputStream.read(arrayOfByte)) != -1) {
            paramOutputStream.write(arrayOfByte, 0, i);
        }
    }
}
