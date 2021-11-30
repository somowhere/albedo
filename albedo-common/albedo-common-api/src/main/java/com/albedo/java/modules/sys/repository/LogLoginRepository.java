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
package com.albedo.java.modules.sys.repository;


import com.albedo.java.modules.sys.domain.LogLogin;
import com.albedo.java.plugins.database.mybatis.repository.BaseRepository;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

/**
 * 登录日志管理Repository 登录日志
 *
 * @author admin
 * @version 2021-11-30 10:15:00
 */
@Repository
public interface LogLoginRepository extends BaseRepository<LogLogin> {

	/**
	 * 获取系统总访问次数
	 *
	 * @return 总访问次数
	 */
	Long getTotalLoginPv();

	/**
	 * 获取系统今日访问次数
	 *
	 * @param today 今天
	 * @return 今日访问次数
	 */
	Long getTodayLoginPv(@Param("today") LocalDate today);

	/**
	 * 获取系统今日 登录IV
	 *
	 * @param today 今天
	 * @return 今日访问IP数
	 */
	Long getTodayLoginIv(@Param("today") LocalDate today);

	/**
	 * 获取系统 登录IV
	 *
	 * @return 今日访问IP数
	 */
	Long getTotalLoginIv();

	/**
	 * 获取系统近十天来的访问记录
	 *
	 * @param tenDays  10天前
	 * @param username 用户账号
	 * @return 系统近十天来的访问记录
	 */
	List<Map<String, String>> findLastTenDaysVisitCount(@Param("tenDays") LocalDateTime tenDays, @Param("username") String username);

	/**
	 * 按浏览器来统计数量
	 *
	 * @return 浏览器的数量
	 */
	List<Map<String, Object>> findByBrowser();

	/**
	 * 按操作系统来统计数量
	 *
	 * @return 操作系统的数量
	 */
	List<Map<String, Object>> findByOperatingSystem();

	/**
	 * 清理日志
	 *
	 * @param clearBeforeTime 多久之前的
	 * @param clearBeforeNum  多少条
	 * @return 是否成功
	 */
	Long clearLog(@Param("clearBeforeTime") LocalDateTime clearBeforeTime, @Param("clearBeforeNum") Integer clearBeforeNum);


}
