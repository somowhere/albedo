/**
 * Copyright &copy; 2015 <a href="http://www.bs-innotech.com/">bs-innotech</a> All rights reserved.
 */
package com.albedo.java.modules.sys.domain;

import com.albedo.java.common.domain.base.IdEntity;
import com.albedo.java.util.annotation.DictType;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import org.apache.commons.lang3.StringEscapeUtils;
import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;
import org.springframework.data.mybatis.annotations.Column;
import org.springframework.data.mybatis.annotations.Entity;

/**
 * 任务调度管理Entity 任务调度
 *
 * @author lj
 * @version 2017-01-23
 */

@Entity(table = "sys_task_schedule_job_t")
@Data
@AllArgsConstructor
@ToString
@NoArgsConstructor
public class TaskScheduleJob extends IdEntity {

    /**
     * F_NAME name_ : 名称
     */
    public static final String F_NAME = "name";
    /**
     * F_GROUP group_ : 分组
     */
    public static final String F_GROUP = "group";
    /**
     * F_STARTSTATUS start_status : 是否启动
     */
    public static final String F_JOBSTATUS = "jobStatus";
    /**
     * F_CRONEXPRESSION cron_expression : cron表达式
     */
    public static final String F_CRONEXPRESSION = "cronExpression";
    /**
     * F_BEANCLASS bean_class : 调用类名
     */
    public static final String F_BEANCLASS = "beanClass";
    /**
     * F_ISCONCURRENT is_concurrent : 是否当前任务
     */
    public static final String F_ISCONCURRENT = "isConcurrent";
    /**
     * F_SPRINGID spring_id : spring bean
     */
    public static final String F_SPRINGID = "springId";
    /**
     * F_SOURCEID sourceId : 业务编号
     */
    public static final String F_SOURCEID = "sourceId";
    /**
     * F_METHODNAME method_name : 调用方法名
     */
    public static final String F_METHODNAME = "methodName";
    /**
     * F_METHODPARAMS method_params : 调用方法参数 json
     */
    public static final String F_METHODPARAMS = "methodParams";
    private static final long serialVersionUID = 1L;
    // columns START
    /**
     * name 名称
     */
    @Length(max = 255)
    @Column(name = "name_")
    private String name;
    /**
     * group 分组
     */
    @Length(max = 255)
    @Column(name = "group_")
    private String group;
    /**
     * jobStatus 任务状态
     */
    @Column(name = "job_status")
    @DictType(name = "sys_yes_no")
    private String jobStatus;
    /**
     * cronExpression cron表达式
     */
    @NotBlank
    @Length(max = 255)
    @Column(name = "cron_expression")
    private String cronExpression;
    /**
     * beanClass 调用类名
     */
    @Length(max = 255)
    @Column(name = "bean_class")
    private String beanClass;
    /**
     * isConcurrent 是否当前任务
     */
    @Column(name = "is_concurrent")
    @DictType(name = "sys_yes_no")
    private Integer isConcurrent;
    /**
     * springId spring bean
     */
    @Length(max = 255)
    @Column(name = "spring_id")
    private String springId;
    /**
     * sourceId 业务编号
     */
    @Length(max = 32)
    @Column(name = "source_id")
    private String sourceId;
    /**
     * methodName 调用方法名
     */
    @NotBlank
    @Length(max = 255)
    @Column(name = "method_name")
    private String methodName;
    @Column(name = "method_params")
    private String methodParams;

    // columns END
    public TaskScheduleJob(String id) {
        this.id = id;
    }

    /**
     * id id_
     */
    public String getId() {
        return this.id;
    }

    /**
     * id id_
     */
    public void setId(String value) {
        this.id = value;
    }

    /**
     * name 名称
     */
    public String getName() {
        return this.name;
    }

    /**
     * name 名称
     */
    public void setName(String value) {
        this.name = value;
    }

    /**
     * group 分组
     */
    public String getGroup() {
        return this.group;
    }

    /**
     * group 分组
     */
    public void setGroup(String value) {
        this.group = value;
    }

    /**
     * cronExpression cron表达式
     */
    public String getCronExpression() {
        return this.cronExpression;
    }

    /**
     * cronExpression cron表达式
     */
    public void setCronExpression(String value) {
        this.cronExpression = value;
    }

    /**
     * beanClass 调用类名
     */
    public String getBeanClass() {
        return this.beanClass;
    }

    /**
     * beanClass 调用类名
     */
    public void setBeanClass(String value) {
        this.beanClass = value;
    }

    /**
     * isConcurrent 是否当前任务
     */
    public Integer getIsConcurrent() {
        return this.isConcurrent;
    }

    /**
     * isConcurrent 是否当前任务
     */
    public void setIsConcurrent(Integer value) {
        this.isConcurrent = value;
    }

    public String getJobStatus() {
        return jobStatus;
    }

    public void setJobStatus(String jobStatus) {
        this.jobStatus = jobStatus;
    }

    /**
     * springId spring bean
     */
    public String getSpringId() {
        return this.springId;
    }

    /**
     * springId spring bean
     */
    public void setSpringId(String value) {
        this.springId = value;
    }

    /**
     * methodName 调用方法名
     */
    public String getMethodName() {
        return this.methodName;
    }

    /**
     * methodName 调用方法名
     */
    public void setMethodName(String value) {
        this.methodName = value;
    }

    public String getSourceId() {
        return sourceId;
    }

    public void setSourceId(String sourceId) {
        this.sourceId = sourceId;
    }


    public String getMethodParams() {
        return methodParams;
    }

    public void setMethodParams(String methodParams) {
        this.methodParams = StringEscapeUtils.escapeHtml4(methodParams);
    }
}
