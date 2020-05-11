package com.albedo.java.modules.gen.web;

import com.albedo.java.common.core.util.ResultBuilder;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.common.web.resource.BaseResource;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 *
 * @author somewhere
 */
@Controller
@RequestMapping("${application.admin-path}/hello")
public class HelloResource extends BaseResource {


	/**
	 * @param pm
	 * @return
	 */
	@GetMapping(value = StringUtil.SLASH)
	@PreAuthorize("@pms.hasPermission('gen_scheme_view')")
	public ResponseEntity getPage(PageModel pm) {

		return ResultBuilder.buildOk("hello");
	}




}
