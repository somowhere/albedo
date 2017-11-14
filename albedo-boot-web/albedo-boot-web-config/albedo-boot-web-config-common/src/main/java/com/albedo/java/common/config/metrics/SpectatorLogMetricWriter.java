package com.albedo.java.common.config.metrics;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.actuate.metrics.Metric;
import org.springframework.boot.actuate.metrics.writer.Delta;
import org.springframework.boot.actuate.metrics.writer.MetricWriter;

public class SpectatorLogMetricWriter implements MetricWriter {
    private final Logger log = LoggerFactory.getLogger("metrics");

    public SpectatorLogMetricWriter() {
    }

    public void set(Metric<?> metric) {
        String metricContent = metric.getName();
        String[] metricSplit = metricContent.split("\\.");
        String hystrixType = "";
        String serviceName = "";
        String methodName = "";
        String metricName = metricContent;
        if (metricSplit[2].equals("RibbonCommand")) {
            hystrixType = "hystrix.HystrixCommand.RibbonCommand";
            serviceName = metricSplit[3];
            metricName = metricContent.substring(37);
        } else {
            if (metricSplit[1].equals("HystrixCommand")) {
                hystrixType = "hystrix.HystrixCommand";
                serviceName = metricSplit[2];
                methodName = metricSplit[3];
                metricName = metricContent.substring(23);
            }

            if (metricSplit[1].equals("HystrixThreadPool")) {
                hystrixType = "hystrix.HystrixThreadPool";
                serviceName = metricSplit[2];
                methodName = metricSplit[3];
                metricName = metricContent.substring(26);
            }
        }

        this.log.info("type=GAUGE, hystrix_type={}, service={}, method={}, name={}, value={}", new Object[]{hystrixType, serviceName, methodName, metricName, metric.getValue()});
    }

    public void increment(Delta<?> metric) {
        this.log.info("type=COUNTER, name={}, count={}", metric.getName(), metric.getValue());
    }

    public void reset(String metricName) {
    }
}
