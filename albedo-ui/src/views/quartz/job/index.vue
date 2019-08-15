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
            <el-button @click="handleFilter" icon="el-icon-search" size="small" type="primary">查询</el-button>
            <el-button @click="searchReset" icon="icon-rest" size="small">重置</el-button>
          </el-form-item>
        </el-form>
      </div>

      <!-- 表格功能列 -->
      <div class="table-menu">
        <div class="table-menu-left">
          <el-button-group>
            <el-button @click="handleEdit" class="filter-item" icon="edit" size="mini" type="primary"
                       v-if="quartz_job_edit">添加
            </el-button>
            <el-button @click="handleEdit" class="filter-item" icon="edit" size="mini" type="primary"
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
          <el-table-column fixed="left" type="index" width="60"></el-table-column>
          <el-form-item :rules="[{required: true,message: '请输入任务名称'},{min: 0,max: 64,message: '长度在 0 到 64 个字符'},]" label="任务名称"
                        prop="name">
            <el-input v-model="form.name"></el-input>

          </el-form-item>
          <el-form-item :rules="[{required: true,message: '请输入任务组名'}]" label="任务组名" prop="group">
            <CrudSelect :dic="jobGroupOptions" v-model="form.group"></CrudSelect>
          </el-form-item>
          <el-form-item :rules="[{required: true,message: '请输入调用目标'},{min: 0,max: 500,message: '长度在 0 到 500 个字符'},]" label="调用目标"
                        prop="invokeTarget">
            <el-input v-model="form.invokeTarget"></el-input>
            <div>
              <el-tag size="mini" type="info">Bean调用示例：simpleTask.ryParams('ry')</el-tag>
              <el-tag size="mini" type="info">Class类调用示例：com.ruoyi.quartz.task.RyTask.ryParams('ry')
                参数说明：支持字符串，布尔类型，长整型，浮点型，整型
              </el-tag>
              <el-tag size="mini" type="info">参数说明：支持字符串，布尔类型，长整型，浮点型，整型</el-tag>
            </div>
          </el-form-item>
          <el-form-item :rules="[{min: 0,max: 255,message: '长度在 0 到 255 个字符'},]" label="cron表达式" prop="cronExpression">
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
          <el-button @click="save()" type="primary">保 存</el-button>
        </div>
      </el-dialog>
    </basic-container>
  </div>
</template>

<script>
    import {
        availableJob,
        concurrentJob,
        findJob,
        pageJob,
        removeJob,
        runJob,
        saveJob,
        validateUniqueJob
    } from "./service";
    import {mapGetters} from "vuex";
    import {isValidateDigits, isValidateNumber, objectToString, validateNull} from "@/util/validate";
    import {parseJsonItemForm} from "@/util/util";
    import CrudSelect from "@/views/avue/crud-select";
    import CrudCheckbox from "@/views/avue/crud-checkbox";
    import CrudRadio from "@/views/avue/crud-radio";

    export default {
        name: "table_quartz_job",
        components: {CrudSelect, CrudCheckbox, CrudRadio},
        data() {
            return {
                searchFilterVisible: true,
                dialogFormVisible: false,
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
                validateUnique: (rule, value, callback) => {
                    validateUniqueJob(rule, value, callback, this.form.id)
                },
                validateNumber: (rule, value, callback) => {
                    isValidateNumber(rule, value, callback)
                },
                validateDigits: (rule, value, callback) => {
                    isValidateDigits(rule, value, callback)
                },
                misfirePolicyOptions: undefined,
                concurrentOptions: undefined,
                availableOptions: undefined,
                delFlagOptions: undefined,
                dialogStatus: 'create',
                textMap: {
                    update: '编辑任务调度',
                    create: '创建任务调度'
                },
                tableKey: 0
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
            this.jobGroupOptions = this.dicts["sys_job_group"];
            this.misfirePolicyOptions = this.dicts["sys_misfire_policy"];
            this.concurrentOptions = this.dicts["sys_flag"];
            this.availableOptions = this.dicts["sys_flag"];
            this.delFlagOptions = this.dicts["sys_flag"];
        },
        methods: {
            getList() {
                this.listLoading = true;
                this.listQuery.queryConditionJson = parseJsonItemForm([
                    {fieldName: 'name', value: this.searchJobForm.name, operate: 'like', attrType: 'String'},
                    {fieldName: 'group', value: this.searchJobForm.group, operate: 'like', attrType: 'String'},
                ]);
                pageJob(this.listQuery).then(response => {
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
                this.dialogStatus = row && !validateNull(row.id) ? "update" : "create";
                if (this.dialogStatus == "create") {
                    this.dialogFormVisible = true;
                } else {
                    findJob(row.id).then(response => {
                        this.form = response.data;
                        this.form.misfirePolicy = objectToString(this.form.misfirePolicy);
                        this.form.concurrent = objectToString(this.form.concurrent);
                        this.form.available = objectToString(this.form.available);
                        this.form.delFlag = objectToString(this.form.delFlag);
                        this.dialogFormVisible = true;
                    });
                }
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
                    availableJob(id).then((data) => {
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
                    concurrentJob(id).then((data) => {
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
                        saveJob(this.form).then((data) => {
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
                    runJob(row.id).then((data) => {
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
                    removeJob(row.id).then((data) => {
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
            }
        }
    };
</script>
