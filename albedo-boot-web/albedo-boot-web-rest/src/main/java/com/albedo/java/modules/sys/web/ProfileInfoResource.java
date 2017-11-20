package com.albedo.java.modules.sys.web;

import com.albedo.java.common.config.AlbedoProperties;
import com.albedo.java.util.spring.DefaultProfileUtil;
import com.albedo.java.web.rest.vm.ProfileInfoVM;
import org.springframework.core.env.Environment;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * @author somewhere
 */
@RestController
@RequestMapping("${albedo.adminPath}")
public class ProfileInfoResource {

    private Environment environment;

    private AlbedoProperties albedoProperties;

    public ProfileInfoResource(Environment environment, AlbedoProperties albedoProperties) {
        this.environment = environment;
        this.albedoProperties = albedoProperties;
    }

    @GetMapping(value = "/profile-info",
            produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    public ProfileInfoVM getActiveProfiles() {
        return new ProfileInfoVM(DefaultProfileUtil.getActiveProfiles(environment), getRibbonEnv());
    }

    private String getRibbonEnv() {
        String[] activeProfiles = DefaultProfileUtil.getActiveProfiles(environment);
        String[] displayOnActiveProfiles = albedoProperties.getRibbon().getDisplayOnActiveProfiles();

        if (displayOnActiveProfiles == null) {
            return null;
        }

        List<String> ribbonProfiles = new ArrayList<>(Arrays.asList(displayOnActiveProfiles));
        List<String> springBootProfiles = Arrays.asList(activeProfiles);
        ribbonProfiles.retainAll(springBootProfiles);

        if (ribbonProfiles.size() > 0) {
            return ribbonProfiles.get(0);
        }
        return null;
    }


}
