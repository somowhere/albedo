//package com.albedo.java.common.config.metrics;
//
//import com.albedo.java.common.config.AlbedoProperties;
//import com.codahale.metrics.MetricRegistry;
//import com.codahale.metrics.graphite.Graphite;
//import com.codahale.metrics.graphite.GraphiteReporter;
//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
//import org.springframework.boot.autoconfigure.condition.ConditionalOnClass;
//import org.springframework.context.annotation.Configuration;
//
//import java.net.InetSocketAddress;
//import java.util.concurrent.TimeUnit;
//
//@Configuration
//@ConditionalOnClass({Graphite.class})
//public class GraphiteRegistry {
//    private final Logger log = LoggerFactory.getLogger(GraphiteRegistry.class);
//    private final AlbedoProperties albedoProperties;
//
//    public GraphiteRegistry(MetricRegistry metricRegistry, AlbedoProperties albedoProperties) {
//        this.albedoProperties = albedoProperties;
//        if (this.albedoProperties.getMetrics().getGraphite().isEnabled()) {
//            this.log.info("Initializing Metrics Graphite reporting");
//            String graphiteHost = albedoProperties.getMetrics().getGraphite().getHost();
//            Integer graphitePort = albedoProperties.getMetrics().getGraphite().getPort();
//            String graphitePrefix = albedoProperties.getMetrics().getGraphite().getPrefix();
//            Graphite graphite = new Graphite(new InetSocketAddress(graphiteHost, graphitePort.intValue()));
//            GraphiteReporter graphiteReporter = GraphiteReporter.forRegistry(metricRegistry).convertRatesTo(TimeUnit.SECONDS).convertDurationsTo(TimeUnit.MILLISECONDS).prefixedWith(graphitePrefix).build(graphite);
//            graphiteReporter.start(1L, TimeUnit.MINUTES);
//        }
//
//    }
//}
//
