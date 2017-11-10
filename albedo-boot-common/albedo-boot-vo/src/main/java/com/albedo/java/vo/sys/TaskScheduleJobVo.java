/**
 * Copyright &copy; 2015 <a href="http://www.bs-innotech.com/">bs-innotech</a> All rights reserved.
 */
package com.albedo.java.vo.sys;

import com.albedo.java.vo.base.DataEntityVo;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import org.apache.commons.lang3.builder.EqualsBuilder;
import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;

/**
 * 任务调度EntityVo 任务调度
 *
 * @author admin
 * @version 2017-11-10
 */
@Data
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class TaskScheduleJobVo extends DataEntityVo {

    /**
     * F_NAME name_  :  名称
     */
    public static final String F_NAME = "name";
    /**
     * F_GROUP group_  :  分组
     */
    public static final String F_GROUP = "group";
    /**
     * F_JOBSTATUS job_status  :  任务状态
     */
    public static final String F_JOBSTATUS = "jobStatus";
    /**
     * F_CRONEXPRESSION cron_expression  :  cron表达式
     */
    public static final String F_CRONEXPRESSION = "cronExpression";
    /**
     * F_BEANCLASS bean_class  :  类名
     */
    public static final String F_BEANCLASS = "beanClass";
    /**
     * F_ISCONCURRENT is_concurrent  :  任务是否有状态
     */
    public static final String F_ISCONCURRENT = "isConcurrent";
    /**
     * F_SPRINGID spring_id  :  springBean
     */
    public static final String F_SPRINGID = "springId";
    /**
     * F_SOURCEID source_id  :  业务编号
     */
    public static final String F_SOURCEID = "sourceId";
    /**
     * F_METHODNAME method_name  :  任务调用的方法名
     */
    public static final String F_METHODNAME = "methodName";
    /**
     * F_METHODPARAMS method_params  :  方法参数
     */
    public static final String F_METHODPARAMS = "methodParams";
    private static final long serialVersionUID = 1L;

    //columns START
    /**
     * name 名称
     */
    @Length(max = 255)
    private String name;
    /**
     * group 分组
     */
    @Length(max = 255)
    private String group;
    /**
     * jobStatus 任务状态
     */
    @Length(max = 255)
    private String jobStatus;
    /**
     * cronExpression cron表达式
     */
    @NotBlank
    @Length(max = 255)
    private String cronExpression;
    /**
     * beanClass 类名
     */
    @Length(max = 255)
    private String beanClass;
    /**
     * isConcurrent 任务是否有状态
     */
    private Integer isConcurrent;
    /**
     * springId springBean
     */
    @Length(max = 255)
    private String springId;
    /**
     * sourceId 业务编号
     */
    @Length(max = 32)
    private String sourceId;
    /**
     * methodName 任务调用的方法名
     */
    @NotBlank
    @Length(max = 255)
    private String methodName;
    /**
     * methodParams 方法参数
     */
    @Length(max = 512)
    private String methodParams;
    //columns END


    @Override
    public boolean equals(Object obj) {
        if (obj instanceof TaskScheduleJobVo == false) {
            return false;
        }
        if (this == obj) {
            return true;
        }
        TaskScheduleJobVo other = (TaskScheduleJobVo) obj;
        return new EqualsBuilder()
                .append(getId(), other.getId())
                .isEquals();
    }
}
