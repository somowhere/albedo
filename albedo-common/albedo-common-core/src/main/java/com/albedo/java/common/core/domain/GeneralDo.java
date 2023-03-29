/*
 *  Copyright (c) 2019-2023  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
 *  <p>
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

package com.albedo.java.common.core.domain;

import com.baomidou.mybatisplus.extension.activerecord.Model;
import lombok.Data;

import java.io.Serializable;

/**
 * 通常的数据基类 copyright 2014 albedo all right reserved author somewhere created on
 * 2014年12月31日 下午1:57:09
 *
 * @author somewhere
 */

@Data
public class GeneralDo<T extends Model<T>> extends Model<T> implements Serializable {

	/*** 状态 正常 */
	public static final String FLAG_NORMAL = "0";

	/*** 状态 已删除 */
	public static final String FLAG_DELETE = "1";

	/**
	 * 状态（0：正常 1：删除）
	 */
	public static final String F_DEL_FLAG = "delFlag";

	/*** ID */
	public static final String F_ID = "id";

	public static final String F_CREATED_BY = "createdBy";

	public static final String F_CREATOR = "creator";

	public static final String F_CREATED_DATE = "createdDate";

	public static final String F_LAST_MODIFIED_BY = "lastModifiedBy";

	public static final String F_MODIFIER = "modifier";

	public static final String F_LAST_MODIFIED_DATE = "lastModifiedDate";

	public static final String F_VERSION = "version";

	public static final String F_DESCRIPTION = "description";

	public static final String F_TENANT_CODE = "tenantCode";

	public static final String F_SQL_ID = "id";

	public static final String F_SQL_CREATED_BY = "created_by";

	public static final String F_SQL_CREATED_DATE = "created_date";

	public static final String F_SQL_LAST_MODIFIED_BY = "last_modified_by";

	public static final String F_SQL_MODIFIER = "modifier";

	public static final String F_SQL_LAST_MODIFIED_DATE = "last_modified_date";

	public static final String F_SQL_VERSION = "version";

	public static final String F_SQL_DESCRIPTION = "description";

	public static final String F_SQL_DEL_FLAG = "del_flag";

	private static final long serialVersionUID = 1L;

}
