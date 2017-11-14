package com.albedo.java.modules.sys.web;

import com.albedo.java.common.security.SecurityUtil;
import com.albedo.java.modules.sys.service.PersistentTokenService;
import com.albedo.java.util.JsonUtil;
import com.albedo.java.util.StringUtil;
import com.albedo.java.util.domain.Globals;
import com.albedo.java.util.domain.PageModel;
import com.albedo.java.web.rest.ResultBuilder;
import com.albedo.java.web.rest.base.BaseResource;
import com.alibaba.fastjson.JSON;
import com.codahale.metrics.annotation.Timed;
import com.google.common.collect.Lists;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.annotation.Resource;

/**
 * session 管理
 *
 * @author admin
 * @version 2017-01-03
 */
@Controller
@RequestMapping(value = "${albedo.adminPath}/sys/persistentToken")
public class PersistentTokenResource extends BaseResource {

    @Resource
    private PersistentTokenService persistentTokenService;

    @RequestMapping(value = "/", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    @Timed
    public String list() {
        return "modules/sys/persistentTokenList";
    }

    /**
     * @param pm
     */
    @RequestMapping(value = "/page", method = RequestMethod.GET)
    public ResponseEntity getPage(PageModel pm) {
        persistentTokenService.findPage(pm, SecurityUtil.dataScopeFilter());
        JSON rs = JsonUtil.getInstance().setRecurrenceStr("user_loginId").toJsonObject(pm);
        return ResultBuilder.buildObject(rs);
    }

    @RequestMapping(value = "/delete/{ids:" + Globals.LOGIN_REGEX
            + "}", method = RequestMethod.DELETE, produces = MediaType.APPLICATION_JSON_VALUE)
    @Timed
    public ResponseEntity delete(@PathVariable String ids) {
        log.debug("REST request to delete User: {}", ids);
        persistentTokenService.delete(Lists.newArrayList(ids.split(StringUtil.SPLIT_DEFAULT)));
        return ResultBuilder.buildOk("删除成功");
    }

}