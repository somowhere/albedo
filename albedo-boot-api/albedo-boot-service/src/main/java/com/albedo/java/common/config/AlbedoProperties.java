//package com.albedo.java.common.config;
//
//import com.albedo.java.util.PublicUtil;
//import org.springframework.boot.context.properties.ConfigurationProperties;
//import org.springframework.web.cors.CorsConfiguration;
//
//import javax.validation.constraints.NotNull;
//
///**
// * Properties specific to JHipster.
// *
// * <p>
// *     Properties are configured in the application.yml file.
// * </p>
// */
//@ConfigurationProperties(prefix = "albedo",
//        ignoreUnknownFields = true,
//        ignoreInvalidFields= true,
//        exceptionIfInvalid = false)
//public class AlbedoProperties {
//
//	private String adminPath = "/a";
//
//	private String frontPath = "/f";
//
//	private String defaultView;
//
//	private String application = "albedo";
//
//	private String jedisKeyPrefix = "";
//
//	private String urlSuffix = ".html";
//
//	private Boolean developMode=true;
//
//	private Boolean quartzEnabled=true;
//
//	private Boolean isTokenInterceptor=true;
//
//	private Boolean cluster=false;
//
//	private String freeURL = "";
//
//	private String staticFileDirectory = "";
//
//	private String rsaPublicKey = "";
//
//	private String rsaPrivateKey = "";
//
//    private final Async async = new Async();
//
//    private final Http http = new Http();
//
//    private final Cache cache = new Cache();
//
//    private final Mail mail = new Mail();
//
//    private final Security security = new Security();
//
//    private final Metrics metrics = new Metrics();
//
//    private final CorsConfiguration cors = new CorsConfiguration();
//
//    private final Ribbon ribbon = new Ribbon();
//
//    public Async getAsync() {
//        return async;
//    }
//
//    public Http getHttp() {
//        return http;
//    }
//
//    public Cache getCache() {
//        return cache;
//    }
//
//    public Mail getMail() {
//        return mail;
//    }
//
//    public Security getSecurity() {
//        return security;
//    }
//
//
//    public Metrics getMetrics() {
//        return metrics;
//    }
//
//    public CorsConfiguration getCors() {
//        return cors;
//    }
//
//    public Ribbon getRibbon() {
//        return ribbon;
//    }
//    public static class Async {
//
//        private int corePoolSize = 2;
//
//        private int maxPoolSize = 50;
//
//        private int queueCapacity = 10000;
//
//        public int getCorePoolSize() {
//            return corePoolSize;
//        }
//
//        public void setCorePoolSize(int corePoolSize) {
//            this.corePoolSize = corePoolSize;
//        }
//
//        public int getMaxPoolSize() {
//            return maxPoolSize;
//        }
//
//        public void setMaxPoolSize(int maxPoolSize) {
//            this.maxPoolSize = maxPoolSize;
//        }
//
//        public int getQueueCapacity() {
//            return queueCapacity;
//        }
//
//        public void setQueueCapacity(int queueCapacity) {
//            this.queueCapacity = queueCapacity;
//        }
//    }
//
//    public static class Http {
//
//        private final Cache cache = new Cache();
//        private Boolean restful = false;
//        public Cache getCache() {
//            return cache;
//        }
//
//		public Boolean getRestful() {
//			return restful;
//		}
//
//		public void setRestful(Boolean restful) {
//			this.restful = restful;
//		}
//
//
//		public static class Cache {
//
//            private int timeToLiveInDays = 1461;
//
//            public int getTimeToLiveInDays() {
//                return timeToLiveInDays;
//            }
//
//            public void setTimeToLiveInDays(int timeToLiveInDays) {
//                this.timeToLiveInDays = timeToLiveInDays;
//            }
//        }
//    }
//
//    public static class Cache {
//
//        private int timeToLiveSeconds = 3600;
//
//        private final Ehcache ehcache = new Ehcache();
//
//        public int getTimeToLiveSeconds() {
//            return timeToLiveSeconds;
//        }
//
//        public void setTimeToLiveSeconds(int timeToLiveSeconds) {
//            this.timeToLiveSeconds = timeToLiveSeconds;
//        }
//
//        public Ehcache getEhcache() {
//            return ehcache;
//        }
//
//        public static class Ehcache {
//
//            private String maxBytesLocalHeap = "16M";
//
//            public String getMaxBytesLocalHeap() {
//                return maxBytesLocalHeap;
//            }
//
//            public void setMaxBytesLocalHeap(String maxBytesLocalHeap) {
//                this.maxBytesLocalHeap = maxBytesLocalHeap;
//            }
//        }
//    }
//
//    public static class Mail {
//
//        private String from = "albedoJhipster@localhost";
//
//        public String getFrom() {
//            return from;
//        }
//
//        public void setFrom(String from) {
//            this.from = from;
//        }
//    }
//
//    public static class Security {
//
//        private final RememberMe rememberMe = new RememberMe();
//
//        public RememberMe getRememberMe() {
//            return rememberMe;
//        }
//
//        public static class RememberMe {
//
//            @NotNull
//            private String key;
//
//            public String getKey() {
//                return key;
//            }
//
//            public void setKey(String key) {
//                this.key = key;
//            }
//        }
//    }
//
//    public static class Metrics {
//
//        private final Jmx jmx = new Jmx();
//
//        private final Spark spark = new Spark();
//
//        private final Graphite graphite = new Graphite();
//
//        private final Logs logs = new Logs();
//
//        public Jmx getJmx() {
//            return jmx;
//        }
//
//        public Spark getSpark() {
//            return spark;
//        }
//
//        public Graphite getGraphite() {
//            return graphite;
//        }
//
//        public Logs getLogs() {
//            return logs;
//        }
//
//        public static class Jmx {
//
//            private boolean enabled = true;
//
//            public boolean isEnabled() {
//                return enabled;
//            }
//
//            public void setEnabled(boolean enabled) {
//                this.enabled = enabled;
//            }
//        }
//
//        public static class Spark {
//
//            private boolean enabled = false;
//
//            private String host = "localhost";
//
//            private int port = 9999;
//
//            public boolean isEnabled() {
//                return enabled;
//            }
//
//            public void setEnabled(boolean enabled) {
//                this.enabled = enabled;
//            }
//
//            public String getHost() {
//                return host;
//            }
//
//            public void setHost(String host) {
//                this.host = host;
//            }
//
//            public int getPort() {
//                return port;
//            }
//
//            public void setPort(int port) {
//                this.port = port;
//            }
//        }
//
//        public static class Graphite {
//
//            private boolean enabled = false;
//
//            private String host = "localhost";
//
//            private int port = 2003;
//
//            private String prefix = "albedoJhipster";
//
//            public boolean isEnabled() {
//                return enabled;
//            }
//
//            public void setEnabled(boolean enabled) {
//                this.enabled = enabled;
//            }
//
//            public String getHost() {
//                return host;
//            }
//
//            public void setHost(String host) {
//                this.host = host;
//            }
//
//            public int getPort() {
//                return port;
//            }
//
//            public void setPort(int port) {
//                this.port = port;
//            }
//
//            public String getPrefix() {
//                return prefix;
//            }
//
//            public void setPrefix(String prefix) {
//                this.prefix = prefix;
//            }
//        }
//
//        public static  class Logs {
//
//            private boolean enabled = false;
//
//            private long reportFrequency = 60;
//
//            public long getReportFrequency() {
//                return reportFrequency;
//            }
//
//            public void setReportFrequency(int reportFrequency) {
//                this.reportFrequency = reportFrequency;
//            }
//
//            public boolean isEnabled() {
//                return enabled;
//            }
//
//            public void setEnabled(boolean enabled) {
//                this.enabled = enabled;
//            }
//        }
//    }
//
//    private final Logging logging = new Logging();
//
//    public Logging getLogging() { return logging; }
//
//    public Boolean getDevelopMode() {
//		return developMode;
//	}
//
//	public void setDevelopMode(Boolean developMode) {
//		this.developMode = developMode;
//	}
//
//	public String getAdminPath() {
//		return adminPath;
//	}
//
//	public String getAdminPath(String strs) {
//		return PublicUtil.toAppendStr(adminPath, strs);
//	}
//
//	public String getStaticUrlPath(String strs) {
//		return PublicUtil.toAppendStr(adminPath, "/file/get", strs);
//	}
//
//	public String getStaticFileDirectory(String strs) {
//		return PublicUtil.toAppendStr(staticFileDirectory, strs);
//	}
//
//	public void setAdminPath(String adminPath) {
//		this.adminPath = adminPath;
//	}
//
//	public Boolean getIsTokenInterceptor() {
//		return isTokenInterceptor;
//	}
//
//	public void setIsTokenInterceptor(Boolean isTokenInterceptor) {
//		this.isTokenInterceptor = isTokenInterceptor;
//	}
//
//	public String getFreeURL() {
//		return freeURL;
//	}
//
//	public void setFreeURL(String freeURL) {
//		this.freeURL = freeURL;
//	}
//
//	public String getFrontPath() {
//		return frontPath;
//	}
//
//	public void setFrontPath(String frontPath) {
//		this.frontPath = frontPath;
//	}
//
//	public String getUrlSuffix() {
//		return urlSuffix;
//	}
//
//	public void setUrlSuffix(String urlSuffix) {
//		this.urlSuffix = urlSuffix;
//	}
//
//	public static class Logging {
//
//        private final Logstash logstash = new Logstash();
//
//        public Logstash getLogstash() { return logstash; }
//
//        public static class Logstash {
//
//            private boolean enabled = false;
//
//            private String host = "localhost";
//
//            private int port = 5000;
//
//            private int queueSize = 512;
//
//            public boolean isEnabled() { return enabled; }
//
//            public void setEnabled(boolean enabled) { this.enabled = enabled; }
//
//            public String getHost() { return host; }
//
//            public void setHost(String host) { this.host = host; }
//
//            public int getPort() { return port; }
//
//            public void setPort(int port) { this.port = port; }
//
//            public int getQueueSize() { return queueSize; }
//
//            public void setQueueSize(int queueSize) { this.queueSize = queueSize; }
//        }
//    }
//
//    public static class Ribbon {
//
//        private String[] displayOnActiveProfiles;
//
//        public String[] getDisplayOnActiveProfiles() {
//            return displayOnActiveProfiles;
//        }
//
//        public void setDisplayOnActiveProfiles(String[] displayOnActiveProfiles) {
//            this.displayOnActiveProfiles = displayOnActiveProfiles;
//        }
//    }
//
//	public String getApplication() {
//		return application;
//	}
//
//	public void setApplication(String application) {
//		this.application = application;
//	}
//
//	public String getJedisKeyPrefix() {
//		return jedisKeyPrefix;
//	}
//
//	public void setJedisKeyPrefix(String jedisKeyPrefix) {
//		this.jedisKeyPrefix = jedisKeyPrefix;
//	}
//
//	public Boolean getCluster() {
//		return cluster;
//	}
//
//	public void setCluster(Boolean cluster) {
//		this.cluster = cluster;
//	}
//
//	public String getStaticFileDirectory() {
//		return staticFileDirectory;
//	}
//
//	public void setStaticFileDirectory(String staticFileDirectory) {
//		this.staticFileDirectory = staticFileDirectory;
//	}
//
//	public Boolean getQuartzEnabled() {
//		return quartzEnabled;
//	}
//
//	public void setQuartzEnabled(Boolean quartzEnabled) {
//		this.quartzEnabled = quartzEnabled;
//	}
//
//	public String getDefaultView() {
//		return defaultView;
//	}
//
//	public void setDefaultView(String defaultView) {
//		this.defaultView = defaultView;
//	}
//
//	public String getRsaPublicKey() {
//		return rsaPublicKey;
//	}
//
//	public void setRsaPublicKey(String rsaPublicKey) {
//		this.rsaPublicKey = rsaPublicKey;
//	}
//
//	public String getRsaPrivateKey() {
//		return rsaPrivateKey;
//	}
//
//	public void setRsaPrivateKey(String rsaPrivateKey) {
//		this.rsaPrivateKey = rsaPrivateKey;
//	}
//
//}
