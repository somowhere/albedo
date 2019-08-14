<template>
  <div class="app-container calendar-list-container">
    <basic-container>
      <el-row>

        <el-col>
          <div class="filter-container" v-show="searchFilterVisible">
            <el-form :inline="true" :model="searchForm" ref="searchForm">
              <el-form-item label="名称" prop="username">
                <el-input class="filter-item input-normal" size="small" v-model="searchForm.username"></el-input>
              </el-form-item>

              <el-form-item label="会话状态" prop="status">
                <CrudRadio v-model="searchForm.status" :dic="sysOnlineStatusOptions"></CrudRadio>
              </el-form-item>
              <el-form-item>
                <el-button size="small" type="primary" icon="el-icon-search" @click="handleFilter">查询</el-button>
                <el-button size="small" @click="searchReset" icon="icon-rest">重置</el-button>
              </el-form-item>
            </el-form>
          </div>
          <!-- 表格功能列 -->

          <div class="table-menu">
            <div class="table-menu-left">
            </div>
            <div class="table-menu-right">
              <el-button icon="el-icon-search" circle size="mini"
                         @click="searchFilterVisible= !searchFilterVisible"></el-button>
            </div>
          </div>
          <el-table :key='tableKey' @sort-change="sortChange" :data="list" v-loading="listLoading"
                    :default-sort="{prop:'start_timestamp',order:'descending'}"
                    element-loading-text="加载中..." fit highlight-current-row>
            <el-table-column
              type="index" fixed="left" width="50">
            </el-table-column>
            <el-table-column align="center" label="会话编号">
              <template slot-scope="scope">
              <span>
                {{scope.row.sessionId}}
              </span>
              </template>
            </el-table-column>

            <el-table-column align="center" label="登录名称" width="120">
              <template slot-scope="scope">
              <span>
                {{scope.row.username}}
              </span>
              </template>
            </el-table-column>
            <el-table-column align="center" label="部门名称" width="120">
              <template slot-scope="scope">
              <span>
                {{scope.row.deptName}}
              </span>
              </template>
            </el-table-column>
            <el-table-column align="center" label="主机" width="120">
              <template slot-scope="scope">
              <span>
                {{scope.row.ipAddress}}
              </span>
              </template>
            </el-table-column>
            <el-table-column align="center" label="登录地点">
              <template slot-scope="scope">
              <span>
                {{scope.row.loginLocation}}
              </span>
              </template>
            </el-table-column>
            <!--            <el-table-column align="center" label="浏览器">-->
            <!--              <template slot-scope="scope">-->
            <!--              <span>-->
            <!--                {{scope.row.browser}}-->
            <!--              </span>-->
            <!--              </template>-->
            <!--            </el-table-column>-->
            <!--            <el-table-column align="center" label="操作系统">-->
            <!--              <template slot-scope="scope">-->
            <!--              <span>-->
            <!--                {{scope.row.os}}-->
            <!--              </span>-->
            <!--              </template>-->
            <!--            </el-table-column>-->
            <el-table-column align="center" label="会话状态" width="100">
              <template slot-scope="scope">
              <span>
                {{scope.row.statusText}}
              </span>
              </template>
            </el-table-column>

            <el-table-column align="center" label="登录时间" prop="start_timestamp" sortable="custom">
              <template slot-scope="scope">
                <span>{{scope.row.startTimestamp}} </span>
              </template>
            </el-table-column>
            <el-table-column align="center" label="最后访问时间" prop="last_access_time" sortable="custom">
              <template slot-scope="scope">
              <span>
                {{scope.row.lastAccessTime}}
              </span>
              </template>
            </el-table-column>
            <el-table-column align="center" label="操作" fixed="right" width="180" v-if="sys_persistentToken_del">
              <template slot-scope="scope">
                <el-button v-if="sys_persistentToken_del" icon="icon-rest" title="强退" type="text"
                           @click="handleLogout(scope.row)">强退
                </el-button>
                <el-button v-if="sys_persistentToken_del" icon="icon-delete" title="删除" type="text"
                           @click="handleDelete(scope.row)">删除
                </el-button>
              </template>
            </el-table-column>

          </el-table>
          <div v-show="!listLoading" class="pagination-container">
            <el-pagination class="pull-right" background @size-change="handleSizeChange"
                           @current-change="handleCurrentChange" :current-page.sync="listQuery.current"
                           :page-sizes="[10,20,30, 50]" :page-size="listQuery.size"
                           layout="total, sizes, prev, pager, next, jumper" :total="total">
            </el-pagination>
          </div>
        </el-col>
      </el-row>
    </basic-container>
  </div>
</template>

<script>
    import {forceLogout, pageToken, removeToken} from "./service";
    import {mapGetters} from 'vuex';
    import {parseJsonItemForm} from "@/util/util";
    import CrudSelect from "@/views/avue/crud-select";
    import CrudRadio from "@/views/avue/crud-radio";

    export default {
        components: {CrudSelect, CrudRadio},
        name: 'Token',
        data() {
            return {
                treeMenuData: [],
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
                sysOnlineStatusOptions: [],
                sys_persistentToken_del: false,
                currentNode: {},
                tableKey: 0
            }
        },
        watch: {},
        created() {
            this.getList()
            this.sysOnlineStatusOptions = this.dicts["sys_online_status"]
            this.sys_persistentToken_del = this.permissions["sys_persistentToken_del"];
        },
        computed: {
            ...mapGetters([
                "permissions", "dicts"
            ])
        },
        methods: {
            getList() {
                this.listLoading = true;
                this.listQuery.queryConditionJson = parseJsonItemForm([{
                    fieldName: 'username', value: this.searchForm.username
                }, {
                    fieldName: 'status', value: this.searchForm.status
                }])
                pageToken(this.listQuery).then(response => {
                    this.list = response.data.records;
                    this.total = response.data.total;
                    this.listLoading = false;
                });
            },
            sortChange(column) {
                if (column.order == "ascending") {
                    this.listQuery.ascs = column.prop
                    this.listQuery.descs = undefined;
                } else {
                    this.listQuery.descs = column.prop
                    this.listQuery.ascs = undefined;
                }
                this.getList()
            },

            //搜索清空
            searchReset() {
                this.$refs['searchForm'].resetFields();
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
            handleLogout(row) {
                this.$confirm('确定要强制选中用户下线吗？', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    forceLogout(row.id).then(response => {
                        this.getList();
                    })
                })
            },
            handleDelete(row) {
                this.$confirm('确定要强制删除选中用户吗？', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    removeToken(row.id).then(response => {
                        this.getList();
                    })
                })
            }
        }
    }
</script>

