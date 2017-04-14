package com.albedo.java.modules.sys.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import javax.validation.constraints.NotNull;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

/**
 * Persist AuditEvent managed by the Spring Boot actuator
 * @see org.springframework.boot.actuate.audit.AuditEvent
 */
@Data
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class PersistentAuditEvent {

    private Long id;

    @NotNull
    private String principal;

    private LocalDateTime auditEventDate;
    private String auditEventType;

    private Map<String, String> data = new HashMap<>();

}
