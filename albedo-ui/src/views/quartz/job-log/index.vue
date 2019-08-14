<template>
  <div class="app-container calendar-list-container">
    <basic-container>
    <div class="filter-container">
      <el-form :inline="true"  :model="searchJobLogForm" ref="searchJobLogForm" v-show="searchFilterVisible">
        <el-form-item label="任务名称" prop="jobName">
          <el-input class="filter-item input-normal" v-model="searchJobLogForm.jobName"></el-input>
        </el-form-item>
        <el-form-item label="任务组名" prop="jobGroup">
          <el-input class="filter-item input-normal" v-model="searchJobLogForm.jobGroup"></el-input>
        </el-form-item>
        <el-form-item label="执行状态（1正常 1失败）" prop="status">
          <CrudRadio v-model="searchJobLogForm.status" :dic="statusOptions"></CrudRadio>
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
          <el-button size="mini" v-if="quartz_jobLog_edit" class="filter-item" @click="handleEdit" type="primary" icon="edit">添加</el-button>
        </el-button-group>
      </div>
      <div class="table-menu-right">
        <el-button icon="el-icon-search" circle size="mini" @click="searchFilterVisible= !searchFilterVisible"></el-button>
      </div>
    </div>
    <el-table :key='tableKey' @sort-change="sortChange" :data="list" v-loading="listLoading" element-loading-text="加载中..." fit highlight-current-row>
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
      <el-table-column align="center" label="日志信息">
        <template slot-scope="scope">
          <span>{{scope.row.jobMessage}}</span>
        </template>
      </el-table-column>
      <el-table-column align="center" label="执行状态（1正常 1失败）">
        <template slot-scope="scope">
          <span>{{scope.row.status}}</span>
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
      <el-table-column align="center" label="异常信息">
        <template slot-scope="scope">
          <span>{{scope.row.exceptionInfo}}</span>
        </template>
      </el-table-column>
      <el-table-column align="center" fixed="right" label="操作" v-if="quartz_jobLog_edit || quartz_jobLog_del">
        <template slot-scope="scope">
          <el-button v-if="quartz_jobLog_edit" icon="icon-edit" title="编辑" type="text" @click="handleEdit(scope.row)">
          </el-button>
          <el-button v-if="quartz_jobLog_del" icon="icon-delete" title="删除" type="text" @click="handleDelete(scope.row)">
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
        <el-form-item label="任务名称" prop="jobName" :rules="[{required: true,message: '请输入任务名称'},{min: 0,max: 64,message: '长度在 0 到 64 个字符'},]">
                <el-input v-model="form.jobName"></el-input>
        </el-form-item>
        <el-form-item label="任务组名" prop="jobGroup" :rules="[{required: true,message: '请输入任务组名'},{min: 0,max: 64,message: '长度在 0 到 64 个字符'},]">
                <el-input v-model="form.jobGroup"></el-input>
        </el-form-item>
        <el-form-item label="调用目标字符串" prop="invokeTarget" :rules="[{required: true,message: '请输入调用目标字符串'},{min: 0,max: 500,message: '长度在 0 到 500 个字符'},]">
                <el-input v-model="form.invokeTarget"></el-input>
        </el-form-item>
        <el-form-item label="日志信息" prop="jobMessage" :rules="[{min: 0,max: 500,message: '长度在 0 到 500 个字符'},]">
                <el-input type="textarea" v-model="form.jobMessage"></el-input>
        </el-form-item>
        <el-form-item label="执行状态（1正常 1失败）" prop="status" :rules="[{min: 0,max: 1,message: '长度在 0 到 1 个字符'},]">
              <CrudRadio v-model="form.status" :dic="statusOptions"></CrudRadio>
        </el-form-item>
        <el-form-item label="开始时间" prop="startTime" :rules="[]">
              <el-date-picker v-model="form.startTime" type="datetime" value-format="yyyy-MM-dd HH:mm:ss" >
              </el-date-picker>
        </el-form-item>
        <el-form-item label="结束时间" prop="endTime" :rules="[]">
              <el-date-picker v-model="form.endTime" type="datetime" value-format="yyyy-MM-dd HH:mm:ss" >
              </el-date-picker>
        </el-form-item>
        <el-form-item label="创建时间" prop="createTime" :rules="[]">
              <el-date-picker v-model="form.createTime" type="datetime" value-format="yyyy-MM-dd HH:mm:ss" >
              </el-date-picker>
        </el-form-item>
        <el-form-item label="异常信息" prop="exceptionInfo" :rules="[{min: 0,max: 2000,message: '长度在 0 到 2000 个字符'},]">
                <el-input v-model="form.exceptionInfo"></el-input>
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
import { pageJobLog, findJobLog, saveJobLog, removeJobLog, validateUniqueJobLog} from "./service";
import { mapGetters } from "vuex";
import {isValidateUnique, isValidateNumber, isValidateDigits, objectToString, validateNull} from "@/util/validate";
import {parseJsonItemForm} from "@/util/util";
import CrudSelect from "@/views/avue/crud-select";
import CrudCheckbox from "@/views/avue/crud-checkbox";
import CrudRadio from "@/views/avue/crud-radio";

export default {
  name: "table_quartz_jobLog",
  components: {CrudSelect, CrudCheckbox, CrudRadio},
  data() {
    return{
      searchFilterVisible: true,
      dialogFormVisible: false,
      list: null,
      total: null,
      listLoading: true,
      searchJobLogForm:{},
      listQuery: {
        page: 1,
        size: 20
      },
      form: {
        jobName: undefined,
        jobGroup: undefined,
        invokeTarget: undefined,
        jobMessage: undefined,
        status: undefined,
        startTime: undefined,
        endTime: undefined,
        createTime: undefined,
        exceptionInfo: undefined,
        description: undefined,
      },
      validateUnique: (rule, value, callback) => {
          validateUniqueJobLog(rule, value, callback, this.form.id)
        },
        validateNumber: (rule, value, callback) => {
          isValidateNumber(rule, value, callback)
        },
        validateDigits: (rule, value, callback) => {
          isValidateDigits(rule, value, callback)
        },
      statusOptions: undefined,
      dialogStatus: 'create',
      textMap: {
        update: '编辑任务调度日志',
        create: '创建任务调度日志'
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
    this.quartz_jobLog_edit = this.permissions["quartz_jobLog_edit"];
    this.quartz_jobLog_del = this.permissions["quartz_jobLog_del"];
    this.statusOptions = this.dicts["sys_job_status"];
  },
  methods: {
    getList() {
      this.listLoading = true;
      this.listQuery.queryConditionJson = parseJsonItemForm([
      {fieldName: 'jobName',value:this.searchJobLogForm.jobName,operate:'like',attrType:'String'},
      {fieldName: 'jobGroup',value:this.searchJobLogForm.jobGroup,operate:'like',attrType:'String'},
      {fieldName: 'status',value:this.searchJobLogForm.status,operate:'eq',attrType:'String'},
      ])
      pageJobLog(this.listQuery).then(response => {
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
    handleEdit(row) {
      this.resetForm();
      this.dialogStatus = row && !validateNull(row.id)? "update" : "create";
      if(this.dialogStatus == "create"){
        this.dialogFormVisible = true;
      }else{
        findJobLog(row.id).then(response => {
            this.form = response.data;
            this.form.status=objectToString(this.form.status);
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
          saveJobLog(this.form).then((data) => {
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
        "此操作将永久删除该任务调度日志, 是否继续?",
        "提示",
        {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "warning"
        }
      ).then(() => {
        removeJobLog(row.id).then((data) => {
            this.getList();
          });
      });
    },
    resetForm() {
      this.form = {
        jobName: "",
        jobGroup: "",
        invokeTarget: "",
        jobMessage: "",
        status: "",
        startTime: "",
        endTime: "",
        createTime: "",
        exceptionInfo: "",
        description: "",
      };
      this.$refs['form']&&this.$refs['form'].resetFields();
    }
  }
};
</script>