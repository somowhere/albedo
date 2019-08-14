package com.albedo.java.modules.sys.domain;

import com.albedo.java.common.persistence.domain.GeneralEntity;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotNull;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * Persist AuditEvent managed by the Spring Boot actuator.
 *
 * @see org.springframework.boot.actuate.audit.AuditEvent
 */
@TableName("sys_persistent_audit_event")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class PersistentAuditEvent extends GeneralEntity<PersistentAuditEvent> {


	public static final String F_AUDITEVENTDATE = "auditEventDate";
	public static final String F_PRINCIPAL = "principal";
	public static final String F_AUDITEVENTTYPE = "auditEventType";

	public static final String F_SQL_AUDITEVENTDATE = "event_date";
	public static final String F_SQL_PRINCIPAL = "principal";
	public static final String F_SQL_AUDITEVENTTYPE = "auditEventType";

	@TableId(value = "event_id", type = IdType.AUTO)
	private Long id;

	@NotNull
	@TableField
	private String principal;

	@TableField(PersistentAuditEvent.F_SQL_AUDITEVENTDATE)
	private Date auditEventDate;
	@TableField("event_type")
	private String auditEventType;

	//    @ElementCollection
//    @MapKeyTableField("name")
//    @TableField("value")
//    @CollectionTable(name = "jhi_persistent_audit_evt_data", joinColumns=@JoinColumn(name="event_id"))
	@TableField(exist = false)
	private Map<String, String> data = new HashMap<>();
}
