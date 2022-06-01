
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

package com.albedo.java.modules.sys.repository;

import com.albedo.java.modules.sys.domain.DictDo;
import com.albedo.java.modules.sys.domain.vo.DictVo;
import com.albedo.java.plugins.database.mybatis.repository.TreeRepository;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Constants;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * <p>
 * 字典表 Mapper 接口
 * </p>
 *
 * @author somewhere
 * @since 2019/2/1
 */
@Mapper
public interface DictRepository extends TreeRepository<DictDo> {

	/**
	 * 字典树数据集合
	 *
	 * @param wrapper
	 * @return
	 */
	List<DictVo> findDictVoList(@Param(Constants.WRAPPER) QueryWrapper<DictDo> wrapper);

	/**
	 * 批量更新可用状态
	 *
	 * @param idList
	 * @param available
	 */
	void updateAvailableByIdList(@Param("idList") List<Long> idList, @Param("available") Integer available);

}
