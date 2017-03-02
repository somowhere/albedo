package com.albedo.java.modules.sys.web;

import com.albedo.java.common.config.template.tag.FormDirective;
import com.albedo.java.common.domain.data.DynamicSpecifications;
import com.albedo.java.common.domain.data.SpecificationDetail;
import com.albedo.java.common.security.SecurityUtil;
import com.albedo.java.modules.sys.domain.Role;
import com.albedo.java.modules.sys.domain.User;
import com.albedo.java.modules.sys.service.UserService;
import com.albedo.java.modules.sys.service.util.JsonUtil;
import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.base.Reflections;
import com.albedo.java.util.domain.Globals;
import com.albedo.java.util.domain.PageModel;
import com.albedo.java.util.domain.QueryCondition;
import com.albedo.java.util.exception.RuntimeMsgException;
import com.albedo.java.web.bean.ResultBuilder;
import com.albedo.java.web.rest.base.DataResource;
import com.alibaba.fastjson.JSON;
import com.codahale.metrics.annotation.Timed;
import com.google.common.collect.Lists;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Page;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.inject.Inject;
import java.net.URISyntaxException;

/**
 * REST controller for managing user.
 *
 * <p>
 * This class accesses the User entity, and needs to fetch its collection of
 * authorities.
 * </p>
 * <p>
 * For a normal use-case, it would be better to have an eager relationship
 * between User and Authority, and send everything to the client side: there
 * would be no View Model and DTO, a lot less code, and an outer-join which
 * would be good for performance.
 * </p>
 * <p>
 * We use a View Model and a DTO for 3 reasons:
 * <ul>
 * <li>We want to keep a lazy association between the user and the authorities,
 * because people will quite often do relationships with the user, and we don't
 * want them to get the authorities all the time for nothing (for performance
 * reasons). This is the #1 goal: we should not impact our user' application
 * because of this use-case.</li>
 * <li>Not having an outer join causes n+1 requests to the database. This is not
 * a real issue as we have by default a second-level cache. This means on the
 * first HTTP call we do the n+1 requests, but then all authorities come from
 * the cache, so in fact it's much better than doing an outer join (which will
 * get lots of data from the database, for each HTTP call).</li>
 * <li>As this manages user, for security reasons, we'd rather have a DTO
 * layer.</li>
 * </ul>
 * <p>
 * Another option would be to have a specific JPA entity graph to handle this
 * case.
 * </p>
 */
@Controller
@RequestMapping("${albedo.adminPath}/sys/user")
public class UserResource extends DataResource<User> {

	private final Logger log = LoggerFactory.getLogger(UserResource.class);


	@Inject
	private UserService userService;

	@ModelAttribute
	public User get(@RequestParam(required = false) String id) throws Exception {
		String path = request.getRequestURI();
		if (path != null && !path.contains("checkBy") && !path.contains("find") && PublicUtil.isNotEmpty(id)) {
			return userService.findOne(id);
		} else {
			return new User();
		}
	}

	@RequestMapping(value = "/", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	@Timed
	public String list() {
		return "modules/sys/userList";
	}
	/**
	 * 分页
	 * @param pm
	 */
	@RequestMapping(value = "/page", method = RequestMethod.GET)
	public ResponseEntity getPage(PageModel<User> pm) { SpecificationDetail<User> spec = DynamicSpecifications.buildSpecification(pm.getQueryConditionJson(), SecurityUtil.dataScopeFilter(),
				QueryCondition.ne(User.F_STATUS, User.FLAG_DELETE), QueryCondition.ne(User.F_ID, "1"));
		Page<User> page = userService.findAll(spec, pm);
		pm.setPageInstance(page);
		JSON rs = JsonUtil.getInstance().setFreeFilters("roleIdList").setRecurrenceStr("org_name").toJsonObject(pm);
		return ResultBuilder.buildObject(rs);
	}
	
	@RequestMapping(value = "/edit", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	@Timed
//	@Secured(AuthoritiesConstants.ADMIN)
	public String form(User user, @RequestParam(required=false) Boolean isModal) {
		request.setAttribute("allRoles", FormDirective.convertComboDataList(SecurityUtil.getRoleList(), Role.F_ID, Role.F_NAME));
		return PublicUtil.toAppendStr("modules/sys/userForm", isModal ? "Modal" : "");
	}

	/**
	 * 保存
	 * @param user
	 * @param confirmPassword
	 * @return
	 * @throws URISyntaxException
	 */
	@RequestMapping(value = "/edit", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
	@Timed @ApiImplicitParams(@ApiImplicitParam(paramType = "query",name = "confirmPassword"))
//	@Secured(AuthoritiesConstants.ADMIN)
	public ResponseEntity save(@RequestBody User user, String confirmPassword){
		log.debug("REST request to save User : {}", user);
		// beanValidatorAjax(user);
		if (PublicUtil.isNotEmpty(user.getPassword()) && !user.getPassword().equals(confirmPassword)) {
			throw new RuntimeMsgException("两次输入密码不一致");
		}
		// Lowercase the user login before comparing with database
		if (!checkByProperty(Reflections.createObj(User.class, Lists.newArrayList(User.F_ID, User.F_LOGINID),
				user.getId(), user.getLoginId()))) {
			throw new RuntimeMsgException("登录Id已存在");
		}
		if (!PublicUtil.isNotEmpty(user.getEmail()) && checkByProperty(Reflections.createObj(User.class,
				Lists.newArrayList(User.F_ID, User.F_EMAIL), user.getId(), user.getEmail()))) {
			throw new RuntimeMsgException("邮箱已存在");
		}
		User newUser = userService.save(user);
		// if(PublicUtil.isEmpty(user.getId()) &&
		// PublicUtil.isNotEmpty(user.getEmail())){
		// String baseUrl = request.getParameter("basePath");
		// mailService.sendCreationEmail(newUser, baseUrl);
		// }
		return ResultBuilder.buildOk("保存", user.getLoginId(), "成功");
	}

	/**
	 * 批量删除
	 * @param ids
	 * @return
	 */
	@RequestMapping(value = "/delete/{ids:" + Globals.LOGIN_REGEX
			+ "}", method = RequestMethod.DELETE, produces = MediaType.APPLICATION_JSON_VALUE)
	@Timed
//	@Secured(AuthoritiesConstants.ADMIN)
	public ResponseEntity delete(@PathVariable String ids) {
		log.debug("REST request to delete User: {}", ids);
		userService.delete(ids);
		return ResultBuilder.buildOk("删除成功");
	}

	/**
	 * 锁定or解锁
	 * @param ids
	 * @return
	 */
	@RequestMapping(value = "/lock/{ids:" + Globals.LOGIN_REGEX
			+ "}", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
	@Timed
//	@Secured(AuthoritiesConstants.ADMIN)
	public ResponseEntity lockOrUnLock(@PathVariable String ids) {
		log.debug("REST request to lockOrUnLock User: {}", ids);
		userService.lockOrUnLock(ids);
		return ResultBuilder.buildOk("操作成功");
	}
	
}
