///*
// *  Copyright (c) 2019-2021  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
// *  <p>
// *  you may not use this file except in compliance with the License.
// *  You may obtain a copy of the License at
// *  <p>
// * https://www.gnu.org/licenses/lgpl.html
// *  <p>
// * Unless required by applicable law or agreed to in writing, software
// * distributed under the License is distributed on an "AS IS" BASIS,
// * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// * See the License for the specific language governing permissions and
// * limitations under the License.
// */
//
//package com.albedo.java.plugins.swagger.config.apidoc;
//
//import com.albedo.java.common.core.vo.PageModel;
//import com.fasterxml.classmate.TypeResolver;
//import org.springframework.boot.autoconfigure.AutoConfigureAfter;
//import org.springframework.boot.autoconfigure.condition.ConditionalOnBean;
//import org.springframework.boot.autoconfigure.condition.ConditionalOnClass;
//import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;
//import org.springframework.boot.autoconfigure.condition.ConditionalOnWebApplication;
//import org.springframework.context.annotation.Bean;
//import org.springframework.context.annotation.Configuration;
//import springfox.documentation.schema.TypeNameExtractor;
//import springfox.documentation.spring.web.plugins.Docket;
//
///**
// * @author somewhere
// * @description
// * @date 2020/5/31 17:14
// */
//@Configuration
//@ConditionalOnWebApplication
//@ConditionalOnBean({Docket.class})
//@AutoConfigureAfter({SwaggerAutoConfiguration.class})
//public class SwaggerPluginsAutoConfiguration {
//
//	@Configuration
//	@ConditionalOnClass({PageModel.class})
//	public static class MybatisPlusPagePluginConfiguration {
//
//		public MybatisPlusPagePluginConfiguration() {
//		}
//
//		@Bean
//		@ConditionalOnMissingBean
//		public PageableParameterBuilderPlugin pageableParameterBuilderPlugin(TypeNameExtractor typeNameExtractor,
//																			 TypeResolver typeResolver) {
//			return new PageableParameterBuilderPlugin(typeNameExtractor, typeResolver);
//		}
//
//	}
//
//}
