<template>
  <div class="app-container calendar-list-container">
    <basic-container>
      <div class="filter-container">
        <el-form :inline="true" :model="searchJobForm" ref="searchJobForm" v-show="searchFilterVisible">
          <el-form-item label="任务名称" prop="name">
            <el-input class="filter-item input-normal" v-model="searchJobForm.name"></el-input>
          </el-form-item>
          <el-form-item label="任务组名" prop="group">
            <el-input class="filter-item input-normal" v-model="searchJobForm.group"></el-input>
          </el-form-item>
          <el-form-item>
            <el-button @click="handleFilter" icon="el-icon-search" size="small" type="primado">查询</el-button>
            <el-button @click="searchReset" icon="icon-rest" size="small">重置</el-button>
          </el-form-item>
        </el-form>
      </div>

      <!-- 表格功能列 -->
      <div class="table-menu">
        <div class="table-menu-left">
          <el-button-group>
            <el-button @click="handleEdit" class="filter-item" icon="edit" size="mini" type="primado"
                       v-if="quartz_job_edit">添加
            </el-button>
            <el-button @click="handleJobLog" class="filter-item" icon="edit" size="mini" type="primado"
                       v-if="quartz_job_log_view">执行日志
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
            <span>{{scope.row.name}}</span>
          </template>
        </el-table-column>
        <el-table-column align="center" label="任务组名">
          <template slot-scope="scope">
            <span>{{scope.row.group}}</span>
          </template>
        </el-table-column>
        <el-table-column align="center" label="调用目标">
          <template slot-scope="scope">
            <span>{{scope.row.invokeTarget}}</span>
          </template>
        </el-table-column>
        <el-table-column align="center" label="cron表达式">
          <template slot-scope="scope">
            <span>{{scope.row.cronExpression}}</span>
          </template>
        </el-table-column>
        <el-table-column align="center" label="执行失败策略" width="120">
          <template slot-scope="scope">
            <el-tag>{{scope.row.misfirePolicyText}}</el-tag>
          </template>
        </el-table-column>
        <el-table-column align="center" label="是否并发执行" width="120">
          <template slot-scope="scope">
            <el-switch
              @change="concurrentChange(scope.row.available, scope.row.id)"
              active-value="1" inactive-value="0" v-model="scope.row.concurrent">
            </el-switch>
          </template>
        </el-table-column>
        <el-table-column align="center" label="是否启用" width="120">
          <template slot-scope="scope">
            <el-switch
              @change="availableChange(scope.row.available, scope.row.id)"
              active-value="1" inactive-value="0" v-model="scope.row.available">
            </el-switch>
          </template>
        </el-table-column>
        <el-table-column align="center" fixed="right" label="操作" v-if="quartz_job_edit || quartz_job_del">
          <template slot-scope="scope">
            <el-button @click="handleRun(scope.row)" icon="icon-edit" title="执行" type="text" v-if="quartz_job_run">
              执行
            </el-button>
            <el-button @click="handleEdit(scope.row)" icon="icon-edit" title="编辑" type="text" v-if="quartz_job_edit">
              编辑
            </el-button>
            <el-button @click="handleDelete(scope.row)" icon="icon-delete" title="删除" type="text" v-if="quartz_job_del">
              删除
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
      <el-dialog :title="textMap[dialogStatus]" :visible.sync="dialogFormVisible">
        <el-form :model="form" label-width="100px" ref="form">
          <el-form-item :rules="[{required: true,message: '请输入任务名称'},{min: 0,max: 64,message: '长度在 0 到 64 个字符'},]"
                        label="任务名称"
                        prop="name">
            <el-input v-model="form.name"></el-input>

          </el-form-item>
          <el-form-item :rules="[{required: true,message: '请输入任务组名'}]" label="任务组名" prop="group">
            <CrudSelect :dic="jobGroupOptions" v-model="form.group"></CrudSelect>
          </el-form-item>
          <el-form-item :rules="[{required: true,message: '请输入调用目标'},{min: 0,max: 500,message: '长度在 0 到 500 个字符'},]"
                        label="调用目标"
                        prop="invokeTarget">
            <el-input v-model="form.invokeTarget"></el-input>
            <div>
              <el-tag size="mini" type="info">Bean调用示例：simpleTask.doParams('albedo')</el-tag>
              <el-tag size="mini" type="info">
                Class类调用示例：com.albedo.java.modules.quartz.task.SimpleTask.doParams('albedo')
                参数说明：支持字符串，布尔类型，长整型，浮点型，整型
              </el-tag>
              <el-tag size="mini" type="info">参数说明：支持字符串，布尔类型，长整型，浮点型，整型</el-tag>
            </div>
          </el-form-item>
          <el-form-item :rules="[{validator: validateCronExpression}]" label="cron表达式" prop="cronExpression">
            <el-input v-model="form.cronExpression"></el-input>

          </el-form-item>
          <el-form-item :rules="[{required: true},]" label="执行失败策略" prop="misfirePolicy">
            <CrudSelect :dic="misfirePolicyOptions" v-model="form.misfirePolicy"></CrudSelect>
            <div>
              <el-tag size="mini" type="info">计划执行错误策略</el-tag>
            </div>
          </el-form-item>
          <el-form-item :rules="[{required: true},]" label="是否并发执行" prop="concurrent">
            <CrudRadio :dic="concurrentOptions" v-model="form.concurrent"></CrudRadio>

          </el-form-item>
          <el-form-item :rules="[{required: true},]" label="是否启用" prop="available">
            <CrudRadio :dic="availableOptions" v-model="form.available"></CrudRadio>
          </el-form-item>
          <el-form-item :rules="[{min: 0,max: 255,message: '长度在 0 到 255 个字符'},]" label="备注" prop="description">
            <el-input type="textarea" v-model="form.description"></el-input>

          </el-form-item>
        </el-form>
        <div class="dialog-footer" slot="footer">
          <el-button @click="cancel()">取 消</el-button>
          <el-button @click="save()" type="primado">保 存</el-button>
        </div>
      </el-dialog>

      <el-dialog :visible.sync="dialogJobLogVisible" title="任务调度日志" width="90%">
        <div class="app-container calendar-listJobLog-container">
          <basic-container>
            <div class="filter-container">
              <el-form :inline="true" :model="searchJobLogForm" ref="searchJobLogForm"
                       v-show="searchJobLogFilterVisible">
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
                  <el-button @click="handleJobLogFilter" icon="el-icon-search" size="small" type="primary">查询
                  </el-button>
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
            <el-table :data="listJobLog" :key='tableKeyJobLog' @sort-change="sortChangeJobLog"
                      element-loading-text="加载中..."
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
      </el-dialog>
    </basic-container>
  </div>
</template>

<script>
    import jobService from "./job-service";
    import {mapGetters} from "vuex";
    import util from "@/util/util";
    import CrudSelect from "@/components/avue/crud-select";
    import CrudCheckbox from "@/components/avue/crud-checkbox";
    import CrudRadio from "@/components/avue/crud-radio";
    import validate from "../../../util/validate";
    import jobLogService from "./job-log-service";
    import {baseUrl} from "../../../config/env";

    export default {
        name: "table_quartz_job",
        components: {CrudSelect, CrudCheckbox, CrudRadio},
        data() {
            return {
                searchFilterVisible: true,
                dialogFormVisible: false,
                dialogJobLogVisible: false,
                list: null,
                total: null,
                listLoading: true,
                searchJobForm: {},
                listQuery: {
                    page: 1,
                    size: 20
                },
                form: {
                    name: undefined,
                    group: undefined,
                    invokeTarget: undefined,
                    cronExpression: undefined,
                    misfirePolicy: undefined,
                    concurrent: undefined,
                    available: undefined,
                    description: undefined,
                },
                sortList: [],
                validateCronExpression: (rule, value, callback) => {
                    jobService.validateCronExpression(rule, value, callback, this.form.id)
                },
                misfirePolicyOptions: undefined,
                concurrentOptions: undefined,
                availableOptions: undefined,
                dialogStatus: 'create',
                textMap: {
                    update: '编辑任务调度',
                    create: '创建任务调度'
                },
                tableKey: 0,
                searchJobLogFilterVisible: false,
                listJobLog: null,
                totalJobLog: null,
                listJobLogLoading: true,
                searchJobLogForm: {},
                listJobLogQuery: {
                    page: 1,
                    size: 10
                },
                tableKeyJobLog: 1
            };
        },
        computed: {
            ...mapGetters(["permissions", "dicts"])
        },
        filters: {},
        created() {
            this.getList();
            this.quartz_job_run = this.permissions["quartz_job_run"];
            this.quartz_job_edit = this.permissions["quartz_job_edit"];
            this.quartz_job_log_view = this.permissions["quartz_job_log_view"];
            this.quartz_job_del = this.permissions["quartz_job_del"];
            this.quartz_jobLog_export = this.permissions["quartz_jobLog_export"];
            this.quartz_jobLog_clean = this.permissions["quartz_jobLog_clean"];
            this.quartz_jobLog_del = this.permissions["quartz_jobLog_del"];
            this.statusOptions = this.dicts["sys_status"];
            this.jobGroupOptions = this.dicts["sys_job_group"];
            this.misfirePolicyOptions = this.dicts["sys_misfire_policy"];
            this.concurrentOptions = this.dicts["sys_flag"];
            this.availableOptions = this.dicts["sys_flag"];
        },
        methods: {
            getList() {
                this.listLoading = true;
                this.listQuery.quedoConditionJson = util.parseJsonItemForm([
                    {fieldName: 'name', value: this.searchJobForm.name, operate: 'like', attrType: 'String'},
                    {fieldName: 'group', value: this.searchJobForm.group, operate: 'like', attrType: 'String'},
                ]);
                jobService.page(this.listQuery).then(response => {
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
                this.$refs['searchJobForm'].resetFields();
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
            handleEdit(row) {
                this.resetForm();
                this.dialogStatus = row && !validate.checkNull(row.id) ? "update" : "create";
                if (this.dialogStatus == "create") {
                    this.dialogFormVisible = true;
                } else {
                    jobService.find(row.id).then(response => {
                        this.form = response.data;
                        this.form.misfirePolicy = util.objToStr(this.form.misfirePolicy);
                        this.form.concurrent = util.objToStr(this.form.concurrent);
                        this.form.available = util.objToStr(this.form.available);
                        this.form.delFlag = util.objToStr(this.form.delFlag);
                        this.dialogFormVisible = true;
                    });
                }
            },
            handleJobLog(row) {
                this.dialogJobLogVisible = true;
                this.getListJobLog();
            },
            availableChange(available, id) {
                this.$confirm(
                    "您确定要执行此操作吗?",
                    "提示",
                    {
                        confirmButtonText: "确定",
                        cancelButtonText: "取消",
                        type: "warning"
                    }
                ).then(() => {
                    jobService.available(id).then((data) => {
                        this.getList();
                    });
                });
            },
            concurrentChange(concurrent, id) {
                this.$confirm(
                    "您确定要执行此操作吗?",
                    "提示",
                    {
                        confirmButtonText: "确定",
                        cancelButtonText: "取消",
                        type: "warning"
                    }
                ).then(() => {
                    jobService.concurrent(id).then((data) => {
                        this.getList();
                    });
                });
            },
            cancel() {
                this.dialogFormVisible = false;
                this.$refs['form'].resetFields();
            },
            save() {
                const set = this.$refs;
                set['form'].validate(valid => {
                    if (valid) {
                        jobService.save(this.form).then((data) => {
                            this.getList();
                            this.cancel()
                        });
                    } else {
                        return false;
                    }
                });
            },
            handleRun(row) {
                this.$confirm(
                    "此操作将永久删除该任务调度, 是否继续?",
                    "提示",
                    {
                        confirmButtonText: "确定",
                        cancelButtonText: "取消",
                        type: "warning"
                    }
                ).then(() => {
                    jobService.run(row.id).then((data) => {
                        this.getList();
                    });
                });
            },
            handleDelete(row) {
                this.$confirm(
                    "此操作将永久删除该任务调度, 是否继续?",
                    "提示",
                    {
                        confirmButtonText: "确定",
                        cancelButtonText: "取消",
                        type: "warning"
                    }
                ).then(() => {
                    jobService.remove(row.id).then((data) => {
                        this.getList();
                    });
                });
            },
            resetForm() {
                this.form = {
                    name: "",
                    group: "",
                    invokeTarget: "",
                    cronExpression: "",
                    misfirePolicy: "",
                    concurrent: "",
                    available: "",
                    description: "",
                };
                this.$refs['form'] && this.$refs['form'].resetFields();
            },
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
