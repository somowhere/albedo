package com.albedo.java.modules.sys.web;

import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.config.SystemConfig;
import com.albedo.java.web.rest.ResultBuilder;
import com.albedo.java.web.rest.base.BaseResource;
import com.codahale.metrics.servlets.MetricsServlet;
import com.google.common.collect.Maps;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import java.util.Map;

/**
 * Copyright 2013 albedo All right reserved Author lijie Created on 2013-10-23 下午5:44:04
 *
 * @author somewhere
 */
@Controller
@RequestMapping(value = "${albedo.adminPath}/sys")
public class SystemResource extends BaseResource {

    public SystemResource() {
        log.warn(PublicUtil.toAppendStr("Abledo_Boot Web [", SystemConfig.get("version"), "] 框架开发版权所有 Copyright(c) 2010-2017\n未经授权非法复制,使用,传播,销售,本公司必究法律责任"));
    }

    @ResponseBody
    @RequestMapping(value = "findWaitMessage", method = RequestMethod.GET)
    public ResponseEntity findWaitMessage() {
//		String staffId = UserUtil.getUserId();
        Map<String, Object> msgObject = Maps.newHashMap();
//		// 推送当前用户的离线消息列表
//		List<MessageDeal> infoList = MessageUtil.getWaitInfoMapByUser(staffId);
//		if (PublicUtil.isNotEmpty(infoList)) {
//			List<Map<String, Object>> list = Lists.newArrayList();
//			for (MessageDeal messageDeal : infoList) {
//				Map<String, Object> map = JsonUtil.getInstance().setRecurrenceStr("message", "message_senderUser_loginId").objToMap(messageDeal);
//				list.add(map);
//			}
//			msgObject.put(MessageUtil.MESSAGE_TYPE, MessageUtil.MESSAGE_TYPE_1);
//			msgObject.put(MessageUtil.MESSAGE_DATA, list);
//		}
        return ResultBuilder.buildOk();
    }

    /**
     * 树结构选择标签（treeselect.tag）
     */
    @RequestMapping(value = "findTreeSelect", method = RequestMethod.GET)
    public String findTreeSelect(HttpServletRequest request, Model model) {
        // 树结构数据URL
        model.addAttribute("url", request.getParameter("url"));
        // 排除的编号ID
        model.addAttribute("extId", request.getParameter("extId"));
        // 是否可复选
        model.addAttribute("checked", request.getParameter("checked"));
        // 指定默认选中的ID
        model.addAttribute("selectIds", request.getParameter("selectIds"));
        // 过滤栏目模型（仅针对CMS的Category树）
        model.addAttribute("module", request.getParameter("module"));
        // 默认展开level
        model.addAttribute("nodesLevel", request.getParameter("nodesLevel"));
        return "modules/sys/tagTreeselect";
    }

    /**
     * 图标选择标签（iconselect.tag）
     */
    @RequestMapping(value = "findIconSelect", method = RequestMethod.GET)
    public String findIconSelect(HttpServletRequest request, Model model) {
        model.addAttribute("value", request.getParameter("value"));
        return "modules/sys/tagIconselect";
    }

    @RequestMapping(value = "metrics", method = RequestMethod.GET)
    public String metrics(HttpServletRequest request, Model model) {
        ServletContext context = request.getServletContext();
        final Object registryAttr = context.getAttribute(MetricsServlet.METRICS_REGISTRY);
        model.addAttribute("registry", registryAttr);
        return "modules/sys/metrics";
    }

}
