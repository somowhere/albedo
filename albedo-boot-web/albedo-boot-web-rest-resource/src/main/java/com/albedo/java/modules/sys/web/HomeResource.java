package com.albedo.java.modules.sys.web;

import com.albedo.java.web.rest.base.BaseResource;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

/**
 * REST controller for managing the current user's account.
 *
 * @author somewhere
 */
@RestController
public class HomeResource extends BaseResource {

    @PostMapping("/home")
    public Object home() {
        Map map = new HashMap();
        map.put("key", 123);
        map.put("value", "pillar");
        return map;
    }

}
