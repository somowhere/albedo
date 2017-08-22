package com.albedo.java.modules.sys.web;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.servlet.mvc.method.annotation.AbstractJsonpResponseBodyAdvice;

/**
 * Created by bin on 2017/3/10.
 */
@ControllerAdvice(basePackages = {"com.albedo.java.modules.sys.web"})
public class JSONPConfig extends AbstractJsonpResponseBodyAdvice {

    public JSONPConfig() {
        super("callback", "jsop");
    }
}
