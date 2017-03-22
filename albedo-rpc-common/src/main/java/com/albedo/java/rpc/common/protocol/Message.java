package com.albedo.java.rpc.common.protocol;

/**
 * Created by chenghao on 9/14/16.
 */
public class Message {
    private Header header;
    private Object body;

    public Message(Header header,Object body){
        this.header=header;
        this.body=body;
    }

    public static Message create(Object object){
        return new Message(new Header(),object);
    }

    public Header getHeader() {
        return header;
    }

    public void setHeader(Header header) {
        this.header = header;
    }

    public Object getBody() {
        return body;
    }

    public void setBody(Object body) {
        this.body = body;
    }
}
