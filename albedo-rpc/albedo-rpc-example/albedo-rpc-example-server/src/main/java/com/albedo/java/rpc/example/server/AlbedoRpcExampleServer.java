package com.albedo.java.rpc.example.server;

import com.albedo.java.util.domain.Globals;
import com.albedo.java.util.spring.DefaultProfileUtil;
import com.albedo.java.util.spring.SpringContextHolder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.core.env.Environment;

import javax.annotation.PostConstruct;
import java.net.UnknownHostException;
import java.util.Arrays;
import java.util.Collection;

/**
 * Created by lijie on 2017/3/21.
 */
@ComponentScan(basePackages = {"com.albedo.java.*"})
public class AlbedoRpcExampleServer {


    private static final Logger log = LoggerFactory.getLogger(AlbedoRpcExampleServer.class);

    @Autowired
    private Environment env;

    /**
     * Initializes hcxd-mpns-server.
     * <p>
     * Spring profiles can be configured with a program arguments --spring.profiles.active=your-active-profile
     * <p>
     * You can find more information on how profiles work with JHipster on <a href="http://albedo.github.io/profiles/">http://albedo.github.io/profiles/</a>.
     */
    @PostConstruct
    public void initApplication() {
        log.info("Running with Spring profile(s) : {}", Arrays.toString(env.getActiveProfiles()));
        Collection<String> activeProfiles = Arrays.asList(env.getActiveProfiles());
        if (activeProfiles.contains(Globals.SPRING_PROFILE_DEVELOPMENT) && activeProfiles.contains(Globals.SPRING_PROFILE_PRODUCTION)) {
            log.error("You have misconfigured your application! It should not run " +
                    "with both the 'dev' and 'prod' profiles at the same time.");
        }
        if (activeProfiles.contains(Globals.SPRING_PROFILE_DEVELOPMENT) && activeProfiles.contains(Globals.SPRING_PROFILE_CLOUD)) {
            log.error("You have misconfigured your application! It should not" +
                    "run with both the 'dev' and 'cloud' profiles at the same time.");
        }
    }

    /**
     * Main method, used to run the application.
     *
     * @param args the command line arguments
     * @throws UnknownHostException if the local host name could not be resolved into an address
     */
    public static void main(String[] args) throws Exception {
//        ConfigurableApplicationContext context = new SpringApplicationBuilder(AlbedoRpcExampleServer.class)
//                .registerShutdownHook(true)
//                .logStartupInfo(true)
//                .bannerMode(Banner.Mode.CONSOLE)
//                .run(args);
        SpringApplication app = new SpringApplication(AlbedoRpcExampleServer.class);
        DefaultProfileUtil.addDefaultProfile(app);
        final ApplicationContext applicationContext = app.run(args);
        SpringContextHolder.setStaticApplicationContext(applicationContext);
        Environment env = applicationContext.getEnvironment();
        log.info("\n----------------------------------------------------------\n\t" +
                        "Application '{}' is running! ",
                env.getProperty("spring.application.name"));
    }

}
