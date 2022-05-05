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

package com.albedo.java.modules.quartz.task;

import com.albedo.java.common.core.util.StringUtil;
import org.springframework.stereotype.Component;

/**
 * 定时任务调度测试
 *
 * @author somewhere
 */
@Component
public class SimpleTask {

	public void doMultipleParams(String s, Boolean b, Long l, Double d, Integer i) {
		System.out.println(StringUtil.format("执行多参方法： 字符串类型{}，布尔类型{}，长整型{}，浮点型{}，整形{}", s, b, l, d, i));
	}

	public void doParams(String params) {
		System.out.println("执行有参方法：" + params);
	}

	public void doNoParams() {
		System.out.println("执行无参方法");
	}

}
