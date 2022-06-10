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

package com.albedo.java.common.core.config;

import com.albedo.java.common.core.util.StringUtil;
import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.cors.CorsConfiguration;

import javax.validation.constraints.NotNull;
import java.util.ArrayList;
import java.util.List;

/**
 * Properties specific to albedo.
 * <p>
 * <p>
 * Properties are configured in the application.yml file.
 * </p>
 *
 * @author somewhere
 */
@Configuration
@ConfigurationProperties(prefix = "application", ignoreInvalidFields = true)
@Data
public class ApplicationProperties {

	private String adminPath = "/a";
	private String version;

	private String defaultView;

	private Boolean addressEnabled = true;

	private int dbSyncSessionPeriod = 1;

	private String name = "albedo";

	private String urlSuffix = ".html";

	private Boolean developMode = true;

	private Boolean cluster = false;

	private String logPath = "logs/";

	private Security security = new Security();

	private Http http = new Http();

	private Rsa rsa = new Rsa();

	private CorsConfiguration cors = new CorsConfiguration();

	public String getAdminPath(String url) {
		return StringUtil.toAppendStr(adminPath, url);
	}

	@Data
	public static class Security {

		private final RememberMe rememberMe = new RememberMe();

		private final ClientAuthorization clientAuthorization = new ClientAuthorization();

		private final Authentication authentication = new Authentication();

		private List<String> authorize = new ArrayList<>();

		private List<String> authorizePermitAll = new ArrayList<>();

		private String encodeKey;

		public Security() {
		}

		@Data
		public static class RememberMe {

			@NotNull
			private String key;

			public RememberMe() {
			}

		}

		@Data
		public static class Authentication {

			private final Oauth oauth = new Oauth();

			private final Jwt jwt = new Jwt();

			public Authentication() {
			}

			@Data
			public static class Jwt {

				private String base64Secret;

				private long tokenValidityInSeconds = 1800L;

				private long tokenValidityInSecondsForRememberMe = 2592000L;

				public Jwt() {
				}

			}

			@Data
			public static class Oauth {

				private String clientId;

				private String clientSecret;

				private int tokenValidityInSeconds = 1800;

				public Oauth() {
				}

			}

		}

		@Data
		public static class ClientAuthorization {

			private String accessTokenUri;

			private String tokenServiceId;

			private String clientId;

			private String clientSecret;

			public ClientAuthorization() {
			}

		}

	}

	@Data
	public static class Rsa {

		private String publicKey;

		private String privateKey;

	}

	@Data
	public static class Http {

		private final Cache cache = new Cache();

		public Version version;

		public Http() {
			this.version = Version.V_1_1;
		}

		public enum Version {

			V_1_1, V_2_0;

			Version() {
			}

		}

		@Data
		public static class Cache {

			private int timeToLiveInDays = 1461;

			public Cache() {
			}

		}

	}

}
