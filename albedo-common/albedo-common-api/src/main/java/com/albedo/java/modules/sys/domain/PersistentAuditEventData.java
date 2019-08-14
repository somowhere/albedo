package com.albedo.java.modules.sys.domain;

import com.albedo.java.common.persistence.domain.GeneralEntity;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotNull;

/**
 * Persist AuditEvent managed by the Spring Boot actuator.
 *
 * @see org.springframework.boot.actuate.audit.AuditEvent
 */
@TableName("sys_persistent_audit_event_data")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class PersistentAuditEventData extends GeneralEntity<PersistentAuditEventData> {

	@TableId(value = "event_id")
	private Long id;

	@NotNull
	private String name;

	private String value;

}
