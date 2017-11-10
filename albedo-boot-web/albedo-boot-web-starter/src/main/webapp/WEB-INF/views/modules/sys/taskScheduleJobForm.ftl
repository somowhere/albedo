<div class="portlet light bordered">
    <div class="portlet-title">
        <div class="caption font-blue">
            <i class="fa fa-globe font-blue"></i><#if taskScheduleJobVo.id??>编辑<#else>添加</#if>任务调度
        </div>
        <div class="actions">
            <div class="btn-group">
                <a id="taskScheduleJob_list" class="btn red list" href="javascript:void(0);"
                   data-table-id="#data-table-taskScheduleJob">
                    <i class="fa fa-list"> 任务调度列表</i>
                </a>
            </div>
        </div>
    </div>
    <div class="portlet-body form form-no-modal">
        <!-- BEGIN FORM-->
        <div id="bootstrap-alerts"></div>
        <form id="ajax_form" action="${ctx}/sys/taskScheduleJob/edit" method="post"
              class="form-horizontal form-validation form-bordered form-label-stripped"
              config="{rules:{
						},
                       messages:{
					   }}}">
            <div class="form-body">
                <input type="hidden" name="id" value="${(taskScheduleJobVo.id)!}"/>
                <div class="form-group">
                    <label class="control-label col-md-3">名称<span class="required">*</span></label>
                    <div class="col-md-5">
                        <input type="text" class="form-control required" id="name" name="name"
                               value="${(taskScheduleJobVo.name)!}" htmlEscape="false" maxlength="255">
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-md-3">分组<span class="required">*</span></label>
                    <div class="col-md-5">
                        <input type="text" class="form-control required" id="group" name="group"
                               value="${(taskScheduleJobVo.group)!}" htmlEscape="false" maxlength="255">
                        <label class="help-block"> 名称和分组不能同时重复</label>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-md-3">调用类名<span class="required">*</span></label>
                    <div class="col-md-5">
                        <input type="text" class="form-control " id="beanClass" name="beanClass"
                               value="${(taskScheduleJobVo.beanClass)!}" htmlEscape="false" maxlength="255">
                        <label class="help-block"> 包名+类名</label>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-md-3">spring bean<span class="required">*</span></label>
                    <div class="col-md-5">
                        <input type="text" class="form-control " id="springId" name="springId"
                               value="${(taskScheduleJobVo.springId)!}" htmlEscape="false" maxlength="255"">
                        <label class="help-block"> spring bean 和 调用类名必填一项</label>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-md-3">是否启动<span class="required">*</span></label>
                    <div class="col-md-5">
                    <@albedo.form name="jobStatus" dictCode="sys_yes_no" cssClass="required" boxType="radio" value="${(taskScheduleJobVo.jobStatus)!}" > </@albedo.form>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-md-3">cron表达式<span class="required">*</span></label>
                    <div class="col-md-5">
                        <input type="text" class="form-control required" id="cronExpression" name="cronExpression"
                               value="${(taskScheduleJobVo.cronExpression)!}" htmlEscape="false" maxlength="255">
                        <label class="help-block">每隔5秒执行一次：*/5 * * * * ?</label>

                        <label class="help-block">每隔1分钟执行一次：0 */1 * * * ?</label>

                        <label class="help-block"> 每天23点执行一次：0 0 23 * * ?</label>

                        <label class="help-block">每天凌晨1点执行一次：0 0 1 * * ?</label>

                        <label class="help-block"> 每月1号凌晨1点执行一次：0 0 1 1 * ?</label>

                        <label class="help-block">每月最后一天23点执行一次：0 0 23 L * ?</label>

                        <label class="help-block">每周星期天凌晨1点实行一次：0 0 1 ? * L</label>

                        <label class="help-block">在26分、29分、33分执行一次：0 26,29,33 * * * ?</label>

                        <label class="help-block">每天的0点、13点、18点、21点都执行一次：0 0 0,13,18,21 * * ?</label>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-md-3">是否当前任务<span class="required">*</span></label>
                    <div class="col-md-5">
                    <@albedo.form name="isConcurrent" dictCode="sys_yes_no" cssClass="required" boxType="radio" value="${(taskScheduleJobVo.isConcurrent)!}" > </@albedo.form>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-md-3">调用方法名<span class="required">*</span></label>
                    <div class="col-md-5">
                        <input type="text" class="form-control required" id="methodName" name="methodName"
                               value="${(taskScheduleJobVo.methodName)!}" htmlEscape="false" maxlength="255">
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-md-3">方法参数</label>
                    <div class="col-md-5">
                        <textarea class="form-control" name="methodParams" rows="5" maxlength="255"
                                  class="input-xxlarge ">${(taskScheduleJobVo.methodParams)! }</textarea>
                        <label class="help-block">单个 {value:'test',attrType:'String',format:''} 多个加[] json 语法</label>
                        <label class="help-block">value 参数值 attrType 参数类型 Integer Long Short Float Double Date
                            format当类型为Date 时有效</label>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-md-3">业务编号</label>
                    <div class="col-md-5">
                        <input type="text" class="form-control" id="sourceId" name="sourceId"
                               value="${(taskScheduleJobVo.sourceId)!}" htmlEscape="false" maxlength="255">
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-md-3">备注</label>
                    <div class="col-md-5">
                        <textarea class="form-control" name="description" rows="5" maxlength="255"
                                  class="input-xxlarge ">${(taskScheduleJobVo.description)! }</textarea>
                    </div>
                </div>
                <div class="form-actions">
                    <div class="row">
                        <div class="col-md-offset-3 col-md-9">
                            <button type="button" class="btn add green">
                                <i class="fa fa-check"></i> 保存
                            </button>
                            <button type="reset" class="btn default">重置</button>
                            <button type="button" class="btn list" data-table-id="#data-table-taskScheduleJob">返回
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>
