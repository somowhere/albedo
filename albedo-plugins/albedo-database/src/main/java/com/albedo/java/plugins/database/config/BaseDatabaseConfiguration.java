package com.albedo.java.plugins.database.config;


import cn.hutool.core.bean.BeanUtil;
import com.albedo.java.plugins.database.mybatis.typehandler.CustomEnumTypeHandler;
import com.albedo.java.plugins.database.properties.DatabaseProperties;
import com.baomidou.mybatisplus.autoconfigure.ConfigurationCustomizer;
import com.baomidou.mybatisplus.autoconfigure.MybatisPlusProperties;
import com.baomidou.mybatisplus.autoconfigure.MybatisPlusPropertiesCustomizer;
import com.baomidou.mybatisplus.autoconfigure.SpringBootVFS;
import com.baomidou.mybatisplus.core.MybatisConfiguration;
import com.baomidou.mybatisplus.core.config.GlobalConfig;
import com.baomidou.mybatisplus.core.handlers.MetaObjectHandler;
import com.baomidou.mybatisplus.core.incrementer.IKeyGenerator;
import com.baomidou.mybatisplus.core.incrementer.IdentifierGenerator;
import com.baomidou.mybatisplus.core.injector.ISqlInjector;
import com.baomidou.mybatisplus.extension.spring.MybatisSqlSessionFactoryBean;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.mapping.DatabaseIdProvider;
import org.apache.ibatis.plugin.Interceptor;
import org.apache.ibatis.scripting.LanguageDriver;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.transaction.TransactionFactory;
import org.apache.ibatis.type.TypeHandler;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.ObjectProvider;
import org.springframework.context.ApplicationContext;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.util.Assert;
import org.springframework.util.CollectionUtils;
import org.springframework.util.ObjectUtils;
import org.springframework.util.StringUtils;

import javax.sql.DataSource;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.function.Consumer;

/**
 * 数据库& 事务& MyBatis & Mp 配置
 * application.database.multiTenantType != DATASOURCE时， 子类需要继承它，并让程序启动时加载
 * <p>
 * 注意：BaseDatabaseConfiguration 和 DynamicDataSourceAutoConfiguration 只能同时加载一个
 * <p>
 * 对 MybatisPlusAutoConfiguration 的增强
 *
 * @author somewhere
 * @author Eddú Meléndez
 * @author Josh Long
 * @author Kazuki Shimizu
 * @author Eduardo Macarrón
 * @date 2020年01月07日17:09:23
 */
@Slf4j
public abstract class BaseDatabaseConfiguration implements InitializingBean {


	protected final DatabaseProperties databaseProperties;
	protected final MybatisPlusProperties properties;
	protected final Interceptor[] interceptors;
	protected final TypeHandler[] typeHandlers;
	protected final LanguageDriver[] languageDrivers;
	protected final ResourceLoader resourceLoader;
	protected final DatabaseIdProvider databaseIdProvider;
	protected final List<ConfigurationCustomizer> configurationCustomizers;
	protected final List<MybatisPlusPropertiesCustomizer> mybatisPlusPropertiesCustomizers;
	protected final ApplicationContext applicationContext;

	public BaseDatabaseConfiguration(final MybatisPlusProperties properties,
									 final DatabaseProperties databaseProperties,
									 ObjectProvider<Interceptor[]> interceptorsProvider,
									 ObjectProvider<TypeHandler[]> typeHandlersProvider,
									 ObjectProvider<LanguageDriver[]> languageDriversProvider,
									 final ResourceLoader resourceLoader,
									 final ObjectProvider<DatabaseIdProvider> databaseIdProvider,
									 ObjectProvider<List<ConfigurationCustomizer>> configurationCustomizersProvider,
									 ObjectProvider<List<MybatisPlusPropertiesCustomizer>> mybatisPlusPropertiesCustomizerProvider,
									 final ApplicationContext applicationContext) {
		this.properties = properties;
		this.databaseProperties = databaseProperties;
		this.interceptors = interceptorsProvider.getIfAvailable();
		this.typeHandlers = typeHandlersProvider.getIfAvailable();
		this.languageDrivers = languageDriversProvider.getIfAvailable();
		this.resourceLoader = resourceLoader;
		this.databaseIdProvider = databaseIdProvider.getIfAvailable();
		this.configurationCustomizers = configurationCustomizersProvider.getIfAvailable();
		this.mybatisPlusPropertiesCustomizers = mybatisPlusPropertiesCustomizerProvider.getIfAvailable();
		this.applicationContext = applicationContext;
	}

	/**
	 * 设置属性后
	 */
	@Override
	public void afterPropertiesSet() {
		if (!CollectionUtils.isEmpty(this.mybatisPlusPropertiesCustomizers)) {
			mybatisPlusPropertiesCustomizers.forEach(i -> i.customize(this.properties));
		}
		checkConfigFileExists();
	}

	private void checkConfigFileExists() {
		if (this.properties.isCheckConfigLocation() && StringUtils.hasText(this.properties.getConfigLocation())) {
			Resource resource = this.resourceLoader.getResource(this.properties.getConfigLocation());
			Assert.state(resource.exists(),
				"Cannot find config location: " + resource + " (please add config file or check your Mybatis configuration)");
		}
	}

	/**
	 * 构建sqlSession工厂
	 *
	 * @param dataSource 数据源
	 * @return sqlSession工厂
	 * @throws Exception 异常
	 */
	public SqlSessionFactory sqlSessionFactory(DataSource dataSource) throws Exception {
		// TODO 使用 MybatisSqlSessionFactoryBean 而不是 SqlSessionFactoryBean
		MybatisSqlSessionFactoryBean factory = new MybatisSqlSessionFactoryBean();
		factory.setDataSource(dataSource);
		factory.setVfs(SpringBootVFS.class);
		if (StringUtils.hasText(this.properties.getConfigLocation())) {
			factory.setConfigLocation(this.resourceLoader.getResource(this.properties.getConfigLocation()));
		}
		applyConfiguration(factory);
		if (this.properties.getConfigurationProperties() != null) {
			factory.setConfigurationProperties(this.properties.getConfigurationProperties());
		}
		if (!ObjectUtils.isEmpty(this.interceptors)) {
			factory.setPlugins(this.interceptors);
		}
		if (this.databaseIdProvider != null) {
			factory.setDatabaseIdProvider(this.databaseIdProvider);
		}
		if (StringUtils.hasLength(this.properties.getTypeAliasesPackage())) {
			factory.setTypeAliasesPackage(this.properties.getTypeAliasesPackage());
		}
		if (this.properties.getTypeAliasesSuperType() != null) {
			factory.setTypeAliasesSuperType(this.properties.getTypeAliasesSuperType());
		}
		if (StringUtils.hasLength(this.properties.getTypeHandlersPackage())) {
			factory.setTypeHandlersPackage(this.properties.getTypeHandlersPackage());
		}
		if (!ObjectUtils.isEmpty(this.typeHandlers)) {
			factory.setTypeHandlers(this.typeHandlers);
		}
		Resource[] mapperLocations = this.properties.resolveMapperLocations();
		if (!ObjectUtils.isEmpty(mapperLocations)) {
			factory.setMapperLocations(mapperLocations);
		}
		// TODO 修改源码支持定义 TransactionFactory
		this.getBeanThen(TransactionFactory.class, factory::setTransactionFactory);

		// TODO 对源码做了一定的修改(因为源码适配了老旧的mybatis版本,但我们不需要适配)
		Class<? extends LanguageDriver> defaultLanguageDriver = this.properties.getDefaultScriptingLanguageDriver();
		if (!ObjectUtils.isEmpty(this.languageDrivers)) {
			factory.setScriptingLanguageDrivers(this.languageDrivers);
		}
		Optional.ofNullable(defaultLanguageDriver).ifPresent(factory::setDefaultScriptingLanguageDriver);

		// TODO 自定义枚举包
		if (StringUtils.hasLength(this.properties.getTypeEnumsPackage())) {
			factory.setTypeEnumsPackage(this.properties.getTypeEnumsPackage());
		}
		// TODO 此处必为非 NULL
		GlobalConfig globalConfig = this.properties.getGlobalConfig();
		// TODO 注入填充器
		this.getBeanThen(MetaObjectHandler.class, globalConfig::setMetaObjectHandler);
		// TODO 注入主键成器
		this.getBeansThen(IKeyGenerator.class, i -> globalConfig.getDbConfig().setKeyGenerators(i));
		// TODO 注入sql注入器
		this.getBeanThen(ISqlInjector.class, globalConfig::setSqlInjector);
		// TODO 注入ID生成器
		this.getBeanThen(IdentifierGenerator.class, globalConfig::setIdentifierGenerator);
		// TODO 设置 GlobalConfig 到 MybatisSqlSessionFactoryBean
		factory.setGlobalConfig(globalConfig);
		return factory.getObject();
	}

	private <T> void getBeanThen(Class<T> clazz, Consumer<T> consumer) {
		if (this.applicationContext.getBeanNamesForType(clazz, false, false).length > 0) {
			consumer.accept(this.applicationContext.getBean(clazz));
		}
	}

	/**
	 * 检查spring容器里是否有对应的bean,有则进行消费
	 *
	 * @param clazz    class
	 * @param consumer 消费
	 * @param <T>      泛型
	 */
	private <T> void getBeansThen(Class<T> clazz, Consumer<List<T>> consumer) {
		if (this.applicationContext.getBeanNamesForType(clazz, false, false).length > 0) {
			final Map<String, T> beansOfType = this.applicationContext.getBeansOfType(clazz);
			List<T> clazzList = new ArrayList<>();
			beansOfType.forEach((k, v) -> clazzList.add(v));
			consumer.accept(clazzList);
		}
	}

	protected void applyConfiguration(MybatisSqlSessionFactoryBean factory) {
		MybatisConfiguration newConfiguration = this.properties.getConfiguration();
		if (newConfiguration == null && !StringUtils.hasText(this.properties.getConfigLocation())) {
			newConfiguration = new MybatisConfiguration();
		}

		// somewhere 改过这里：  这里一定要复制一次， 否则多数据源时，会导致拦截器等执行多次
		MybatisConfiguration configuration = new MybatisConfiguration();
		BeanUtil.copyProperties(newConfiguration, configuration);
		configuration.getTypeHandlerRegistry().setDefaultEnumTypeHandler(CustomEnumTypeHandler.class);
		if (!CollectionUtils.isEmpty(this.configurationCustomizers)) {
			for (ConfigurationCustomizer customizer : this.configurationCustomizers) {
				customizer.customize(configuration);
			}
		}
		factory.setConfiguration(configuration);
	}


}
