package com.albedo.java.web.rest.errors;

import com.albedo.java.util.domain.Parameter;

import java.util.Map;
/**
 * @author somewhere
 */
public class CustomParameterizedException extends RuntimeException {


    private Map<String, Object> params;

    public CustomParameterizedException(String error, String... params) {
        super(error);
        this.params = new Parameter(params);

    }

    public CustomParameterizedException(String error, Map<String, Object> params) {
        super(error);
        this.params = params;
    }

    public Map<String, Object> getParams() {
        return params;
    }

    public void setParams(Map<String, Object> params) {
        this.params = params;
    }
}
