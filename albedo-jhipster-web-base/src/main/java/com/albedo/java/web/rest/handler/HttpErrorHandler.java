package com.albedo.java.web.rest.handler;

import org.springframework.boot.autoconfigure.web.ErrorController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Created by lijie on 2017/3/2.
 */
@Controller
public class HttpErrorHandler implements ErrorController {

    private final static String ERROR_PATH = "/error";

    /**
     * Supports the HTML Error View
     *
     * @return
     */
    @RequestMapping(value = ERROR_PATH, produces = "text/html")
    public String errorHtml() {
        return "tip/404";
    }

    /**
     * Supports other formats like JSON, XML
     *
     * @return
     */
    @RequestMapping(value = ERROR_PATH)
    @ResponseBody
    public Object error() {
        return "tip/404";
    }

    /**
     * Returns the path of the error page.
     *
     * @return the error path
     */
    @Override
    public String getErrorPath() {
        return ERROR_PATH;
    }
}
