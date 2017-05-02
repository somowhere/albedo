package com.albedo.java.rpc.common.protocol;

import lombok.Data;
import lombok.ToString;

/**
 * Created by lijie on 9/14/16.
 */
@Data
@ToString
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

}
