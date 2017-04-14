package com.albedo.java;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Import;

import com.albedo.java.common.config.SchedulerConfiguration;

@SpringBootApplication
@Import({SchedulerConfiguration.class})
public class AlbedoJhipsterQuartz {

    public static void main(String[] args) {
        SpringApplication.run(AlbedoJhipsterQuartz.class, args);
    }
}
