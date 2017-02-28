package com.albedo.java.modules.sys.web;

import com.albedo.java.common.domain.data.DynamicSpecifications;
import com.albedo.java.common.domain.data.SpecificationDetail;
import com.albedo.java.common.security.SecurityUtil;
import com.albedo.java.modules.sys.domain.PersistentToken;
import com.albedo.java.modules.sys.service.PersistentTokenService;
import com.albedo.java.modules.sys.service.util.JsonUtil;
import com.albedo.java.util.domain.Globals;
import com.albedo.java.util.domain.PageModel;
import com.albedo.java.web.rest.base.BaseResource;
import com.alibaba.fastjson.JSON;
import com.codahale.metrics.annotation.Timed;
import org.springframework.data.domain.Page;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.net.URISyntaxException;

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
	 * GET / : get all persistentToken.
	 * 
	 * @param pageable
	 *            the pagination information
	 * @return the ResponseEntity with status 200 (OK) and with body all
	 *         persistentToken
	 * @throws URISyntaxException
	 *             if the pagination headers couldn't be generated
	 */
	@RequestMapping(value = "/page", method = RequestMethod.GET)
	public void getPage(PageModel<PersistentToken> pm, HttpServletResponse response) {
		SpecificationDetail<PersistentToken> spec = DynamicSpecifications
				.buildSpecification(pm.getQueryConditionJson(), SecurityUtil.dataScopeFilter());
		Page<PersistentToken> page = persistentTokenService.findAll(spec, pm);
		pm.setPageInstance(page);
		JSON rs = JsonUtil.getInstance().setRecurrenceStr("user_loginId").toJsonObject(pm);
		writeJsonHttpResponse(rs.toString(), response);
	}
	
	@RequestMapping(value = "/delete/{ids:" + Globals.LOGIN_REGEX
			+ "}", method = RequestMethod.DELETE, produces = MediaType.APPLICATION_JSON_VALUE)
	@Timed
	public void delete(@PathVariable String ids, HttpServletResponse response) {
		log.debug("REST request to delete User: {}", ids);
		persistentTokenService.delete(ids);
		addAjaxMsg(MSG_TYPE_SUCCESS, "删除成功", response);
	}

}