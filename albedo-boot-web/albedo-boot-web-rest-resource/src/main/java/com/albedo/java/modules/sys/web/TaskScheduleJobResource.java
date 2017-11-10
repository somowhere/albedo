package com.albedo.java.modules.sys.web;

import com.albedo.java.common.security.SecurityUtil;
import com.albedo.java.modules.sys.domain.TaskScheduleJob;
import com.albedo.java.modules.sys.service.impl.TaskScheduleJobExcutorService;
import com.albedo.java.util.JsonUtil;
import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.StringUtil;
import com.albedo.java.util.domain.Globals;
import com.albedo.java.util.domain.PageModel;
import com.albedo.java.util.exception.RuntimeMsgException;
import com.albedo.java.vo.sys.TaskScheduleJobVo;
import com.albedo.java.web.rest.ResultBuilder;
import com.albedo.java.web.rest.base.DataResource;
import com.albedo.java.web.rest.base.DataVoResource;
import com.alibaba.fastjson.JSON;
import com.google.common.collect.Lists;
import org.jboss.logging.annotations.Pos;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

/**
 * 任务调度管理Controller 任务调度
 *
 * @author lj
 * @version 2017-01-23
 */
@ConditionalOnProperty(name = Globals.ALBEDO_QUARTZENABLED)
@Controller
@RequestMapping(value = "${albedo.adminPath}/sys/taskScheduleJob")
public class TaskScheduleJobResource extends DataVoResource<TaskScheduleJobExcutorService, TaskScheduleJobVo> {


    @GetMapping(value = "/")
    public String list() {
        return "modules/sys/taskScheduleJobList";
    }

    /**
     * @param pm
     */
    @GetMapping(value = "/page")
    public ResponseEntity getPage(PageModel<TaskScheduleJob> pm) {
        pm = service.findAll(pm, SecurityUtil.dataScopeFilter());
        JSON rs = JsonUtil.getInstance().setRecurrenceStr().toJsonObject(pm);
        return ResultBuilder.buildObject(rs);
    }

    /**
     * @param taskScheduleJob
     * @param model
     * @return
     */
    @GetMapping(value = "/edit", produces = MediaType.APPLICATION_JSON_VALUE)
    public String form(TaskScheduleJob taskScheduleJob, Model model) {
        if (taskScheduleJob == null) {
            throw new RuntimeMsgException(PublicUtil.toAppendStr("查询任务调度失败，原因：无法查找到编号为[", request.getParameter("id"), "]的任务调度"));
        }
        return "modules/sys/taskScheduleJobForm";
    }

    /**
     * @param taskScheduleJob
     * @return
     */
    @PostMapping( value = "/edit",  produces = MediaType.APPLICATION_JSON_VALUE)

    public ResponseEntity save(TaskScheduleJob taskScheduleJob) {
        log.debug("REST request to save TaskScheduleJob : {}", taskScheduleJob);
        service.save(taskScheduleJob);

        return ResultBuilder.buildOk("保存任务调度成功");
    }

    /**
     * @param ids
     * @return
     */
    @PostMapping(value = "/delete/{ids:" + Globals.LOGIN_REGEX
            + "}")

    public ResponseEntity delete(@PathVariable String ids) {
        log.debug("REST request to delete TaskScheduleJob: {}", ids);
        service.delete(Lists.newArrayList(ids.split(StringUtil.SPLIT_DEFAULT)));
        return ResultBuilder.buildOk("删除任务调度成功");
    }

    /**
     * @param ids
     * @return
     */
    @PostMapping(value = "/lock/{ids:" + Globals.LOGIN_REGEX
            + "}")

    public ResponseEntity lockOrUnLock(@PathVariable String ids) {
        log.debug("REST request to lockOrUnLock TaskScheduleJob: {}", ids);
        service.lockOrUnLock(Lists.newArrayList(ids.split(StringUtil.SPLIT_DEFAULT)));
        return ResultBuilder.buildOk("操作任务调度成功");
    }

}