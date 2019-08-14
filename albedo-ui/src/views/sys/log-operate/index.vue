<template>
  <div class="app-container calendar-list-container">
    <basic-container>
      <el-row v-show="sys_logOperate_view">

        <el-col>
          <div class="filter-container" v-show="searchFilterVisible">
            <el-form :inline="true" :model="searchForm" ref="searchForm">
              <el-form-item label="标题" prop="title">
                <el-input size="small" v-model="searchForm.title"></el-input>
              </el-form-item>
              <el-form-item label="IP地址" prop="remoteAddr">
                <el-input size="small" v-model="searchForm.remoteAddr"></el-input>
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
              <el-button size="mini" v-if="sys_logOperate_export" @click="handleExport" type="primary"
                         icon="icon-export">导出
              </el-button>
            </div>
            <div class="table-menu-right">
              <el-button icon="el-icon-search" circle size="mini"
                         @click="searchFilterVisible= !searchFilterVisible"></el-button>
            </div>
          </div>
          <el-table :key='tableKey' @sort-change="sortChange" :default-sort="{prop:'created_date',order:'descending'}"
                    :data="list" v-loading="listLoading" element-loading-text="加载中..." fit highlight-current-row>
            <el-table-column
              type="index" fixed="left" width="50">
            </el-table-column>
            <el-table-column align="center" label="标题" width="120">
              <template slot-scope="scope">
                <span>{{scope.row.title}}</span>
              </template>
            </el-table-column>

            <el-table-column align="center" label="业务类型" width="100">
              <template slot-scope="scope">
                <span>{{scope.row.businessTypeText}}</span>
              </template>
            </el-table-column>
            <el-table-column align="center" label="操作类别" width="100">
              <template slot-scope="scope">
                <span>{{scope.row.operatorTypeText}}</span>
              </template>
            </el-table-column>
            <el-table-column align="center" label="IP地址" width="120">
              <template slot-scope="scope">
              <span>
                {{scope.row.ipAddress}}
              </span>
              </template>
            </el-table-column>
            <!--            <el-table-column align="center" label="服务" width="120">-->
            <!--              <template slot-scope="scope">-->
            <!--              <span>-->
            <!--                {{scope.row.serviceId}}-->
            <!--              </span>-->
            <!--              </template>-->
            <!--            </el-table-column>-->
            <!--            <el-table-column align="center" label="客户端">-->
            <!--              <template slot-scope="scope">-->
            <!--              <span>-->
            <!--                {{scope.row.userAgent}}-->
            <!--              </span>-->
            <!--              </template>-->
            <!--            </el-table-column>-->
            <!--            <el-table-column align="center" label="请求地址">-->
            <!--              <template slot-scope="scope">-->
            <!--              <span>-->
            <!--                {{scope.row.requestUri}}-->
            <!--              </span>-->
            <!--              </template>-->
            <!--            </el-table-column>-->

            <el-table-column align="center" label="IP位置" width="100">
              <template slot-scope="scope">
          <span>
            {{scope.row.ipLocation}}
          </span>
              </template>
            </el-table-column>
            <el-table-column align="center" label="浏览器类型" width="100">
              <template slot-scope="scope">
          <span>
            {{scope.row.browser}}
          </span>
              </template>
            </el-table-column>
            <el-table-column align="center" label="操作系统">
              <template slot-scope="scope">
          <span>
            {{scope.row.os}}
          </span>
              </template>
            </el-table-column>
            <el-table-column align="center" label="请求方式" width="100">
              <template slot-scope="scope">
          <span>
            {{scope.row.method}}
          </span>
              </template>
            </el-table-column>
            <el-table-column align="center" label="请求时间" width="100">
              <template slot-scope="scope">
                <el-tag>{{scope.row.time}}</el-tag>
              </template>
            </el-table-column>
            <el-table-column align="center" label="操作人" width="120">
              <template slot-scope="scope">
                {{scope.row.username}}
              </template>
            </el-table-column>
            <el-table-column align="center" label="创建时间" prop="created_date" sortable="custom">
              <template slot-scope="scope">
                {{scope.row.createdDate}}
              </template>
            </el-table-column>

            <el-table-column align="center" label="操作" fixed="right" width="60" v-if="sys_logOperate_del">
              <template slot-scope="scope">
                <el-button v-if="sys_logOperate_del" icon="icon-delete" title="删除" type="text"
                           @click="handleDelete(scope.row)">
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
    import {exportLog, pageLog, removeLog} from "./service";
    import {mapGetters} from 'vuex';
    import {parseJsonItemForm} from "@/util/util";
    import {baseUrl} from "../../../config/env";

    export default {
        name: 'Log',
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
                flagOptions: [],
                dataScopeOptions: [],
                sys_logOperate_del: false,
                sys_logOperate_view: false,
                sys_logOperate_export: false,
                currentNode: {},
                tableKey: 0
            }
        },
        watch: {},
        created() {
            this.getList()
            this.sys_logOperate_view = this.permissions["sys_logOperate_view"];
            this.sys_logOperate_export = this.permissions["sys_logOperate_export"];
            this.sys_logOperate_del = this.permissions["sys_logOperate_del"];
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
                    fieldName: 'title', value: this.searchForm.title
                }, {
                    fieldName: 'remote_addr', value: this.searchForm.remoteAddr
                }

                ])
                pageLog(this.listQuery).then(response => {
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
            handleDelete(row) {
                this.$confirm('此操作将永久删除, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    removeLog(row.id).then((rs) => {
                        this.getList();
                    })
                })
            },
            handleExport() {
                exportLog(this.listQuery).then(response => {
                    console.log(response.data)
                    window.location.href = `${window.location.origin}` + baseUrl + "/file/download?fileName=" + encodeURI(response.data) + "&delete=" + true;
                });
            }
        }
    }
</script>

