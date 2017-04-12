package com.albedo.java;

import com.albedo.java.util.base.Reflections;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Import;

import com.albedo.java.common.config.SchedulerConfiguration;

@SpringBootApplication
@Import({SchedulerConfiguration.class})
public class AlbedoJhipsterQuartz {

    public static void main(String[] args) {
        Reflections.getAnnotation()
        SpringApplication.run(AlbedoJhipsterQuartz.class, args);
    }
}
