package com.albedo.java.plugins.cache.properties;

/**
 * 序列化类型
 *
 * @author somewhere
 * @date 2021年04月19日08:25:13
 */
public enum SerializerType {
	/**
	 * json 序列化
	 */
	JACK_SON,
	/**
	 * 默认:ProtoStuff 序列化
	 */
	ProtoStuff,
	/**
	 * jdk 序列化
	 */
	JDK
}
