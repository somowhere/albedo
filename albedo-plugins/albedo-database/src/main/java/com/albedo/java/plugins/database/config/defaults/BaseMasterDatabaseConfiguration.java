package com.albedo.java.plugins.database.config.defaults;


import com.albedo.java.plugins.database.config.BaseDatabaseConfiguration;
import com.albedo.java.plugins.database.properties.DatabaseProperties;
import com.alibaba.druid.spring.boot.autoconfigure.DruidDataSourceBuilder;
import com.baomidou.mybatisplus.autoconfigure.ConfigurationCustomizer;
import com.baomidou.mybatisplus.autoconfigure.MybatisPlusProperties;
import com.baomidou.mybatisplus.autoconfigure.MybatisPlusPropertiesCustomizer;
import com.p6spy.engine.spy.P6DataSource;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.mapping.DatabaseIdProvider;
import org.apache.ibatis.plugin.Interceptor;
import org.apache.ibatis.scripting.LanguageDriver;
import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.type.TypeHandler;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.ObjectProvider;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Primary;
import org.springframework.core.io.ResourceLoader;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;

import javax.sql.DataSource;
import java.util.List;

/**
 * 数据库& 事务& MyBatis & Mp 配置
 * application.database.multiTenantType != DATASOURCE时， 子类需要继承它，并让程序启动时加载
 * <p>
 * 注意：BaseDatabaseConfiguration 和 DynamicDataSourceAutoConfiguration 只能同时加载一个
 *
 * <p>
 * 不使用多数据源模式时，一个服务如何配置多数据源？
 * <p>
 * 1. 本类的子类的 @MapperScan(basePackages = {"com.albedo.java"}) 修改为  @MapperScan(basePackages = {"com.albedo.java.product.dao"})
 * 2. 修改本类的子类的 @ConfigurationProperties(prefix = "spring.datasource.druid") 为 @ConfigurationProperties(prefix = "spring.datasource.druid.master")
 * 3. 在层复制该类，重命名为 SlaveDatabaseAutoConfiguration （跟AuthorityDatabaseAutoConfiguration放一起）
 * 4. 修改 DATABASE_PREFIX 为 slave  (任意命名，不要跟当前的重复即可)
 * 5. 修改 @ConfigurationProperties(prefix = "spring.datasource.druid") 为 @ConfigurationProperties(prefix = "spring.datasource.druid.slave")
 * 6. SlaveDatabaseAutoConfiguration 中的 basePackages = {"com.albedo.java"}, 修改为  basePackages = {"com.albedo.java.order.dao"} # 这个路径根据你的情况修改
 * 7. mysql.yml 中增加2个数据源的配置 spring.database.druid.master 和 spring.database.druid.slave
 * 8. mysql.yml 中将 mybatis-plus: 相关的所有配置完整的复制一份为： mybatis-plus-slave: ， 并修改各自的子项 mapper-locations: 进行修改
 * 8. 复制 MybatisPlusProperties 为 MybatisPlusSlaveProperties， 并修改类上的配置为 @ConfigurationProperties(prefix = "mybatis-plus-slave")
 * 9. SlaveDatabaseAutoConfiguration 类上面需要配置 AuthorityDatabaseAutoConfiguration 类上的一系列注解
 * 10. SlaveDatabaseAutoConfiguration 类上面需要配置 @EnableConfigurationProperties({MybatisPlusSlaveProperties.class}) ， 构造器第一个参数也改成 MybatisPlusSlaveProperties
 * <p>
 * 完成上述修改后， 位于com.albedo.java.product.dao 包下的dao 将操作  master 库， com.albedo.java.order.dao中的dao 将操作slave库
 *
 * @author somewhere
 * @date 2017-11-18 0:34
 */
@Slf4j
public abstract class BaseMasterDatabaseConfiguration extends BaseDatabaseConfiguration {
	/**
	 * 每个数据源配置不同即可
	 */
	public static final String DATABASE_PREFIX = "master";

	protected BaseMasterDatabaseConfiguration(MybatisPlusProperties properties,
											  DatabaseProperties databaseProperties,
											  ObjectProvider<Interceptor[]> interceptorsProvider,
											  ObjectProvider<TypeHandler[]> typeHandlersProvider,
											  ObjectProvider<LanguageDriver[]> languageDriversProvider,
											  ResourceLoader resourceLoader,
											  ObjectProvider<DatabaseIdProvider> databaseIdProvider,
											  ObjectProvider<List<ConfigurationCustomizer>> configurationCustomizersProvider,
											  ObjectProvider<List<MybatisPlusPropertiesCustomizer>> mybatisPlusPropertiesCustomizerProvider,
											  ApplicationContext applicationContext) {
		super(properties, databaseProperties, interceptorsProvider, typeHandlersProvider,
			languageDriversProvider, resourceLoader, databaseIdProvider,
			configurationCustomizersProvider, mybatisPlusPropertiesCustomizerProvider, applicationContext);
	}

	@Bean(DATABASE_PREFIX + "SqlSessionTemplate")
	public SqlSessionTemplate getSqlSessionTemplate(@Qualifier(DATABASE_PREFIX + "SqlSessionFactory") SqlSessionFactory sqlSessionFactory) {
		ExecutorType executorType = this.properties.getExecutorType();
		if (executorType != null) {
			return new SqlSessionTemplate(sqlSessionFactory, executorType);
		} else {
			return new SqlSessionTemplate(sqlSessionFactory);
		}
	}

	/**
	 * 数据源信息
	 *
	 * @return javax.sql.DataSource Druid数据源
	 * @author somewhere
	 * @date 2021/8/15 10:16 下午
	 * @create [2021/8/15 10:16 下午 ] [somewhere] [初始创建]
	 */
	@Bean(name = DATABASE_PREFIX + "DruidDataSource", initMethod = "init")
	public DataSource druidDataSource() {
		return DruidDataSourceBuilder.create().build();
	}

	@Primary
	@Bean(name = DATABASE_PREFIX + "DataSource")
	public DataSource dataSource(@Qualifier(DATABASE_PREFIX + "DruidDataSource") DataSource dataSource) {
		if (databaseProperties.getP6spy()) {
			return new P6DataSource(dataSource);
		} else {
			return dataSource;
		}
	}

	/**
	 * mybatis Sql Session 工厂
	 *
	 * @return sql链接工厂
	 * @throws Exception 异常
	 */
	@Bean(DATABASE_PREFIX + "SqlSessionFactory")
	@Primary
	public SqlSessionFactory getSqlSessionFactory(@Qualifier(DATABASE_PREFIX + "DataSource") DataSource dataSource) throws Exception {
		return super.sqlSessionFactory(dataSource);
	}

	/**
	 * 数据源事务管理器
	 *
	 * @return 数据源事务管理器
	 */
	@Bean(name = DATABASE_PREFIX + "TransactionManager")
	@Primary
	public DataSourceTransactionManager dsTransactionManager(@Qualifier(DATABASE_PREFIX + "DataSource") DataSource dataSource) {
		return new DataSourceTransactionManager(dataSource);
	}
}
