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

package com.albedo.java.common.core.constant;

/**
 * 任务调度通用常量
 *
 * @author somewhere
 */
public interface ScheduleConstants {

	String TASK_CLASS_NAME = "TASK_CLASS_NAME";

	String REDIS_SCHEDULE_DEFAULT_CHANNEL = "REDIS_SCHEDULE_DEFAULT_CHANNEL";

	/**
	 * 执行目标key
	 */
	String TASK_PROPERTIES = "TASK_PROPERTIES";

	/**
	 * 默认
	 */
	String MISFIRE_DEFAULT = "0";

	/**
	 * 立即触发执行
	 */
	String MISFIRE_IGNORE_MISFIRES = "1";

	/**
	 * 触发一次执行
	 */
	String MISFIRE_FIRE_AND_PROCEED = "2";

	/**
	 * 不触发立即执行
	 */
	String MISFIRE_DO_NOTHING = "3";

	enum Status {

		/**
		 * 暂停
		 */
		PAUSE("0"),
		/**
		 * 正常
		 */
		NORMAL("1");

        private final String value;

		Status(String value) {
			this.value = value;
		}

		public String getValue() {
			return value;
		}

	}

	enum MessageType {

		/**
		 * 创建
		 */
		ADD,
		/**
		 * 更新
		 */
		UPDATE,
		/**
		 * 暂停
		 */
		PAUSE,
		/**
		 * 恢复
		 */
		RESUME,
		/**
		 * 删除
		 */
		DELETE,
		/**
		 * 运行
		 */
		RUN

	}

}
