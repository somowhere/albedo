package com.albedo.java.modules.sys.web;

import com.albedo.java.common.domain.data.DynamicSpecifications;
import com.albedo.java.common.domain.data.SpecificationDetail;
import com.albedo.java.common.security.SecurityUtil;
import com.albedo.java.modules.sys.domain.TaskScheduleJob;
import com.albedo.java.modules.sys.service.ITaskScheduleJobService;
import com.albedo.java.modules.sys.service.util.JsonUtil;
import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.domain.Globals;
import com.albedo.java.util.domain.PageModel;
import com.albedo.java.util.domain.QueryCondition;
import com.albedo.java.util.exception.RuntimeMsgException;
import com.albedo.java.web.rest.ResultBuilder;
import com.albedo.java.web.rest.base.DataResource;
import com.alibaba.fastjson.JSON;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.data.domain.Page;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

/**
 * 任务调度管理Controller 任务调度
 * @author lj
 * @version 2017-01-23
 */
@ConditionalOnProperty(name = Globals.ALBEDO_QUARTZENABLED)
@Controller
@RequestMapping(value = "${albedo.adminPath}/sys/taskScheduleJob")
public class TaskScheduleJobResource extends DataResource<TaskScheduleJob> {

	@Resource
	private ITaskScheduleJobService taskScheduleJobService;
	
	@ModelAttribute
	public TaskScheduleJob get(@RequestParam(required = false) String id) throws Exception {
		String path = request.getRequestURI();
		if (path!=null && !path.contains("checkBy") && !path.contains("find") && PublicUtil.isNotEmpty(id)) {
			return taskScheduleJobService.findOne(id);
		} else {
			return new TaskScheduleJob();
		}
	}

	@RequestMapping(value = "/", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	public String list() {
		return "modules/sys/taskScheduleJobList";
	}

	/**
	 *
	 * @param pm
	 */
	@RequestMapping(value = "/page", method = RequestMethod.GET)
	public ResponseEntity getPage(PageModel<TaskScheduleJob> pm) {
		SpecificationDetail<TaskScheduleJob> spec = DynamicSpecifications.buildSpecification(pm.getQueryConditionJson(), SecurityUtil.dataScopeFilter(),
				QueryCondition.ne(TaskScheduleJob.F_STATUS, TaskScheduleJob.FLAG_DELETE));
		Page<TaskScheduleJob> page = taskScheduleJobService.findAll(spec, pm);
		pm.setPageInstance(page);
		JSON rs = JsonUtil.getInstance().setRecurrenceStr().toJsonObject(pm);
		return ResultBuilder.buildObject(rs);
	}

	/**
	 *
	 * @param taskScheduleJob
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/edit", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	public String form(TaskScheduleJob taskScheduleJob, Model model) {
		if(taskScheduleJob == null){
			throw new RuntimeMsgException(PublicUtil.toAppendStr("查询任务调度失败，原因：无法查找到编号为[", request.getParameter("id"), "]的任务调度"));
		}
		return "modules/sys/taskScheduleJobForm";
	}

	/**
	 *
	 * @param taskScheduleJob
	 * @return
	 */
	@RequestMapping(value = "/edit", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
	
	public ResponseEntity save(TaskScheduleJob taskScheduleJob) {
		log.debug("REST request to save TaskScheduleJob : {}", taskScheduleJob);
		taskScheduleJobService.save(taskScheduleJob);

		return ResultBuilder.buildOk("保存任务调度成功");
	}

	/**
	 *
	 * @param ids
	 * @return
	 */
	@RequestMapping(value = "/delete/{ids:" + Globals.LOGIN_REGEX
			+ "}", method = RequestMethod.DELETE, produces = MediaType.APPLICATION_JSON_VALUE)
	
	public ResponseEntity delete(@PathVariable String ids) {
		log.debug("REST request to delete TaskScheduleJob: {}", ids);
		taskScheduleJobService.delete(ids);
		return ResultBuilder.buildOk("删除任务调度成功");
	}

	/**
	 *
	 * @param ids
	 * @return
	 */
	@RequestMapping(value = "/lock/{ids:" + Globals.LOGIN_REGEX
			+ "}", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
	
	public ResponseEntity lockOrUnLock(@PathVariable String ids) {
		log.debug("REST request to lockOrUnLock TaskScheduleJob: {}", ids);
		taskScheduleJobService.lockOrUnLock(ids);
		return ResultBuilder.buildOk("操作任务调度成功");
	}

}