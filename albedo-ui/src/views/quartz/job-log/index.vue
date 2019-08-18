<template>
  <div class="app-container calendar-listJobLog-container">
    <basic-container>
      <div class="filter-container">
        <el-form :inline="true" :model="searchJobLogForm" ref="searchJobLogForm" v-show="searchJobLogFilterVisible">
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
            <el-button @click="handleJobLogFilter" icon="el-icon-search" size="small" type="primary">查询</el-button>
            <el-button @click="searchResetJobLog" icon="icon-rest" size="small">重置</el-button>
          </el-form-item>
        </el-form>
      </div>
      <!-- 表格功能列 -->
      <div class="table-menu">
        <div class="table-menu-left">
          <el-button-group>
            <el-button @click="handleJobLogClean" icon="icon-export" size="mini" type="primary"
                       v-if="quartz_jobLog_clean">清空
            </el-button>
            <el-button @click="handleJobLogExport" icon="icon-export" size="mini" type="primary"
                       v-if="quartz_jobLog_export">导出
            </el-button>
          </el-button-group>
        </div>
        <div class="table-menu-right">
          <el-button @click="searchJobLogFilterVisible= !searchJobLogFilterVisible" circle icon="el-icon-search"
                     size="mini"></el-button>
        </div>
      </div>
      <el-table :data="listJobLog" :key='tableKeyJobLog' @sort-change="sortChangeJobLog" element-loading-text="加载中..."
                fit highlight-current-row v-loading="listJobLogLoading">
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
            <el-button @click="handleJobLogDelete(scope.row)" icon="icon-delete" title="删除" type="text"
                       v-if="quartz_jobLog_del">
            </el-button>
          </template>
        </el-table-column>

      </el-table>
      <div class="pagination-container" v-show="!listJobLogLoading">
        <el-pagination :current-page.sync="listJobLogQuery.current" :page-size="listJobLogQuery.size"
                       :page-sizes="[10,20,30, 50]"
                       :total="totalJobLog" @current-change="handleJobLogCurrentChange"
                       @size-change="handleJobLogSizeChange" background
                       class="pull-right" layout="total, sizes, prev, pager, next, jumper">
        </el-pagination>
      </div>
    </basic-container>
  </div>
</template>

<script>
    import {mapGetters} from "vuex";
    import util from "@/util/util";
    import CrudSelect from "@/components/avue/crud-select";
    import CrudCheckbox from "@/components/avue/crud-checkbox";
    import CrudRadio from "@/components/avue/crud-radio";
    import {baseUrl} from "../../../config/env";
    import jobLogService from "../job/job-log-service";

    export default {
        name: "table_quartz_jobLog",
        components: {CrudSelect, CrudCheckbox, CrudRadio},
        data() {
            return {
                searchJobLogFilterVisible: true,
                listJobLog: null,
                totalJobLog: null,
                listJobLogLoading: true,
                searchJobLogForm: {},
                listJobLogQuery: {
                    page: 1,
                    size: 20
                },
                tableKeyJobLog: 1
            };
        },
        computed: {
            ...mapGetters(["permissions", "dicts"])
        },
        filters: {},
        created() {
            this.getListJobLog();
            this.quartz_jobLog_export = this.permissions["quartz_jobLog_export"];
            this.quartz_jobLog_clean = this.permissions["quartz_jobLog_clean"];
            this.quartz_jobLog_del = this.permissions["quartz_jobLog_del"];
            this.statusOptions = this.dicts["sys_status"];
        },
        methods: {
            getListJobLog() {
                this.listJobLogLoading = true;
                this.listJobLogQuery.queryConditionJson = util.parseJsonItemForm([
                    {fieldName: 'jobName', value: this.searchJobLogForm.jobName, operate: 'like', attrType: 'String'},
                    {fieldName: 'jobGroup', value: this.searchJobLogForm.jobGroup, operate: 'like', attrType: 'String'},
                    {fieldName: 'status', value: this.searchJobLogForm.status, operate: 'eq', attrType: 'String'},
                ]);
                jobLogService.page(this.listJobLogQuery).then(response => {
                    this.listJobLog = response.data.records;
                    this.totalJobLog = response.data.total;
                    this.listJobLogLoading = false;
                });
            },
            sortChangeJobLog(column) {
                if (column.order == "ascending") {
                    this.listJobLogQuery.ascs = column.prop;
                    this.listJobLogQuery.descs = undefined;
                } else {
                    this.listJobLogQuery.descs = column.prop;
                    this.listJobLogQuery.ascs = undefined;
                }
                this.getListJobLog()
            },
            searchResetJobLog() {
                this.$refs['searchJobLogForm'].resetFields();
            },
            handleJobLogFilter() {
                this.listJobLogQuery.page = 1;
                this.getListJobLog();
            },
            handleJobLogSizeChange(val) {
                this.listJobLogQuery.size = val;
                this.getListJobLog();
            },
            handleJobLogCurrentChange(val) {
                this.listJobLogQuery.page = val;
                this.getListJobLog();
            },
            handleJobLogDelete(row) {
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
                        this.getListJobLog();
                    });
                });
            },
            handleJobLogClean(row) {
                this.$confirm('确定要此操作吗?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    jobLogService.clean(row.id).then((rs) => {
                        this.getListJobLog();
                    })
                })
            },
            handleJobLogExport() {
                jobLogService.export(this.listJobLogQuery).then(response => {
                    window.location.href = `${window.location.origin}` + baseUrl + "/file/download?fileName=" + encodeURI(response.data) + "&delete=" + true;
                });
            }
        }
    };
</script>
