/**
 * Copyright &copy; 2015 <a href="http://www.bs-innotech.com/">bs-innotech</a> All rights reserved.
 */
package com.albedo.java.modules.sys.domain;

import com.albedo.java.util.annotation.DictType;
import com.albedo.java.util.annotation.SearchField;
import org.apache.commons.lang3.builder.EqualsBuilder;
import org.apache.commons.lang3.builder.HashCodeBuilder;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;
import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;

import javax.persistence.*;
import javax.validation.constraints.NotNull;

/**
 * 操作日志Entity 操作日志
 *
 * @author admin
 * @version 2017-01-03
 */
@Entity
@Table(name = "logging_event")
@DynamicInsert
@DynamicUpdate
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
public class LoggingEvent {

    /**
     * F_TIMESTMP timestmp : 创建时间
     */
    public static final String F_TIMESTMP = "timestmp";
    /**
     * F_FORMATTEDMESSAGE formatted_message : 内容
     */
    public static final String F_FORMATTEDMESSAGE = "formattedMessage";
    /**
     * F_LOGGERNAME logger_name : 名称
     */
    public static final String F_LOGGERNAME = "loggerName";
    /**
     * F_LEVELSTRING level_string : 级别
     */
    public static final String F_LEVELSTRING = "levelString";
    /**
     * F_THREADNAME thread_name : 线程
     */
    public static final String F_THREADNAME = "threadName";
    /**
     * F_REFERENCEFLAG reference_flag : 引用标识
     */
    public static final String F_REFERENCEFLAG = "referenceFlag";
    /**
     * F_ARG0 arg0 : 参数0
     */
    public static final String F_ARG0 = "arg0";
    /**
     * F_ARG1 arg1 : 参数1
     */
    public static final String F_ARG1 = "arg1";
    /**
     * F_ARG2 arg2 : 参数2
     */
    public static final String F_ARG2 = "arg2";
    /**
     * F_ARG3 arg3 : 参数3
     */
    public static final String F_ARG3 = "arg3";
    /**
     * F_CALLERFILENAME caller_filename : 操作文件
     */
    public static final String F_CALLERFILENAME = "callerFilename";
    /**
     * F_CALLERCLASS caller_class : 操作类名
     */
    public static final String F_CALLERCLASS = "callerClass";
    /**
     * F_CALLERMETHOD caller_method : 操作方法
     */
    public static final String F_CALLERMETHOD = "callerMethod";
    /**
     * F_CALLERLINE caller_line : 操作行
     */
    public static final String F_CALLERLINE = "callerLine";
    private static final long serialVersionUID = 1L;
    // columns START
    @Id
    @Column(name = "event_id")
    @SearchField
    private Long id;
    /**
     * timestmp 创建时间
     */
    @NotNull
    @Column(name = "timestmp", unique = false, nullable = false)
    private Long timestmp;
    /**
     * formattedMessage 内容
     */
    @NotBlank
    @Length(max = 65535)
    @Column(name = "formatted_message", unique = false, nullable = false, length = 65535)
    private String formattedMessage;
    /**
     * loggerName 名称
     */
    @NotBlank
    @Length(max = 254)
    @Column(name = "logger_name", unique = false, nullable = false, length = 254)
    private String loggerName;
    /**
     * levelString 级别
     */
    @NotBlank
    @Length(max = 254)
    @Column(name = "level_string", unique = false, nullable = false, length = 254)
    @DictType(name = "sys_log_level")
    private String levelString;
    /**
     * threadName 线程
     */
    @Length(max = 254)
    @Column(name = "thread_name", unique = false, nullable = true, length = 254)
    private String threadName;
    /**
     * referenceFlag 引用标识
     */
    @Length(max = 6)
    @Column(name = "reference_flag", unique = false, nullable = true, length = 6)
    @DictType(name = "sys_yes_no")
    private String referenceFlag;
    /**
     * arg0 参数0
     */
    @Length(max = 254)
    @Column(name = "arg0", unique = false, nullable = true, length = 254)
    private String arg0;
    /**
     * arg1 参数1
     */
    @Length(max = 254)
    @Column(name = "arg1", unique = false, nullable = true, length = 254)
    private String arg1;
    /**
     * arg2 参数2
     */
    @Length(max = 254)
    @Column(name = "arg2", unique = false, nullable = true, length = 254)
    private String arg2;
    /**
     * arg3 参数3
     */
    @Length(max = 254)
    @Column(name = "arg3", unique = false, nullable = true, length = 254)
    private String arg3;
    /**
     * callerFilename 操作文件
     */
    @NotBlank
    @Length(max = 254)
    @Column(name = "caller_filename", unique = false, nullable = false, length = 254)
    private String callerFilename;
    /**
     * callerClass 操作类名
     */
    @NotBlank
    @Length(max = 254)
    @Column(name = "caller_class", unique = false, nullable = false, length = 254)
    private String callerClass;
    /**
     * callerMethod 操作方法
     */
    @NotBlank
    @Length(max = 254)
    @Column(name = "caller_method", unique = false, nullable = false, length = 254)
    private String callerMethod;
    /**
     * callerLine 操作行
     */
    @NotBlank
    @Length(max = 4)
    @Column(name = "caller_line", unique = false, nullable = false, length = 4)
    private String callerLine;

    // columns END
    public LoggingEvent() {
    }

    public LoggingEvent(Long id) {
        this.id = id;
    }

    @PrePersist
    public void prePersist() {
    }

    /**
     * eventId event_id
     */
    public Long getId() {
        return this.id;
    }

    /**
     * eventId event_id
     */
    public void setId(Long value) {
        this.id = value;
    }

    /**
     * timestmp 创建时间
     */
    public Long getTimestmp() {
        return this.timestmp;
    }

    /**
     * timestmp 创建时间
     */
    public void setTimestmp(Long value) {
        this.timestmp = value;
    }

    /**
     * formattedMessage 内容
     */
    public String getFormattedMessage() {
        return this.formattedMessage;
    }

    /**
     * formattedMessage 内容
     */
    public void setFormattedMessage(String value) {
        this.formattedMessage = value;
    }

    /**
     * loggerName 名称
     */
    public String getLoggerName() {
        return this.loggerName;
    }

    /**
     * loggerName 名称
     */
    public void setLoggerName(String value) {
        this.loggerName = value;
    }

    /**
     * levelString 级别
     */
    public String getLevelString() {
        return this.levelString;
    }

    /**
     * levelString 级别
     */
    public void setLevelString(String value) {
        this.levelString = value;
    }

    /**
     * threadName 线程
     */
    public String getThreadName() {
        return this.threadName;
    }

    /**
     * threadName 线程
     */
    public void setThreadName(String value) {
        this.threadName = value;
    }

    /**
     * referenceFlag 引用标识
     */
    public String getReferenceFlag() {
        return this.referenceFlag;
    }

    /**
     * referenceFlag 引用标识
     */
    public void setReferenceFlag(String value) {
        this.referenceFlag = value;
    }

    /**
     * arg0 参数0
     */
    public String getArg0() {
        return this.arg0;
    }

    /**
     * arg0 参数0
     */
    public void setArg0(String value) {
        this.arg0 = value;
    }

    /**
     * arg1 参数1
     */
    public String getArg1() {
        return this.arg1;
    }

    /**
     * arg1 参数1
     */
    public void setArg1(String value) {
        this.arg1 = value;
    }

    /**
     * arg2 参数2
     */
    public String getArg2() {
        return this.arg2;
    }

    /**
     * arg2 参数2
     */
    public void setArg2(String value) {
        this.arg2 = value;
    }

    /**
     * arg3 参数3
     */
    public String getArg3() {
        return this.arg3;
    }

    /**
     * arg3 参数3
     */
    public void setArg3(String value) {
        this.arg3 = value;
    }

    /**
     * callerFilename 操作文件
     */
    public String getCallerFilename() {
        return this.callerFilename;
    }

    /**
     * callerFilename 操作文件
     */
    public void setCallerFilename(String value) {
        this.callerFilename = value;
    }

    /**
     * callerClass 操作类名
     */
    public String getCallerClass() {
        return this.callerClass;
    }

    /**
     * callerClass 操作类名
     */
    public void setCallerClass(String value) {
        this.callerClass = value;
    }

    /**
     * callerMethod 操作方法
     */
    public String getCallerMethod() {
        return this.callerMethod;
    }

    /**
     * callerMethod 操作方法
     */
    public void setCallerMethod(String value) {
        this.callerMethod = value;
    }

    /**
     * callerLine 操作行
     */
    public String getCallerLine() {
        return this.callerLine;
    }

    /**
     * callerLine 操作行
     */
    public void setCallerLine(String value) {
        this.callerLine = value;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE).append("eventId", getId())
                .append("timestmp", getTimestmp()).append("formattedMessage", getFormattedMessage())
                .append("loggerName", getLoggerName()).append("levelString", getLevelString())
                .append("threadName", getThreadName()).append("referenceFlag", getReferenceFlag())
                .append("arg0", getArg0()).append("arg1", getArg1()).append("arg2", getArg2()).append("arg3", getArg3())
                .append("callerFilename", getCallerFilename()).append("callerClass", getCallerClass())
                .append("callerMethod", getCallerMethod()).append("callerLine", getCallerLine()).toString();
    }

    @Override
    public int hashCode() {
        return new HashCodeBuilder().append(getId()).toHashCode();
    }

    @Override
    public boolean equals(Object obj) {
        if (obj instanceof LoggingEvent == false) {
            return false;
        }
        if (this == obj) {
            return true;
        }
        LoggingEvent other = (LoggingEvent) obj;
        return new EqualsBuilder().append(getId(), other.getId()).isEquals();
    }
}
