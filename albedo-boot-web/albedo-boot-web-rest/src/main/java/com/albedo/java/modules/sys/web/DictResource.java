package com.albedo.java.modules.sys.web;

import com.albedo.java.modules.sys.domain.Dict;
import com.albedo.java.modules.sys.service.DictService;
import com.albedo.java.util.DictUtil;
import com.albedo.java.util.JsonUtil;
import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.StringUtil;
import com.albedo.java.util.base.Reflections;
import com.albedo.java.util.domain.Globals;
import com.albedo.java.util.domain.PageModel;
import com.albedo.java.util.exception.RuntimeMsgException;
import com.albedo.java.vo.base.SelectResult;
import com.albedo.java.vo.sys.DictVo;
import com.albedo.java.vo.sys.query.DictQuery;
import com.albedo.java.vo.sys.query.DictQuerySearch;
import com.albedo.java.vo.sys.query.DictTreeQuery;
import com.albedo.java.vo.sys.query.DictTreeResult;
import com.albedo.java.web.rest.ResultBuilder;
import com.albedo.java.web.rest.base.TreeVoResource;
import com.alibaba.fastjson.JSON;
import com.codahale.metrics.annotation.Timed;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.validation.Valid;
import java.net.URISyntaxException;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * REST controller for managing Station.
 *
 * @author somewhere
 */
@Controller
@RequestMapping("${albedo.adminPath}/sys/dict")
public class DictResource extends TreeVoResource<DictService, DictVo> {

    @Resource
    private DictService dictService;


    @GetMapping(value = "findTreeData")
    public ResponseEntity findTreeData(DictTreeQuery dictTreeQuery) {
        List<DictTreeResult> rs = dictService.findTreeData(dictTreeQuery, DictUtil.getDictList());
        return ResultBuilder.buildOk(rs);
    }

    @GetMapping(value = "findSelectData")
    public ResponseEntity findSelectData(DictQuerySearch dictQuerySearch) {
        Map<String, Object> map = Maps.newHashMap();
        if (PublicUtil.isNotEmpty(dictQuerySearch.getDictQueries())) {
            List<DictQuery> dictQueries = JSON.parseArray(dictQuerySearch.getDictQueries(), DictQuery.class);
            dictQueries.forEach(dictQuery -> map.put(StringUtil.toCamelCase(dictQuery.getCode()),
                    DictUtil.getDictList(dictQuery).
                    stream().map(item -> new SelectResult(item.getVal(), item.getName())).collect(Collectors.toList())));
        }
        return ResultBuilder.buildOk(map);
    }


    @GetMapping(value = "/")
    @Timed
    public String list() {
        return "modules/sys/dictList";
    }

    /**
     * @param pm
     * @return
     * @throws URISyntaxException
     */
    @GetMapping(value = "/page")
    public ResponseEntity getPage(PageModel<Dict> pm) {
        pm.setSortDefaultName(Direction.DESC, Dict.F_SORT, Dict.F_LASTMODIFIEDDATE);
        dictService.findPage(pm);
        JSON rs = JsonUtil.getInstance().setRecurrenceStr("parent_name").toJsonObject(pm);
        return ResultBuilder.buildObject(rs);
    }

    @GetMapping(value = "/edit")
    @Timed
    public String form(DictVo dictVo) {
        if (dictVo == null) {
            throw new RuntimeMsgException("无法获取字典数据");
        }
        if (PublicUtil.isNotEmpty(dictVo.getParentId())) {
            dictService.findOptionalTopByParentId(dictVo.getParentId()).ifPresent(item -> dictVo.setSort(item.getSort() + 30));
            dictService.findOneById(dictVo.getParentId()).ifPresent(item -> dictVo.setParentName(item.getName()));
        }
        if (dictVo.getSort() == null) {
            dictVo.setSort(30);
        }
        return "modules/sys/dictForm";
    }

    /**
     * @param dictVo
     * @return
     * @throws URISyntaxException
     */
    @PostMapping(value = "/edit", produces = MediaType.APPLICATION_JSON_VALUE)
    @Timed
    public ResponseEntity save(@Valid @RequestBody DictVo dictVo)
            throws URISyntaxException {
        log.debug("REST request to save Dict : {}", dictVo);
        // Lowercase the dictVo login before comparing with database
        if (!checkByProperty(Reflections.createObj(DictVo.class, Lists.newArrayList(DictVo.F_ID, DictVo.F_CODE),
                dictVo.getId(), dictVo.getName()))) {
            throw new RuntimeMsgException("编码已存在");
        }
        dictService.save(dictVo);
        DictUtil.clearCache();
        return ResultBuilder.buildOk("保存", dictVo.getName(), "成功");
    }

    /**
     * @param ids
     * @return
     */
    @PostMapping(value = "/delete/{ids:" + Globals.LOGIN_REGEX
            + "}")
    @Timed
    public ResponseEntity delete(@PathVariable String ids) {
        log.debug("REST request to delete Dict: {}", ids);
        dictService.delete(Lists.newArrayList(ids.split(StringUtil.SPLIT_DEFAULT)));
        DictUtil.clearCache();
        return ResultBuilder.buildOk("删除成功");
    }


    @PostMapping(value = "/lock/{ids:" + Globals.LOGIN_REGEX
            + "}")
    @Timed
    public ResponseEntity lockOrUnLock(@PathVariable String ids) {
        log.debug("REST request to lockOrUnLock User: {}", ids);
        dictService.lockOrUnLock(Lists.newArrayList(ids.split(StringUtil.SPLIT_DEFAULT)));
        DictUtil.clearCache();
        return ResultBuilder.buildOk("操作成功");
    }

}
