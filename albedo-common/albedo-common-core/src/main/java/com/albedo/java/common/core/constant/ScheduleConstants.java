package com.albedo.java.common.core.constant;

/**
 * 任务调度通用常量
 *
 * @author somewhere
 */
public interface ScheduleConstants {
	String TASK_CLASS_NAME = "TASK_CLASS_NAME";

	/**
	 * 执行目标key
	 */
	String TASK_PROPERTIES = "TASK_PROPERTIES";

	/**
	 * 默认
	 */
	String MISFIRE_DEFAULT = "0";

	/**
	 * 立即触发执行
	 */
	String MISFIRE_IGNORE_MISFIRES = "1";

	/**
	 * 触发一次执行
	 */
	String MISFIRE_FIRE_AND_PROCEED = "2";

	/**
	 * 不触发立即执行
	 */
	String MISFIRE_DO_NOTHING = "3";

	enum Status {

		/**
		 * 暂停
		 */
		PAUSE("0"),
		/**
		 * 正常
		 */
		NORMAL("1");

		private String value;

		private Status(String value) {
			this.value = value;
		}

		public String getValue() {
			return value;
		}
	}
}
