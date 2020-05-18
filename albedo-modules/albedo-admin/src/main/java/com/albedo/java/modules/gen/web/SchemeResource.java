package com.albedo.java.modules.gen.web;

import cn.hutool.core.lang.Assert;
import cn.hutool.core.util.CharUtil;
import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.util.ResultBuilder;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.common.data.util.QueryWrapperUtil;
import com.albedo.java.common.log.annotation.Log;
import com.albedo.java.common.log.enums.BusinessType;
import com.albedo.java.common.security.util.SecurityUtil;
import com.albedo.java.common.web.resource.BaseResource;
import com.albedo.java.modules.gen.domain.dto.*;
import com.albedo.java.modules.gen.service.SchemeService;
import com.albedo.java.modules.gen.service.TableService;
import com.albedo.java.modules.sys.domain.dto.GenSchemeDto;
import com.albedo.java.modules.sys.service.MenuService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.Map;
import java.util.Set;

/**
 * 生成方案Controller
 *
 * @author somewhere
 */
@Controller
@RequestMapping("${application.admin-path}/gen/scheme")
@AllArgsConstructor
public class SchemeResource extends BaseResource {

	private final SchemeService schemeService;
	private final TableService tableService;
	private final MenuService menuService;

	/**
	 * @param pm
	 * @return
	 */
	@GetMapping
	@PreAuthorize("@pms.hasPermission('gen_scheme_view')")
	@Log(value = "生成方案", businessType = BusinessType.VIEW)
	public ResponseEntity getPage(PageModel pm, SchemeQueryCriteria schemeQueryCriteria) {
		return ResultBuilder.buildOk(schemeService.getSchemeVoPage(pm, schemeQueryCriteria));
	}

	@GetMapping(value = "/preview" + CommonConstants.URL_ID_REGEX)
	@PreAuthorize("@pms.hasPermission('gen_scheme_view')")
	public ResponseEntity preview(@PathVariable String id) {
		String username = SecurityUtil.getUser().getUsername();
		Map<String, Object> formData = schemeService.previewCode(id, username);
		return ResultBuilder.buildOkData(formData);
	}

	@GetMapping(value = "/form-data")
	@PreAuthorize("@pms.hasPermission('gen_scheme_view')")
	public ResponseEntity formData(SchemeDto schemeDto) {
		String username = SecurityUtil.getUser().getUsername();
		Map<String, Object> formData = schemeService.findFormData(schemeDto, username);
		return ResultBuilder.buildOk(formData);
	}

	@Log(value = "生成方案", businessType = BusinessType.GENCODE)
	@PutMapping(value = "/gen-code")
	@PreAuthorize("@pms.hasPermission('gen_scheme_code')")
	public ResponseEntity genCode(@Valid @RequestBody GenCodeDto genCodeDto) {
		SchemeDto genSchemeDto = schemeService.getOneDto(genCodeDto.getId());
		Assert.isTrue(genSchemeDto != null, "无法获取代码生成方案信息");
		genSchemeDto.setReplaceFile(genCodeDto.getReplaceFile());
		schemeService.generateCode(genSchemeDto);
		return ResultBuilder.buildOk("生成", genSchemeDto.getName(), "代码成功");
	}

	@Log(value = "生成方案", businessType = BusinessType.EDIT)
	@PostMapping
	@PreAuthorize("@pms.hasPermission('gen_scheme_edit')")
	public ResponseEntity save(@Valid @RequestBody SchemeDto schemeDto) {
		schemeService.saveOrUpdate(schemeDto);
		// 生成代码
		if (schemeDto.getGenCode()) {
			schemeService.generateCode(schemeDto);
		}
		return ResultBuilder.buildOk("保存", schemeDto.getName(), "成功");
	}

	@Log(value = "生成方案", businessType = BusinessType.EDIT)
	@PostMapping("/gen-menu")
	@PreAuthorize("@pms.hasPermission('gen_scheme_menu')")
	public ResponseEntity genMenu(@Valid @RequestBody SchemeGenDto schemeGenDto) {
		SchemeDto schemeDto = schemeService.getOneDto(schemeGenDto.getId());
		TableDto tableDto = schemeDto.getTableDto();
		if (tableDto == null) {
			tableDto = tableService.getOneDto(schemeDto.getTableId());
		}
		String url = StringUtil.toAppendStr(StringUtil.SLASH, StringUtil.lowerCase(schemeDto.getModuleName()), (StringUtil.isNotBlank(schemeDto.getSubModuleName()) ? StringUtil.SLASH + StringUtil.lowerCase(schemeDto.getSubModuleName()) : ""), StringUtil.SLASH,
			StringUtil.toRevertCamelCase(StringUtil.lowerFirst(tableDto.getClassName()), CharUtil.DASHED), StringUtil.SLASH);
		menuService.saveByGenScheme(new GenSchemeDto(schemeDto.getName(), schemeGenDto.getParentMenuId(), url, tableDto.getClassName()));
		return ResultBuilder.buildOk("生成", schemeDto.getName(), "菜单成功");
	}


	@Log(value = "生成方案", businessType = BusinessType.DELETE)
	@DeleteMapping
	@PreAuthorize("@pms.hasPermission('gen_scheme_del')")
	public ResponseEntity delete(@RequestBody Set<String> ids) {
		log.debug("REST request to delete User: {}", ids);
		schemeService.removeByIds(ids);
		return ResultBuilder.buildOk("删除成功");
	}


}
