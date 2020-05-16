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
 */
@Configuration
@ConfigurationProperties(prefix = "application", ignoreInvalidFields = true)
@Data
public class ApplicationProperties {

	private String adminPath = "/a";
	private String defaultView;
	private Boolean addressEnabled = true;
	private int dbSyncSessionPeriod = 1;
	private String name = "albedo";
	private String urlSuffix = ".html";
	private Boolean developMode = true;
	private Boolean cluster = false;
	private String staticFileDirectory = "";
	private String logPath = ".logs/";
	private Security security = new Security();
	private Http http = new Http();
	private CorsConfiguration cors = new CorsConfiguration();


//    public String getStaticUrlPath(String strs) {
//        return StringUtil.toAppendStr( "/file/get", strs);
//    }

	public String getStaticFileDirectory(String strs) {
		return StringUtil.toAppendStr(
			staticFileDirectory, strs);
	}

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
				private String secret;
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
	public static class Http {

		private final Cache cache = new Cache();
		public Version version;

		public Http() {
			this.version = Version.V_1_1;
		}

		public enum Version {
			V_1_1,
			V_2_0;

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
