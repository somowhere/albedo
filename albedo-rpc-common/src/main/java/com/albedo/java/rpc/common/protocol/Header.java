package com.albedo.java.rpc.common.protocol;

import lombok.Data;
import lombok.ToString;

/**
 * @author lijie
 */
@Data
@ToString
public final class Header {

    private int crcCode = 0xaddf0201;

    private int length;


}
