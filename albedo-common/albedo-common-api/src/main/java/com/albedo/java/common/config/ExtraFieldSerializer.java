/*
 *  Copyright (c) 2019-2021  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
 *  <p>
 *  Licensed under the GNU Lesser General Public License 3.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *  <p>
 * https://www.gnu.org/licenses/lgpl.html
 *  <p>
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.albedo.java.common.config;

import cn.hutool.core.map.MapUtil;
import com.albedo.java.common.core.annotation.DictType;
import com.albedo.java.common.core.util.ObjectUtil;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.core.vo.SelectVo;
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

/**
 * @author somewhere
 */
@Log4j2
public class ExtraFieldSerializer extends BeanSerializerBase {

	Map<String, List<SelectVo>> codeItemData = Maps.newHashMap();

	public ExtraFieldSerializer(BeanSerializerBase source) {
		super(source);
	}

	public ExtraFieldSerializer(ExtraFieldSerializer source, ObjectIdWriter objectIdWriter) {
		super(source, objectIdWriter);
	}

	public ExtraFieldSerializer(ExtraFieldSerializer source, Set<String> toIgnore, Set<String> var2) {
		super(source, toIgnore, var2);
	}

	public ExtraFieldSerializer(ExtraFieldSerializer source, ObjectIdWriter objectIdWriter, Object filterId) {
		super(source, objectIdWriter, filterId);
	}

	@Override
	public BeanSerializerBase withObjectIdWriter(ObjectIdWriter objectIdWriter) {
		return new ExtraFieldSerializer(this, objectIdWriter);
	}

	@Override
	protected BeanSerializerBase withByNameInclusion(Set<String> toIgnore, Set<String> set1) {
		return new ExtraFieldSerializer(this, toIgnore, set1);
	}

	@Override
	protected BeanSerializerBase asArraySerializer() {
		return (this._objectIdWriter == null && this._anyGetterWriter == null && this._propertyFilterId == null
			? new BeanAsArraySerializer(this) : this);
	}

	@Override
	public BeanSerializerBase withFilterId(Object filterId) {
		return new ExtraFieldSerializer(this, this._objectIdWriter, filterId);
	}

	@Override
	protected BeanSerializerBase withProperties(BeanPropertyWriter[] beanPropertyWriters,
												BeanPropertyWriter[] beanPropertyWriters1) {
		return null;
	}

	@Override
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
						String showText = dictType.showText();
						String result = getDictVal(code, prop.get(bean));
						if (result != null) {
							gen.writeStringField(StringUtil.isEmpty(showText) ? (prop.getName() + "Text") : showText, result);
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

	private List<SelectVo> getCodeItemData(String code) {
		List<SelectVo> jobj = codeItemData.get(code);
		if (jobj == null) {
			Map<String, List<SelectVo>> selectResultListByCodes = DictUtil.getSelectVoListByCodes(code);
			if (MapUtil.isNotEmpty(selectResultListByCodes)) {
				codeItemData.putAll(selectResultListByCodes);
			} else {
				log.warn("can not find code {} dict data ", code);
			}
		}
		jobj = codeItemData.get(code);
		return jobj;
	}

	private String getDictVal(String code, Object val) {
		List<SelectVo> selectVos = getCodeItemData(code);
		if (selectVos != null) {
			String valStr = val + "";
			if (valStr.contains(StringUtil.SPLIT_DEFAULT)) {
				StringBuffer temp = new StringBuffer();
				String[] vals = valStr.split(StringUtil.SPLIT_DEFAULT);
				for (String item : vals) {
					if (ObjectUtil.isNotEmpty(item)) {
						temp.append(getDictVal(selectVos, item)).append(StringUtil.SPLIT_DEFAULT);
					}
				}
				if (temp.length() > 0) {
					temp.deleteCharAt(temp.length() - 1);
				}
				return temp.toString();
			} else {
				return getDictVal(selectVos, valStr);
			}
		} else {
			log.warn("无法查询到code {} val {}  的字典对象", code, val);
		}
		return null;
	}

	private String getDictVal(List<SelectVo> selectVos, Object value) {
		for (int i = 0, size = selectVos.size(); i < size; i++) {
			SelectVo selectVo = selectVos.get(i);
			if (selectVo.getValue().equals(value)) {
				return selectVo.getLabel();
			}
		}
		return null;
	}

	@Override
	public void serialize(Object bean, JsonGenerator jgen, SerializerProvider provider) throws IOException {
		jgen.writeStartObject();
		serializeFields(bean, jgen, provider);
		jgen.writeEndObject();
	}

}
