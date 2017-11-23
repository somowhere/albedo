package com.albedo.java.common.config;

import com.albedo.java.util.PublicUtil;
import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.web.cors.CorsConfiguration;

import javax.validation.constraints.NotNull;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * Properties specific to Albedo.
 * <p>
 * <p>
 * Properties are configured in the application.yml file.
 * </p>
 */
@ConfigurationProperties(prefix = "albedo",
        ignoreInvalidFields = true,
        exceptionIfInvalid = false)
@Data
public class AlbedoProperties {

    private final Async async = new Async();
    private final Http http = new Http();
    private final Cache cache = new Cache();
    private final Mail mail = new Mail();
    private final Security security = new Security();
    private final Metrics metrics = new Metrics();
    private final CorsConfiguration cors = new CorsConfiguration();
    private final Logging logging = new Logging();
    private final AlbedoProperties.Gateway gateway = new AlbedoProperties.Gateway();
    private final AlbedoProperties.Ribbon ribbon = new AlbedoProperties.Ribbon();
    private final AlbedoProperties.Registry registry = new AlbedoProperties.Registry();

    private String adminPath = "/a";
    private String frontPath = "/f";
    private String defaultView;
    private String application = "albedo";
    private String jedisKeyPrefix = "";
    private String urlSuffix = ".html";
    private Boolean microModel = false;
    private Boolean gatewayModel = false;
    private String micorservice;
    private Boolean developMode = true;
    private Boolean testMode = true;
    private Boolean quartzEnabled = true;
    private Boolean isTokenInterceptor = true;
    private Boolean cluster = false;
    private String freeURL = "";
    private String staticFileDirectory = "";

    public String getAdminPath(String strs) {
        return PublicUtil.toAppendStr(adminPath, strs);
    }

    public String getStaticUrlPath(String strs) {
        return PublicUtil.toAppendStr(adminPath, "/file/get", strs);
    }

    public String getStaticFileDirectory(String strs) {
        return PublicUtil.toAppendStr(staticFileDirectory, strs);
    }

    private static class Registry {
        private String password;

        private Registry() {
        }

        public String getPassword() {
            return this.password;
        }

        public void setPassword(String password) {
            this.password = password;
        }
    }

    public static class Ribbon {
        private String[] displayOnActiveProfiles;

        public Ribbon() {
        }

        public String[] getDisplayOnActiveProfiles() {
            return this.displayOnActiveProfiles;
        }

        public void setDisplayOnActiveProfiles(String[] displayOnActiveProfiles) {
            this.displayOnActiveProfiles = displayOnActiveProfiles;
        }
    }

    public static class Gateway {
        private final AlbedoProperties.Gateway.RateLimiting rateLimiting = new AlbedoProperties.Gateway.RateLimiting();
        private Map<String, List<String>> authorizedMicroservicesEndpoints = new LinkedHashMap();

        public Gateway() {
        }

        public AlbedoProperties.Gateway.RateLimiting getRateLimiting() {
            return this.rateLimiting;
        }

        public Map<String, List<String>> getAuthorizedMicroservicesEndpoints() {
            return this.authorizedMicroservicesEndpoints;
        }

        public void setAuthorizedMicroservicesEndpoints(Map<String, List<String>> authorizedMicroservicesEndpoints) {
            this.authorizedMicroservicesEndpoints = authorizedMicroservicesEndpoints;
        }

        public static class RateLimiting {
            private boolean enabled = false;
            private long limit = 100000L;
            private int durationInSeconds = 3600;

            public RateLimiting() {
            }

            public boolean isEnabled() {
                return this.enabled;
            }

            public void setEnabled(boolean enabled) {
                this.enabled = enabled;
            }

            public long getLimit() {
                return this.limit;
            }

            public void setLimit(long limit) {
                this.limit = limit;
            }

            public int getDurationInSeconds() {
                return this.durationInSeconds;
            }

            public void setDurationInSeconds(int durationInSeconds) {
                this.durationInSeconds = durationInSeconds;
            }
        }
    }
    public static class Async {

        private int corePoolSize = 2;

        private int maxPoolSize = 50;

        private int queueCapacity = 10000;

        public int getCorePoolSize() {
            return corePoolSize;
        }

        public void setCorePoolSize(int corePoolSize) {
            this.corePoolSize = corePoolSize;
        }

        public int getMaxPoolSize() {
            return maxPoolSize;
        }

        public void setMaxPoolSize(int maxPoolSize) {
            this.maxPoolSize = maxPoolSize;
        }

        public int getQueueCapacity() {
            return queueCapacity;
        }

        public void setQueueCapacity(int queueCapacity) {
            this.queueCapacity = queueCapacity;
        }
    }

    public static class Http {

        private Boolean restful = false;
        
        public Boolean getRestful() {
            return restful;
        }

        public void setRestful(Boolean restful) {
            this.restful = restful;
        }


        private final AlbedoProperties.Http.Cache cache = new AlbedoProperties.Http.Cache();
        public AlbedoProperties.Http.Version version;

        public Http() {
            this.version = AlbedoProperties.Http.Version.V_1_1;
        }

        public AlbedoProperties.Http.Cache getCache() {
            return this.cache;
        }

        public AlbedoProperties.Http.Version getVersion() {
            return this.version;
        }

        public void setVersion(AlbedoProperties.Http.Version version) {
            this.version = version;
        }

        public static class Cache {
            private int timeToLiveInDays = 1461;

            public Cache() {
            }

            public int getTimeToLiveInDays() {
                return this.timeToLiveInDays;
            }

            public void setTimeToLiveInDays(int timeToLiveInDays) {
                this.timeToLiveInDays = timeToLiveInDays;
            }
        }

        public static enum Version {
            V_1_1,
            V_2_0;

            private Version() {
            }
        }
    }

    public static class Cache {

        private final AlbedoProperties.Cache.Hazelcast hazelcast = new AlbedoProperties.Cache.Hazelcast();
        private final AlbedoProperties.Cache.Ehcache ehcache = new AlbedoProperties.Cache.Ehcache();
        private final AlbedoProperties.Cache.Infinispan infinispan = new AlbedoProperties.Cache.Infinispan();

        public Cache() {
        }

        public AlbedoProperties.Cache.Hazelcast getHazelcast() {
            return this.hazelcast;
        }

        public AlbedoProperties.Cache.Ehcache getEhcache() {
            return this.ehcache;
        }

        public AlbedoProperties.Cache.Infinispan getInfinispan() {
            return this.infinispan;
        }

        public static class Infinispan {
            private String configFile = "default-configs/default-jgroups-tcp.xml";
            private boolean statsEnabled;
            private final AlbedoProperties.Cache.Infinispan.Local local = new AlbedoProperties.Cache.Infinispan.Local();
            private final AlbedoProperties.Cache.Infinispan.Distributed distributed = new AlbedoProperties.Cache.Infinispan.Distributed();
            private final AlbedoProperties.Cache.Infinispan.Replicated replicated = new AlbedoProperties.Cache.Infinispan.Replicated();

            public Infinispan() {
            }

            public String getConfigFile() {
                return this.configFile;
            }

            public void setConfigFile(String configFile) {
                this.configFile = configFile;
            }

            public boolean isStatsEnabled() {
                return this.statsEnabled;
            }

            public void setStatsEnabled(boolean statsEnabled) {
                this.statsEnabled = statsEnabled;
            }

            public AlbedoProperties.Cache.Infinispan.Local getLocal() {
                return this.local;
            }

            public AlbedoProperties.Cache.Infinispan.Distributed getDistributed() {
                return this.distributed;
            }

            public AlbedoProperties.Cache.Infinispan.Replicated getReplicated() {
                return this.replicated;
            }

            public static class Replicated {
                private long timeToLiveSeconds = 60L;
                private long maxEntries = 100L;

                public Replicated() {
                }

                public long getTimeToLiveSeconds() {
                    return this.timeToLiveSeconds;
                }

                public void setTimeToLiveSeconds(long timeToLiveSeconds) {
                    this.timeToLiveSeconds = timeToLiveSeconds;
                }

                public long getMaxEntries() {
                    return this.maxEntries;
                }

                public void setMaxEntries(long maxEntries) {
                    this.maxEntries = maxEntries;
                }
            }

            public static class Distributed {
                private long timeToLiveSeconds = 60L;
                private long maxEntries = 100L;
                private int instanceCount = 1;

                public Distributed() {
                }

                public long getTimeToLiveSeconds() {
                    return this.timeToLiveSeconds;
                }

                public void setTimeToLiveSeconds(long timeToLiveSeconds) {
                    this.timeToLiveSeconds = timeToLiveSeconds;
                }

                public long getMaxEntries() {
                    return this.maxEntries;
                }

                public void setMaxEntries(long maxEntries) {
                    this.maxEntries = maxEntries;
                }

                public int getInstanceCount() {
                    return this.instanceCount;
                }

                public void setInstanceCount(int instanceCount) {
                    this.instanceCount = instanceCount;
                }
            }

            public static class Local {
                private long timeToLiveSeconds = 60L;
                private long maxEntries = 100L;

                public Local() {
                }

                public long getTimeToLiveSeconds() {
                    return this.timeToLiveSeconds;
                }

                public void setTimeToLiveSeconds(long timeToLiveSeconds) {
                    this.timeToLiveSeconds = timeToLiveSeconds;
                }

                public long getMaxEntries() {
                    return this.maxEntries;
                }

                public void setMaxEntries(long maxEntries) {
                    this.maxEntries = maxEntries;
                }
            }
        }


        public static class Ehcache {
            private int timeToLiveSeconds = 3600;
            private long maxEntries = 100L;

            public Ehcache() {
            }

            public int getTimeToLiveSeconds() {
                return this.timeToLiveSeconds;
            }

            public void setTimeToLiveSeconds(int timeToLiveSeconds) {
                this.timeToLiveSeconds = timeToLiveSeconds;
            }

            public long getMaxEntries() {
                return this.maxEntries;
            }

            public void setMaxEntries(long maxEntries) {
                this.maxEntries = maxEntries;
            }
        }

        public static class Hazelcast {
            private int timeToLiveSeconds = 3600;
            private int backupCount = 1;

            public Hazelcast() {
            }

            public int getTimeToLiveSeconds() {
                return this.timeToLiveSeconds;
            }

            public void setTimeToLiveSeconds(int timeToLiveSeconds) {
                this.timeToLiveSeconds = timeToLiveSeconds;
            }

            public int getBackupCount() {
                return this.backupCount;
            }

            public void setBackupCount(int backupCount) {
                this.backupCount = backupCount;
            }
        }
    }

    public static class Mail {
        private String from = "";
        private String baseUrl = "";

        public Mail() {
        }

        public String getFrom() {
            return this.from;
        }

        public void setFrom(String from) {
            this.from = from;
        }

        public String getBaseUrl() {
            return this.baseUrl;
        }

        public void setBaseUrl(String baseUrl) {
            this.baseUrl = baseUrl;
        }
    }

    public static class Security {

        private final AlbedoProperties.Security.RememberMe rememberMe = new AlbedoProperties.Security.RememberMe();
        private final AlbedoProperties.Security.ClientAuthorization clientAuthorization = new AlbedoProperties.Security.ClientAuthorization();
        private final AlbedoProperties.Security.Authentication authentication = new AlbedoProperties.Security.Authentication();

        public Security() {
        }

        public AlbedoProperties.Security.RememberMe getRememberMe() {
            return this.rememberMe;
        }

        public AlbedoProperties.Security.ClientAuthorization getClientAuthorization() {
            return this.clientAuthorization;
        }

        public AlbedoProperties.Security.Authentication getAuthentication() {
            return this.authentication;
        }

        public static class RememberMe {
            @NotNull
            private String key;

            public RememberMe() {
            }

            public String getKey() {
                return this.key;
            }

            public void setKey(String key) {
                this.key = key;
            }
        }

        public static class Authentication {
            private final AlbedoProperties.Security.Authentication.Oauth oauth = new AlbedoProperties.Security.Authentication.Oauth();
            private final AlbedoProperties.Security.Authentication.Jwt jwt = new AlbedoProperties.Security.Authentication.Jwt();

            public Authentication() {
            }

            public AlbedoProperties.Security.Authentication.Oauth getOauth() {
                return this.oauth;
            }

            public AlbedoProperties.Security.Authentication.Jwt getJwt() {
                return this.jwt;
            }

            public static class Jwt {
                private String secret;
                private long tokenValidityInSeconds = 1800L;
                private long tokenValidityInSecondsForRememberMe = 2592000L;

                public Jwt() {
                }

                public String getSecret() {
                    return this.secret;
                }

                public void setSecret(String secret) {
                    this.secret = secret;
                }

                public long getTokenValidityInSeconds() {
                    return this.tokenValidityInSeconds;
                }

                public void setTokenValidityInSeconds(long tokenValidityInSeconds) {
                    this.tokenValidityInSeconds = tokenValidityInSeconds;
                }

                public long getTokenValidityInSecondsForRememberMe() {
                    return this.tokenValidityInSecondsForRememberMe;
                }

                public void setTokenValidityInSecondsForRememberMe(long tokenValidityInSecondsForRememberMe) {
                    this.tokenValidityInSecondsForRememberMe = tokenValidityInSecondsForRememberMe;
                }
            }

            public static class Oauth {
                private String clientId;
                private String clientSecret;
                private int tokenValidityInSeconds = 1800;

                public Oauth() {
                }

                public String getClientId() {
                    return this.clientId;
                }

                public void setClientId(String clientId) {
                    this.clientId = clientId;
                }

                public String getClientSecret() {
                    return this.clientSecret;
                }

                public void setClientSecret(String clientSecret) {
                    this.clientSecret = clientSecret;
                }

                public int getTokenValidityInSeconds() {
                    return this.tokenValidityInSeconds;
                }

                public void setTokenValidityInSeconds(int tokenValidityInSeconds) {
                    this.tokenValidityInSeconds = tokenValidityInSeconds;
                }
            }
        }

        public static class ClientAuthorization {
            private String accessTokenUri;
            private String tokenServiceId;
            private String clientId;
            private String clientSecret;

            public ClientAuthorization() {
            }

            public String getAccessTokenUri() {
                return this.accessTokenUri;
            }

            public void setAccessTokenUri(String accessTokenUri) {
                this.accessTokenUri = accessTokenUri;
            }

            public String getTokenServiceId() {
                return this.tokenServiceId;
            }

            public void setTokenServiceId(String tokenServiceId) {
                this.tokenServiceId = tokenServiceId;
            }

            public String getClientId() {
                return this.clientId;
            }

            public void setClientId(String clientId) {
                this.clientId = clientId;
            }

            public String getClientSecret() {
                return this.clientSecret;
            }

            public void setClientSecret(String clientSecret) {
                this.clientSecret = clientSecret;
            }
        }
    }

    public static class Metrics {

        private final Jmx jmx = new Jmx();

        private final Spark spark = new Spark();

        private final Graphite graphite = new Graphite();

        private final Logs logs = new Logs();

        public Jmx getJmx() {
            return jmx;
        }

        public Spark getSpark() {
            return spark;
        }

        public Graphite getGraphite() {
            return graphite;
        }

        public Logs getLogs() {
            return logs;
        }

        public static class Jmx {

            private boolean enabled = true;

            public boolean isEnabled() {
                return enabled;
            }

            public void setEnabled(boolean enabled) {
                this.enabled = enabled;
            }
        }

        public static class Spark {

            private boolean enabled = false;

            private String host = "localhost";

            private int port = 9999;

            public boolean isEnabled() {
                return enabled;
            }

            public void setEnabled(boolean enabled) {
                this.enabled = enabled;
            }

            public String getHost() {
                return host;
            }

            public void setHost(String host) {
                this.host = host;
            }

            public int getPort() {
                return port;
            }

            public void setPort(int port) {
                this.port = port;
            }
        }

        public static class Graphite {

            private boolean enabled = false;

            private String host = "localhost";

            private int port = 2003;

            private String prefix = "albedoAlbedo";

            public boolean isEnabled() {
                return enabled;
            }

            public void setEnabled(boolean enabled) {
                this.enabled = enabled;
            }

            public String getHost() {
                return host;
            }

            public void setHost(String host) {
                this.host = host;
            }

            public int getPort() {
                return port;
            }

            public void setPort(int port) {
                this.port = port;
            }

            public String getPrefix() {
                return prefix;
            }

            public void setPrefix(String prefix) {
                this.prefix = prefix;
            }
        }

        public static class Logs {

            private boolean enabled = false;

            private long reportFrequency = 60;

            public long getReportFrequency() {
                return reportFrequency;
            }

            public void setReportFrequency(int reportFrequency) {
                this.reportFrequency = reportFrequency;
            }

            public boolean isEnabled() {
                return enabled;
            }

            public void setEnabled(boolean enabled) {
                this.enabled = enabled;
            }
        }
    }

    public static class Logging {

        private final Logstash logstash = new Logstash();

        public Logstash getLogstash() {
            return logstash;
        }

        public static class Logstash {

            private boolean enabled = false;

            private String host = "localhost";

            private int port = 5000;

            private int queueSize = 512;

            public boolean isEnabled() {
                return enabled;
            }

            public void setEnabled(boolean enabled) {
                this.enabled = enabled;
            }

            public String getHost() {
                return host;
            }

            public void setHost(String host) {
                this.host = host;
            }

            public int getPort() {
                return port;
            }

            public void setPort(int port) {
                this.port = port;
            }

            public int getQueueSize() {
                return queueSize;
            }

            public void setQueueSize(int queueSize) {
                this.queueSize = queueSize;
            }
        }
    }


}
