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

package com.albedo.java.plugins.database.mybatis.service.impl;

import com.albedo.java.plugins.database.mybatis.repository.BaseRepository;
import com.albedo.java.plugins.database.mybatis.service.BaseService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.baomidou.mybatisplus.extension.toolkit.SqlHelper;
import org.apache.ibatis.logging.Log;
import org.apache.ibatis.logging.LogFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

/**
 * Service基类
 *
 * @author somewhere
 * @version 2014-05-16
 */
@Transactional(rollbackFor = Exception.class)
public abstract class BaseServiceImpl<Repository extends BaseRepository<T>, T> extends ServiceImpl<Repository, T>
	implements BaseService<T> {

	public final Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired
	public Repository repository;

	@Override
	@Transactional(rollbackFor = Exception.class)
	public boolean updateAllById(T model) {
		return SqlHelper.retBool(repository.updateAllById(model));
	}

	@Override
	public Repository getRepository() {
		return repository;
	}
}
