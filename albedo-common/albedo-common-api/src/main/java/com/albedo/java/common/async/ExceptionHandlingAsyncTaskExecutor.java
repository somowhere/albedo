package com.albedo.java.common.async;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.DisposableBean;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.core.task.AsyncTaskExecutor;

import java.util.concurrent.Callable;
import java.util.concurrent.Future;

public class ExceptionHandlingAsyncTaskExecutor implements AsyncTaskExecutor, InitializingBean, DisposableBean {
	static final String EXCEPTION_MESSAGE = "Caught async exception";
	private final Logger log = LoggerFactory.getLogger(ExceptionHandlingAsyncTaskExecutor.class);
	private final AsyncTaskExecutor executor;

	public ExceptionHandlingAsyncTaskExecutor(AsyncTaskExecutor executor) {
		this.executor = executor;
	}

	public void execute(Runnable task) {
		this.executor.execute(this.createWrappedRunnable(task));
	}

	public void execute(Runnable task, long startTimeout) {
		this.executor.execute(this.createWrappedRunnable(task), startTimeout);
	}

	private <T> Callable<T> createCallable(Callable<T> task) {
		return () -> {
			try {
				return task.call();
			} catch (Exception var3) {
				this.handle(var3);
				throw var3;
			}
		};
	}

	private Runnable createWrappedRunnable(Runnable task) {
		return () -> {
			try {
				task.run();
			} catch (Exception var3) {
				this.handle(var3);
			}

		};
	}

	protected void handle(Exception e) {
		this.log.error("Caught async exception", e);
	}

	public Future<?> submit(Runnable task) {
		return this.executor.submit(this.createWrappedRunnable(task));
	}

	public <T> Future<T> submit(Callable<T> task) {
		return this.executor.submit(this.createCallable(task));
	}

	public void destroy() throws Exception {
		if (this.executor instanceof DisposableBean) {
			DisposableBean bean = (DisposableBean)this.executor;
			bean.destroy();
		}

	}

	public void afterPropertiesSet() throws Exception {
		if (this.executor instanceof InitializingBean) {
			InitializingBean bean = (InitializingBean)this.executor;
			bean.afterPropertiesSet();
		}

	}
}
