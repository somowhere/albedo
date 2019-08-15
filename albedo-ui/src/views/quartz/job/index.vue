<template>
  <div class="app-container calendar-list-container">
    <basic-container>
    <div class="filter-container">
      <el-form :inline="true"  :model="searchJobForm" ref="searchJobForm" v-show="searchFilterVisible">
        <el-form-item label="任务名称" prop="name">
          <el-input class="filter-item input-normal" v-model="searchJobForm.name"></el-input>
        </el-form-item>
        <el-form-item label="任务组名" prop="group">
          <el-input class="filter-item input-normal" v-model="searchJobForm.group"></el-input>
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
        <el-button-group>
          <el-button size="mini" v-if="quartz_job_edit" class="filter-item" @click="handleEdit" type="primary" icon="edit">添加</el-button>
          <el-button size="mini" v-if="quartz_job_log_view" class="filter-item" @click="handleEdit" type="primary" icon="edit">执行日志</el-button>
        </el-button-group>
      </div>
      <div class="table-menu-right">
        <el-button icon="el-icon-search" circle size="mini" @click="searchFilterVisible= !searchFilterVisible"></el-button>
      </div>
    </div>
    <el-table :key='tableKey' @sort-change="sortChange" :data="list" v-loading="listLoading" element-loading-text="加载中..." fit highlight-current-row>
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
            v-model="scope.row.concurrent"
            active-value="1" inactive-value="0" @change="concurrentChange(scope.row.available, scope.row.id)">
          </el-switch>
        </template>
      </el-table-column>
      <el-table-column align="center" label="是否启用" width="120">
        <template slot-scope="scope">
          <el-switch
            v-model="scope.row.available"
            active-value="1" inactive-value="0" @change="availableChange(scope.row.available, scope.row.id)">
          </el-switch>
        </template>
      </el-table-column>
      <el-table-column align="center" fixed="right" label="操作" v-if="quartz_job_edit || quartz_job_del">
        <template slot-scope="scope">
          <el-button v-if="quartz_job_run" icon="icon-edit" title="执行" type="text" @click="handleRun(scope.row)">
            执行</el-button>
          <el-button v-if="quartz_job_edit" icon="icon-edit" title="编辑" type="text" @click="handleEdit(scope.row)">
            编辑</el-button>
          <el-button v-if="quartz_job_del" icon="icon-delete" title="删除" type="text" @click="handleDelete(scope.row)">
            删除</el-button>
        </template>
      </el-table-column>

    </el-table>

    <div v-show="!listLoading" class="pagination-container">
      <el-pagination @size-change="handleSizeChange" @current-change="handleCurrentChange" :current-page.sync="listQuery.page" :page-sizes="[10,20,30, 50]" :page-size="listQuery.size" layout="total, sizes, prev, pager, next, jumper" :total="total">
      </el-pagination>
    </div>
    <el-dialog :title="textMap[dialogStatus]" :visible.sync="dialogFormVisible">
      <el-form :model="form" ref="form" label-width="100px">
      <el-table-column type="index" fixed="left" width="60"></el-table-column>
        <el-form-item label="任务名称" prop="name" :rules="[{required: true,message: '请输入任务名称'},{min: 0,max: 64,message: '长度在 0 到 64 个字符'},]">
                <el-input v-model="form.name"></el-input>

        </el-form-item>
        <el-form-item label="任务组名" prop="group" :rules="[{required: true,message: '请输入任务组名'}]">
          <CrudSelect v-model="form.group" :dic="jobGroupOptions"></CrudSelect>
        </el-form-item>
        <el-form-item label="调用目标" prop="invokeTarget" :rules="[{required: true,message: '请输入调用目标'},{min: 0,max: 500,message: '长度在 0 到 500 个字符'},]">
                <el-input v-model="form.invokeTarget"></el-input>
          <div>
            <el-tag type="info" size="mini">Bean调用示例：simpleTask.ryParams('ry')</el-tag>
            <el-tag type="info" size="mini">Class类调用示例：com.ruoyi.quartz.task.RyTask.ryParams('ry') 参数说明：支持字符串，布尔类型，长整型，浮点型，整型</el-tag>
            <el-tag type="info" size="mini">参数说明：支持字符串，布尔类型，长整型，浮点型，整型</el-tag>
          </div>
        </el-form-item>
        <el-form-item label="cron表达式" prop="cronExpression" :rules="[{min: 0,max: 255,message: '长度在 0 到 255 个字符'},]">
                <el-input v-model="form.cronExpression"></el-input>

        </el-form-item>
        <el-form-item label="执行失败策略" prop="misfirePolicy" :rules="[{required: true},]">
              <CrudSelect v-model="form.misfirePolicy" :dic="misfirePolicyOptions"></CrudSelect>
        <div>
		  <el-tag type="info" size="mini">计划执行错误策略</el-tag>
		</div>
        </el-form-item>
        <el-form-item label="是否并发执行" prop="concurrent" :rules="[{required: true},]">
              <CrudRadio v-model="form.concurrent" :dic="concurrentOptions"></CrudRadio>

        </el-form-item>
        <el-form-item label="是否启用" prop="available" :rules="[{required: true},]">
              <CrudRadio v-model="form.available" :dic="availableOptions"></CrudRadio>
        </el-form-item>
        <el-form-item label="备注" prop="description" :rules="[{min: 0,max: 255,message: '长度在 0 到 255 个字符'},]">
                <el-input type="textarea" v-model="form.description"></el-input>

        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="cancel()">取 消</el-button>
        <el-button type="primary" @click="save()">保 存</el-button>
      </div>
    </el-dialog>
    </basic-container>
  </div>
</template>

<script>
    import {
        pageJob,
        findJob,
        saveJob,
        removeJob,
        validateUniqueJob,
        availableJob,
        concurrentJob,
        runJob
    } from "./service";
import { mapGetters } from "vuex";
import {isValidateUnique, isValidateNumber, isValidateDigits, objectToString, validateNull} from "@/util/validate";
import {parseJsonItemForm} from "@/util/util";
import CrudSelect from "@/views/avue/crud-select";
import CrudCheckbox from "@/views/avue/crud-checkbox";
import CrudRadio from "@/views/avue/crud-radio";

export default {
  name: "table_quartz_job",
  components: {CrudSelect, CrudCheckbox, CrudRadio},
  data() {
    return{
      searchFilterVisible: true,
      dialogFormVisible: false,
      list: null,
      total: null,
      listLoading: true,
      searchJobForm:{},
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
    ...mapGetters(["permissions","dicts"])
  },
  filters: {
  },
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
      {fieldName: 'name',value:this.searchJobForm.name,operate:'like',attrType:'String'},
      {fieldName: 'group',value:this.searchJobForm.group,operate:'like',attrType:'String'},
      ])
      pageJob(this.listQuery).then(response => {
        this.list = response.data.records;
        this.total = response.data.total;
        this.listLoading = false;
      });
    },
    sortChange(column){
      if(column.order=="ascending"){
        this.listQuery.ascs=column.prop
        this.listQuery.descs=undefined;
      }else{
        this.listQuery.descs=column.prop
        this.listQuery.ascs=undefined;
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
      this.dialogStatus = row && !validateNull(row.id)? "update" : "create";
      if(this.dialogStatus == "create"){
        this.dialogFormVisible = true;
      }else{
        findJob(row.id).then(response => {
            this.form = response.data;
            this.form.misfirePolicy=objectToString(this.form.misfirePolicy);
            this.form.concurrent=objectToString(this.form.concurrent);
            this.form.available=objectToString(this.form.available);
            this.form.delFlag=objectToString(this.form.delFlag);
            this.dialogFormVisible = true;
          });
      }
    },
    availableChange(available, id){
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
    concurrentChange(concurrent, id){
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
      this.$refs['form']&&this.$refs['form'].resetFields();
    }
  }
};
</script>
