package com.albedo.java.thrift.rpc.example;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.SpringBootConfiguration;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.core.env.Environment;

import java.net.UnknownHostException;

//服务端启动
@SpringBootConfiguration
@ComponentScan(value = "com.albedo.java.thrift.*")
public class AlbedoThriftExampleServer {

	private static final Logger log = LoggerFactory.getLogger(AlbedoThriftExampleServer.class);

	@Autowired
	private Environment env;



	/**
	 * Main method, used to run the application.
	 *
	 * @param args the command line arguments
	 * @throws UnknownHostException if the local host name could not be resolved into an address
	 */
	public static void main(String[] args) throws Exception {
		SpringApplication app = new SpringApplication(AlbedoThriftExampleServer.class);
		final ApplicationContext applicationContext = app.run(args);
		Environment env = applicationContext.getEnvironment();
		log.info("\n----------------------------------------------------------\n\t" +
						"Application '{}' is running! ",
				env.getProperty("spring.application.name"));
	}
}
