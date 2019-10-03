<template>
  <div class="app-container calendar-list-container">
    <basic-container>
      <el-row :gutter="20">
        <el-col :span="6"
                style='margin-top:15px;'>
          <el-card class="box-card" shadow="never">
            <div class="clearfix" slot="header">
              <span>部门</span>
              <el-button @click="searchTree=(searchTree ? false:true)" class="card-heard-btn" icon="icon-filesearch"
                         title="搜索"
                         type="text"></el-button>
              <el-button @click="getTreeDept()" class="card-heard-btn" icon="icon-reload" title="刷新"
                         type="text"></el-button>
            </div>
            <el-input placeholder="输入关键字进行过滤"
                      v-model="filterText"
                      v-show="searchTree">
            </el-input>
            <el-tree
              :data="treeDeptData"
              :expand-on-click-node="false"
              :filter-node-method="filterNode"
              @node-click="clickNodeTreeData"
              class="filter-tree"
              highlight-current
              node-key="id"
              ref="leftDeptTree">
            </el-tree>
          </el-card>
        </el-col>
        <el-col :span="18">
          <div class="filter-container" v-show="searchFilterVisible">
            <el-form :inline="true" :model="searchForm" ref="searchForm">
              <el-form-item label="名称" prop="username">
                <el-input class="filter-item input-normal" size="small" v-model="searchForm.username"></el-input>
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
              <el-button @click="handleEdit" icon="el-icon-plus" size="mini" type="primary" v-if="sys_user_edit">添加
              </el-button>
            </div>
            <div class="table-menu-right">
              <el-button @click="searchFilterVisible= !searchFilterVisible" circle icon="el-icon-search"
                         size="mini"></el-button>
            </div>
          </div>
          <el-table :data="list" :key='tableKey' @sort-change="sortChange" element-loading-text="加载中..."
                    fit highlight-current-row v-loading="listLoading">
            <el-table-column
              fixed="left" type="index" width="20">
            </el-table-column>
            <el-table-column align="center" label="所属组织" width="100">
              <template slot-scope="scope">
                <span>{{scope.row.deptName}}</span>
              </template>
            </el-table-column>

            <el-table-column align="center" label="用户名" prop="a.username" sortable="custom" width="140">
              <template slot-scope="scope">
          <span>
<!--            <img v-if="scope.row.avatar" class="user-avatar" style="width: 20px; height: 20px; border-radius: 50%;" :src="getFilePath(scope.row.avatar)">-->
            {{scope.row.username}}
          </span>
              </template>
            </el-table-column>

            <el-table-column align="center" label="邮箱" width="120">
              <template slot-scope="scope">
          <span>
            {{scope.row.email}}
          </span>
              </template>
            </el-table-column>

            <el-table-column align="center" label="手机号" width="120">
              <template slot-scope="scope">
                <span>{{scope.row.phone}}</span>
              </template>
            </el-table-column>

            <el-table-column align="center" label="角色" width="160">
              <template slot-scope="scope">
                <span>{{scope.row.roleNames}}</span>
              </template>
            </el-table-column>

            <el-table-column align="center" label="是否可用" width="80">
              <template slot-scope="scope">
                <el-tag>{{scope.row.availableText}}</el-tag>
              </template>
            </el-table-column>
            <el-table-column align="center" label="创建时间" prop="a.created_date" sortable="custom">
              <template slot-scope="scope">
                <span>{{scope.row.createdDate}}</span>
              </template>
            </el-table-column>


            <el-table-column align="center" fixed="right" label="操作"
                             v-if="sys_user_edit || sys_user_lock || sys_user_del"
                             width="130">
              <template slot-scope="scope">
                <el-button @click="handleEdit(scope.row)" icon="icon-edit" title="编辑" type="text" v-if="sys_user_edit">
                </el-button>
                <el-button :icon="scope.row.available == '0' ? 'icon-lock' : 'icon-unlock'"
                           :title="scope.row.available == '0' ? '锁定' : '解锁'"
                           @click="handleLock(scope.row)" type="text" v-if="sys_user_lock">
                </el-button>
                <el-button @click="handleDelete(scope.row)" icon="icon-delete" title="删除" type="text"
                           v-if="sys_user_del">
                </el-button>
              </template>
            </el-table-column>

          </el-table>
          <div class="pagination-container" v-show="!listLoading">
            <el-pagination :current-page.sync="listQuery.current" :page-size="listQuery.size"
                           :page-sizes="[10,20,30, 50]"
                           :total="total" @current-change="handleCurrentChange"
                           @size-change="handleSizeChange" background
                           class="pull-right" layout="total, sizes, prev, pager, next, jumper">
            </el-pagination>
          </div>
        </el-col>
      </el-row>
      <el-dialog :visible.sync="dialogDeptVisible" title="选择部门">
        <el-tree :data="treeDeptData" :default-checked-keys="checkedKeys" @node-click="clickNodeSelectData"
                 check-strictly class="filter-tree" default-expand-all highlight-current node-key="id">
        </el-tree>
      </el-dialog>
      <el-dialog :title="textMap[dialogStatus]" :visible.sync="dialogFormVisible">
        <el-form :model="form" label-width="100px" ref="form">
          <!--      <el-form-item label="头像" prop="avatar">-->
          <!--        <my-upload field="uploadFile" @crop-upload-success="cropUploadSuccess" v-model="showUpload"-->
          <!--                   :width="300" :height="300" :url="ctx+'/file/upload'" :headers="headers" img-format="png"></my-upload>-->
          <!--        <img :src="getFilePath(form.avatar)" class="header-img" />-->
          <!--        <input type="hidden" v-model="form.avatar" />-->
          <!--        <el-button type="primary" @click="showUpload = !showUpload" size="mini">选择-->
          <!--          <i class="el-icon-upload el-icon--right"></i>-->
          <!--        </el-button>-->
          <!--      </el-form-item>-->
          <el-form-item :rules="[{required: true,message: '请选择部门', trigger: 'change'}]" label="所属部门" prop="deptName">
            <el-input @focus="dialogDeptVisible=true" placeholder="选择部门" readonly v-model="form.deptName">
            </el-input>
            <input type="hidden" v-model="form.deptId"/>
          </el-form-item>

          <el-form-item :rules="[
            {required: true,message: '请输入账户'},
            {min: 3,max: 20,message: '长度在 3 到 20 个字符'},
            {validator:validateUnique}
          ]" label="用户名" prop="username">
            <el-input placeholder="请输用户名" v-model="form.username"></el-input>
          </el-form-item>

          <el-form-item :rules="[{validator: validatePass}]" label="密码" prop="password">
            <el-input :placeholder="this.dialogStatus == 'create' ? '请输入密码' : '若不修改密码，请留空'" type="password"
                      v-model="form.password"></el-input>
          </el-form-item>

          <el-form-item :rules="[{validator: validateConfirmPass}]" label="确认密码" placeholder="请再次输入密码"
                        prop="confirmPassword">
            <el-input type="password" v-model="form.confirmPassword"></el-input>
          </el-form-item>

          <el-form-item :rules="[{validator:validatePhone}]" label="手机号" prop="phone">
            <el-input placeholder="验证码登录使用" v-model="form.phone"></el-input>
          </el-form-item>
          <el-form-item :rules="[{ type: 'email',message: '请填写正确邮箱' }]" label="邮箱" prop="email">
            <el-input v-model="form.email"></el-input>
          </el-form-item>

          <el-form-item :rules="[{required: true,message: '请选择角色' }]" label="角色" prop="roleIdList">
            <crud-select :dic="rolesOptions" :filterable="true" :multiple="true"
                         v-model="form.roleIdList"></crud-select>
          </el-form-item>

          <el-form-item :rules="[{required: true,message: '请选择' }]" label="是否可用" prop="available">
            <crud-radio :dic="flagOptions" v-model="form.available"></crud-radio>
          </el-form-item>

          <el-form-item label="备注" prop="description">
            <el-input placeholder="" type="textarea" v-model="form.description"></el-input>
          </el-form-item>
        </el-form>
        <div class="dialog-footer" slot="footer">
          <el-button @click="cancel()" size="small">取 消</el-button>
          <el-button @click="resetForm()" size="small">重 置</el-button>
          <el-button @click="save()" size="small" type="primary">保 存</el-button>
        </div>
      </el-dialog>
    </basic-container>
  </div>
</template>

<script>
  import userService from "./user-service";
  import deptService from "../dept/dept-service";
  import roleService from "../role/role-service";
  import {mapGetters} from 'vuex';
  import util from "@/util/util";
  import validate from "@/util/validate";

  export default {
    name: 'User',
    data() {
      return {
        treeDeptData: [],
        dialogDeptVisible: false,
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
        filterText: '',
        filterFormText: '',
        formStatus: '',
        flagOptions: [],
        rolesOptions: [],
        searchTree: false,
        labelPosition: 'right',
        form: {
          username: undefined,
          deptId: undefined,
          password: undefined,
          confirmPassword: undefined,
          phone: undefined,
          email: undefined,
          roleIdList: undefined,
          available: undefined,
          description: undefined
        },
        validateUnique: (rule, value, callback) => {
          validate.isUnique(rule, value, callback, '/sys/user/checkByProperty?id=' + toStr(this.form.id))
        },
        validatePhone: (rule, value, callback) => {
          validate.isMobile(rule, value, callback)
        },
        validatePass: (rule, value, callback) => {
          if (validate.checkNull(this.form.id)) {
            if (validate.checkNull(value)) {
              callback(new Error('请输入密码'));
              return;
            }
          }
          callback();
        },
        validateConfirmPass: (rule, value, callback) => {
          if (validate.checkNotNull(this.form.password)) {
            if (validate.checkNull(value)) {
              callback(new Error('请再次输入密码'));
              return;
            } else if (value !== this.form.password) {
              callback(new Error('两次输入密码不一致!'));
              return;
            }
          }
          callback();
        },
        dialogStatus: 'create',
        textMap: {
          update: '编辑',
          create: '创建'
        },
        sys_user_edit: false,
        sys_user_lock: false,
        sys_user_del: false,
        currentNode: {},
        tableKey: 0
      }
    },
    watch: {
      filterText(val) {
        this.$refs['leftDeptTree'].filter(val);
      }
    },
    created() {
      this.getTreeDept();
      this.getList();
      this.sys_user_edit = this.permissions["sys_user_edit"];
      this.sys_user_lock = this.permissions["sys_user_lock"];
      this.sys_user_del = this.permissions["sys_user_del"];
      roleService.deptRoleList().then(response => {
        this.rolesOptions = response.data;
      });
      this.flagOptions = this.dicts['sys_flag'];
    },
    computed: {
      ...mapGetters([
        "permissions", "dicts"
      ])
    },
    methods: {
      getList() {
        this.listLoading = true;
        // this.listQuery.isAsc = false;
        this.listQuery.queryConditionJson = util.parseJsonItemForm([{
          fieldName: 'a.username', value: this.searchForm.username
        }, {
          fieldName: 'a.dept_id', value: this.searchForm.deptId
        }]);
        userService.page(this.listQuery).then(response => {
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
      getTreeDept() {
        deptService.fetchTreeUser().then(response => {
          this.treeDeptData = util.parseTreeData(response.data);
          this.searchForm.parentId = this.treeDeptData[0].id;
          setTimeout(() => {
            this.$refs.leftDeptTree.setCurrentKey(this.searchForm.parentId);
          }, 0);
        })
      },
      filterNode(value, data) {
        if (!value) return true;
        return data.label.indexOf(value) !== -1
      },
      clickNodeTreeData(data) {
        this.searchForm.deptId = data.id;
        this.currentNode = data;
        this.getList()
      },
      clickNodeSelectData(data) {
        this.form.deptId = data.id;
        this.form.deptName = data.label;
        this.dialogDeptVisible = false;
      },
      //搜索清空
      searchReset() {
        this.$refs['searchForm'].resetFields();
        this.listQuery.deptId = undefined;
        this.$refs['leftDeptTree'].setCurrentKey(null)
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
      handleEdit(row) {
        this.resetForm();
        this.dialogStatus = row && validate.checkNotNull(row.id) ? "update" : "create";
        if (this.dialogStatus == "create") {
          this.dialogFormVisible = true;
        } else {
          userService.find(row.id).then(response => {
            this.form = response.data;
            this.form.password = undefined;
            this.dialogFormVisible = true;
          });
        }
      },
      handleLock: function (row) {
        userService.lock(row.id).then(response => {
          this.getList();
        });
      },
      handleDelete(row) {
        this.$confirm('此操作将永久删除, 是否继续?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          userService.remove(row.id).then(response => {
            this.getList();
          })
        })
      },
      save() {
        this.$refs['form'].validate(valid => {
          if (valid) {
            userService.save(this.form).then(response => {
              this.getList();
              this.dialogFormVisible = false;
            })
          } else {
            return false;
          }
        });
      },
      cancel() {
        this.dialogFormVisible = false;
        this.$refs['form'].resetFields();
      },
      resetForm() {
        this.form = {
          username: undefined,
          deptId: undefined,
          deptName: undefined,
          password: undefined,
          confirmPassword: undefined,
          phone: undefined,
          email: undefined,
          roleIdList: undefined,
          available: undefined,
          description: undefined
        };
        this.$refs['form'] && this.$refs['form'].resetFields();
      }
    }
  }
</script>

