/*
 *  Copyright (c) 2019-2020, somowhere (somewhere0813@gmail.com).
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

package com.albedo.java.common.log.event;

import com.albedo.java.modules.sys.domain.LogOperateDo;
import org.springframework.context.ApplicationEvent;

/**
 * @author somowhere
 * 系统日志事件
 */
public class SysLogOperateEvent extends ApplicationEvent {

	public SysLogOperateEvent(LogOperateDo source) {
		super(source);
	}
}
