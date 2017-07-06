package com.albedo.java.modules.sys.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import org.springframework.data.mybatis.annotations.Column;
import org.springframework.data.mybatis.annotations.ElementCollection;
import org.springframework.data.mybatis.annotations.Entity;
import org.springframework.data.mybatis.annotations.Id;

import javax.validation.constraints.NotNull;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * Persist AuditEvent managed by the Spring Boot actuator
 *
 * @see org.springframework.boot.actuate.audit.AuditEvent
 */
@Entity(table = "jhi_persistent_audit_event")
@Data
@AllArgsConstructor
@ToString
@NoArgsConstructor
public class PersistentAuditEvent {

    @Id(strategy = Id.GenerationType.AUTO)
    @Column(name = "event_id")
    private Long id;

    @NotNull
    @Column
    private String principal;

    @Column(name = "event_date")
    private Date auditEventDate;
    @Column(name = "event_type")
    private String auditEventType;

    @ElementCollection
//    @MapKeyColumn(name = "name")
    @Column(name = "value")
//    @CollectionTable(name = "jhi_persistent_audit_evt_data", joinColumns=@JoinColumn(name="event_id"))
    private Map<String, String> data = new HashMap<>();

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getPrincipal() {
        return principal;
    }

    public void setPrincipal(String principal) {
        this.principal = principal;
    }

    public Date getAuditEventDate() {
        return auditEventDate;
    }

    public void setAuditEventDate(Date auditEventDate) {
        this.auditEventDate = auditEventDate;
    }

    public String getAuditEventType() {
        return auditEventType;
    }

    public void setAuditEventType(String auditEventType) {
        this.auditEventType = auditEventType;
    }

    public Map<String, String> getData() {
        return data;
    }

    public void setData(Map<String, String> data) {
        this.data = data;
    }
}
