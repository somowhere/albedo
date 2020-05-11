package com.albedo.java.modules.gen.web;

import cn.hutool.core.lang.Assert;
import cn.hutool.core.util.CharUtil;
import com.albedo.java.common.core.constant.CommonConstants;
import com.albedo.java.common.core.util.ResultBuilder;
import com.albedo.java.common.core.util.StringUtil;
import com.albedo.java.common.core.vo.PageModel;
import com.albedo.java.common.log.annotation.Log;
import com.albedo.java.common.log.enums.BusinessType;
import com.albedo.java.common.security.util.SecurityUtil;
import com.albedo.java.common.web.resource.BaseResource;
import com.albedo.java.modules.gen.domain.dto.GenCodeDto;
import com.albedo.java.modules.gen.domain.dto.SchemeDto;
import com.albedo.java.modules.gen.domain.dto.SchemeGenDto;
import com.albedo.java.modules.gen.domain.dto.TableDto;
import com.albedo.java.modules.gen.service.SchemeService;
import com.albedo.java.modules.gen.service.TableService;
import com.albedo.java.modules.sys.domain.dto.GenSchemeDto;
import com.albedo.java.modules.sys.service.MenuService;
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
	@GetMapping(value = StringUtil.SLASH)
	@PreAuthorize("@pms.hasPermission('gen_scheme_view')")
	public ResponseEntity getPage(PageModel pm) {
		return ResultBuilder.buildOk(schemeService.getSchemeVoPage(pm));
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
	public ResponseEntity formData(SchemeDto schemeDataVo) {
		String username = SecurityUtil.getUser().getUsername();
		Map<String, Object> formData = schemeService.findFormData(schemeDataVo, username);
		return ResultBuilder.buildOk(formData);
	}

	@Log(value = "生成方案", businessType = BusinessType.GENCODE)
	@PutMapping(value = "/gen-code")
	@PreAuthorize("@pms.hasPermission('gen_scheme_code')")
	public ResponseEntity genCode(@Valid @RequestBody GenCodeDto genCodeDto) {
		SchemeDto genSchemeDataVo = schemeService.getOneDto(genCodeDto.getId());
		Assert.isTrue(genSchemeDataVo != null, "无法获取代码生成方案信息");
		genSchemeDataVo.setReplaceFile(genCodeDto.getReplaceFile());
		schemeService.generateCode(genSchemeDataVo);
		return ResultBuilder.buildOk("生成", genSchemeDataVo.getName(), "代码成功");
	}

	@Log(value = "生成方案", businessType = BusinessType.EDIT)
	@PostMapping
	@PreAuthorize("@pms.hasPermission('gen_scheme_edit')")
	public ResponseEntity save(@Valid @RequestBody SchemeDto schemeDataVo) {
		schemeService.saveOrUpdate(schemeDataVo);
		// 生成代码
		if (schemeDataVo.getGenCode()) {
			schemeService.generateCode(schemeDataVo);
		}
		return ResultBuilder.buildOk("保存", schemeDataVo.getName(), "成功");
	}

	@Log(value = "生成方案", businessType = BusinessType.EDIT)
	@PostMapping("/gen-menu")
	@PreAuthorize("@pms.hasPermission('gen_scheme_menu')")
	public ResponseEntity genMenu(@Valid @RequestBody SchemeGenDto schemeGenDto) {
		SchemeDto schemeDataVo = schemeService.getOneDto(schemeGenDto.getId());
		TableDto tableDataVo = schemeDataVo.getTableDataVo();
		if (tableDataVo == null) {
			tableDataVo = tableService.getOneDto(schemeDataVo.getTableId());
		}
		String url = StringUtil.toAppendStr(StringUtil.SLASH, StringUtil.lowerCase(schemeDataVo.getModuleName()), (StringUtil.isNotBlank(schemeDataVo.getSubModuleName()) ? StringUtil.SLASH + StringUtil.lowerCase(schemeDataVo.getSubModuleName()) : ""), StringUtil.SLASH,
			StringUtil.toRevertCamelCase(StringUtil.lowerFirst(tableDataVo.getClassName()), CharUtil.DASHED), StringUtil.SLASH);
		menuService.saveByGenScheme(new GenSchemeDto(schemeDataVo.getName(), schemeGenDto.getParentMenuId(), url, tableDataVo.getClassName()));
		return ResultBuilder.buildOk("生成", schemeDataVo.getName(), "菜单成功");
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
