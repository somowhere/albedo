package com.albedo.java.rpc.common.protocol;

/**
 * @author chenghao
 */
public final class Header {

    private int crcCode = 0xaddf0201;


    private int length;

    public int getCrcCode() {
        return crcCode;
    }

    public void setCrcCode(int crcCode) {
        this.crcCode = crcCode;
    }

    public int getLength() {
        return length;
    }

    public void setLength(int length) {
        this.length = length;
    }


    @Override
    public String toString() {
	    return "Header [crcCode=" + crcCode + ", length=" + length;
    }

}
