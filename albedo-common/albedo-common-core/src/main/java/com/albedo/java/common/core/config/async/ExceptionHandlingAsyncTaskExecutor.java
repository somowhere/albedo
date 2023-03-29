/*
 *  Copyright (c) 2019-2023  <a href="https://github.com/somowhere/albedo">Albedo</a>, somewhere (somewhere0813@gmail.com).
 *  <p>
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *  <p>
 * https://www.gnu.org/licenses/lgpl.html
 *  <p>
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.albedo.java.common.core.config.async;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.DisposableBean;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.core.task.AsyncTaskExecutor;

import java.util.concurrent.Callable;
import java.util.concurrent.Future;

/**
 * @author somewhere
 * @description
 * @date 2020/5/31 17:08
 */
public class ExceptionHandlingAsyncTaskExecutor implements AsyncTaskExecutor, InitializingBean, DisposableBean {

	static final String EXCEPTION_MESSAGE = "Caught async exception";

	private final Logger log = LoggerFactory.getLogger(ExceptionHandlingAsyncTaskExecutor.class);

	private final AsyncTaskExecutor executor;

	public ExceptionHandlingAsyncTaskExecutor(AsyncTaskExecutor executor) {
		this.executor = executor;
	}

	@Override
	public void execute(Runnable task) {
		this.executor.execute(this.createWrappedRunnable(task));
	}

	@Override
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

	@Override
	public Future<?> submit(Runnable task) {
		return this.executor.submit(this.createWrappedRunnable(task));
	}

	@Override
	public <T> Future<T> submit(Callable<T> task) {
		return this.executor.submit(this.createCallable(task));
	}

	@Override
	public void destroy() throws Exception {
		if (this.executor instanceof DisposableBean) {
			DisposableBean bean = (DisposableBean) this.executor;
			bean.destroy();
		}

	}

	@Override
	public void afterPropertiesSet() throws Exception {
		if (this.executor instanceof InitializingBean) {
			InitializingBean bean = (InitializingBean) this.executor;
			bean.afterPropertiesSet();
		}

	}

}
