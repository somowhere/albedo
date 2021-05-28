<h1 style="text-align: center">Albedo 3.0.8 - 企业信息化快速开发平台</h1>
 <p align="center">
 
 [![AUR](https://img.shields.io/badge/license-Apache%20License%202.0-blue.svg)](https://github.com/somowhere/albedo/blob/master/LICENSE)
 [![AUR](https://img.shields.io/badge/Spring%20Boot-2.5.0-blue.svg)](https://spring.io/projects/spring-boot#overview)
 [![star](https://gitee.com/somowhere/albedo/badge/star.svg?theme=white)](https://gitee.com/somowhere/albedo)
 [![GitHub stars](https://img.shields.io/github/stars/somowhere/albedo.svg?style=social&label=Stars)](https://github.com/somowhere/albedo)
 [![GitHub forks](https://img.shields.io/github/forks/somowhere/albedo.svg?style=social&label=Fork)](https://github.com/somowhere/albedo)
 
 </p> 
 
- 基于 Spring Boot 、Spring Security、Mybatis 的RBAC权限管理系统  

- 基于数据驱动视图的理念封装 Element-ui，即使没有 vue 的使用经验也能快速上手 
 
- 微服务版本 <a href="https://github.com/somowhere/albedo-cloud">albedo-cloud</a>   

<table>
    <tr>
        <td><img src="https://raw.githubusercontent.com/somowhere/albedo-source/master/albedo/1.png"/></td>
        <td><img src="https://raw.githubusercontent.com/somowhere/albedo-source/master/albedo/2.png"/></td>
    </tr>
    <tr>
        <td><img src="https://raw.githubusercontent.com/somowhere/albedo-source/master/albedo/3.png"/></td>
        <td><img src="https://raw.githubusercontent.com/somowhere/albedo-source/master/albedo/4.png"/></td>
    </tr>
    <tr>
        <td><img src="https://raw.githubusercontent.com/somowhere/albedo-source/master/albedo/5.png"/></td>
        <td><img src="https://raw.githubusercontent.com/somowhere/albedo-source/master/albedo/6.png"/></td>
    </tr>
    <tr>
        <td><img src="https://raw.githubusercontent.com/somowhere/albedo-source/master/albedo/7.png"/></td>
        <td><img src="https://raw.githubusercontent.com/somowhere/albedo-source/master/albedo/8.png"/></td>
    </tr>
    <tr>
        <td><img src="https://raw.githubusercontent.com/somowhere/albedo-source/master/albedo/9.png"/></td>
        <td><img src="https://raw.githubusercontent.com/somowhere/albedo-source/master/albedo/10.png"/></td>
    </tr>
    <tr>
        <td><img src="https://raw.githubusercontent.com/somowhere/albedo-source/master/albedo/11.png"/></td>
        <td></td>
    </tr>
</table>
   
 

#### 核心依赖 


依赖 | 版本
---|---
Spring Boot |  2.5.0 
Mybatis Plus | 3.4.3
hutool | 5.6.5
   


#### 模块说明
```
albedo
├── albedo-ui -- 前端工程[8080]
└── albedo-common -- 系统公共模块 
     ├── albedo-common-api --  服务基础api
     ├── albedo-common-core -- 公共工具类核心包
     ├── albedo-common-module -- 模块基础包
└── albedo-modules -- 功能模块
     ├── albedo-admin -- 通用用户权限管理系统业务处理模块[4000]
     ├── albedo-api -- 接口模块
     ├── albedo-quartz -- 定时任务模块
└── albedo-plugin  -- 插件模块 
     ├── albedo-data-mybatis -- mybatis 基础模块
     └── albedo-swagger-api -- swagger api
	 
```

## 快速搭建

#### 为了能够快速搭建请首先加入maven的阿里云镜像
```
<mirror>
        <id>nexus-aliyun</id>
        <mirrorOf>central</mirrorOf>
        <name>Nexus aliyun</name>
        <url>http://maven.aliyun.com/nexus/content/groups/public</url>
</mirror>
```

1. 具备运行环境：JDK1.8、Maven3.0+、MySql8+或Oracle10g+。
2. 导入ide前，安装lombok插件
3. 运行albedo.sql脚本初始化数据库,修改albedo-admin src\main\resources\config\application-dev.yml文件中的数据库设置参数。
4. 在albedo目录下执行mvn clean install 
5. 在albedo-ui目录下执行 npm run build 生成dist目录
6. 启动redis 127.0.0.1 6379 
7. 最高管理员账号，用户名：admin 密码：111111 
8. IntelliJ IDEA 推荐安装 阿里编码规范插件  [alibaba-java-coding-guidelines](https://plugins.jetbrains.com/plugin/10046-alibaba-java-coding-guidelines)

#### 特别鸣谢

- 感谢 [JetBrains](https://www.jetbrains.com/) 提供的非商业开源软件开发授权
- 感谢
  [jhipster](https://www.jhipster.tech/)  [pig](https://gitee.com/log4j/pig)  [RuoYi](https://gitee.com/y_project/RuoYi)  [eladmin](https://github.com/elunez/eladmin)
  

#### 提交反馈

1. 欢迎提交 issue，请写清楚遇到问题的原因，开发环境，复显步骤。

2. 不接受`功能请求`的 issue，功能请求可能会被直接关闭。  

3. QQ群: 685728393 


#### 项目捐赠

项目的发展离不开您的支持，请作者喝杯咖啡吧☕  

<table>
    <tr>
        <td><img src="https://raw.githubusercontent.com/somowhere/albedo-source/master/albedo/alipay.png"/></td>
        <td><img src="https://raw.githubusercontent.com/somowhere/albedo-source/master/albedo/wxpay.png"/></td>
    </tr>
</table>
 
