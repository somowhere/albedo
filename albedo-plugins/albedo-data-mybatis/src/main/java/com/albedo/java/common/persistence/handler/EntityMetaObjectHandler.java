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

package com.albedo.java.common.persistence.handler;

import com.albedo.java.common.persistence.domain.BaseDataEntity;
import com.baomidou.mybatisplus.core.handlers.MetaObjectHandler;
import org.apache.ibatis.reflection.MetaObject;
import org.springframework.data.domain.AuditorAware;
import org.springframework.util.Assert;

import java.time.LocalDateTime;
import java.util.Iterator;
import java.util.Map;

/**
 * @author somewhere
 * @description
 * @date 2020/5/31 17:07
 */
public class EntityMetaObjectHandler implements MetaObjectHandler {

	private final AuditorAware auditorAware;

	public EntityMetaObjectHandler(AuditorAware auditorAware) {
		Assert.isTrue(auditorAware != null, "auditorAware is not defined");
		this.auditorAware = auditorAware;
	}


	@Override
	public void insertFill(MetaObject metaObject) {
		if (checkMetaObject(metaObject)) {
			setFieldValByName(BaseDataEntity.F_CREATED_BY, auditorAware.getCurrentAuditor().get(), metaObject);
			LocalDateTime date = LocalDateTime.now();
			setFieldValByName(BaseDataEntity.F_CREATED_DATE, date, metaObject);
			setFieldValByName(BaseDataEntity.F_LAST_MODIFIED_BY, auditorAware.getCurrentAuditor().get(), metaObject);
			setFieldValByName(BaseDataEntity.F_LAST_MODIFIED_DATE, date, metaObject);
		}

	}

	private boolean checkMetaObject(MetaObject metaObject) {
		boolean isDataEntity = false;
		if (metaObject.getOriginalObject() instanceof Map) {
			Map<String, Object> map = (Map<String, Object>) metaObject.getOriginalObject();
			Iterator<String> iterator = map.keySet().iterator();
			while (iterator.hasNext()) {
				String next = iterator.next();
				if (map.get(next) instanceof BaseDataEntity) {
					isDataEntity = true;
					break;
				}
			}
		}
		return isDataEntity || metaObject.getOriginalObject() instanceof BaseDataEntity;
	}

	@Override
	public void updateFill(MetaObject metaObject) {
		if (checkMetaObject(metaObject)) {
			LocalDateTime date = LocalDateTime.now();
			setFieldValByName(BaseDataEntity.F_LAST_MODIFIED_BY, auditorAware.getCurrentAuditor().get(), metaObject);
			setFieldValByName(BaseDataEntity.F_LAST_MODIFIED_DATE, date, metaObject);
		}
	}
}
