package com.albedo.java.web.rest.vm;

public class ProfileInfoVM {

    private String[] activeProfiles;

    private String ribbonEnv;

    public ProfileInfoVM(String[] activeProfiles, String ribbonEnv) {
        this.activeProfiles = activeProfiles;
        this.ribbonEnv = ribbonEnv;
    }

    public String[] getActiveProfiles() {
        return activeProfiles;
    }

    public String getRibbonEnv() {
        return ribbonEnv;
    }
}