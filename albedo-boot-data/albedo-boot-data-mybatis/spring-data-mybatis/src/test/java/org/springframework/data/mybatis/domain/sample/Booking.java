package org.springframework.data.mybatis.domain.sample;

import org.springframework.data.annotation.PersistenceConstructor;
import org.springframework.data.mybatis.annotations.Entity;
import org.springframework.data.mybatis.domains.LongId;

/**
 * @author Jarvis Song
 */
@Entity(table = "ds_booking")
public class Booking extends LongId {

    private Long    userId;
    private String  serialNumber;
    private Integer amount;

    public Booking() {
    }

    @PersistenceConstructor
    public Booking(Long userId) {
        this.userId = userId;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getSerialNumber() {
        return serialNumber;
    }

    public void setSerialNumber(String serialNumber) {
        this.serialNumber = serialNumber;
    }

    public Integer getAmount() {
        return amount;
    }

    public void setAmount(Integer amount) {
        this.amount = amount;
    }
}
