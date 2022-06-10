/*
 *  Copyright (c) 2019-2022  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
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
package com.albedo.java.modules.sys.domain.dto;

import com.albedo.java.common.core.annotation.Query;
import lombok.Data;

import java.io.Serializable;

/**
 * 登录日志管理QueryCriteria 登录日志
 *
 * @author admin
 * @version 2021-11-30 10:15:00
 */
@Data
public class LogLoginQueryCriteria implements Serializable {

	private static final long serialVersionUID = 1L;
	/**
	 * F_TITLE title  :  日志标题
	 */
	@Query(blurry = "title,username,nickname,ip_location,os", operator = Query.Operator.like)
	private String title;
	/**
	 * userId
	 */
	@Query
	private String userId;

}
