/*
 *  Copyright (c) 2019-2021  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
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
package com.albedo.java.modules.sys.service;

import com.albedo.java.modules.sys.domain.LogLogin;
import com.albedo.java.plugins.database.mybatis.service.BaseService;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

/**
 * 登录日志管理Service 登录日志
 *
 * @author admin
 * @version 2021-11-30 10:15:00
 */
public interface LogLoginService extends BaseService<LogLogin> {


	/**
	 * 获取系统总 登录次数
	 *
	 * @return Long
	 */
	Long getTotalLoginPv();

	/**
	 * 获取系统今日 登录次数
	 *
	 * @return Long
	 */
	Long getTodayLoginPv();

	/**
	 * 获取系统总 登录IV
	 *
	 * @return Long
	 */
	Long getTotalLoginIv();

	/**
	 * 获取系统今日 登录IV
	 *
	 * @return Long
	 */
	Long getTodayLoginIv();


	/**
	 * 获取系统近十天来的访问记录
	 *
	 * @param username 账号
	 * @return 系统近十天来的访问记录
	 */
	List<Map<String, String>> findLastTenDaysVisitCount(String username);


	/**
	 * 按浏览器来统计数量
	 *
	 * @return 浏览器访问量
	 */
	List<Map<String, Object>> findByBrowser();

	/**
	 * 按操作系统来统计数量
	 *
	 * @return 操作系统访问量
	 */
	List<Map<String, Object>> findByOperatingSystem();

	/**
	 * 清理日志
	 *
	 * @param clearBeforeTime 多久之前的
	 * @param clearBeforeNum  多少条
	 * @return 是否成功
	 */
	boolean clearLog(LocalDateTime clearBeforeTime, Integer clearBeforeNum);

	/**
	 * 总 PV
	 *
	 * @return
	 */
	Long getTotalPv();

	/**
	 * 今日 PV
	 *
	 * @return
	 */
	Long getTodayPv();

	/**
	 * pv 计数
	 */
	void pvIncr();

}
