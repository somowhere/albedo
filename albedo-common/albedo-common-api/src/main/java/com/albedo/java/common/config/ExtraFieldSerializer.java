package com.albedo.java.common.config;

import com.albedo.java.common.core.annotation.DictType;
import com.albedo.java.common.core.util.CollUtil;
import com.albedo.java.common.core.util.ObjectUtil;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.core.vo.SelectResult;
import com.albedo.java.modules.sys.util.DictUtil;
import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.SerializerProvider;
import com.fasterxml.jackson.databind.ser.BeanPropertyWriter;
import com.fasterxml.jackson.databind.ser.impl.BeanAsArraySerializer;
import com.fasterxml.jackson.databind.ser.impl.ObjectIdWriter;
import com.fasterxml.jackson.databind.ser.std.BeanSerializerBase;
import com.google.common.collect.Maps;
import lombok.extern.log4j.Log4j2;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.Set;

@Log4j2
public class ExtraFieldSerializer extends BeanSerializerBase {


	Map<String, List<SelectResult>> codeItemData = Maps.newHashMap();


	public ExtraFieldSerializer(BeanSerializerBase source) {
		super(source);
	}

	public ExtraFieldSerializer(ExtraFieldSerializer source,
								ObjectIdWriter objectIdWriter) {
		super(source, objectIdWriter);
	}

	public ExtraFieldSerializer(ExtraFieldSerializer source,
								Set<String> toIgnore) {
		super(source, toIgnore);
	}

	public ExtraFieldSerializer(ExtraFieldSerializer source,
								ObjectIdWriter objectIdWriter, Object filterId) {
		super(source, objectIdWriter, filterId);
	}

	public BeanSerializerBase withObjectIdWriter(
		ObjectIdWriter objectIdWriter) {
		return new ExtraFieldSerializer(this, objectIdWriter);
	}

	protected BeanSerializerBase withIgnorals(Set<String> toIgnore) {
		return new ExtraFieldSerializer(this, toIgnore);
	}

	@Override
	protected BeanSerializerBase asArraySerializer() {
		return (this._objectIdWriter == null && this._anyGetterWriter == null && this._propertyFilterId == null ? new BeanAsArraySerializer(this) : this);
	}

	@Override
	public BeanSerializerBase withFilterId(Object filterId) {
		return new ExtraFieldSerializer(this, this._objectIdWriter, filterId);
	}


	protected void serializeFields(Object bean, JsonGenerator gen, SerializerProvider provider) throws IOException {
		BeanPropertyWriter[] props;
		if (this._filteredProps != null && provider.getActiveView() != null) {
			props = this._filteredProps;
		} else {
			props = this._props;
		}

		int i = 0;

		try {
			codeItemData.clear();
			for (int len = props.length; i < len; ++i) {
				BeanPropertyWriter prop = props[i];
				if (prop != null) {
					DictType dictType = prop.getAnnotation(DictType.class);
					if (dictType != null) {
						String code = dictType.value();
						String result = getDictVal(code, prop.get(bean));
						if (result != null) {
							gen.writeStringField(prop.getName() + "Text", result);
						}
					}
					prop.serializeAsField(bean, gen, provider);
				}
			}

			if (this._anyGetterWriter != null) {
				this._anyGetterWriter.getAndSerialize(bean, gen, provider);
			}
		} catch (Exception var9) {
			String name = i == props.length ? "[anySetter]" : props[i].getName();
			this.wrapAndThrow(provider, var9, bean, name);
		} catch (StackOverflowError var10) {
			JsonMappingException mapE = new JsonMappingException(gen, "Infinite recursion (StackOverflowError)", var10);
			String name = i == props.length ? "[anySetter]" : props[i].getName();
			mapE.prependPath(new JsonMappingException.Reference(bean, name));
			throw mapE;
		}

	}

	private List<SelectResult> getCodeItemData(String code) {
		List<SelectResult> jobj = codeItemData.get(code);
		if (jobj == null) {
			Map<String, List<SelectResult>> selectResultListByCodes = DictUtil.getSelectResultListByCodes(code);
			if (CollUtil.isNotEmpty(selectResultListByCodes)) {
				codeItemData.putAll(selectResultListByCodes);
			} else {
				log.warn("can not find code {} dict data ", code);
			}
		}
		jobj = codeItemData.get(code);
		return jobj;
	}

	private String getDictVal(String code, Object val) {
		List<SelectResult> selectResults = getCodeItemData(code);
		if (selectResults != null) {
			String valStr = val + "";
			if (valStr.contains(StringUtil.SPLIT_DEFAULT)) {
				StringBuffer temp = new StringBuffer();
				String[] vals = valStr.split(StringUtil.SPLIT_DEFAULT);
				for (String item : vals) {
					if (ObjectUtil.isNotEmpty(item)) {
						temp.append(getDictVal(selectResults, item)).append(StringUtil.SPLIT_DEFAULT);
					}
				}
				if (temp.length() > 0) {
					temp.deleteCharAt(temp.length() - 1);
				}
				return temp.toString();
			} else {
				return getDictVal(selectResults, valStr);
			}
		} else {
			log.warn("无法查询到code {} val {}  的字典对象", code, val);
		}
		return null;
	}

	private String getDictVal(List<SelectResult> selectResults, Object value) {
		for (int i = 0, size = selectResults.size(); i < size; i++) {
			SelectResult selectResult = selectResults.get(i);
			if (selectResult.getValue().equals(value)) {
				return selectResult.getLabel();
			}
		}
		return null;
	}


	public void serialize(Object bean, JsonGenerator jgen,
						  SerializerProvider provider) throws IOException {
		jgen.writeStartObject();
		serializeFields(bean, jgen, provider);
		jgen.writeEndObject();
	}

}
