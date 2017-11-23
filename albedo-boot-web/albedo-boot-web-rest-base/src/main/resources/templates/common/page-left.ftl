<div class="page-sidebar-wrapper">
    <!-- BEGIN SIDEBAR -->
    <!-- DOC: Set data-auto-scroll="false" to disable the sidebar from auto scrolling/focusing -->
    <!-- DOC: Change data-auto-speed="200" to adjust the sub menu slide up/down speed -->
    <div class="page-sidebar navbar-collapse collapse">
        <!-- BEGIN SIDEBAR MENU -->
        <!-- DOC: Apply "page-sidebar-menu-light" class right after "page-sidebar-menu" to enable light sidebar menu style(without borders) -->
        <!-- DOC: Apply "page-sidebar-menu-hover-submenu" class right after "page-sidebar-menu" to enable hoverable(hover vs accordion) sub menu mode -->
        <!-- DOC: Apply "page-sidebar-menu-closed" class right after "page-sidebar-menu" to collapse("page-sidebar-closed" class must be applied to the body element) the sidebar sub menu mode -->
        <!-- DOC: Set data-auto-scroll="false" to disable the sidebar from auto scrolling/focusing -->
        <!-- DOC: Set data-keep-expand="true" to keep the submenues expanded -->
        <!-- DOC: Set data-auto-speed="200" to adjust the sub menu slide up/down speed-->
        <ul class="page-sidebar-menu" data-keep-expanded="false"
            data-auto-scroll="true" data-slide-speed="200">
        <#list  SecurityUtil.getModuleList()! as moduleParent>
            <#if (moduleParent.parentId)! == '4d32c49cc7f448dcbfb92ce9c4dde058' >
                <#if moduleParent.url !=''>
                    <li class='nav-item ${(moduleParent_index == 0)!?string("start", "")}'>
                        <a href="#${(moduleParent.hrefName)! }" data-url-name="${(moduleParent.hrefName)! }"
                           class="nav-link pageModal" data-target="${(moduleParent.target)!}">
                            <i class="fa ${moduleParent.iconCls}"></i>
                            <span class="title">${(moduleParent.name)!}</span>
                        </a>
                    </li>
                <#else>
                    <li class="heading">
                        <h3 class="uppercase">${(moduleParent.name)!}</h3>
                    </li></#if>
                <#list moduleList as module>
                    <#if module.show && (module.type)! == '1' && (module.parentId)! == moduleParent.id >
                        <#assign isChild=false />
                        <#list moduleList as temp><#if temp.show && temp.type == '1' && temp.parentId == module.id ><#assign isChild=true /><#break></#if></#list>
                        <#if module.leaf || !isChild>
                            <li class='nav-item ${(module_index == 0)!?string("start", "")}'>
                                <a href="#${(module.hrefName)! }" data-url-name="${(module.hrefName)! }"
                                   data-url="${ctx }${(module.href)! }" class="nav-link pageModal"
                                   data-target="${(module.target)!}">
                                    <i class="fa ${(module.iconCls)!}"></i>
                                    <span class="title">${(module.name)!}</span>
                                </a>
                            </li>
                        <#else>
                            <li class="nav-item">
                                <a href="javascript:void(0);" class="nav-link nav-toggle">
                                    <i class="fa ${module.iconCls}"></i>
                                    <span class="title">${(module.name)!}</span>
                                    <span class="arrow"></span>
                                </a>
                                <ul class="sub-menu">
                                    <#list moduleList as tempModule>
                                        <#if (module.show)! && (module.type)! == '1' && (tempModule.parentId)! == (module.id)! >
                                            <li class="nav-item start">
                                                <a href="#${(tempModule.hrefName)! }"
                                                   data-url-name="${(tempModule.hrefName)! }"
                                                   data-url="<#if (gatewayModel)! && (tempModule.microservice)??>${basePath}/${tempModule.microservice}${(tempModule.href)! }<#else>${ctx }${(tempModule.href)! }</#if>" class="nav-link pageModal"
                                                   data-target="${(tempModule.target)!}">
                                                    <i class="icon-bar-chart" style="visibility: hidden;"></i>
                                                    <span class="title">${(tempModule.name)!}</span>
                                                </a>
                                            </li>
                                        </#if>
                                    </#list>
                                </ul>
                            </li>
                        </#if></#if>

                </#list>
            </#if>
        </#list>
        </ul>
        <!-- END SIDEBAR MENU -->
    </div>
    <!-- END SIDEBAR -->
</div>