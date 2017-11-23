package com.albedo.java.common.security.service;

import com.albedo.java.common.security.SecurityConstants;
import com.albedo.java.common.base.BaseInit;
import com.albedo.java.common.config.AlbedoProperties;
import com.albedo.java.modules.sys.domain.Dict;
import com.albedo.java.modules.sys.domain.Module;
import com.albedo.java.modules.sys.repository.ModuleRepository;
import com.albedo.java.util.DictUtil;
import com.albedo.java.util.JedisUtil;
import com.albedo.java.util.PublicUtil;
import com.albedo.java.util.StringUtil;
import com.albedo.java.util.domain.GlobalJedis;
import com.google.common.collect.Lists;
import org.springframework.context.ApplicationContext;
import org.springframework.security.access.ConfigAttribute;
import org.springframework.security.access.SecurityConfig;
import org.springframework.security.web.FilterInvocation;
import org.springframework.security.web.access.intercept.FilterInvocationSecurityMetadataSource;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.*;
import java.util.stream.Collectors;

@Component("invocationSecurityMetadataSourceService")
public class InvocationSecurityMetadataSourceService
        implements FilterInvocationSecurityMetadataSource {

    public static List<String> authorizePermitAllList = Lists.newArrayList(SecurityConstants.authorizePermitAll);
    @Resource
    ApplicationContext applicationContext;
    @Resource
    AlbedoProperties albedoProperties;
    private Map<String, Collection<ConfigAttribute>> resourceMap = null;
    @Resource
    private ModuleRepository moduleRepository;

    public Map<String, Collection<ConfigAttribute>> getResourceMap() {
        if (resourceMap == null) {
            resourceMap = (Map<String, Collection<ConfigAttribute>>) JedisUtil.getSys(GlobalJedis.RESOURCE_MODULE_DATA_MAP);

            if (resourceMap == null) {
                resourceMap = new HashMap<String, Collection<ConfigAttribute>>();
            }

            if (PublicUtil.isEmpty(resourceMap)) {
                List<Module> moduleList = moduleRepository.findAllByStatusOrderBySort(Module.FLAG_NORMAL);
                List<Dict> dictRequestList = DictUtil.getDictList("sys_request_method");
                moduleList.stream().forEach(item -> {
                    if (PublicUtil.isNotEmpty(item.getPermission())) {

                        Lists.newArrayList(item.getPermission().split(StringUtil.SPLIT_DEFAULT)).forEach(p -> {
                            ConfigAttribute ca = new SecurityConfig(p);
                            String tempUrl = item.getUrl();
                            List<String> keyList = Lists.newArrayList();
                            if (tempUrl != null) {
                                (tempUrl.indexOf(StringUtil.SPLIT_DEFAULT) == -1 ? Lists.newArrayList(tempUrl) : Lists.newArrayList(tempUrl.split(StringUtil.SPLIT_DEFAULT))).forEach(url -> {
                                    if (PublicUtil.isEmpty(item.getRequestMethod())) {
                                        dictRequestList.forEach(dict -> {
                                            keyList.add(PublicUtil.toAppendStr(url, "-", dict.getVal()));
                                        });
                                    } else {
                                        Lists.newArrayList(item.getRequestMethod().split(StringUtil.SPLIT_DEFAULT)).forEach(method -> {
                                            keyList.add(PublicUtil.toAppendStr(url, "-", item.getRequestMethod()));
                                        });
                                    }
                                });
                            }
                            if (PublicUtil.isNotEmpty(keyList)) {
                                keyList.forEach(key -> {
                                /*
                                 * 判断资源文件和权限的对应关系，如果已经存在相关的资源url，则要通过该url为key提取出权限集合，
								 * 将权限增加到权限集合中。 sparta
								 */
                                    if (resourceMap.containsKey(key)) {
                                        Collection<ConfigAttribute> value = resourceMap.get(key);
                                        value.add(ca);
                                        resourceMap.put(key, value);
                                    } else {
                                        Collection<ConfigAttribute> atts = new ArrayList<ConfigAttribute>();
                                        atts.add(ca);
                                        resourceMap.put(key, atts);
                                    }

                                });
                            }
                        });

                    }
                });
                JedisUtil.putSys(GlobalJedis.RESOURCE_MODULE_DATA_MAP, resourceMap);
            }
        }

        return resourceMap;

    }


    @Override
    public Collection<ConfigAttribute> getAllConfigAttributes() {
        return moduleRepository.findAllByStatusOrderBySort(Module.FLAG_NORMAL).stream()
                .map(item -> new SecurityConfig(item.getPermission())).collect(Collectors.toList());
    }

    // 根据URL，找到相关的权限配置。
    @Override
    public Collection<ConfigAttribute> getAttributes(Object object) throws IllegalArgumentException {

        // object 是一个URL，被用户请求的url。
        FilterInvocation filterInvocation = (FilterInvocation) object;
        HttpServletRequest request = filterInvocation.getHttpRequest();
        Iterator<String> ite = getResourceMap().keySet().iterator();
        String url = null;
        while (ite.hasNext()) {
            url = ite.next();
            if (PublicUtil.isNotEmpty(url)) {
                if (new AntPathRequestMatcher(PublicUtil.toAppendStr(albedoProperties.getAdminPath(), url))
                        .matches(request)) {
                    SecurityConstants.setCurrentUrl(url);
                    return getResourceMap().get(PublicUtil.toAppendStr(url, "-", request.getMethod().toUpperCase()));
                }
            }

        }
        String rqurl = request.getRequestURI();

        if (new AntPathRequestMatcher(albedoProperties.getAdminPath(SecurityConstants.loginUrl)).matches(request)
                || new AntPathRequestMatcher(albedoProperties.getAdminPath(SecurityConstants.authLogin)).matches(request)
                || new AntPathRequestMatcher(albedoProperties.getAdminPath(SecurityConstants.logoutUrl)).matches(request)) {
            return null;
        }

        for (int i = 0; i < SecurityConstants.authorizePermitAll.length; i++) {
            if (new AntPathRequestMatcher(albedoProperties.getAdminPath(SecurityConstants.authorizePermitAll[i])).matches(request)) {
                return null;
            }
        }

        if (rqurl.startsWith(albedoProperties.getAdminPath())) {
            return Lists.newArrayList(new SecurityConfig("user"));
        }

        return null;

    }

    @Override
    public boolean supports(Class<?> arg0) {
        return true;
    }

}