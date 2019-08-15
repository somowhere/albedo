<template>
  <div class="app-container calendar-list-container">
    <basic-container>
    <div class="filter-container">
      <el-form :inline="true"  :model="searchLogLoginForm" ref="searchLogLoginForm" v-show="searchFilterVisible">
        <el-form-item label="登录账号" prop="loginName">
          <el-input class="filter-item input-normal" v-model="searchLogLoginForm.loginName"></el-input>
        </el-form-item>
        <el-form-item label="登录地点" prop="loginLocation">
          <el-input class="filter-item input-normal" v-model="searchLogLoginForm.loginLocation"></el-input>
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
          <el-button size="mini" v-if="sys_logLogin_edit" class="filter-item" @click="handleEdit" type="primary" icon="edit">添加</el-button>
        </el-button-group>
      </div>
      <div class="table-menu-right">
        <el-button icon="el-icon-search" circle size="mini" @click="searchFilterVisible= !searchFilterVisible"></el-button>
      </div>
    </div>
    <el-table :key='tableKey' @sort-change="sortChange" :data="list" v-loading="listLoading" element-loading-text="加载中..." fit highlight-current-row>
      <el-table-column align="center" label="登录账号">
        <template slot-scope="scope">
          <span>{{scope.row.loginName}}</span>
        </template>
      </el-table-column>
      <el-table-column align="center" label="登录IP地址">
        <template slot-scope="scope">
          <span>{{scope.row.ipAddress}}</span>
        </template>
      </el-table-column>
      <el-table-column align="center" label="登录地点">
        <template slot-scope="scope">
          <span>{{scope.row.loginLocation}}</span>
        </template>
      </el-table-column>
      <el-table-column align="center" label="用户代理">
        <template slot-scope="scope">
          <span>{{scope.row.userAgent}}</span>
        </template>
      </el-table-column>
      <el-table-column align="center" label="浏览器类型">
        <template slot-scope="scope">
          <span>{{scope.row.browser}}</span>
        </template>
      </el-table-column>
      <el-table-column align="center" label="操作系统">
        <template slot-scope="scope">
          <span>{{scope.row.os}}</span>
        </template>
      </el-table-column>
      <el-table-column align="center" label="登录状态">
        <template slot-scope="scope">
          <span>{{scope.row.status}}</span>
        </template>
      </el-table-column>
      <el-table-column align="center" label="提示消息">
        <template slot-scope="scope">
          <span>{{scope.row.message}}</span>
        </template>
      </el-table-column>
      <el-table-column align="center" label="访问时间">
        <template slot-scope="scope">
          <span>{{scope.row.loginTime}}</span>
        </template>
      </el-table-column>
      <el-table-column align="center" fixed="right" label="操作" v-if="sys_logLogin_del">
        <template slot-scope="scope">
          <el-button v-if="sys_logLogin_del" icon="icon-delete" title="删除" type="text" @click="handleDelete(scope.row)">
          </el-button>
        </template>
      </el-table-column>

    </el-table>

    <div v-show="!listLoading" class="pagination-container">
      <el-pagination @size-change="handleSizeChange" @current-change="handleCurrentChange" :current-page.sync="listQuery.page" :page-sizes="[10,20,30, 50]" :page-size="listQuery.size" layout="total, sizes, prev, pager, next, jumper" :total="total">
      </el-pagination>
    </div>
    </basic-container>
  </div>
</template>

<script>
import { pageLogLogin, findLogLogin, saveLogLogin, removeLogLogin, validateUniqueLogLogin} from "./service";
import { mapGetters } from "vuex";
import {isValidateUnique, isValidateNumber, isValidateDigits, objectToString, validateNull} from "@/util/validate";
import {parseJsonItemForm} from "@/util/util";
import CrudSelect from "@/views/avue/crud-select";
import CrudCheckbox from "@/views/avue/crud-checkbox";
import CrudRadio from "@/views/avue/crud-radio";

export default {
  name: "table_sys_logLogin",
  components: {CrudSelect, CrudCheckbox, CrudRadio},
  data() {
    return{
      searchFilterVisible: true,
      list: null,
      total: null,
      listLoading: true,
      searchLogLoginForm:{},
      listQuery: {
        page: 1,
        size: 20
      },
      statusOptions: undefined,
      delFlagOptions: undefined,
      dialogStatus: 'create',
      textMap: {
        update: '编辑登录日志',
        create: '创建登录日志'
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
    this.sys_logLogin_edit = this.permissions["sys_logLogin_edit"];
    this.sys_logLogin_del = this.permissions["sys_logLogin_del"];
    this.statusOptions = this.dicts["sys_status"];
    this.delFlagOptions = this.dicts["sys_flag"];
  },
  methods: {
    getList() {
      this.listLoading = true;
      this.listQuery.queryConditionJson = parseJsonItemForm([
      {fieldName: 'loginName',value:this.searchLogLoginForm.loginName,operate:'like',attrType:'String'},
      {fieldName: 'loginLocation',value:this.searchLogLoginForm.loginLocation,operate:'like',attrType:'String'},
      ])
      pageLogLogin(this.listQuery).then(response => {
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
      this.$refs['searchLogLoginForm'].resetFields();
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
        "此操作将永久删除该登录日志, 是否继续?",
        "提示",
        {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "warning"
        }
      ).then(() => {
        removeLogLogin(row.id).then((data) => {
            this.getList();
          });
      });
    },
  }
};
</script>
