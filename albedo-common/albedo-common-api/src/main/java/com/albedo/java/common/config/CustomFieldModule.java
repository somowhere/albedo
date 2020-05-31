package com.albedo.java.common.config;

import com.fasterxml.jackson.databind.BeanDescription;
import com.fasterxml.jackson.databind.JsonSerializer;
import com.fasterxml.jackson.databind.Module;
import com.fasterxml.jackson.databind.SerializationConfig;
import com.fasterxml.jackson.databind.module.SimpleModule;
import com.fasterxml.jackson.databind.ser.BeanSerializerModifier;
import com.fasterxml.jackson.databind.ser.std.BeanSerializerBase;

/**
 * @author somewhere
 * @description
 * @date 2020/5/31 17:07
 */
public class CustomFieldModule extends SimpleModule {


	@Override
	public void setupModule(Module.SetupContext context) {
		super.setupModule(context);

		context.addBeanSerializerModifier(new BeanSerializerModifier() {

			@Override
			public JsonSerializer<?> modifySerializer(
				SerializationConfig config,
				BeanDescription beanDesc,
				JsonSerializer<?> serializer) {
				if (serializer instanceof BeanSerializerBase) {
					return new ExtraFieldSerializer(
						(BeanSerializerBase) serializer);
				}
				return serializer;

			}
		});
	}

}
