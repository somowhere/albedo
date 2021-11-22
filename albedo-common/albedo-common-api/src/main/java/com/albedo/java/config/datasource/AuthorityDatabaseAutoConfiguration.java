package com.albedo.java.config.datasource;

import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.plugins.database.config.defaults.BaseMasterDatabaseConfiguration;
import com.albedo.java.plugins.database.properties.DatabaseProperties;
import com.baomidou.mybatisplus.autoconfigure.ConfigurationCustomizer;
import com.baomidou.mybatisplus.autoconfigure.MybatisPlusProperties;
import com.baomidou.mybatisplus.autoconfigure.MybatisPlusPropertiesCustomizer;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.mapping.DatabaseIdProvider;
import org.apache.ibatis.plugin.Interceptor;
import org.apache.ibatis.scripting.LanguageDriver;
import org.apache.ibatis.type.TypeHandler;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.ObjectProvider;
import org.springframework.boot.autoconfigure.condition.ConditionalOnExpression;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ResourceLoader;
import org.springframework.stereotype.Repository;

import java.util.List;


/**
 * application.database.multiTenantType != DATASOURCE 时，该类启用.
 * 此时，项目的多租户模式切换成：${application.database.multiTenantType}。
 * <p>
 * NONE("非租户模式"): 不存在租户的概念
 * COLUMN("字段模式"): 在sql中拼接 tenant_code 字段
 * SCHEMA("独立schema模式"): 在sql中拼接 数据库 schema
 * <p>
 * COLUMN和SCHEMA模式的实现 参考下面的 @see 中的2个类
 *
 * @author somewhere
 * @date 2017-11-18 0:34
 * 断点查看原理：👇👇👇
 * @see com.albedo.java.plugins.database.config.BaseMybatisConfiguration#mybatisPlusInterceptor()
 */
@Configuration
@Slf4j
@MapperScan(
	basePackages = {CommonConstants.UTIL_PACKAGE, CommonConstants.BUSINESS_PACKAGE},
	annotationClass = Repository.class,
	sqlSessionFactoryRef = BaseMasterDatabaseConfiguration.DATABASE_PREFIX + "SqlSessionFactory")
@EnableConfigurationProperties({MybatisPlusProperties.class})
//@ConditionalOnExpression("!'DATASOURCE'.equals('${application.database.multiTenantType}') && " +
//	"!'DATASOURCE_COLUMN'.equals('${application.database.multiTenantType}') ")
public class AuthorityDatabaseAutoConfiguration extends BaseMasterDatabaseConfiguration {

	public AuthorityDatabaseAutoConfiguration(MybatisPlusProperties properties,
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
		log.debug("检测到 application.database.multiTenantType!=DATASOURCE，加载了 AuthorityDatabaseAutoConfiguration");
	}

}
