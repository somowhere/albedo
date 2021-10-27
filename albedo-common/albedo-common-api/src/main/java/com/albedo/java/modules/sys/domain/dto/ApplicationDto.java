package com.albedo.java.modules.sys.domain.dto;

import com.albedo.java.common.core.annotation.ExcelField;
import com.albedo.java.common.core.basic.domain.IdEntity;
import com.albedo.java.common.core.vo.DataDto;
import com.albedo.java.modules.sys.domain.enums.ApplicationAppTypeEnum;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.*;
import lombok.experimental.Accessors;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Size;
import java.time.LocalDateTime;

import static com.baomidou.mybatisplus.annotation.SqlCondition.LIKE;

/**
 * <p>
 * 实体类
 * 应用
 * </p>
 *
 * @author zuihou
 * @since 2020-11-20
 */
@Data
@NoArgsConstructor
@ToString(callSuper = true)
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
@ApiModel(value = "Application", description = "应用")
@AllArgsConstructor
public class ApplicationDto extends DataDto<Long> {

    private static final long serialVersionUID = 1L;

    /**
     * 客户端ID
     */
    @Size(max = 24, message = "客户端ID长度不能超过24")
    private String clientId;

    /**
     * 客户端密码
     */
    @Size(max = 32, message = "客户端密码长度不能超过32")
    private String clientSecret;

    /**
     * 官网
     */
    @Size(max = 100, message = "官网长度不能超过100")
    private String website;

    /**
     * 应用名称
     */
    @NotEmpty(message = "应用名称不能为空")
    @Size(max = 255, message = "应用名称长度不能超过255")
    private String name;

    /**
     * 应用图标
     */
    @Size(max = 255, message = "应用图标长度不能超过255")
    private String icon;

    /**
     * 类型
     * #{SERVER:服务应用;APP:手机应用;PC:PC网页应用;WAP:手机网页应用}
     */
    private ApplicationAppTypeEnum appType;

    /**
     * 备注
     */
    @Size(max = 200, message = "备注长度不能超过200")
    private String describe;

    /**
     * 状态
     */
    private Boolean state;


    @Builder
    public ApplicationDto(Long id,
                          String clientId, String clientSecret, String website, String name, String icon,
                          ApplicationAppTypeEnum appType, String describe, Boolean state) {
        this.setId(id);
        this.clientId = clientId;
        this.clientSecret = clientSecret;
        this.website = website;
        this.name = name;
        this.icon = icon;
        this.appType = appType;
        this.describe = describe;
        this.state = state;
    }

}
