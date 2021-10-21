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

package com.albedo.java.modules.gen.service.impl;

import com.albedo.java.common.core.cache.model.CacheKeyBuilder;
import com.albedo.java.common.core.exception.EntityExistException;
import com.albedo.java.common.core.util.SpringContextHolder;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.datasource.support.DataSourceConstants;
import com.albedo.java.common.persistence.service.impl.DataCacheServiceImpl;
import com.albedo.java.modules.gen.cache.DatasourceConfCacheKeyBuilder;
import com.albedo.java.modules.gen.domain.DatasourceConf;
import com.albedo.java.modules.gen.domain.dto.DatasourceConfDto;
import com.albedo.java.modules.gen.repository.DatasourceConfRepository;
import com.albedo.java.modules.gen.service.DatasourceConfService;
import com.baomidou.dynamic.datasource.DynamicRoutingDataSource;
import com.baomidou.dynamic.datasource.creator.DataSourceCreator;
import com.baomidou.dynamic.datasource.spring.boot.autoconfigure.DataSourceProperty;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import lombok.RequiredArgsConstructor;
import org.jasypt.encryption.StringEncryptor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import javax.sql.DataSource;
import java.io.Serializable;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Collection;

/**
 * 数据源ServiceImpl 数据源
 *
 * @author somewhere
 * @version 2020-09-20 09:36:15
 */
@Service
@Transactional(rollbackFor = Exception.class)
@RequiredArgsConstructor
public class DatasourceConfServiceImpl
	extends DataCacheServiceImpl<DatasourceConfRepository, DatasourceConf, DatasourceConfDto>
	implements DatasourceConfService {

	private final StringEncryptor stringEncryptor;

	private final DataSourceCreator hikariDataSourceCreator;

	@Override
	protected CacheKeyBuilder cacheKeyBuilder() {
		return new DatasourceConfCacheKeyBuilder();
	}

	public Boolean exitDatasourceConfByName(DatasourceConfDto datasourceConfDto) {
		return getOne(Wrappers.<DatasourceConf>lambdaUpdate()
			.ne(StringUtil.isNotEmpty(datasourceConfDto.getId()), DatasourceConf::getId, datasourceConfDto.getId())
			.eq(DatasourceConf::getName, datasourceConfDto.getName())) != null;
	}

	@Override
	public void saveOrUpdate(DatasourceConfDto datasourceConfDto) {
		Assert.isTrue(checkDataSource(datasourceConfDto), "无效数据源");
		// name before comparing with database
		if (exitDatasourceConfByName(datasourceConfDto)) {
			throw new EntityExistException(DatasourceConfDto.class, "name", datasourceConfDto.getName());
		}
		if (StringUtil.isNotEmpty(datasourceConfDto.getId())) {
			removeDynamicDataSourceById(datasourceConfDto.getId());
		}
		addDynamicDataSource(datasourceConfDto);
		datasourceConfDto.setPassword(stringEncryptor.encrypt(datasourceConfDto.getPassword()));
		super.saveOrUpdate(datasourceConfDto);
	}

	@Override
	public boolean removeByIds(Collection<? extends Serializable> idList) {
		idList.forEach(id -> removeDynamicDataSourceById((String) id));
		return super.removeByIds(idList);

	}

	/**
	 * 删除动态数据源
	 *
	 * @param id 数据源信息
	 */
	public void removeDynamicDataSourceById(String id) {
		SpringContextHolder.getBean(DynamicRoutingDataSource.class)
			.removeDataSource(baseMapper.selectById(id).getName());
	}

	/**
	 * 添加动态数据源
	 *
	 * @param conf 数据源信息
	 */
	public void addDynamicDataSource(DatasourceConfDto conf) {
		DataSourceProperty dataSourceProperty = new DataSourceProperty();
		dataSourceProperty.setPoolName(conf.getName());
		dataSourceProperty.setUrl(conf.getUrl());
		dataSourceProperty.setUsername(conf.getUsername());
		dataSourceProperty.setPassword(conf.getPassword());
		dataSourceProperty.setDriverClassName(DataSourceConstants.DS_DRIVER);
		dataSourceProperty.setLazy(true);
		DataSource dataSource = hikariDataSourceCreator.createDataSource(dataSourceProperty);
		SpringContextHolder.getBean(DynamicRoutingDataSource.class).addDataSource(dataSourceProperty.getPoolName(),
			dataSource);
	}

	/**
	 * 校验数据源配置是否有效
	 *
	 * @param conf 数据源信息
	 * @return 有效/无效
	 */
	public Boolean checkDataSource(DatasourceConfDto conf) {
		try {
			DriverManager.getConnection(conf.getUrl(), conf.getUsername(), conf.getPassword());
		} catch (SQLException e) {
			log.error("数据源配置 {} , 获取链接失败", conf.getName(), e);
			return Boolean.FALSE;
		}
		return Boolean.TRUE;
	}

}
