package com.albedo.java.grpc.client;

import com.google.common.base.Preconditions;
import com.google.common.collect.Lists;
import com.netflix.appinfo.InstanceInfo;
import com.netflix.discovery.DiscoveryClient;
import io.grpc.*;
import io.grpc.internal.LogExceptionRunnable;
import io.grpc.internal.SharedResourceHolder;
import lombok.extern.slf4j.Slf4j;

import javax.annotation.concurrent.GuardedBy;
import java.net.InetSocketAddress;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.ScheduledFuture;
import java.util.concurrent.TimeUnit;

/**
 * User: Michael
 * Email: yidongnan@gmail.com
 * Date: 5/17/16
 */
@Slf4j
public class DiscoveryClientNameResolver extends NameResolver {
    private final String name;
    private final DiscoveryClient client;
    private final Attributes attributes;
    private final SharedResourceHolder.Resource<ScheduledExecutorService> timerServiceResource;
    private final SharedResourceHolder.Resource<ExecutorService> executorResource;
    @GuardedBy("this")
    private boolean shutdown;
    @GuardedBy("this")
    private ScheduledExecutorService timerService;
    @GuardedBy("this")
    private ExecutorService executor;
    @GuardedBy("this")
    private ScheduledFuture<?> resolutionTask;
    @GuardedBy("this")
    private boolean resolving;
    @GuardedBy("this")
    private Listener listener;
    @GuardedBy("this")
    private List<InstanceInfo> serviceInstanceList;

    public DiscoveryClientNameResolver(String name, DiscoveryClient client, Attributes attributes, SharedResourceHolder.Resource<ScheduledExecutorService> timerServiceResource,
                                       SharedResourceHolder.Resource<ExecutorService> executorResource) {
        this.name = name;
        this.client = client;
        this.attributes = attributes;
        this.timerServiceResource = timerServiceResource;
        this.executorResource = executorResource;
        this.serviceInstanceList = Lists.newArrayList();
    }

    @Override
    public final String getServiceAuthority() {
        return name;
    }

    @Override
    public final synchronized void start(Listener listener) {
        Preconditions.checkState(this.listener == null, "already started");
        timerService = SharedResourceHolder.get(timerServiceResource);
        this.listener = listener;
        executor = SharedResourceHolder.get(executorResource);
        this.listener = Preconditions.checkNotNull(listener, "listener");
        resolve();
        timerService.scheduleWithFixedDelay(new LogExceptionRunnable(resolutionRunnableOnExecutor), 1, 1, TimeUnit.MINUTES);
    }

    @Override
    public final synchronized void refresh() {
        Preconditions.checkState(listener != null, "not started");
        resolve();
    }

    private final Runnable resolutionRunnable = new Runnable() {
        @Override
        public void run() {
            Listener savedListener;
            synchronized (DiscoveryClientNameResolver.this) {
                // If this task is started by refresh(), there might already be a scheduled task.
                if (resolutionTask != null) {
                    resolutionTask.cancel(false);
                    resolutionTask = null;
                }
                if (shutdown) {
                    return;
                }
                savedListener = listener;
                resolving = true;
            }
            try {
                List<InstanceInfo> newServiceInstanceList;
                try {
                    newServiceInstanceList = client.getInstancesByVipAddress(name, false);
                } catch (Exception e) {
                    savedListener.onError(Status.UNAVAILABLE.withCause(e));
                    return;
                }

                if (newServiceInstanceList!=null && newServiceInstanceList.size()>0) {
                    if (isNeedToUpdateServiceInstanceList(newServiceInstanceList)) {
                        serviceInstanceList = newServiceInstanceList;
                    } else {
                        return;
                    }
                    List<ResolvedServerInfoGroup> resolvedServerInfoGroupList = Lists.newArrayList();
                    for (InstanceInfo serviceInstance : serviceInstanceList) {
                        ResolvedServerInfoGroup.Builder servers = ResolvedServerInfoGroup.builder();
                        Map<String, String> metadata = serviceInstance.getMetadata();
                        if (metadata.get("gRPC") != null) {
                            Integer port = Integer.valueOf(metadata.get("gRPC"));
                            log.info("Found gRPC server {} {}:{}", name, serviceInstance.getHostName(), port);
                            ResolvedServerInfo resolvedServerInfo = new ResolvedServerInfo(new InetSocketAddress(serviceInstance.getHostName(), port), Attributes.EMPTY);
                            resolvedServerInfoGroupList.add(servers.add(resolvedServerInfo).build());
                        } else {
                            log.error("Can not found gRPC server {}", name);
                        }
                    }
                    savedListener.onUpdate(resolvedServerInfoGroupList, Attributes.EMPTY);
                } else {
                    savedListener.onError(Status.UNAVAILABLE.withCause(new RuntimeException("UNAVAILABLE: NameResolver returned an empty list")));
                }
            } finally {
                synchronized (DiscoveryClientNameResolver.this) {
                    resolving = false;
                }
            }
        }
    };

    private boolean isNeedToUpdateServiceInstanceList(List<InstanceInfo> newServiceInstanceList) {
        if (serviceInstanceList.size() == newServiceInstanceList.size()) {
            for (InstanceInfo serviceInstance : serviceInstanceList) {
                boolean isSame = false;
                for (InstanceInfo newServiceInstance : newServiceInstanceList) {
                    if (newServiceInstance.getHostName().equals(serviceInstance.getHostName()) && newServiceInstance.getPort() == serviceInstance.getPort()) {
                        isSame = true;
                        break;
                    }
                }
                if (!isSame) {
                    log.info("Ready to update {} server info group list", name);
                    return true;
                }
            }
        } else {
            log.info("Ready to update {} server info group list", name);
            return true;
        }
        return false;
    }

    private final Runnable resolutionRunnableOnExecutor = new Runnable() {
        @Override
        public void run() {
            synchronized (DiscoveryClientNameResolver.this) {
                if (!shutdown) {
                    executor.execute(resolutionRunnable);
                }
            }
        }
    };

    @GuardedBy("this")
    private void resolve() {
        if (resolving || shutdown) {
            return;
        }
        executor.execute(resolutionRunnable);
    }

    @Override
    public void shutdown() {
        if (shutdown) {
            return;
        }
        shutdown = true;
        if (resolutionTask != null) {
            resolutionTask.cancel(false);
        }
        if (timerService != null) {
            timerService = SharedResourceHolder.release(timerServiceResource, timerService);
        }
        if (executor != null) {
            executor = SharedResourceHolder.release(executorResource, executor);
        }
    }
}
