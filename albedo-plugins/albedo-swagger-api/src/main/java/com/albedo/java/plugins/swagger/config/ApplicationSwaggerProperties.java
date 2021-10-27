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

package com.albedo.java.plugins.swagger.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

/**
 * @author somewhere
 * @date 9/7/16
 */

@Component
@ConfigurationProperties(prefix = "application.swagger", ignoreUnknownFields = false)
@Data
public class ApplicationSwaggerProperties {

	private String title = "Application API";

	private String description = "API documentation";

	private String version = "0.0.1";

	private String termsOfServiceUrl;

	private String contactName;

	private String contactUrl;

	private String contactEmail;

	private String license;

	private String licenseUrl;

	private String defaultIncludePattern = "/api/.*";

	private String host;

	private String[] protocols = {};

	private boolean useDefaultResponseMessages = true;

	private String oauthServer = "http://albedo-gateway:9999/oauth/token";

}
