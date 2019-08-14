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
      <el-table-column align="center" label="调用目标字符串">
        <template slot-scope="scope">
          <span>{{scope.row.invokeTarget}}</span>
        </template>
      </el-table-column>
      <el-table-column align="center" label="cron执行表达式">
        <template slot-scope="scope">
          <span>{{scope.row.cronExpression}}</span>
        </template>
      </el-table-column>
      <el-table-column align="center" label="计划执行错误策略（1立即执行 2执行一次 3放弃执行）">
        <template slot-scope="scope">
          <span>{{scope.row.misfirePolicy}}</span>
        </template>
      </el-table-column>
      <el-table-column align="center" label="是否并发执行（1允许 0禁止）">
        <template slot-scope="scope">
          <span>{{scope.row.concurrent}}</span>
        </template>
      </el-table-column>
      <el-table-column align="center" label="状态(1-正常，0-锁定)">
        <template slot-scope="scope">
          <span>{{scope.row.available}}</span>
        </template>
      </el-table-column>
      <el-table-column align="center" fixed="right" label="操作" v-if="quartz_job_edit || quartz_job_del">
        <template slot-scope="scope">
          <el-button v-if="quartz_job_edit" icon="icon-edit" title="编辑" type="text" @click="handleEdit(scope.row)">
          </el-button>
          <el-button v-if="quartz_job_del" icon="icon-delete" title="删除" type="text" @click="handleDelete(scope.row)">
          </el-button>
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
        <el-form-item label="任务组名" prop="group" :rules="[{required: true,message: '请输入任务组名'},{min: 0,max: 64,message: '长度在 0 到 64 个字符'},]">
                <el-input v-model="form.group"></el-input>
        </el-form-item>
        <el-form-item label="调用目标字符串" prop="invokeTarget" :rules="[{required: true,message: '请输入调用目标字符串'},{min: 0,max: 500,message: '长度在 0 到 500 个字符'},]">
                <el-input v-model="form.invokeTarget"></el-input>
        </el-form-item>
        <el-form-item label="cron执行表达式" prop="cronExpression" :rules="[{min: 0,max: 255,message: '长度在 0 到 255 个字符'},]">
                <el-input v-model="form.cronExpression"></el-input>
        </el-form-item>
        <el-form-item label="计划执行错误策略（1立即执行 2执行一次 3放弃执行）" prop="misfirePolicy" :rules="[{min: 0,max: 20,message: '长度在 0 到 20 个字符'},]">
                <el-input v-model="form.misfirePolicy"></el-input>
        </el-form-item>
        <el-form-item label="是否并发执行（1允许 0禁止）" prop="concurrent" :rules="[{min: 0,max: 1,message: '长度在 0 到 1 个字符'},]">
              <CrudRadio v-model="form.concurrent" :dic="concurrentOptions"></CrudRadio>
        </el-form-item>
        <el-form-item label="状态(1-正常，0-锁定)" prop="available" :rules="[{min: 0,max: 1,message: '长度在 0 到 1 个字符'},]">
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
import { pageJob, findJob, saveJob, removeJob, validateUniqueJob} from "./service";
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
    this.quartz_job_edit = this.permissions["quartz_job_edit"];
    this.quartz_job_del = this.permissions["quartz_job_del"];
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