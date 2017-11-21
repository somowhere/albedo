package com.albedo.java.modules.gateway.web;

import com.albedo.java.common.config.RouteVo;
import com.albedo.java.web.rest.ResultBuilder;
import com.codahale.metrics.annotation.Timed;
import com.netflix.servo.monitor.Monitors;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.cloud.client.discovery.DiscoveryClient;
import org.springframework.cloud.netflix.zuul.filters.Route;
import org.springframework.cloud.netflix.zuul.filters.RouteLocator;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;

/**
 * REST controller for managing Gateway configuration.
 */
@RestController
@RequestMapping("${albedo.adminPath}/gateway")
public class GatewayResource {

    private final Logger log = LoggerFactory.getLogger(GatewayResource.class);

    private final RouteLocator routeLocator;

    private final DiscoveryClient discoveryClient;

    public GatewayResource(RouteLocator routeLocator, DiscoveryClient discoveryClient) {
        this.routeLocator = routeLocator;
        this.discoveryClient = discoveryClient;
    }

    /**
     * GET  /routes : get the active routes.
     *
     * @return the ResponseEntity with status 200 (OK) and with body the list of routes
     */
    @GetMapping("/routes")
    @Timed
    public ResponseEntity<List<RouteVo>> activeRoutes() {
        List<Route> routes = routeLocator.getRoutes();
        List<RouteVo> routeVMs = new ArrayList<>();
        routes.forEach(route -> {
            RouteVo routeVM = new RouteVo();
            routeVM.setPath(route.getFullPath());
            routeVM.setServiceId(route.getId());
            routeVM.setServiceInstances(discoveryClient.getInstances(route.getLocation()));
            routeVMs.add(routeVM);
        });
        return ResultBuilder.buildOk(routeVMs);
    }
}
