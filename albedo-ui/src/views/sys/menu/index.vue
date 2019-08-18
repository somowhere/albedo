<template>
  <div class="app-container calendar-list-container">
    <basic-container>
      <el-row :gutter="20">
        <el-col :span="5"
                style='margin-top:15px;'>
          <el-card class="box-card">
            <div class="clearfix" slot="header">
              <span>菜单</span>
              <el-button @click="searchTree=(searchTree ? false:true)" class="card-heard-btn" icon="icon-filesearch"
                         title="搜索"
                         type="text"></el-button>
              <el-button @click="getTreeMenu()" class="card-heard-btn" icon="icon-reload" title="刷新"
                         type="text"></el-button>
            </div>
            <el-input placeholder="输入关键字进行过滤"
                      v-model="filterTreeMenuText"
                      v-show="searchTree">
            </el-input>
            <el-tree
              :data="treeMenuData"
              :expand-on-click-node="false"
              :filter-node-method="filterNode"
              @node-click="clickNodeTreeData"
              class="filter-tree"
              highlight-current
              node-key="id"
              ref="leftMenuTree">
            </el-tree>
          </el-card>
        </el-col>
        <el-col :span="19">
          <div class="filter-container" v-show="searchFilterVisible">
            <el-form :inline="true" :model="searchForm" ref="searchForm">
              <el-form-item label="名称" prop="name">
                <el-input class="filter-item input-normal" size="small" v-model="searchForm.name"></el-input>
              </el-form-item>
              <el-form-item label="VUE页面" prop="component">
                <el-input class="filter-item input-normal" size="small" v-model="searchForm.component"></el-input>
              </el-form-item>
              <el-form-item>
                <el-button @click="handleFilter" icon="el-icon-search" size="small" type="primary">查询</el-button>
                <el-button @click="searchReset" icon="icon-rest" size="small">重置</el-button>
              </el-form-item>
            </el-form>

          </div>
          <!-- 表格功能列 -->
          <div class="table-menu">
            <div class="table-menu-left">

              <el-button-group>
                <el-button @click="handleEdit" icon="el-icon-plus" size="mini" type="primary" v-if="sys_menu_edit">添加
                </el-button>
                <el-button @click="handleEditSort" icon="icon-up-circle" size="mini" type="primary"
                           v-if="sys_menu_edit">更新序号
                </el-button>
                <el-button @click="handleIcon()" icon="icon-eye" size="mini" type="primary">查看图标</el-button>
              </el-button-group>
            </div>
            <div class="table-menu-right">
              <el-button @click="searchFilterVisible= !searchFilterVisible" circle icon="el-icon-search"
                         size="mini"></el-button>
            </div>
          </div>
          <el-table :data="list" :default-sort="{prop:'menu.sort',order:'ascending'}" :key='tableKey'
                    @sort-change="sortChange" element-loading-text="加载中..."
                    fit highlight-current-row v-loading="listLoading">
            <el-table-column
              fixed="left" type="index" width="20">
            </el-table-column>
            <!--            <el-table-column align="center" label="上级菜单" width="100">-->
            <!--              <template slot-scope="scope">-->
            <!--                <span>{{scope.row.parentName}}</span>-->
            <!--              </template>-->
            <!--            </el-table-column>-->

            <el-table-column align="center" label="名称" prop="menu.name" sortable="custom" width="130">
              <template slot-scope="scope">
                <span>
                  <i :class="scope.row.icon"></i>
                  {{scope.row.name}}
                </span>
              </template>
            </el-table-column>
            <el-table-column align="center" label="菜单类型" width="80">
              <template slot-scope="scope">
                <span>{{scope.row.typeText}}</span>
              </template>
            </el-table-column>
            <el-table-column align="center" label="权限">
              <template slot-scope="scope">
                <span>{{scope.row.permission}}</span>
              </template>
            </el-table-column>
            <el-table-column align="center" label="VUE页面">
              <template slot-scope="scope">
                <span>{{scope.row.component}}</span>
              </template>
            </el-table-column>
            <!--            <el-table-column align="center" label="路由缓冲" width="80">-->
            <!--              <template slot-scope="scope">-->
            <!--                <span>{{scope.row.keepAliveText}}</span>-->
            <!--              </template>-->
            <!--            </el-table-column>-->
            <el-table-column align="center" label="前端URL">
              <template slot-scope="scope">
                <span>{{scope.row.path}}</span>
              </template>
            </el-table-column>

            <el-table-column align="center" label="是否显示" width="80">
              <template slot-scope="scope">
                <el-tag>{{scope.row.showText}}</el-tag>
              </template>
            </el-table-column>
            <el-table-column align="center" label="序号" prop="menu.sort" sortable="custom">
              <template slot-scope="scope">
                <span>
                  <el-input-number :ref="'sort'+scope.row.id" :step="5" size="small"
                                   v-model="scope.row.sort"></el-input-number>
                </span>
              </template>
            </el-table-column>
            <el-table-column align="center" label="创建时间" prop="menu.created_date" sortable="custom">
              <template slot-scope="scope">
                <span>{{scope.row.createdDate}}</span>
              </template>
            </el-table-column>

            <el-table-column align="center" fixed="right" label="操作"
                             v-if="sys_menu_edit || sys_menu_lock || sys_menu_del"
                             width="100">
              <template slot-scope="scope">
                <el-button @click="handleEdit(scope.row)" icon="icon-edit" title="编辑" type="text" v-if="sys_menu_edit">
                </el-button>
                <el-button @click="handleDelete(scope.row)" icon="icon-delete" title="删除" type="text"
                           v-if="sys_menu_del">
                </el-button>
              </template>
            </el-table-column>

          </el-table>
          <div class="pagination-container" v-show="!listLoading">
            <el-pagination :current-page.sync="listQuery.current" :page-size="listQuery.size"
                           :page-sizes="[10,20,30, 50]"
                           :total="total" @current-change="handleCurrentChange"
                           @size-change="handleSizeChange" background
                           class="pull-right" layout="total, sizes, prev, pager, next, jumper">
            </el-pagination>
          </div>
        </el-col>
      </el-row>
      <el-dialog :visible.sync="dialogMenuVisible" title="选择菜单">
        <el-input placeholder="输入关键字进行过滤"
                  v-model="filterParentTreeMenuText">
        </el-input>
        <el-tree :data="treeMenuSelectData" :default-checked-keys="checkedKeys" :filter-node-method="filterNode"
                 @node-click="clickNodeSelectData"
                 check-strictly
                 class="filter-tree" default-expand-all highlight-current node-key="id"
                 ref="selectParentMenuTree">
        </el-tree>
      </el-dialog>

      <el-dialog :visible.sync="dialogIconVisible" title="查看图标">
        <ul class="icon_lists clear">

          <li>
            <i class="icon iconfont icon-xiugaimima"></i>
            <div class="name">修改密码</div>
            <div class="fontclass">.icon-xiugaimima</div>
          </li>

          <li>
            <i class="icon iconfont icon-zhanghuzhongxin"></i>
            <div class="name">账户中心</div>
            <div class="fontclass">.icon-zhanghuzhongxin</div>
          </li>

          <li>
            <i class="icon iconfont icon-check-circle"></i>
            <div class="name">check-circle</div>
            <div class="fontclass">.icon-check-circle</div>
          </li>

          <li>
            <i class="icon iconfont icon-CI"></i>
            <div class="name">CI</div>
            <div class="fontclass">.icon-CI</div>
          </li>

          <li>
            <i class="icon iconfont icon-Dollar"></i>
            <div class="name">Dollar</div>
            <div class="fontclass">.icon-Dollar</div>
          </li>

          <li>
            <i class="icon iconfont icon-compass"></i>
            <div class="name">compass</div>
            <div class="fontclass">.icon-compass</div>
          </li>

          <li>
            <i class="icon iconfont icon-close-circle"></i>
            <div class="name">close-circle</div>
            <div class="fontclass">.icon-close-circle</div>
          </li>

          <li>
            <i class="icon iconfont icon-frown"></i>
            <div class="name">frown</div>
            <div class="fontclass">.icon-frown</div>
          </li>

          <li>
            <i class="icon iconfont icon-info-circle"></i>
            <div class="name">info-circle</div>
            <div class="fontclass">.icon-info-circle</div>
          </li>

          <li>
            <i class="icon iconfont icon-left-circle"></i>
            <div class="name">left-circle</div>
            <div class="fontclass">.icon-left-circle</div>
          </li>

          <li>
            <i class="icon iconfont icon-down-circle"></i>
            <div class="name">down-circle</div>
            <div class="fontclass">.icon-down-circle</div>
          </li>

          <li>
            <i class="icon iconfont icon-EURO"></i>
            <div class="name">EURO</div>
            <div class="fontclass">.icon-EURO</div>
          </li>

          <li>
            <i class="icon iconfont icon-copyright"></i>
            <div class="name">copyright</div>
            <div class="fontclass">.icon-copyright</div>
          </li>

          <li>
            <i class="icon iconfont icon-minus-circle"></i>
            <div class="name">minus-circle</div>
            <div class="fontclass">.icon-minus-circle</div>
          </li>

          <li>
            <i class="icon iconfont icon-meh"></i>
            <div class="name">meh</div>
            <div class="fontclass">.icon-meh</div>
          </li>

          <li>
            <i class="icon iconfont icon-plus-circle"></i>
            <div class="name">plus-circle</div>
            <div class="fontclass">.icon-plus-circle</div>
          </li>

          <li>
            <i class="icon iconfont icon-play-circle"></i>
            <div class="name">play-circle</div>
            <div class="fontclass">.icon-play-circle</div>
          </li>

          <li>
            <i class="icon iconfont icon-question-circle"></i>
            <div class="name">question-circle</div>
            <div class="fontclass">.icon-question-circle</div>
          </li>

          <li>
            <i class="icon iconfont icon-Pound"></i>
            <div class="name">Pound</div>
            <div class="fontclass">.icon-Pound</div>
          </li>

          <li>
            <i class="icon iconfont icon-right-circle"></i>
            <div class="name">right-circle</div>
            <div class="fontclass">.icon-right-circle</div>
          </li>

          <li>
            <i class="icon iconfont icon-smile"></i>
            <div class="name">smile</div>
            <div class="fontclass">.icon-smile</div>
          </li>

          <li>
            <i class="icon iconfont icon-trademark"></i>
            <div class="name">trademark</div>
            <div class="fontclass">.icon-trademark</div>
          </li>

          <li>
            <i class="icon iconfont icon-time-circle"></i>
            <div class="name">time-circle</div>
            <div class="fontclass">.icon-time-circle</div>
          </li>

          <li>
            <i class="icon iconfont icon-timeout"></i>
            <div class="name">time out</div>
            <div class="fontclass">.icon-timeout</div>
          </li>

          <li>
            <i class="icon iconfont icon-earth"></i>
            <div class="name">earth</div>
            <div class="fontclass">.icon-earth</div>
          </li>

          <li>
            <i class="icon iconfont icon-YUAN"></i>
            <div class="name">YUAN</div>
            <div class="fontclass">.icon-YUAN</div>
          </li>

          <li>
            <i class="icon iconfont icon-up-circle"></i>
            <div class="name">up-circle</div>
            <div class="fontclass">.icon-up-circle</div>
          </li>

          <li>
            <i class="icon iconfont icon-warning-circle"></i>
            <div class="name">warning-circle</div>
            <div class="fontclass">.icon-warning-circle</div>
          </li>

          <li>
            <i class="icon iconfont icon-sync"></i>
            <div class="name">sync</div>
            <div class="fontclass">.icon-sync</div>
          </li>

          <li>
            <i class="icon iconfont icon-transaction"></i>
            <div class="name">transaction</div>
            <div class="fontclass">.icon-transaction</div>
          </li>

          <li>
            <i class="icon iconfont icon-undo"></i>
            <div class="name">undo</div>
            <div class="fontclass">.icon-undo</div>
          </li>

          <li>
            <i class="icon iconfont icon-redo"></i>
            <div class="name">redo</div>
            <div class="fontclass">.icon-redo</div>
          </li>

          <li>
            <i class="icon iconfont icon-reload"></i>
            <div class="name">reload</div>
            <div class="fontclass">.icon-reload</div>
          </li>

          <li>
            <i class="icon iconfont icon-reloadtime"></i>
            <div class="name">reload time</div>
            <div class="fontclass">.icon-reloadtime</div>
          </li>

          <li>
            <i class="icon iconfont icon-message"></i>
            <div class="name">message</div>
            <div class="fontclass">.icon-message</div>
          </li>

          <li>
            <i class="icon iconfont icon-dashboard"></i>
            <div class="name">dashboard</div>
            <div class="fontclass">.icon-dashboard</div>
          </li>

          <li>
            <i class="icon iconfont icon-issuesclose"></i>
            <div class="name">issues close</div>
            <div class="fontclass">.icon-issuesclose</div>
          </li>

          <li>
            <i class="icon iconfont icon-poweroff"></i>
            <div class="name">poweroff</div>
            <div class="fontclass">.icon-poweroff</div>
          </li>

          <li>
            <i class="icon iconfont icon-logout"></i>
            <div class="name">logout</div>
            <div class="fontclass">.icon-logout</div>
          </li>

          <li>
            <i class="icon iconfont icon-login"></i>
            <div class="name">login</div>
            <div class="fontclass">.icon-login</div>
          </li>

          <li>
            <i class="icon iconfont icon-piechart"></i>
            <div class="name">pie chart</div>
            <div class="fontclass">.icon-piechart</div>
          </li>

          <li>
            <i class="icon iconfont icon-setting"></i>
            <div class="name">setting</div>
            <div class="fontclass">.icon-setting</div>
          </li>

          <li>
            <i class="icon iconfont icon-eye"></i>
            <div class="name">eye</div>
            <div class="fontclass">.icon-eye</div>
          </li>

          <li>
            <i class="icon iconfont icon-location"></i>
            <div class="name">location</div>
            <div class="fontclass">.icon-location</div>
          </li>

          <li>
            <i class="icon iconfont icon-edit-square"></i>
            <div class="name">edit-square</div>
            <div class="fontclass">.icon-edit-square</div>
          </li>

          <li>
            <i class="icon iconfont icon-export"></i>
            <div class="name">export</div>
            <div class="fontclass">.icon-export</div>
          </li>

          <li>
            <i class="icon iconfont icon-save"></i>
            <div class="name">save</div>
            <div class="fontclass">.icon-save</div>
          </li>

          <li>
            <i class="icon iconfont icon-Import"></i>
            <div class="name">Import</div>
            <div class="fontclass">.icon-Import</div>
          </li>

          <li>
            <i class="icon iconfont icon-appstore"></i>
            <div class="name">app store</div>
            <div class="fontclass">.icon-appstore</div>
          </li>

          <li>
            <i class="icon iconfont icon-close-square"></i>
            <div class="name">close-square</div>
            <div class="fontclass">.icon-close-square</div>
          </li>

          <li>
            <i class="icon iconfont icon-down-square"></i>
            <div class="name">down-square</div>
            <div class="fontclass">.icon-down-square</div>
          </li>

          <li>
            <i class="icon iconfont icon-layout"></i>
            <div class="name">layout</div>
            <div class="fontclass">.icon-layout</div>
          </li>

          <li>
            <i class="icon iconfont icon-left-square"></i>
            <div class="name">left-square</div>
            <div class="fontclass">.icon-left-square</div>
          </li>

          <li>
            <i class="icon iconfont icon-play-square"></i>
            <div class="name">play-square</div>
            <div class="fontclass">.icon-play-square</div>
          </li>

          <li>
            <i class="icon iconfont icon-control"></i>
            <div class="name">control</div>
            <div class="fontclass">.icon-control</div>
          </li>

          <li>
            <i class="icon iconfont icon-codelibrary"></i>
            <div class="name">code library</div>
            <div class="fontclass">.icon-codelibrary</div>
          </li>

          <li>
            <i class="icon iconfont icon-detail"></i>
            <div class="name">detail</div>
            <div class="fontclass">.icon-detail</div>
          </li>

          <li>
            <i class="icon iconfont icon-minus-square"></i>
            <div class="name">minus-square</div>
            <div class="fontclass">.icon-minus-square</div>
          </li>

          <li>
            <i class="icon iconfont icon-plus-square"></i>
            <div class="name">plus-square</div>
            <div class="fontclass">.icon-plus-square</div>
          </li>

          <li>
            <i class="icon iconfont icon-right-square"></i>
            <div class="name">right-square</div>
            <div class="fontclass">.icon-right-square</div>
          </li>

          <li>
            <i class="icon iconfont icon-project"></i>
            <div class="name">project</div>
            <div class="fontclass">.icon-project</div>
          </li>

          <li>
            <i class="icon iconfont icon-wallet"></i>
            <div class="name">wallet</div>
            <div class="fontclass">.icon-wallet</div>
          </li>

          <li>
            <i class="icon iconfont icon-up-square"></i>
            <div class="name">up-square</div>
            <div class="fontclass">.icon-up-square</div>
          </li>

          <li>
            <i class="icon iconfont icon-calculator"></i>
            <div class="name">calculator</div>
            <div class="fontclass">.icon-calculator</div>
          </li>

          <li>
            <i class="icon iconfont icon-interation"></i>
            <div class="name">interation</div>
            <div class="fontclass">.icon-interation</div>
          </li>

          <li>
            <i class="icon iconfont icon-check-square"></i>
            <div class="name">check-square</div>
            <div class="fontclass">.icon-check-square</div>
          </li>

          <li>
            <i class="icon iconfont icon-border"></i>
            <div class="name">border</div>
            <div class="fontclass">.icon-border</div>
          </li>

          <li>
            <i class="icon iconfont icon-border-outer"></i>
            <div class="name">border-outer</div>
            <div class="fontclass">.icon-border-outer</div>
          </li>

          <li>
            <i class="icon iconfont icon-border-top"></i>
            <div class="name">border-top</div>
            <div class="fontclass">.icon-border-top</div>
          </li>

          <li>
            <i class="icon iconfont icon-border-bottom"></i>
            <div class="name">border-bottom</div>
            <div class="fontclass">.icon-border-bottom</div>
          </li>

          <li>
            <i class="icon iconfont icon-border-left"></i>
            <div class="name">border-left</div>
            <div class="fontclass">.icon-border-left</div>
          </li>

          <li>
            <i class="icon iconfont icon-border-right"></i>
            <div class="name">border-right</div>
            <div class="fontclass">.icon-border-right</div>
          </li>

          <li>
            <i class="icon iconfont icon-border-inner"></i>
            <div class="name">border-inner</div>
            <div class="fontclass">.icon-border-inner</div>
          </li>

          <li>
            <i class="icon iconfont icon-border-verticle"></i>
            <div class="name">border-verticle</div>
            <div class="fontclass">.icon-border-verticle</div>
          </li>

          <li>
            <i class="icon iconfont icon-border-horizontal"></i>
            <div class="name">border-horizontal</div>
            <div class="fontclass">.icon-border-horizontal</div>
          </li>

          <li>
            <i class="icon iconfont icon-radius-bottomleft"></i>
            <div class="name">radius-bottomleft</div>
            <div class="fontclass">.icon-radius-bottomleft</div>
          </li>

          <li>
            <i class="icon iconfont icon-radius-bottomright"></i>
            <div class="name">radius-bottomright</div>
            <div class="fontclass">.icon-radius-bottomright</div>
          </li>

          <li>
            <i class="icon iconfont icon-radius-upleft"></i>
            <div class="name">radius-upleft</div>
            <div class="fontclass">.icon-radius-upleft</div>
          </li>

          <li>
            <i class="icon iconfont icon-radius-upright"></i>
            <div class="name">radius-upright</div>
            <div class="fontclass">.icon-radius-upright</div>
          </li>

          <li>
            <i class="icon iconfont icon-radius-setting"></i>
            <div class="name">radius-setting</div>
            <div class="fontclass">.icon-radius-setting</div>
          </li>

          <li>
            <i class="icon iconfont icon-adduser"></i>
            <div class="name">add user</div>
            <div class="fontclass">.icon-adduser</div>
          </li>

          <li>
            <i class="icon iconfont icon-deleteteam"></i>
            <div class="name">delete team</div>
            <div class="fontclass">.icon-deleteteam</div>
          </li>

          <li>
            <i class="icon iconfont icon-deleteuser"></i>
            <div class="name">delete user</div>
            <div class="fontclass">.icon-deleteuser</div>
          </li>

          <li>
            <i class="icon iconfont icon-addteam"></i>
            <div class="name">addteam</div>
            <div class="fontclass">.icon-addteam</div>
          </li>

          <li>
            <i class="icon iconfont icon-user"></i>
            <div class="name">user</div>
            <div class="fontclass">.icon-user</div>
          </li>

          <li>
            <i class="icon iconfont icon-team"></i>
            <div class="name">team</div>
            <div class="fontclass">.icon-team</div>
          </li>

          <li>
            <i class="icon iconfont icon-areachart"></i>
            <div class="name">area chart</div>
            <div class="fontclass">.icon-areachart</div>
          </li>

          <li>
            <i class="icon iconfont icon-linechart"></i>
            <div class="name">line chart</div>
            <div class="fontclass">.icon-linechart</div>
          </li>

          <li>
            <i class="icon iconfont icon-barchart"></i>
            <div class="name">bar chart</div>
            <div class="fontclass">.icon-barchart</div>
          </li>

          <li>
            <i class="icon iconfont icon-pointmap"></i>
            <div class="name">point map</div>
            <div class="fontclass">.icon-pointmap</div>
          </li>

          <li>
            <i class="icon iconfont icon-container"></i>
            <div class="name">container</div>
            <div class="fontclass">.icon-container</div>
          </li>

          <li>
            <i class="icon iconfont icon-database"></i>
            <div class="name">database</div>
            <div class="fontclass">.icon-database</div>
          </li>

          <li>
            <i class="icon iconfont icon-sever"></i>
            <div class="name">sever</div>
            <div class="fontclass">.icon-sever</div>
          </li>

          <li>
            <i class="icon iconfont icon-mobile"></i>
            <div class="name">mobile</div>
            <div class="fontclass">.icon-mobile</div>
          </li>

          <li>
            <i class="icon iconfont icon-tablet"></i>
            <div class="name">tablet</div>
            <div class="fontclass">.icon-tablet</div>
          </li>

          <li>
            <i class="icon iconfont icon-redenvelope"></i>
            <div class="name">red envelope</div>
            <div class="fontclass">.icon-redenvelope</div>
          </li>

          <li>
            <i class="icon iconfont icon-book"></i>
            <div class="name">book</div>
            <div class="fontclass">.icon-book</div>
          </li>

          <li>
            <i class="icon iconfont icon-filedone"></i>
            <div class="name">file done</div>
            <div class="fontclass">.icon-filedone</div>
          </li>

          <li>
            <i class="icon iconfont icon-reconciliation"></i>
            <div class="name">reconciliation</div>
            <div class="fontclass">.icon-reconciliation</div>
          </li>

          <li>
            <i class="icon iconfont icon-file-exception"></i>
            <div class="name">file -exception</div>
            <div class="fontclass">.icon-file-exception</div>
          </li>

          <li>
            <i class="icon iconfont icon-filesync"></i>
            <div class="name">file sync</div>
            <div class="fontclass">.icon-filesync</div>
          </li>

          <li>
            <i class="icon iconfont icon-filesearch"></i>
            <div class="name">file search</div>
            <div class="fontclass">.icon-filesearch</div>
          </li>

          <li>
            <i class="icon iconfont icon-solution"></i>
            <div class="name">solution</div>
            <div class="fontclass">.icon-solution</div>
          </li>

          <li>
            <i class="icon iconfont icon-fileprotect"></i>
            <div class="name">file protect</div>
            <div class="fontclass">.icon-fileprotect</div>
          </li>

          <li>
            <i class="icon iconfont icon-file-add"></i>
            <div class="name">file-add</div>
            <div class="fontclass">.icon-file-add</div>
          </li>

          <li>
            <i class="icon iconfont icon-file-excelField"></i>
            <div class="name">file-excelField</div>
            <div class="fontclass">.icon-file-excelField</div>
          </li>

          <li>
            <i class="icon iconfont icon-file-exclamation"></i>
            <div class="name">file-exclamation</div>
            <div class="fontclass">.icon-file-exclamation</div>
          </li>

          <li>
            <i class="icon iconfont icon-file-pdf"></i>
            <div class="name">file-pdf</div>
            <div class="fontclass">.icon-file-pdf</div>
          </li>

          <li>
            <i class="icon iconfont icon-file-image"></i>
            <div class="name">file-image</div>
            <div class="fontclass">.icon-file-image</div>
          </li>

          <li>
            <i class="icon iconfont icon-file-markdown"></i>
            <div class="name">file-markdown</div>
            <div class="fontclass">.icon-file-markdown</div>
          </li>

          <li>
            <i class="icon iconfont icon-file-unknown"></i>
            <div class="name">file-unknown</div>
            <div class="fontclass">.icon-file-unknown</div>
          </li>

          <li>
            <i class="icon iconfont icon-file-ppt"></i>
            <div class="name">file-ppt</div>
            <div class="fontclass">.icon-file-ppt</div>
          </li>

          <li>
            <i class="icon iconfont icon-file-word"></i>
            <div class="name">file-word</div>
            <div class="fontclass">.icon-file-word</div>
          </li>

          <li>
            <i class="icon iconfont icon-file"></i>
            <div class="name">file</div>
            <div class="fontclass">.icon-file</div>
          </li>

          <li>
            <i class="icon iconfont icon-file-zip"></i>
            <div class="name">file-zip</div>
            <div class="fontclass">.icon-file-zip</div>
          </li>

          <li>
            <i class="icon iconfont icon-file-text"></i>
            <div class="name">file-text</div>
            <div class="fontclass">.icon-file-text</div>
          </li>

          <li>
            <i class="icon iconfont icon-file-copy"></i>
            <div class="name">file-copy</div>
            <div class="fontclass">.icon-file-copy</div>
          </li>

          <li>
            <i class="icon iconfont icon-snippets"></i>
            <div class="name">snippets</div>
            <div class="fontclass">.icon-snippets</div>
          </li>

          <li>
            <i class="icon iconfont icon-audit"></i>
            <div class="name">audit</div>
            <div class="fontclass">.icon-audit</div>
          </li>

          <li>
            <i class="icon iconfont icon-diff"></i>
            <div class="name">diff</div>
            <div class="fontclass">.icon-diff</div>
          </li>

          <li>
            <i class="icon iconfont icon-Batchfolding"></i>
            <div class="name">Batch folding</div>
            <div class="fontclass">.icon-Batchfolding</div>
          </li>

          <li>
            <i class="icon iconfont icon-securityscan"></i>
            <div class="name">security scan</div>
            <div class="fontclass">.icon-securityscan</div>
          </li>

          <li>
            <i class="icon iconfont icon-propertysafety"></i>
            <div class="name">property safety</div>
            <div class="fontclass">.icon-propertysafety</div>
          </li>

          <li>
            <i class="icon iconfont icon-safetycertificate"></i>
            <div class="name">safety certificate</div>
            <div class="fontclass">.icon-safetycertificate</div>
          </li>

          <li>
            <i class="icon iconfont icon-insurance"></i>
            <div class="name">insurance</div>
            <div class="fontclass">.icon-insurance</div>
          </li>

          <li>
            <i class="icon iconfont icon-alert"></i>
            <div class="name">alert</div>
            <div class="fontclass">.icon-alert</div>
          </li>

          <li>
            <i class="icon iconfont icon-delete"></i>
            <div class="name">delete</div>
            <div class="fontclass">.icon-delete</div>
          </li>

          <li>
            <i class="icon iconfont icon-hourglass"></i>
            <div class="name">hourglass</div>
            <div class="fontclass">.icon-hourglass</div>
          </li>

          <li>
            <i class="icon iconfont icon-bulb"></i>
            <div class="name">bulb</div>
            <div class="fontclass">.icon-bulb</div>
          </li>

          <li>
            <i class="icon iconfont icon-experiment"></i>
            <div class="name">experiment</div>
            <div class="fontclass">.icon-experiment</div>
          </li>

          <li>
            <i class="icon iconfont icon-bell"></i>
            <div class="name">bell</div>
            <div class="fontclass">.icon-bell</div>
          </li>

          <li>
            <i class="icon iconfont icon-trophy"></i>
            <div class="name">trophy</div>
            <div class="fontclass">.icon-trophy</div>
          </li>

          <li>
            <i class="icon iconfont icon-rest"></i>
            <div class="name">rest</div>
            <div class="fontclass">.icon-rest</div>
          </li>

          <li>
            <i class="icon iconfont icon-USB"></i>
            <div class="name">USB</div>
            <div class="fontclass">.icon-USB</div>
          </li>

          <li>
            <i class="icon iconfont icon-skin"></i>
            <div class="name">skin</div>
            <div class="fontclass">.icon-skin</div>
          </li>

          <li>
            <i class="icon iconfont icon-home"></i>
            <div class="name">home</div>
            <div class="fontclass">.icon-home</div>
          </li>

          <li>
            <i class="icon iconfont icon-bank"></i>
            <div class="name">bank</div>
            <div class="fontclass">.icon-bank</div>
          </li>

          <li>
            <i class="icon iconfont icon-filter"></i>
            <div class="name">filter</div>
            <div class="fontclass">.icon-filter</div>
          </li>

          <li>
            <i class="icon iconfont icon-funnelplot"></i>
            <div class="name">funnel plot</div>
            <div class="fontclass">.icon-funnelplot</div>
          </li>

          <li>
            <i class="icon iconfont icon-like"></i>
            <div class="name">like</div>
            <div class="fontclass">.icon-like</div>
          </li>

          <li>
            <i class="icon iconfont icon-unlike"></i>
            <div class="name">unlike</div>
            <div class="fontclass">.icon-unlike</div>
          </li>

          <li>
            <i class="icon iconfont icon-unlock"></i>
            <div class="name">unlock</div>
            <div class="fontclass">.icon-unlock</div>
          </li>

          <li>
            <i class="icon iconfont icon-lock"></i>
            <div class="name">lock</div>
            <div class="fontclass">.icon-lock</div>
          </li>

          <li>
            <i class="icon iconfont icon-customerservice"></i>
            <div class="name">customerservice</div>
            <div class="fontclass">.icon-customerservice</div>
          </li>

          <li>
            <i class="icon iconfont icon-flag"></i>
            <div class="name">flag</div>
            <div class="fontclass">.icon-flag</div>
          </li>

          <li>
            <i class="icon iconfont icon-moneycollect"></i>
            <div class="name">money collect</div>
            <div class="fontclass">.icon-moneycollect</div>
          </li>

          <li>
            <i class="icon iconfont icon-medicinebox"></i>
            <div class="name">medicinebox</div>
            <div class="fontclass">.icon-medicinebox</div>
          </li>

          <li>
            <i class="icon iconfont icon-shop"></i>
            <div class="name">shop</div>
            <div class="fontclass">.icon-shop</div>
          </li>

          <li>
            <i class="icon iconfont icon-rocket"></i>
            <div class="name">rocket</div>
            <div class="fontclass">.icon-rocket</div>
          </li>

          <li>
            <i class="icon iconfont icon-shopping"></i>
            <div class="name">shopping</div>
            <div class="fontclass">.icon-shopping</div>
          </li>

          <li>
            <i class="icon iconfont icon-folder"></i>
            <div class="name">folder</div>
            <div class="fontclass">.icon-folder</div>
          </li>

          <li>
            <i class="icon iconfont icon-folder-open"></i>
            <div class="name">folder-open</div>
            <div class="fontclass">.icon-folder-open</div>
          </li>

          <li>
            <i class="icon iconfont icon-folder-add"></i>
            <div class="name">folder-add</div>
            <div class="fontclass">.icon-folder-add</div>
          </li>

          <li>
            <i class="icon iconfont icon-deploymentunit"></i>
            <div class="name">deployment unit</div>
            <div class="fontclass">.icon-deploymentunit</div>
          </li>

          <li>
            <i class="icon iconfont icon-accountbook"></i>
            <div class="name">account book</div>
            <div class="fontclass">.icon-accountbook</div>
          </li>

          <li>
            <i class="icon iconfont icon-contacts"></i>
            <div class="name">contacts</div>
            <div class="fontclass">.icon-contacts</div>
          </li>

          <li>
            <i class="icon iconfont icon-carryout"></i>
            <div class="name">carry out</div>
            <div class="fontclass">.icon-carryout</div>
          </li>

          <li>
            <i class="icon iconfont icon-calendar-check"></i>
            <div class="name">calendar-check</div>
            <div class="fontclass">.icon-calendar-check</div>
          </li>

          <li>
            <i class="icon iconfont icon-calendar"></i>
            <div class="name">calendar</div>
            <div class="fontclass">.icon-calendar</div>
          </li>

          <li>
            <i class="icon iconfont icon-scan"></i>
            <div class="name">scan</div>
            <div class="fontclass">.icon-scan</div>
          </li>

          <li>
            <i class="icon iconfont icon-select"></i>
            <div class="name">select</div>
            <div class="fontclass">.icon-select</div>
          </li>

          <li>
            <i class="icon iconfont icon-boxplot"></i>
            <div class="name">box plot</div>
            <div class="fontclass">.icon-boxplot</div>
          </li>

          <li>
            <i class="icon iconfont icon-build"></i>
            <div class="name">build</div>
            <div class="fontclass">.icon-build</div>
          </li>

          <li>
            <i class="icon iconfont icon-sliders"></i>
            <div class="name">sliders</div>
            <div class="fontclass">.icon-sliders</div>
          </li>

          <li>
            <i class="icon iconfont icon-laptop"></i>
            <div class="name">laptop</div>
            <div class="fontclass">.icon-laptop</div>
          </li>

          <li>
            <i class="icon iconfont icon-barcode"></i>
            <div class="name">barcode</div>
            <div class="fontclass">.icon-barcode</div>
          </li>

          <li>
            <i class="icon iconfont icon-camera"></i>
            <div class="name">camera</div>
            <div class="fontclass">.icon-camera</div>
          </li>

          <li>
            <i class="icon iconfont icon-cluster"></i>
            <div class="name">cluster</div>
            <div class="fontclass">.icon-cluster</div>
          </li>

          <li>
            <i class="icon iconfont icon-gateway"></i>
            <div class="name">gateway</div>
            <div class="fontclass">.icon-gateway</div>
          </li>

          <li>
            <i class="icon iconfont icon-car"></i>
            <div class="name">car</div>
            <div class="fontclass">.icon-car</div>
          </li>

          <li>
            <i class="icon iconfont icon-printer"></i>
            <div class="name">printer</div>
            <div class="fontclass">.icon-printer</div>
          </li>

          <li>
            <i class="icon iconfont icon-read"></i>
            <div class="name">read</div>
            <div class="fontclass">.icon-read</div>
          </li>

          <li>
            <i class="icon iconfont icon-cloud-server"></i>
            <div class="name">cloud-server</div>
            <div class="fontclass">.icon-cloud-server</div>
          </li>

          <li>
            <i class="icon iconfont icon-cloud-upload"></i>
            <div class="name">cloud-upload</div>
            <div class="fontclass">.icon-cloud-upload</div>
          </li>

          <li>
            <i class="icon iconfont icon-cloud"></i>
            <div class="name">cloud</div>
            <div class="fontclass">.icon-cloud</div>
          </li>

          <li>
            <i class="icon iconfont icon-cloud-download"></i>
            <div class="name">cloud-download</div>
            <div class="fontclass">.icon-cloud-download</div>
          </li>

          <li>
            <i class="icon iconfont icon-cloud-sync"></i>
            <div class="name">cloud-sync</div>
            <div class="fontclass">.icon-cloud-sync</div>
          </li>

          <li>
            <i class="icon iconfont icon-video"></i>
            <div class="name">video</div>
            <div class="fontclass">.icon-video</div>
          </li>

          <li>
            <i class="icon iconfont icon-notification"></i>
            <div class="name">notification</div>
            <div class="fontclass">.icon-notification</div>
          </li>

          <li>
            <i class="icon iconfont icon-sound"></i>
            <div class="name">sound</div>
            <div class="fontclass">.icon-sound</div>
          </li>

          <li>
            <i class="icon iconfont icon-radarchart"></i>
            <div class="name">radar chart</div>
            <div class="fontclass">.icon-radarchart</div>
          </li>

          <li>
            <i class="icon iconfont icon-qrcode"></i>
            <div class="name">qrcode</div>
            <div class="fontclass">.icon-qrcode</div>
          </li>

          <li>
            <i class="icon iconfont icon-fund"></i>
            <div class="name">fund</div>
            <div class="fontclass">.icon-fund</div>
          </li>

          <li>
            <i class="icon iconfont icon-image"></i>
            <div class="name">image</div>
            <div class="fontclass">.icon-image</div>
          </li>

          <li>
            <i class="icon iconfont icon-mail"></i>
            <div class="name">mail</div>
            <div class="fontclass">.icon-mail</div>
          </li>

          <li>
            <i class="icon iconfont icon-table"></i>
            <div class="name">table</div>
            <div class="fontclass">.icon-table</div>
          </li>

          <li>
            <i class="icon iconfont icon-idcard"></i>
            <div class="name">id card</div>
            <div class="fontclass">.icon-idcard</div>
          </li>

          <li>
            <i class="icon iconfont icon-creditcard"></i>
            <div class="name">credit card</div>
            <div class="fontclass">.icon-creditcard</div>
          </li>

          <li>
            <i class="icon iconfont icon-heart"></i>
            <div class="name">heart</div>
            <div class="fontclass">.icon-heart</div>
          </li>

          <li>
            <i class="icon iconfont icon-block"></i>
            <div class="name">block</div>
            <div class="fontclass">.icon-block</div>
          </li>

          <li>
            <i class="icon iconfont icon-error"></i>
            <div class="name">error</div>
            <div class="fontclass">.icon-error</div>
          </li>

          <li>
            <i class="icon iconfont icon-star"></i>
            <div class="name">star</div>
            <div class="fontclass">.icon-star</div>
          </li>

          <li>
            <i class="icon iconfont icon-gold"></i>
            <div class="name">gold</div>
            <div class="fontclass">.icon-gold</div>
          </li>

          <li>
            <i class="icon iconfont icon-heatmap"></i>
            <div class="name">heat map</div>
            <div class="fontclass">.icon-heatmap</div>
          </li>

          <li>
            <i class="icon iconfont icon-wifi"></i>
            <div class="name">wifi</div>
            <div class="fontclass">.icon-wifi</div>
          </li>

          <li>
            <i class="icon iconfont icon-attachment"></i>
            <div class="name">attachment</div>
            <div class="fontclass">.icon-attachment</div>
          </li>

          <li>
            <i class="icon iconfont icon-edit"></i>
            <div class="name">edit</div>
            <div class="fontclass">.icon-edit</div>
          </li>

          <li>
            <i class="icon iconfont icon-key"></i>
            <div class="name">key</div>
            <div class="fontclass">.icon-key</div>
          </li>

          <li>
            <i class="icon iconfont icon-api"></i>
            <div class="name">api</div>
            <div class="fontclass">.icon-api</div>
          </li>

          <li>
            <i class="icon iconfont icon-disconnect"></i>
            <div class="name">disconnect</div>
            <div class="fontclass">.icon-disconnect</div>
          </li>

          <li>
            <i class="icon iconfont icon-highlight"></i>
            <div class="name">highlight</div>
            <div class="fontclass">.icon-highlight</div>
          </li>

          <li>
            <i class="icon iconfont icon-monitor"></i>
            <div class="name">monitor</div>
            <div class="fontclass">.icon-monitor</div>
          </li>

          <li>
            <i class="icon iconfont icon-link"></i>
            <div class="name">link</div>
            <div class="fontclass">.icon-link</div>
          </li>

          <li>
            <i class="icon iconfont icon-man"></i>
            <div class="name">man</div>
            <div class="fontclass">.icon-man</div>
          </li>

          <li>
            <i class="icon iconfont icon-percentage"></i>
            <div class="name">percentage</div>
            <div class="fontclass">.icon-percentage</div>
          </li>

          <li>
            <i class="icon iconfont icon-search"></i>
            <div class="name">search</div>
            <div class="fontclass">.icon-search</div>
          </li>

          <li>
            <i class="icon iconfont icon-pushpin"></i>
            <div class="name">pushpin</div>
            <div class="fontclass">.icon-pushpin</div>
          </li>

          <li>
            <i class="icon iconfont icon-phone"></i>
            <div class="name">phone</div>
            <div class="fontclass">.icon-phone</div>
          </li>

          <li>
            <i class="icon iconfont icon-shake"></i>
            <div class="name">shake</div>
            <div class="fontclass">.icon-shake</div>
          </li>

          <li>
            <i class="icon iconfont icon-tag"></i>
            <div class="name">tag</div>
            <div class="fontclass">.icon-tag</div>
          </li>

          <li>
            <i class="icon iconfont icon-wrench"></i>
            <div class="name">wrench</div>
            <div class="fontclass">.icon-wrench</div>
          </li>

          <li>
            <i class="icon iconfont icon-woman"></i>
            <div class="name">woman</div>
            <div class="fontclass">.icon-woman</div>
          </li>

          <li>
            <i class="icon iconfont icon-tags"></i>
            <div class="name">tags</div>
            <div class="fontclass">.icon-tags</div>
          </li>

          <li>
            <i class="icon iconfont icon-scissor"></i>
            <div class="name">scissor</div>
            <div class="fontclass">.icon-scissor</div>
          </li>

          <li>
            <i class="icon iconfont icon-mr"></i>
            <div class="name">mr</div>
            <div class="fontclass">.icon-mr</div>
          </li>

          <li>
            <i class="icon iconfont icon-share"></i>
            <div class="name">share</div>
            <div class="fontclass">.icon-share</div>
          </li>

          <li>
            <i class="icon iconfont icon-branches"></i>
            <div class="name">branches</div>
            <div class="fontclass">.icon-branches</div>
          </li>

          <li>
            <i class="icon iconfont icon-fork"></i>
            <div class="name">fork</div>
            <div class="fontclass">.icon-fork</div>
          </li>

          <li>
            <i class="icon iconfont icon-shrink"></i>
            <div class="name">shrink</div>
            <div class="fontclass">.icon-shrink</div>
          </li>

          <li>
            <i class="icon iconfont icon-arrawsalt"></i>
            <div class="name">arrawsalt</div>
            <div class="fontclass">.icon-arrawsalt</div>
          </li>

          <li>
            <i class="icon iconfont icon-verticalright"></i>
            <div class="name">vertical right</div>
            <div class="fontclass">.icon-verticalright</div>
          </li>

          <li>
            <i class="icon iconfont icon-verticalleft"></i>
            <div class="name">vertical left</div>
            <div class="fontclass">.icon-verticalleft</div>
          </li>

          <li>
            <i class="icon iconfont icon-right"></i>
            <div class="name">right</div>
            <div class="fontclass">.icon-right</div>
          </li>

          <li>
            <i class="icon iconfont icon-left"></i>
            <div class="name">left</div>
            <div class="fontclass">.icon-left</div>
          </li>

          <li>
            <i class="icon iconfont icon-up"></i>
            <div class="name">up</div>
            <div class="fontclass">.icon-up</div>
          </li>

          <li>
            <i class="icon iconfont icon-down"></i>
            <div class="name">down</div>
            <div class="fontclass">.icon-down</div>
          </li>

          <li>
            <i class="icon iconfont icon-fullscreen"></i>
            <div class="name">fullscreen</div>
            <div class="fontclass">.icon-fullscreen</div>
          </li>

          <li>
            <i class="icon iconfont icon-fullscreen-exit"></i>
            <div class="name">fullscreen-exit</div>
            <div class="fontclass">.icon-fullscreen-exit</div>
          </li>

          <li>
            <i class="icon iconfont icon-doubleleft"></i>
            <div class="name">doubleleft</div>
            <div class="fontclass">.icon-doubleleft</div>
          </li>

          <li>
            <i class="icon iconfont icon-doubleright"></i>
            <div class="name">double right</div>
            <div class="fontclass">.icon-doubleright</div>
          </li>

          <li>
            <i class="icon iconfont icon-arrowright"></i>
            <div class="name">arrowright</div>
            <div class="fontclass">.icon-arrowright</div>
          </li>

          <li>
            <i class="icon iconfont icon-arrowup"></i>
            <div class="name">arrowup</div>
            <div class="fontclass">.icon-arrowup</div>
          </li>

          <li>
            <i class="icon iconfont icon-arrowleft"></i>
            <div class="name">arrowleft</div>
            <div class="fontclass">.icon-arrowleft</div>
          </li>

          <li>
            <i class="icon iconfont icon-arrowdown"></i>
            <div class="name">arrowdown</div>
            <div class="fontclass">.icon-arrowdown</div>
          </li>

          <li>
            <i class="icon iconfont icon-upload"></i>
            <div class="name">upload</div>
            <div class="fontclass">.icon-upload</div>
          </li>

          <li>
            <i class="icon iconfont icon-colum-height"></i>
            <div class="name">colum-height</div>
            <div class="fontclass">.icon-colum-height</div>
          </li>

          <li>
            <i class="icon iconfont icon-vertical-align-botto"></i>
            <div class="name">vertical-align-botto</div>
            <div class="fontclass">.icon-vertical-align-botto</div>
          </li>

          <li>
            <i class="icon iconfont icon-vertical-align-middl"></i>
            <div class="name">vertical-align-middl</div>
            <div class="fontclass">.icon-vertical-align-middl</div>
          </li>

          <li>
            <i class="icon iconfont icon-totop"></i>
            <div class="name">totop</div>
            <div class="fontclass">.icon-totop</div>
          </li>

          <li>
            <i class="icon iconfont icon-vertical-align-top"></i>
            <div class="name">vertical-align-top</div>
            <div class="fontclass">.icon-vertical-align-top</div>
          </li>

          <li>
            <i class="icon iconfont icon-download"></i>
            <div class="name">download</div>
            <div class="fontclass">.icon-download</div>
          </li>

          <li>
            <i class="icon iconfont icon-sort-descending"></i>
            <div class="name">sort-descending</div>
            <div class="fontclass">.icon-sort-descending</div>
          </li>

          <li>
            <i class="icon iconfont icon-sort-ascending"></i>
            <div class="name">sort-ascending</div>
            <div class="fontclass">.icon-sort-ascending</div>
          </li>

          <li>
            <i class="icon iconfont icon-fall"></i>
            <div class="name">fall</div>
            <div class="fontclass">.icon-fall</div>
          </li>

          <li>
            <i class="icon iconfont icon-swap"></i>
            <div class="name">swap</div>
            <div class="fontclass">.icon-swap</div>
          </li>

          <li>
            <i class="icon iconfont icon-stock"></i>
            <div class="name">stock</div>
            <div class="fontclass">.icon-stock</div>
          </li>

          <li>
            <i class="icon iconfont icon-rise"></i>
            <div class="name">rise</div>
            <div class="fontclass">.icon-rise</div>
          </li>

          <li>
            <i class="icon iconfont icon-indent"></i>
            <div class="name">indent</div>
            <div class="fontclass">.icon-indent</div>
          </li>

          <li>
            <i class="icon iconfont icon-outdent"></i>
            <div class="name">outdent</div>
            <div class="fontclass">.icon-outdent</div>
          </li>

          <li>
            <i class="icon iconfont icon-menu"></i>
            <div class="name">menu</div>
            <div class="fontclass">.icon-menu</div>
          </li>

          <li>
            <i class="icon iconfont icon-unorderedlist"></i>
            <div class="name">unordered list</div>
            <div class="fontclass">.icon-unorderedlist</div>
          </li>

          <li>
            <i class="icon iconfont icon-orderedlist"></i>
            <div class="name">ordered list</div>
            <div class="fontclass">.icon-orderedlist</div>
          </li>

          <li>
            <i class="icon iconfont icon-align-right"></i>
            <div class="name">align-right</div>
            <div class="fontclass">.icon-align-right</div>
          </li>

          <li>
            <i class="icon iconfont icon-align-center"></i>
            <div class="name">align-center</div>
            <div class="fontclass">.icon-align-center</div>
          </li>

          <li>
            <i class="icon iconfont icon-align-left"></i>
            <div class="name">align-left</div>
            <div class="fontclass">.icon-align-left</div>
          </li>

          <li>
            <i class="icon iconfont icon-pic-center"></i>
            <div class="name">pic-center</div>
            <div class="fontclass">.icon-pic-center</div>
          </li>

          <li>
            <i class="icon iconfont icon-pic-right"></i>
            <div class="name">pic-right</div>
            <div class="fontclass">.icon-pic-right</div>
          </li>

          <li>
            <i class="icon iconfont icon-pic-left"></i>
            <div class="name">pic-left</div>
            <div class="fontclass">.icon-pic-left</div>
          </li>

          <li>
            <i class="icon iconfont icon-bold"></i>
            <div class="name">bold</div>
            <div class="fontclass">.icon-bold</div>
          </li>

          <li>
            <i class="icon iconfont icon-font-colors"></i>
            <div class="name">font-colors</div>
            <div class="fontclass">.icon-font-colors</div>
          </li>

          <li>
            <i class="icon iconfont icon-exclaimination"></i>
            <div class="name">exclaimination</div>
            <div class="fontclass">.icon-exclaimination</div>
          </li>

          <li>
            <i class="icon iconfont icon-font-size"></i>
            <div class="name">font-size</div>
            <div class="fontclass">.icon-font-size</div>
          </li>

          <li>
            <i class="icon iconfont icon-infomation"></i>
            <div class="name">infomation</div>
            <div class="fontclass">.icon-infomation</div>
          </li>

          <li>
            <i class="icon iconfont icon-line-height"></i>
            <div class="name">line-height</div>
            <div class="fontclass">.icon-line-height</div>
          </li>

          <li>
            <i class="icon iconfont icon-strikethrough"></i>
            <div class="name">strikethrough</div>
            <div class="fontclass">.icon-strikethrough</div>
          </li>

          <li>
            <i class="icon iconfont icon-underline"></i>
            <div class="name">underline</div>
            <div class="fontclass">.icon-underline</div>
          </li>

          <li>
            <i class="icon iconfont icon-number"></i>
            <div class="name">number</div>
            <div class="fontclass">.icon-number</div>
          </li>

          <li>
            <i class="icon iconfont icon-italic"></i>
            <div class="name">italic</div>
            <div class="fontclass">.icon-italic</div>
          </li>

          <li>
            <i class="icon iconfont icon-code"></i>
            <div class="name">code</div>
            <div class="fontclass">.icon-code</div>
          </li>

          <li>
            <i class="icon iconfont icon-column-width"></i>
            <div class="name">column-width</div>
            <div class="fontclass">.icon-column-width</div>
          </li>

          <li>
            <i class="icon iconfont icon-check"></i>
            <div class="name">check</div>
            <div class="fontclass">.icon-check</div>
          </li>

          <li>
            <i class="icon iconfont icon-ellipsis"></i>
            <div class="name">ellipsis</div>
            <div class="fontclass">.icon-ellipsis</div>
          </li>

          <li>
            <i class="icon iconfont icon-dash"></i>
            <div class="name">dash</div>
            <div class="fontclass">.icon-dash</div>
          </li>

          <li>
            <i class="icon iconfont icon-close"></i>
            <div class="name">close</div>
            <div class="fontclass">.icon-close</div>
          </li>

          <li>
            <i class="icon iconfont icon-enter"></i>
            <div class="name">enter</div>
            <div class="fontclass">.icon-enter</div>
          </li>

          <li>
            <i class="icon iconfont icon-line"></i>
            <div class="name">line</div>
            <div class="fontclass">.icon-line</div>
          </li>

          <li>
            <i class="icon iconfont icon-minus"></i>
            <div class="name">minus</div>
            <div class="fontclass">.icon-minus</div>
          </li>

          <li>
            <i class="icon iconfont icon-question"></i>
            <div class="name">question</div>
            <div class="fontclass">.icon-question</div>
          </li>

          <li>
            <i class="icon iconfont icon-plus"></i>
            <div class="name">plus</div>
            <div class="fontclass">.icon-plus</div>
          </li>

          <li>
            <i class="icon iconfont icon-rollback"></i>
            <div class="name">rollback</div>
            <div class="fontclass">.icon-rollback</div>
          </li>

          <li>
            <i class="icon iconfont icon-small-dash"></i>
            <div class="name">small-dash</div>
            <div class="fontclass">.icon-small-dash</div>
          </li>

          <li>
            <i class="icon iconfont icon-pause"></i>
            <div class="name">pause</div>
            <div class="fontclass">.icon-pause</div>
          </li>

          <li>
            <i class="icon iconfont icon-bg-colors"></i>
            <div class="name">bg-colors</div>
            <div class="fontclass">.icon-bg-colors</div>
          </li>

          <li>
            <i class="icon iconfont icon-crown"></i>
            <div class="name">crown</div>
            <div class="fontclass">.icon-crown</div>
          </li>

          <li>
            <i class="icon iconfont icon-drag"></i>
            <div class="name">drag</div>
            <div class="fontclass">.icon-drag</div>
          </li>

          <li>
            <i class="icon iconfont icon-desktop"></i>
            <div class="name">desktop</div>
            <div class="fontclass">.icon-desktop</div>
          </li>

          <li>
            <i class="icon iconfont icon-gift"></i>
            <div class="name">gift</div>
            <div class="fontclass">.icon-gift</div>
          </li>

          <li>
            <i class="icon iconfont icon-stop"></i>
            <div class="name">stop</div>
            <div class="fontclass">.icon-stop</div>
          </li>

          <li>
            <i class="icon iconfont icon-fire"></i>
            <div class="name">fire</div>
            <div class="fontclass">.icon-fire</div>
          </li>

          <li>
            <i class="icon iconfont icon-thunderbolt"></i>
            <div class="name">thunderbolt</div>
            <div class="fontclass">.icon-thunderbolt</div>
          </li>

          <li>
            <i class="icon iconfont icon-check-circle-fill"></i>
            <div class="name">check-circle-fill</div>
            <div class="fontclass">.icon-check-circle-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-left-circle-fill"></i>
            <div class="name">left-circle-fill</div>
            <div class="fontclass">.icon-left-circle-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-down-circle-fill"></i>
            <div class="name">down-circle-fill</div>
            <div class="fontclass">.icon-down-circle-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-minus-circle-fill"></i>
            <div class="name">minus-circle-fill</div>
            <div class="fontclass">.icon-minus-circle-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-close-circle-fill"></i>
            <div class="name">close-circle-fill</div>
            <div class="fontclass">.icon-close-circle-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-info-circle-fill"></i>
            <div class="name">info-circle-fill</div>
            <div class="fontclass">.icon-info-circle-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-up-circle-fill"></i>
            <div class="name">up-circle-fill</div>
            <div class="fontclass">.icon-up-circle-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-right-circle-fill"></i>
            <div class="name">right-circle-fill</div>
            <div class="fontclass">.icon-right-circle-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-plus-circle-fill"></i>
            <div class="name">plus-circle-fill</div>
            <div class="fontclass">.icon-plus-circle-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-question-circle-fill"></i>
            <div class="name">question-circle-fill</div>
            <div class="fontclass">.icon-question-circle-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-EURO-circle-fill"></i>
            <div class="name">EURO-circle-fill</div>
            <div class="fontclass">.icon-EURO-circle-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-frown-fill"></i>
            <div class="name">frown-fill</div>
            <div class="fontclass">.icon-frown-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-copyright-circle-fil"></i>
            <div class="name">copyright-circle-fil</div>
            <div class="fontclass">.icon-copyright-circle-fil</div>
          </li>

          <li>
            <i class="icon iconfont icon-CI-circle-fill"></i>
            <div class="name">CI-circle-fill</div>
            <div class="fontclass">.icon-CI-circle-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-compass-fill"></i>
            <div class="name">compass-fill</div>
            <div class="fontclass">.icon-compass-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-Dollar-circle-fill"></i>
            <div class="name">Dollar-circle-fill</div>
            <div class="fontclass">.icon-Dollar-circle-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-poweroff-circle-fill"></i>
            <div class="name">poweroff-circle-fill</div>
            <div class="fontclass">.icon-poweroff-circle-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-meh-fill"></i>
            <div class="name">meh-fill</div>
            <div class="fontclass">.icon-meh-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-play-circle-fill"></i>
            <div class="name">play-circle-fill</div>
            <div class="fontclass">.icon-play-circle-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-Pound-circle-fill"></i>
            <div class="name">Pound-circle-fill</div>
            <div class="fontclass">.icon-Pound-circle-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-smile-fill"></i>
            <div class="name">smile-fill</div>
            <div class="fontclass">.icon-smile-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-stop-fill"></i>
            <div class="name">stop-fill</div>
            <div class="fontclass">.icon-stop-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-warning-circle-fill"></i>
            <div class="name">warning-circle-fill</div>
            <div class="fontclass">.icon-warning-circle-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-time-circle-fill"></i>
            <div class="name">time-circle-fill</div>
            <div class="fontclass">.icon-time-circle-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-trademark-circle-fil"></i>
            <div class="name">trademark-circle-fil</div>
            <div class="fontclass">.icon-trademark-circle-fil</div>
          </li>

          <li>
            <i class="icon iconfont icon-YUAN-circle-fill"></i>
            <div class="name">YUAN-circle-fill</div>
            <div class="fontclass">.icon-YUAN-circle-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-heart-fill"></i>
            <div class="name">heart-fill</div>
            <div class="fontclass">.icon-heart-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-piechart-circle-fil"></i>
            <div class="name">pie chart-circle-fil</div>
            <div class="fontclass">.icon-piechart-circle-fil</div>
          </li>

          <li>
            <i class="icon iconfont icon-dashboard-fill"></i>
            <div class="name">dashboard-fill</div>
            <div class="fontclass">.icon-dashboard-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-message-fill"></i>
            <div class="name">message-fill</div>
            <div class="fontclass">.icon-message-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-check-square-fill"></i>
            <div class="name">check-square-fill</div>
            <div class="fontclass">.icon-check-square-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-down-square-fill"></i>
            <div class="name">down-square-fill</div>
            <div class="fontclass">.icon-down-square-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-minus-square-fill"></i>
            <div class="name">minus-square-fill</div>
            <div class="fontclass">.icon-minus-square-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-close-square-fill"></i>
            <div class="name">close-square-fill</div>
            <div class="fontclass">.icon-close-square-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-codelibrary-fill"></i>
            <div class="name">code library-fill</div>
            <div class="fontclass">.icon-codelibrary-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-left-square-fill"></i>
            <div class="name">left-square-fill</div>
            <div class="fontclass">.icon-left-square-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-play-square-fill"></i>
            <div class="name">play-square-fill</div>
            <div class="fontclass">.icon-play-square-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-up-square-fill"></i>
            <div class="name">up-square-fill</div>
            <div class="fontclass">.icon-up-square-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-right-square-fill"></i>
            <div class="name">right-square-fill</div>
            <div class="fontclass">.icon-right-square-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-plus-square-fill"></i>
            <div class="name">plus-square-fill</div>
            <div class="fontclass">.icon-plus-square-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-accountbook-fill"></i>
            <div class="name">account book-fill</div>
            <div class="fontclass">.icon-accountbook-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-carryout-fill"></i>
            <div class="name">carry out-fill</div>
            <div class="fontclass">.icon-carryout-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-calendar-fill"></i>
            <div class="name">calendar-fill</div>
            <div class="fontclass">.icon-calendar-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-calculator-fill"></i>
            <div class="name">calculator-fill</div>
            <div class="fontclass">.icon-calculator-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-interation-fill"></i>
            <div class="name">interation-fill</div>
            <div class="fontclass">.icon-interation-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-project-fill"></i>
            <div class="name">project-fill</div>
            <div class="fontclass">.icon-project-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-detail-fill"></i>
            <div class="name">detail-fill</div>
            <div class="fontclass">.icon-detail-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-save-fill"></i>
            <div class="name">save-fill</div>
            <div class="fontclass">.icon-save-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-wallet-fill"></i>
            <div class="name">wallet-fill</div>
            <div class="fontclass">.icon-wallet-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-control-fill"></i>
            <div class="name">control-fill</div>
            <div class="fontclass">.icon-control-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-layout-fill"></i>
            <div class="name">layout-fill</div>
            <div class="fontclass">.icon-layout-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-appstore-fill"></i>
            <div class="name">app store-fill</div>
            <div class="fontclass">.icon-appstore-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-mobile-fill"></i>
            <div class="name">mobile-fill</div>
            <div class="fontclass">.icon-mobile-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-tablet-fill"></i>
            <div class="name">tablet-fill</div>
            <div class="fontclass">.icon-tablet-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-book-fill"></i>
            <div class="name">book-fill</div>
            <div class="fontclass">.icon-book-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-redenvelope-fill"></i>
            <div class="name">red envelope-fill</div>
            <div class="fontclass">.icon-redenvelope-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-safetycertificate-f"></i>
            <div class="name">safety certificate-f</div>
            <div class="fontclass">.icon-safetycertificate-f</div>
          </li>

          <li>
            <i class="icon iconfont icon-propertysafety-fill"></i>
            <div class="name">property safety-fill</div>
            <div class="fontclass">.icon-propertysafety-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-insurance-fill"></i>
            <div class="name">insurance-fill</div>
            <div class="fontclass">.icon-insurance-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-securityscan-fill"></i>
            <div class="name">security scan-fill</div>
            <div class="fontclass">.icon-securityscan-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-file-exclamation-fil"></i>
            <div class="name">file-exclamation-fil</div>
            <div class="fontclass">.icon-file-exclamation-fil</div>
          </li>

          <li>
            <i class="icon iconfont icon-file-add-fill"></i>
            <div class="name">file-add-fill</div>
            <div class="fontclass">.icon-file-add-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-file-fill"></i>
            <div class="name">file-fill</div>
            <div class="fontclass">.icon-file-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-file-excelField-fill"></i>
            <div class="name">file-excelField-fill</div>
            <div class="fontclass">.icon-file-excelField-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-file-markdown-fill"></i>
            <div class="name">file-markdown-fill</div>
            <div class="fontclass">.icon-file-markdown-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-file-text-fill"></i>
            <div class="name">file-text-fill</div>
            <div class="fontclass">.icon-file-text-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-file-ppt-fill"></i>
            <div class="name">file-ppt-fill</div>
            <div class="fontclass">.icon-file-ppt-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-file-unknown-fill"></i>
            <div class="name">file-unknown-fill</div>
            <div class="fontclass">.icon-file-unknown-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-file-word-fill"></i>
            <div class="name">file-word-fill</div>
            <div class="fontclass">.icon-file-word-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-file-zip-fill"></i>
            <div class="name">file-zip-fill</div>
            <div class="fontclass">.icon-file-zip-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-file-pdf-fill"></i>
            <div class="name">file-pdf-fill</div>
            <div class="fontclass">.icon-file-pdf-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-file-image-fill"></i>
            <div class="name">file-image-fill</div>
            <div class="fontclass">.icon-file-image-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-diff-fill"></i>
            <div class="name">diff-fill</div>
            <div class="fontclass">.icon-diff-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-file-copy-fill"></i>
            <div class="name">file-copy-fill</div>
            <div class="fontclass">.icon-file-copy-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-snippets-fill"></i>
            <div class="name">snippets-fill</div>
            <div class="fontclass">.icon-snippets-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-batchfolding-fill"></i>
            <div class="name">batch folding-fill</div>
            <div class="fontclass">.icon-batchfolding-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-reconciliation-fill"></i>
            <div class="name">reconciliation-fill</div>
            <div class="fontclass">.icon-reconciliation-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-folder-add-fill"></i>
            <div class="name">folder-add-fill</div>
            <div class="fontclass">.icon-folder-add-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-folder-fill"></i>
            <div class="name">folder-fill</div>
            <div class="fontclass">.icon-folder-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-folder-open-fill"></i>
            <div class="name">folder-open-fill</div>
            <div class="fontclass">.icon-folder-open-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-database-fill"></i>
            <div class="name">database-fill</div>
            <div class="fontclass">.icon-database-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-container-fill"></i>
            <div class="name">container-fill</div>
            <div class="fontclass">.icon-container-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-sever-fill"></i>
            <div class="name">sever-fill</div>
            <div class="fontclass">.icon-sever-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-calendar-check-fill"></i>
            <div class="name">calendar-check-fill</div>
            <div class="fontclass">.icon-calendar-check-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-image-fill"></i>
            <div class="name">image-fill</div>
            <div class="fontclass">.icon-image-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-idcard-fill"></i>
            <div class="name">id card-fill</div>
            <div class="fontclass">.icon-idcard-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-creditcard-fill"></i>
            <div class="name">credit card-fill</div>
            <div class="fontclass">.icon-creditcard-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-fund-fill"></i>
            <div class="name">fund-fill</div>
            <div class="fontclass">.icon-fund-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-read-fill"></i>
            <div class="name">read-fill</div>
            <div class="fontclass">.icon-read-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-contacts-fill"></i>
            <div class="name">contacts-fill</div>
            <div class="fontclass">.icon-contacts-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-delete-fill"></i>
            <div class="name">delete-fill</div>
            <div class="fontclass">.icon-delete-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-notification-fill"></i>
            <div class="name">notification-fill</div>
            <div class="fontclass">.icon-notification-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-flag-fill"></i>
            <div class="name">flag-fill</div>
            <div class="fontclass">.icon-flag-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-moneycollect-fill"></i>
            <div class="name">money collect-fill</div>
            <div class="fontclass">.icon-moneycollect-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-medicinebox-fill"></i>
            <div class="name">medicine box-fill</div>
            <div class="fontclass">.icon-medicinebox-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-rest-fill"></i>
            <div class="name">rest-fill</div>
            <div class="fontclass">.icon-rest-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-shopping-fill"></i>
            <div class="name">shopping-fill</div>
            <div class="fontclass">.icon-shopping-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-skin-fill"></i>
            <div class="name">skin-fill</div>
            <div class="fontclass">.icon-skin-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-video-fill"></i>
            <div class="name">video-fill</div>
            <div class="fontclass">.icon-video-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-sound-fill"></i>
            <div class="name">sound-fill</div>
            <div class="fontclass">.icon-sound-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-bulb-fill"></i>
            <div class="name">bulb-fill</div>
            <div class="fontclass">.icon-bulb-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-bell-fill"></i>
            <div class="name">bell-fill</div>
            <div class="fontclass">.icon-bell-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-filter-fill"></i>
            <div class="name">filter-fill</div>
            <div class="fontclass">.icon-filter-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-fire-fill"></i>
            <div class="name">fire-fill</div>
            <div class="fontclass">.icon-fire-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-funnelplot-fill"></i>
            <div class="name">funnel plot-fill</div>
            <div class="fontclass">.icon-funnelplot-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-gift-fill"></i>
            <div class="name">gift-fill</div>
            <div class="fontclass">.icon-gift-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-hourglass-fill"></i>
            <div class="name">hourglass-fill</div>
            <div class="fontclass">.icon-hourglass-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-home-fill"></i>
            <div class="name">home-fill</div>
            <div class="fontclass">.icon-home-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-trophy-fill"></i>
            <div class="name">trophy-fill</div>
            <div class="fontclass">.icon-trophy-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-location-fill"></i>
            <div class="name">location-fill</div>
            <div class="fontclass">.icon-location-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-cloud-fill"></i>
            <div class="name">cloud-fill</div>
            <div class="fontclass">.icon-cloud-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-customerservice-fill"></i>
            <div class="name">customerservice-fill</div>
            <div class="fontclass">.icon-customerservice-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-experiment-fill"></i>
            <div class="name">experiment-fill</div>
            <div class="fontclass">.icon-experiment-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-eye-fill"></i>
            <div class="name">eye-fill</div>
            <div class="fontclass">.icon-eye-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-like-fill"></i>
            <div class="name">like-fill</div>
            <div class="fontclass">.icon-like-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-lock-fill"></i>
            <div class="name">lock-fill</div>
            <div class="fontclass">.icon-lock-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-unlike-fill"></i>
            <div class="name">unlike-fill</div>
            <div class="fontclass">.icon-unlike-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-star-fill"></i>
            <div class="name">star-fill</div>
            <div class="fontclass">.icon-star-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-unlock-fill"></i>
            <div class="name">unlock-fill</div>
            <div class="fontclass">.icon-unlock-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-alert-fill"></i>
            <div class="name">alert-fill</div>
            <div class="fontclass">.icon-alert-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-api-fill"></i>
            <div class="name">api-fill</div>
            <div class="fontclass">.icon-api-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-highlight-fill"></i>
            <div class="name">highlight-fill</div>
            <div class="fontclass">.icon-highlight-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-phone-fill"></i>
            <div class="name">phone-fill</div>
            <div class="fontclass">.icon-phone-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-edit-fill"></i>
            <div class="name">edit-fill</div>
            <div class="fontclass">.icon-edit-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-pushpin-fill"></i>
            <div class="name">pushpin-fill</div>
            <div class="fontclass">.icon-pushpin-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-rocket-fill"></i>
            <div class="name">rocket-fill</div>
            <div class="fontclass">.icon-rocket-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-thunderbolt-fill"></i>
            <div class="name">thunderbolt-fill</div>
            <div class="fontclass">.icon-thunderbolt-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-tag-fill"></i>
            <div class="name">tag-fill</div>
            <div class="fontclass">.icon-tag-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-wrench-fill"></i>
            <div class="name">wrench-fill</div>
            <div class="fontclass">.icon-wrench-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-tags-fill"></i>
            <div class="name">tags-fill</div>
            <div class="fontclass">.icon-tags-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-bank-fill"></i>
            <div class="name">bank-fill</div>
            <div class="fontclass">.icon-bank-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-camera-fill"></i>
            <div class="name">camera-fill</div>
            <div class="fontclass">.icon-camera-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-error-fill"></i>
            <div class="name">error-fill</div>
            <div class="fontclass">.icon-error-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-crown-fill"></i>
            <div class="name">crown-fill</div>
            <div class="fontclass">.icon-crown-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-mail-fill"></i>
            <div class="name">mail-fill</div>
            <div class="fontclass">.icon-mail-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-car-fill"></i>
            <div class="name">car-fill</div>
            <div class="fontclass">.icon-car-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-printer-fill"></i>
            <div class="name">printer-fill</div>
            <div class="fontclass">.icon-printer-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-shop-fill"></i>
            <div class="name">shop-fill</div>
            <div class="fontclass">.icon-shop-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-setting-fill"></i>
            <div class="name">setting-fill</div>
            <div class="fontclass">.icon-setting-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-USB-fill"></i>
            <div class="name">USB-fill</div>
            <div class="fontclass">.icon-USB-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-golden-fill"></i>
            <div class="name">golden-fill</div>
            <div class="fontclass">.icon-golden-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-build-fill"></i>
            <div class="name">build-fill</div>
            <div class="fontclass">.icon-build-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-boxplot-fill"></i>
            <div class="name">box plot-fill</div>
            <div class="fontclass">.icon-boxplot-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-sliders-fill"></i>
            <div class="name">sliders-fill</div>
            <div class="fontclass">.icon-sliders-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-alibaba"></i>
            <div class="name">alibaba</div>
            <div class="fontclass">.icon-alibaba</div>
          </li>

          <li>
            <i class="icon iconfont icon-alibabacloud"></i>
            <div class="name">alibabacloud</div>
            <div class="fontclass">.icon-alibabacloud</div>
          </li>

          <li>
            <i class="icon iconfont icon-antdesign"></i>
            <div class="name">ant design</div>
            <div class="fontclass">.icon-antdesign</div>
          </li>

          <li>
            <i class="icon iconfont icon-ant-cloud"></i>
            <div class="name">ant-cloud</div>
            <div class="fontclass">.icon-ant-cloud</div>
          </li>

          <li>
            <i class="icon iconfont icon-behance"></i>
            <div class="name">behance</div>
            <div class="fontclass">.icon-behance</div>
          </li>

          <li>
            <i class="icon iconfont icon-googleplus"></i>
            <div class="name">google plus</div>
            <div class="fontclass">.icon-googleplus</div>
          </li>

          <li>
            <i class="icon iconfont icon-medium"></i>
            <div class="name">medium</div>
            <div class="fontclass">.icon-medium</div>
          </li>

          <li>
            <i class="icon iconfont icon-google"></i>
            <div class="name">google</div>
            <div class="fontclass">.icon-google</div>
          </li>

          <li>
            <i class="icon iconfont icon-IE"></i>
            <div class="name">IE</div>
            <div class="fontclass">.icon-IE</div>
          </li>

          <li>
            <i class="icon iconfont icon-amazon"></i>
            <div class="name">amazon</div>
            <div class="fontclass">.icon-amazon</div>
          </li>

          <li>
            <i class="icon iconfont icon-slack"></i>
            <div class="name">slack</div>
            <div class="fontclass">.icon-slack</div>
          </li>

          <li>
            <i class="icon iconfont icon-alipay"></i>
            <div class="name">alipay</div>
            <div class="fontclass">.icon-alipay</div>
          </li>

          <li>
            <i class="icon iconfont icon-taobao"></i>
            <div class="name">taobao</div>
            <div class="fontclass">.icon-taobao</div>
          </li>

          <li>
            <i class="icon iconfont icon-zhihu"></i>
            <div class="name">zhihu</div>
            <div class="fontclass">.icon-zhihu</div>
          </li>

          <li>
            <i class="icon iconfont icon-HTML"></i>
            <div class="name">HTML5</div>
            <div class="fontclass">.icon-HTML</div>
          </li>

          <li>
            <i class="icon iconfont icon-linkedin"></i>
            <div class="name">linkedin</div>
            <div class="fontclass">.icon-linkedin</div>
          </li>

          <li>
            <i class="icon iconfont icon-yahoo"></i>
            <div class="name">yahoo</div>
            <div class="fontclass">.icon-yahoo</div>
          </li>

          <li>
            <i class="icon iconfont icon-facebook"></i>
            <div class="name">facebook</div>
            <div class="fontclass">.icon-facebook</div>
          </li>

          <li>
            <i class="icon iconfont icon-skype"></i>
            <div class="name">skype</div>
            <div class="fontclass">.icon-skype</div>
          </li>

          <li>
            <i class="icon iconfont icon-CodeSandbox"></i>
            <div class="name">CodeSandbox</div>
            <div class="fontclass">.icon-CodeSandbox</div>
          </li>

          <li>
            <i class="icon iconfont icon-chrome"></i>
            <div class="name">chrome</div>
            <div class="fontclass">.icon-chrome</div>
          </li>

          <li>
            <i class="icon iconfont icon-codepen"></i>
            <div class="name">codepen</div>
            <div class="fontclass">.icon-codepen</div>
          </li>

          <li>
            <i class="icon iconfont icon-aliwangwang"></i>
            <div class="name">aliwangwang</div>
            <div class="fontclass">.icon-aliwangwang</div>
          </li>

          <li>
            <i class="icon iconfont icon-apple"></i>
            <div class="name">apple</div>
            <div class="fontclass">.icon-apple</div>
          </li>

          <li>
            <i class="icon iconfont icon-android"></i>
            <div class="name">android</div>
            <div class="fontclass">.icon-android</div>
          </li>

          <li>
            <i class="icon iconfont icon-sketch"></i>
            <div class="name">sketch</div>
            <div class="fontclass">.icon-sketch</div>
          </li>

          <li>
            <i class="icon iconfont icon-Gitlab"></i>
            <div class="name">Gitlab</div>
            <div class="fontclass">.icon-Gitlab</div>
          </li>

          <li>
            <i class="icon iconfont icon-dribbble"></i>
            <div class="name">dribbble</div>
            <div class="fontclass">.icon-dribbble</div>
          </li>

          <li>
            <i class="icon iconfont icon-instagram"></i>
            <div class="name">instagram</div>
            <div class="fontclass">.icon-instagram</div>
          </li>

          <li>
            <i class="icon iconfont icon-reddit"></i>
            <div class="name">reddit</div>
            <div class="fontclass">.icon-reddit</div>
          </li>

          <li>
            <i class="icon iconfont icon-windows"></i>
            <div class="name">windows</div>
            <div class="fontclass">.icon-windows</div>
          </li>

          <li>
            <i class="icon iconfont icon-yuque"></i>
            <div class="name">yuque</div>
            <div class="fontclass">.icon-yuque</div>
          </li>

          <li>
            <i class="icon iconfont icon-Youtube"></i>
            <div class="name">Youtube</div>
            <div class="fontclass">.icon-Youtube</div>
          </li>

          <li>
            <i class="icon iconfont icon-Gitlab-fill"></i>
            <div class="name">Gitlab-fill</div>
            <div class="fontclass">.icon-Gitlab-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-dropbox"></i>
            <div class="name">dropbox</div>
            <div class="fontclass">.icon-dropbox</div>
          </li>

          <li>
            <i class="icon iconfont icon-dingtalk"></i>
            <div class="name">dingtalk</div>
            <div class="fontclass">.icon-dingtalk</div>
          </li>

          <li>
            <i class="icon iconfont icon-android-fill"></i>
            <div class="name">android-fill</div>
            <div class="fontclass">.icon-android-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-apple-fill"></i>
            <div class="name">apple-fill</div>
            <div class="fontclass">.icon-apple-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-HTML-fill"></i>
            <div class="name">HTML5-fill</div>
            <div class="fontclass">.icon-HTML-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-windows-fill"></i>
            <div class="name">windows-fill</div>
            <div class="fontclass">.icon-windows-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-QQ"></i>
            <div class="name">QQ</div>
            <div class="fontclass">.icon-QQ</div>
          </li>

          <li>
            <i class="icon iconfont icon-twitter"></i>
            <div class="name">twitter</div>
            <div class="fontclass">.icon-twitter</div>
          </li>

          <li>
            <i class="icon iconfont icon-skype-fill"></i>
            <div class="name">skype-fill</div>
            <div class="fontclass">.icon-skype-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-weibo"></i>
            <div class="name">weibo</div>
            <div class="fontclass">.icon-weibo</div>
          </li>

          <li>
            <i class="icon iconfont icon-yuque-fill"></i>
            <div class="name">yuque-fill</div>
            <div class="fontclass">.icon-yuque-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-Youtube-fill"></i>
            <div class="name">Youtube-fill</div>
            <div class="fontclass">.icon-Youtube-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-yahoo-fill"></i>
            <div class="name">yahoo-fill</div>
            <div class="fontclass">.icon-yahoo-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-wechat-fill"></i>
            <div class="name">wechat-fill</div>
            <div class="fontclass">.icon-wechat-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-chrome-fill"></i>
            <div class="name">chrome-fill</div>
            <div class="fontclass">.icon-chrome-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-alipay-circle-fill"></i>
            <div class="name">alipay-circle-fill</div>
            <div class="fontclass">.icon-alipay-circle-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-aliwangwang-fill"></i>
            <div class="name">aliwangwang-fill</div>
            <div class="fontclass">.icon-aliwangwang-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-behance-circle-fill"></i>
            <div class="name">behance-circle-fill</div>
            <div class="fontclass">.icon-behance-circle-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-amazon-circle-fill"></i>
            <div class="name">amazon-circle-fill</div>
            <div class="fontclass">.icon-amazon-circle-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-codepen-circle-fill"></i>
            <div class="name">codepen-circle-fill</div>
            <div class="fontclass">.icon-codepen-circle-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-CodeSandbox-circle-f"></i>
            <div class="name">CodeSandbox-circle-f</div>
            <div class="fontclass">.icon-CodeSandbox-circle-f</div>
          </li>

          <li>
            <i class="icon iconfont icon-dropbox-circle-fill"></i>
            <div class="name">dropbox-circle-fill</div>
            <div class="fontclass">.icon-dropbox-circle-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-github-fill"></i>
            <div class="name">github-fill</div>
            <div class="fontclass">.icon-github-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-dribbble-circle-fill"></i>
            <div class="name">dribbble-circle-fill</div>
            <div class="fontclass">.icon-dribbble-circle-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-googleplus-circle-f"></i>
            <div class="name">google plus-circle-f</div>
            <div class="fontclass">.icon-googleplus-circle-f</div>
          </li>

          <li>
            <i class="icon iconfont icon-medium-circle-fill"></i>
            <div class="name">medium-circle-fill</div>
            <div class="fontclass">.icon-medium-circle-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-QQ-circle-fill"></i>
            <div class="name">QQ-circle-fill</div>
            <div class="fontclass">.icon-QQ-circle-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-IE-circle-fill"></i>
            <div class="name">IE-circle-fill</div>
            <div class="fontclass">.icon-IE-circle-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-google-circle-fill"></i>
            <div class="name">google-circle-fill</div>
            <div class="fontclass">.icon-google-circle-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-dingtalk-circle-fill"></i>
            <div class="name">dingtalk-circle-fill</div>
            <div class="fontclass">.icon-dingtalk-circle-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-sketch-circle-fill"></i>
            <div class="name">sketch-circle-fill</div>
            <div class="fontclass">.icon-sketch-circle-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-slack-circle-fill"></i>
            <div class="name">slack-circle-fill</div>
            <div class="fontclass">.icon-slack-circle-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-twitter-circle-fill"></i>
            <div class="name">twitter-circle-fill</div>
            <div class="fontclass">.icon-twitter-circle-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-taobao-circle-fill"></i>
            <div class="name">taobao-circle-fill</div>
            <div class="fontclass">.icon-taobao-circle-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-weibo-circle-fill"></i>
            <div class="name">weibo-circle-fill</div>
            <div class="fontclass">.icon-weibo-circle-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-zhihu-circle-fill"></i>
            <div class="name">zhihu-circle-fill</div>
            <div class="fontclass">.icon-zhihu-circle-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-reddit-circle-fill"></i>
            <div class="name">reddit-circle-fill</div>
            <div class="fontclass">.icon-reddit-circle-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-alipay-square-fill"></i>
            <div class="name">alipay-square-fill</div>
            <div class="fontclass">.icon-alipay-square-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-dingtalk-square-fill"></i>
            <div class="name">dingtalk-square-fill</div>
            <div class="fontclass">.icon-dingtalk-square-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-CodeSandbox-square-f"></i>
            <div class="name">CodeSandbox-square-f</div>
            <div class="fontclass">.icon-CodeSandbox-square-f</div>
          </li>

          <li>
            <i class="icon iconfont icon-behance-square-fill"></i>
            <div class="name">behance-square-fill</div>
            <div class="fontclass">.icon-behance-square-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-amazon-square-fill"></i>
            <div class="name">amazon-square-fill</div>
            <div class="fontclass">.icon-amazon-square-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-codepen-square-fill"></i>
            <div class="name">codepen-square-fill</div>
            <div class="fontclass">.icon-codepen-square-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-dribbble-square-fill"></i>
            <div class="name">dribbble-square-fill</div>
            <div class="fontclass">.icon-dribbble-square-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-dropbox-square-fill"></i>
            <div class="name">dropbox-square-fill</div>
            <div class="fontclass">.icon-dropbox-square-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-facebook-fill"></i>
            <div class="name">facebook-fill</div>
            <div class="fontclass">.icon-facebook-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-googleplus-square-f"></i>
            <div class="name">google plus-square-f</div>
            <div class="fontclass">.icon-googleplus-square-f</div>
          </li>

          <li>
            <i class="icon iconfont icon-google-square-fill"></i>
            <div class="name">google-square-fill</div>
            <div class="fontclass">.icon-google-square-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-instagram-fill"></i>
            <div class="name">instagram-fill</div>
            <div class="fontclass">.icon-instagram-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-IE-square-fill"></i>
            <div class="name">IE-square-fill</div>
            <div class="fontclass">.icon-IE-square-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-medium-square-fill"></i>
            <div class="name">medium-square-fill</div>
            <div class="fontclass">.icon-medium-square-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-linkedin-fill"></i>
            <div class="name">linkedin-fill</div>
            <div class="fontclass">.icon-linkedin-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-QQ-square-fill"></i>
            <div class="name">QQ-square-fill</div>
            <div class="fontclass">.icon-QQ-square-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-reddit-square-fill"></i>
            <div class="name">reddit-square-fill</div>
            <div class="fontclass">.icon-reddit-square-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-twitter-square-fill"></i>
            <div class="name">twitter-square-fill</div>
            <div class="fontclass">.icon-twitter-square-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-sketch-square-fill"></i>
            <div class="name">sketch-square-fill</div>
            <div class="fontclass">.icon-sketch-square-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-slack-square-fill"></i>
            <div class="name">slack-square-fill</div>
            <div class="fontclass">.icon-slack-square-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-taobao-square-fill"></i>
            <div class="name">taobao-square-fill</div>
            <div class="fontclass">.icon-taobao-square-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-weibo-square-fill"></i>
            <div class="name">weibo-square-fill</div>
            <div class="fontclass">.icon-weibo-square-fill</div>
          </li>

          <li>
            <i class="icon iconfont icon-zhihu-square-fill"></i>
            <div class="name">zhihu-square-fill</div>
            <div class="fontclass">.icon-zhihu-square-fill</div>
          </li>

        </ul>
      </el-dialog>
      <el-dialog :title="textMap[dialogStatus]" :visible.sync="dialogFormVisible">
        <el-form :model="form" label-width="100px" ref="form">
          <el-form-item label="所属菜单" prop="parentName">
            <el-input :disabled="disableSelectMenuParent" @focus="handelParentMenuTree()" placeholder="选择菜单"
                      readonly v-model="form.parentName">
            </el-input>
            <input type="hidden" v-model="form.parentId"/>
          </el-form-item>

          <el-form-item :rules="[{required: true,message: '请输入菜单名称'}]" label="名称" prop="name">
            <el-input placeholder="请输入名称" v-model="form.name"></el-input>
          </el-form-item>

          <el-form-item :rules="[ {validator:validateUnique}]" label="权限" prop="permission">
            <el-input placeholder="请输入权限" v-model="form.permission"></el-input>
          </el-form-item>
          <el-form-item label="图标" prop="icon">
            <el-input v-model="form.icon"></el-input>
            <el-button @click="handleIcon()" type="text">查看图标</el-button>
          </el-form-item>
          <el-form-item label="VUE页面" prop="component">
            <el-input v-model="form.component"></el-input>
          </el-form-item>
          <el-form-item :rules="[{required: true,message: '请选择' }]" label="菜单类型" prop="type">
            <CrudRadio :dic="menuTypeOptions" v-model="form.type"></CrudRadio>
          </el-form-item>
          <!--          <el-form-item label="路由缓冲" prop="keepAlive">-->
          <!--            <el-switch-->
          <!--              v-model="form.keepAlive"-->
          <!--              active-color="#13ce66" inactive-color="#ff4949" active-value="1" inactive-value="0">-->
          <!--            </el-switch>-->
          <!--          </el-form-item>-->
          <el-form-item label="前端URL" prop="path">
            <el-input v-model="form.path"></el-input>
          </el-form-item>
          <el-form-item :rules="[{required: true,message: '请选择' }]" label="是否显示" prop="show">
            <CrudRadio :dic="flagOptions" v-model="form.show"></CrudRadio>
          </el-form-item>
          <el-form-item label="序号" prop="sort">
            <el-input-number :max="1000" :min="1" v-model="form.sort"></el-input-number>
          </el-form-item>
          <el-form-item label="描述" prop="description">
            <el-input placeholder="" type="textarea" v-model="form.description"></el-input>
          </el-form-item>
        </el-form>
        <div class="dialog-footer" slot="footer">
          <el-button @click="cancel()">取 消</el-button>
          <el-button @click="save()" type="primary">保 存</el-button>
        </div>
      </el-dialog>
    </basic-container>
  </div>
</template>

<script>
    import menuService from "./menu-service";
    import {mapGetters} from 'vuex';
    import util from "@/util/util";
    import validate from "@/util/validate";
    import CrudSelect from "@/components/avue/crud-select";
    import CrudRadio from "@/components/avue/crud-radio";

    export default {
        name: 'Menu',
        components: {CrudSelect, CrudRadio},
        data() {
            return {
                treeMenuData: [],
                treeMenuSelectData: [],
                dialogMenuVisible: false,
                dialogIconVisible: false,
                dialogFormVisible: false,
                searchFilterVisible: true,
                checkedKeys: [],
                list: null,
                total: null,
                listLoading: true,
                searchForm: {},
                listQuery: {
                    current: 1,
                    size: 20
                },
                formEdit: true,
                filterTreeMenuText: '',
                filterParentTreeMenuText: '',
                filterFormText: '',
                formStatus: '',
                flagOptions: [],
                menuTypeOptions: [],
                searchTree: false,
                labelPosition: 'right',
                disableSelectMenuParent: false,
                form: {
                    name: undefined,
                    parentId: undefined,
                    permission: undefined,
                    icon: undefined,
                    component: undefined,
                    type: undefined,
                    keepAlive: undefined,
                    show: undefined,
                    path: undefined,
                    sort: undefined,
                    description: undefined
                },
                validateUnique: (rule, value, callback) => {
                    validate.isUnique(rule, value, callback, '/sys/menu/checkByProperty?id=' + util.objToStr(this.form.id))
                },
                dialogStatus: 'create',
                textMap: {
                    update: '编辑',
                    create: '创建'
                },
                sys_menu_edit: false,
                sys_menu_lock: false,
                sys_menu_del: false,
                currentNode: {},
                tableKey: 0
            }
        },
        watch: {
            filterTreeMenuText(val) {
                this.$refs['leftMenuTree'].filter(val);
            },
            filterParentTreeMenuText(val) {
                this.$refs['selectParentMenuTree'].filter(val);
            },
        },
        created() {
            this.getTreeMenu();
            this.sys_menu_edit = this.permissions["sys_menu_edit"];
            this.sys_menu_lock = this.permissions["sys_menu_lock"];
            this.sys_menu_del = this.permissions["sys_menu_del"];
            this.flagOptions = this.dicts['sys_flag'];
            this.menuTypeOptions = this.dicts['sys_menu_type'];

        },
        computed: {
            ...mapGetters([
                "permissions", "dicts"
            ])
        },
        methods: {
            getList() {
                this.listLoading = true;
                this.listQuery.queryConditionJson = util.parseJsonItemForm([{
                    fieldName: 'name', value: this.searchForm.name
                }, {
                    fieldName: 'component', value: this.searchForm.component
                }, {
                    fieldName: 'parent_id', value: this.searchForm.parentId, operate: 'eq'
                }]);
                menuService.page(this.listQuery).then(response => {
                    this.list = response.data.records;
                    this.total = response.data.total;
                    this.listLoading = false;
                });
            },
            sortChange(column) {
                if (column.order == "ascending") {
                    this.listQuery.ascs = column.prop;
                    this.listQuery.descs = undefined;
                } else {
                    this.listQuery.descs = column.prop;
                    this.listQuery.ascs = undefined;
                }
                this.getList()
            },
            getTreeMenu() {
                menuService.fetchTree().then(response => {
                    this.treeMenuData = util.parseTreeData(response.data);
                    this.currentNode = this.treeMenuData[0];
                    this.searchForm.parentId = this.treeMenuData[0].id;
                    setTimeout(() => {
                        this.$refs['leftMenuTree'].setCurrentKey(this.searchForm.parentId);
                    }, 100);
                    this.getList();
                })
            },
            filterNode(value, data) {
                if (!value) return true;
                return data.label.indexOf(value) !== -1
            },
            clickNodeTreeData(data) {
                this.searchForm.parentId = data.id;
                this.currentNode = data;
                this.getList()
            },
            clickNodeSelectData(data) {
                this.form.parentId = data.id;
                this.form.parentName = data.label;
                this.dialogMenuVisible = false;
            },
            handelParentMenuTree() {
                menuService.fetchTree({extId: this.form.id}).then(response => {
                    this.treeMenuSelectData = util.parseTreeData(response.data);
                    this.dialogMenuVisible = true;
                    setTimeout(() => {
                        this.$refs['selectParentMenuTree'].setCurrentKey(this.form.parentId ? this.form.parentId : null);
                    }, 100);
                });
            },
            //搜索清空
            searchReset() {
                this.$refs['searchForm'].resetFields();
                this.searchForm.parentId = undefined;
                this.$refs['leftMenuTree'].setCurrentKey(null);
                this.currentNode = undefined;
            },
            handleFilter() {
                this.listQuery.current = 1;
                this.getList();
            },
            handleSizeChange(val) {
                this.listQuery.size = val;
                this.getList();
            },
            handleCurrentChange(val) {
                this.listQuery.current = val;
                this.getList();
            },
            handleEdit(row) {
                this.resetForm();
                this.dialogStatus = row && validate.checkNotNull(row.id) ? "update" : "create";
                if (this.dialogStatus == "create") {
                    if (this.currentNode) {
                        this.form.parentId = this.currentNode.id;
                        this.form.parentName = this.currentNode.label;
                    }
                    this.dialogFormVisible = true;
                } else {
                    menuService.find(row.id).then(response => {
                        this.form = response.data;
                        this.disableSelectMenuParent = this.form.parentName ? false : true;
                        this.form.show = util.objToStr(this.form.show);
                        this.dialogFormVisible = true;
                    });
                }
            },
            handleEditSort() {
                let sortData = [];
                this.list.forEach(item => {
                    sortData.push({id: item.id, sort: this.$refs["sort" + item.id].value})
                });
                menuService.sortUpdate({"menuSortVoList": sortData}).then(response => {
                    this.getList()
                })
            },
            handleLock: function (row) {
                menuService.lock(row.id).then(response => {
                    this.getList();
                });
            },
            handleDelete(row) {
                this.$confirm('此操作将永久删除, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    menuService.remove(row.id).then(response => {
                        this.getList();
                    })
                })
            },
            handleIcon() {
                this.dialogIconVisible = true;
            },
            save() {
                this.$refs['form'].validate(valid => {
                    if (valid) {
                        menuService.save(this.form).then(response => {
                            this.getList();
                            this.dialogFormVisible = false;
                        })
                    } else {
                        return false;
                    }
                });
            },
            cancel() {
                this.dialogFormVisible = false;
                this.$refs['form'].resetFields();
            },
            resetForm() {
                this.form = {
                    name: undefined,
                    parentId: undefined,
                    permission: undefined,
                    icon: undefined,
                    component: undefined,
                    type: undefined,
                    keepAlive: undefined,
                    show: undefined,
                    path: undefined,
                    sort: undefined,
                    description: undefined
                };
                this.$refs['form'] && this.$refs['form'].resetFields();
            }
        }
    }
</script>

