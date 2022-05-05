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

package com.albedo.java.modules.gen.repository;

import com.albedo.java.modules.gen.domain.Scheme;
import com.albedo.java.modules.gen.domain.vo.SchemeVo;
import com.albedo.java.plugins.database.mybatis.repository.BaseRepository;
import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Constants;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Spring Data JPA repository for the Authority domain.
 *
 * @author somewhere
 */
@Mapper
public interface SchemeRepository extends BaseRepository<Scheme> {

	/**
	 * 分页查询方案信息
	 *
	 * @param page    分页
	 * @param wrapper 查询参数
	 * @return list
	 */
	IPage<List<SchemeVo>> getSchemeVoPage(IPage page, @Param(Constants.WRAPPER) Wrapper wrapper);

}
