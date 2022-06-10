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

package com.albedo.java.modules.gen.domain.vo;

import com.albedo.java.common.core.vo.SelectVo;
import com.albedo.java.modules.gen.domain.dto.TableDto;
import com.albedo.java.modules.gen.domain.xml.GenConfig;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.io.Serializable;
import java.util.List;

/**
 * 业务表Entity
 *
 * @author somowhere
 * @version 2013-10-15
 */
@Data
@ToString
@NoArgsConstructor
public class TableFormDataVo implements Serializable {

	private static final long serialVersionUID = 1L;

	private TableDto tableVo;

	private GenConfig config;

	private List<SelectVo> dsNameList;

	private List<SelectVo> columnList;

	private List<SelectVo> tableList;

	private List<SelectVo> queryTypeList;

	private List<SelectVo> showTypeList;

	private List<SelectVo> javaTypeList;

}
