package com.albedo.java.plugins.cache.utils;

import io.protostuff.LinkedBuffer;
import io.protostuff.ProtostuffIOUtil;
import io.protostuff.Schema;
import io.protostuff.runtime.RuntimeSchema;
import org.springframework.data.redis.serializer.RedisSerializer;
import org.springframework.data.redis.serializer.SerializationException;

/**
 * 此时定义的序列化操作表示可以序列化所有类的对象，当然，这个对象所在的类一定要实现序列化接口
 *
 * @author somewhere
 * @date 2019-08-06 10:42
 */
public class RedisProtostuffSerializer implements RedisSerializer<Object> {

	private final Schema<ProtoWrapper> schema;
	private final ProtoWrapper wrapper;
	private final LinkedBuffer buffer;

	public RedisProtostuffSerializer() {
		this.wrapper = new ProtoWrapper();
        /* RuntimeSchema.getSchema(clazz);
        实际上会将Schema<T>对象缓存 */
		this.schema = RuntimeSchema.getSchema(ProtoWrapper.class);
		this.buffer = LinkedBuffer.allocate(LinkedBuffer.DEFAULT_BUFFER_SIZE);
	}

	/**
	 * 序列化方法，把指定对象序列化成字节数组
	 *
	 * @param t
	 * @return
	 * @throws SerializationException
	 */
	@Override
	public byte[] serialize(Object t) throws SerializationException {
		if (t == null) {
			return new byte[0];
		}
		wrapper.data = t;
		try {
			return ProtostuffIOUtil.toByteArray(wrapper, schema, buffer);
		} finally {
			buffer.clear();
		}
	}

	/**
	 * 反序列化方法，将字节数组反序列化成指定Class类型
	 *
	 * @param bytes
	 * @return
	 * @throws SerializationException
	 */
	@Override
	public Object deserialize(byte[] bytes) throws SerializationException {
		if (isEmpty(bytes)) {
			return null;
		}

		ProtoWrapper newMessage = schema.newMessage();
		ProtostuffIOUtil.mergeFrom(bytes, newMessage, schema);
		return newMessage.data;
	}

	private boolean isEmpty(byte[] data) {
		return (data == null || data.length == 0);
	}

	// Protostuff 无法直接序列化集合类对象，需要包装类包一下
	private static class ProtoWrapper {
		public Object data;
	}
}
