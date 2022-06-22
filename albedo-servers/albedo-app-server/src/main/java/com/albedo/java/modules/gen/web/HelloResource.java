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

package com.albedo.java.modules.gen.web;

import com.albedo.java.common.core.domain.vo.PageModel;
import com.albedo.java.common.core.util.Result;
import com.albedo.java.common.web.resource.BaseResource;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @author somewhere
 */
@Controller
@RequestMapping("${application.admin-path}/hello")
public class HelloResource extends BaseResource {

	/**
	 * @param pageModel
	 * @return
	 */
	@GetMapping
	@PreAuthorize("@pms.hasPermission('gen_scheme_view')")
	public Result getPage(PageModel pm) {
		return Result.buildOk("hello " + pm);
	}

}
