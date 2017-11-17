package com.albedo.java.modules.sys.web;

import com.albedo.java.common.config.AlbedoProperties;
import com.albedo.java.util.spring.DefaultProfileUtil;
import org.springframework.core.env.Environment;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * @author somewhere
 */
@RestController
@RequestMapping("${albedo.adminPath}/api")
public class ProfileInfoResource {

    private Environment environment;

    private AlbedoProperties albedoProperties;

    public ProfileInfoResource(Environment environment, AlbedoProperties albedoProperties) {
        this.environment = environment;
        this.albedoProperties = albedoProperties;
    }

    @RequestMapping(value = "/profile-info",
            method = RequestMethod.GET,
            produces = MediaType.APPLICATION_JSON_VALUE)
    public ProfileInfoResponse getActiveProfiles() {
        return new ProfileInfoResponse(DefaultProfileUtil.getActiveProfiles(environment), getRibbonEnv());
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

    class ProfileInfoResponse {

        public String[] activeProfiles;
        public String ribbonEnv;

        ProfileInfoResponse(String[] activeProfiles, String ribbonEnv) {
            this.activeProfiles = activeProfiles;
            this.ribbonEnv = ribbonEnv;
        }
    }
}
