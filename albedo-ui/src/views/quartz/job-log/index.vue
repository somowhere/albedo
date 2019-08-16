<template>
  <div class="app-container calendar-list-container">
    <basic-container>
      <div class="filter-container">
        <el-form :inline="true" :model="searchJobLogForm" ref="searchJobLogForm" v-show="searchFilterVisible">
          <el-form-item label="任务名称" prop="jobName">
            <el-input class="filter-item input-normal" v-model="searchJobLogForm.jobName"></el-input>
          </el-form-item>
          <el-form-item label="任务组名" prop="jobGroup">
            <el-input class="filter-item input-normal" v-model="searchJobLogForm.jobGroup"></el-input>
          </el-form-item>
          <el-form-item label="执行状态" prop="status">
            <CrudRadio :dic="statusOptions" v-model="searchJobLogForm.status"></CrudRadio>
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
            <el-button @click="handleClean" icon="icon-export" size="mini" type="primary"
                       v-if="quartz_jobLog_clean">清空
            </el-button>
            <el-button @click="handleExport" icon="icon-export" size="mini" type="primary"
                       v-if="quartz_jobLog_export">导出
            </el-button>
          </el-button-group>
        </div>
        <div class="table-menu-right">
          <el-button @click="searchFilterVisible= !searchFilterVisible" circle icon="el-icon-search"
                     size="mini"></el-button>
        </div>
      </div>
      <el-table :data="list" :key='tableKey' @sort-change="sortChange" element-loading-text="加载中..."
                fit highlight-current-row v-loading="listLoading">
        <el-table-column align="center" label="任务名称">
          <template slot-scope="scope">
            <span>{{scope.row.jobName}}</span>
          </template>
        </el-table-column>
        <el-table-column align="center" label="任务组名">
          <template slot-scope="scope">
            <span>{{scope.row.jobGroup}}</span>
          </template>
        </el-table-column>
        <el-table-column align="center" label="调用目标字符串">
          <template slot-scope="scope">
            <span>{{scope.row.invokeTarget}}</span>
          </template>
        </el-table-column>
        <el-table-column align="center" label="执行状态">
          <template slot-scope="scope">
            <el-tag>{{scope.row.statusText}}</el-tag>
          </template>
        </el-table-column>
        <el-table-column align="center" label="开始时间">
          <template slot-scope="scope">
            <span>{{scope.row.startTime}}</span>
          </template>
        </el-table-column>
        <el-table-column align="center" label="结束时间">
          <template slot-scope="scope">
            <span>{{scope.row.endTime}}</span>
          </template>
        </el-table-column>
        <el-table-column align="center" label="创建时间">
          <template slot-scope="scope">
            <span>{{scope.row.createTime}}</span>
          </template>
        </el-table-column>
        <el-table-column align="center" label="日志信息">
          <template slot-scope="scope">
            <span>{{scope.row.jobMessage}}</span>
          </template>
        </el-table-column>
        <el-table-column align="center" label="异常信息">
          <template slot-scope="scope">
            <span>{{scope.row.exceptionInfo}}</span>
          </template>
        </el-table-column>
        <el-table-column align="center" fixed="right" label="操作" v-if="quartz_jobLog_del">
          <template slot-scope="scope">
            <el-button @click="handleDelete(scope.row)" icon="icon-delete" title="删除" type="text"
                       v-if="quartz_jobLog_del">
            </el-button>
          </template>
        </el-table-column>

      </el-table>

      <div class="pagination-container" v-show="!listLoading">
        <el-pagination :current-page.sync="listQuery.page" :page-size="listQuery.size"
                       :page-sizes="[10,20,30, 50]" :total="total" @current-change="handleCurrentChange"
                       @size-change="handleSizeChange" layout="total, sizes, prev, pager, next, jumper">
        </el-pagination>
      </div>
    </basic-container>
  </div>
</template>

<script>
    import jobLogService from "./job-log-service";
    import {mapGetters} from "vuex";
    import util from "@/util/util";
    import CrudSelect from "@/views/avue/crud-select";
    import CrudCheckbox from "@/views/avue/crud-checkbox";
    import CrudRadio from "@/views/avue/crud-radio";
    import {baseUrl} from "../../../config/env";

    export default {
        name: "table_quartz_jobLog",
        components: {CrudSelect, CrudCheckbox, CrudRadio},
        data() {
            return {
                searchFilterVisible: true,
                list: null,
                total: null,
                listLoading: true,
                searchJobLogForm: {},
                listQuery: {
                    page: 1,
                    size: 20
                },
                statusOptions: undefined,
                tableKey: 0
            };
        },
        computed: {
            ...mapGetters(["permissions", "dicts"])
        },
        filters: {},
        created() {
            this.getList();
            this.quartz_jobLog_export = this.permissions["quartz_jobLog_export"];
            this.quartz_jobLog_clean = this.permissions["quartz_jobLog_clean"];
            this.quartz_jobLog_del = this.permissions["quartz_jobLog_del"];
            this.statusOptions = this.dicts["sys_status"];
        },
        methods: {
            getList() {
                this.listLoading = true;
                this.listQuery.queryConditionJson = util.parseJsonItemForm([
                    {fieldName: 'jobName', value: this.searchJobLogForm.jobName, operate: 'like', attrType: 'String'},
                    {fieldName: 'jobGroup', value: this.searchJobLogForm.jobGroup, operate: 'like', attrType: 'String'},
                    {fieldName: 'status', value: this.searchJobLogForm.status, operate: 'eq', attrType: 'String'},
                ]);
                jobLogService.page(this.listQuery).then(response => {
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
            searchReset() {
                this.$refs['searchJobLogForm'].resetFields();
            },
            handleFilter() {
                this.listQuery.page = 1;
                this.getList();
            },
            handleSizeChange(val) {
                this.listQuery.size = val;
                this.getList();
            },
            handleCurrentChange(val) {
                this.listQuery.page = val;
                this.getList();
            },
            handleDelete(row) {
                this.$confirm(
                    "此操作将永久删除该任务调度日志, 是否继续?",
                    "提示",
                    {
                        confirmButtonText: "确定",
                        cancelButtonText: "取消",
                        type: "warning"
                    }
                ).then(() => {
                    jobLogService.remove(row.id).then((data) => {
                        this.getList();
                    });
                });
            },
            handleClean(row) {
                this.$confirm('确定要此操作吗?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    jobLogService.clean(row.id).then((rs) => {
                        this.getList();
                    })
                })
            },
            handleExport() {
                jobLogService.export(this.listQuery).then(response => {
                    window.location.href = `${window.location.origin}` + baseUrl + "/file/download?fileName=" + encodeURI(response.data) + "&delete=" + true;
                });
            }
        }
    };
</script>
