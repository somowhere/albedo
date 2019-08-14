package com.albedo.java.common;

import com.albedo.java.common.config.ExtraFieldSerializer;
import com.fasterxml.jackson.databind.BeanDescription;
import com.fasterxml.jackson.databind.JsonSerializer;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationConfig;
import com.fasterxml.jackson.databind.module.SimpleModule;
import com.fasterxml.jackson.databind.ser.BeanSerializerModifier;
import com.fasterxml.jackson.databind.ser.std.BeanSerializerBase;
import com.google.common.collect.Lists;
import org.junit.jupiter.api.Test;

public class JacksonTest {


	@Test
	public void testAddExtraField() throws Exception {
		ObjectMapper mapper = new ObjectMapper();

		mapper.registerModule(new SimpleModule() {

			public void setupModule(SetupContext context) {
				super.setupModule(context);

				context.addBeanSerializerModifier(new BeanSerializerModifier() {

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
		});

		mapper.writeValue(System.out, Lists.newArrayList(new MyClass1(), new MyClass2()));
		//prints {"classField":"classFieldValue","extraField":"extraFieldValue"}
	}

	class MyClass1 {

		private String classField = "classFieldValue1";

		public String getClassField() {
			return classField;
		}

		public void setClassField(String classField) {
			this.classField = classField;
		}
	}

	class MyClass2 {

		private String classField = "classFieldValue2";

		public String getClassField() {
			return classField;
		}

		public void setClassField(String classField) {
			this.classField = classField;
		}
	}


}
