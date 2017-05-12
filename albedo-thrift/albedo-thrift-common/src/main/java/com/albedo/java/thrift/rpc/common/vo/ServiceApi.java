package com.albedo.java.thrift.rpc.common.vo;

import com.albedo.java.thrift.rpc.common.ThriftConstant;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

/**
 * Created by lijie on 2017/5/12.
 *
 * @author 837158334@qq.com
 */
@Data @ToString
public class ServiceApi {
    //名称
    String name;
    // 优先级
//    int weight = 1;// default
    //服务版本号
    String version = ThriftConstant.DEFAULT_VERSION;

    public ServiceApi(String name) {
        this.name = name;
    }

    public ServiceApi(String name, String version) {
    	this.name = name;
    	this.version = version;
	}

	public static ServiceApi create(String name){
        return new ServiceApi(name);
    }
    public static ServiceApi create(String name, String version){
        return new ServiceApi(name, version);
    }
}
