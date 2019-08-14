<template>
  <div class="app-container calendar-list-container">
    <basic-container>
      <el-row :gutter="20">
        <el-col :span="6"
                style='margin-top:15px;'>
          <el-card class="box-card">
            <div slot="header" class="clearfix">
              <span>部门</span>

              <el-button type="text" class="card-heard-btn" icon="icon-filesearch" title="搜索"
                         @click="searchTree=(searchTree ? false:true)"></el-button>
              <el-button type="text" class="card-heard-btn" icon="icon-reload" title="刷新"
                         @click="getTreeDept()"></el-button>
            </div>
            <el-input v-show="searchTree"
                      placeholder="输入关键字进行过滤"
                      v-model="filterText">
            </el-input>
            <el-tree
              class="filter-tree"
              :data="treeDeptData"
              ref="leftDeptTree"
              node-key="id"
              highlight-current
              :expand-on-click-node="false"
              :filter-node-method="filterNode"
              @node-click="clickNodeTreeData">
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
                <el-button size="small" type="primary" icon="el-icon-search" @click="handleFilter">查询</el-button>
                <el-button size="small" @click="searchReset" icon="icon-rest">重置</el-button>
              </el-form-item>
            </el-form>
          </div>
          <!-- 表格功能列 -->

          <div class="table-menu">
            <div class="table-menu-left">
              <el-button size="mini" v-if="sys_user_edit" @click="handleEdit" type="primary" icon="el-icon-plus">添加
              </el-button>
            </div>
            <div class="table-menu-right">
              <el-button icon="el-icon-search" circle size="mini"
                         @click="searchFilterVisible= !searchFilterVisible"></el-button>
            </div>
          </div>
          <el-table :key='tableKey' @sort-change="sortChange" :data="list" v-loading="listLoading"
                    element-loading-text="加载中..." fit highlight-current-row>
            <el-table-column
              type="index" fixed="left" width="50">
            </el-table-column>
            <el-table-column align="center" label="所属组织" width="100">
              <template slot-scope="scope">
                <span>{{scope.row.deptName}}</span>
              </template>
            </el-table-column>

            <el-table-column align="center" label="用户名" width="140" prop="a.username" sortable="custom">
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


            <el-table-column align="center" label="操作" fixed="right" width="130"
                             v-if="sys_user_edit || sys_user_lock || sys_user_del">
              <template slot-scope="scope">
                <el-button v-if="sys_user_edit" icon="icon-edit" title="编辑" type="text" @click="handleEdit(scope.row)">
                </el-button>
                <el-button v-if="sys_user_lock" :icon="scope.row.available == '0' ? 'icon-lock' : 'icon-unlock'"
                           :title="scope.row.available == '0' ? '锁定' : '解锁'" type="text" @click="handleLock(scope.row)">
                </el-button>
                <el-button v-if="sys_user_del" icon="icon-delete" title="删除" type="text"
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
      <el-dialog title="选择部门" :visible.sync="dialogDeptVisible">
        <el-tree class="filter-tree" :data="treeDeptData" :default-checked-keys="checkedKeys"
                 check-strictly node-key="id" highlight-current @node-click="clickNodeSelectData" default-expand-all>
        </el-tree>
      </el-dialog>
      <el-dialog :title="textMap[dialogStatus]" :visible.sync="dialogFormVisible">
        <el-form :model="form" ref="form" label-width="100px">
          <!--      <el-form-item label="头像" prop="avatar">-->
          <!--        <my-upload field="uploadFile" @crop-upload-success="cropUploadSuccess" v-model="showUpload"-->
          <!--                   :width="300" :height="300" :url="ctx+'/file/upload'" :headers="headers" img-format="png"></my-upload>-->
          <!--        <img :src="getFilePath(form.avatar)" class="header-img" />-->
          <!--        <input type="hidden" v-model="form.avatar" />-->
          <!--        <el-button type="primary" @click="showUpload = !showUpload" size="mini">选择-->
          <!--          <i class="el-icon-upload el-icon--right"></i>-->
          <!--        </el-button>-->
          <!--      </el-form-item>-->
          <el-form-item label="所属部门" prop="deptName" :rules="[{required: true,message: '请选择部门', trigger: 'change'}]">
            <el-input v-model="form.deptName" placeholder="选择部门" @focus="dialogDeptVisible=true" readonly>
            </el-input>
            <input type="hidden" v-model="form.deptId"/>
          </el-form-item>

          <el-form-item label="用户名" prop="username" :rules="[
            {required: true,message: '请输入账户'},
            {min: 3,max: 20,message: '长度在 3 到 20 个字符'},
            {validator:validateUnique}
          ]">
            <el-input v-model="form.username" placeholder="请输用户名"></el-input>
          </el-form-item>

          <el-form-item label="密码" prop="password" :rules="[{validator: validatePass}]">
            <el-input type="password" v-model="form.password"
                      :placeholder="this.dialogStatus == 'create' ? '请输入密码' : '若不修改密码，请留空'"></el-input>
          </el-form-item>

          <el-form-item label="确认密码" placeholder="请再次输入密码" prop="confirmPassword"
                        :rules="[{validator: validateConfirmPass}]">
            <el-input type="password" v-model="form.confirmPassword"></el-input>
          </el-form-item>

          <el-form-item label="手机号" prop="phone" :rules="[{validator:validatePhone}]">
            <el-input v-model="form.phone" placeholder="验证码登录使用"></el-input>
          </el-form-item>
          <el-form-item label="邮箱" prop="email" :rules="[{ type: 'email',message: '请填写正确邮箱' }]">
            <el-input v-model="form.email"></el-input>
          </el-form-item>

          <el-form-item label="角色" prop="roleIdList" :rules="[{required: true,message: '请选择角色' }]">
            <CrudSelect v-model="form.roleIdList" :multiple="true" :filterable="true" :dic="rolesOptions"></CrudSelect>
          </el-form-item>

          <el-form-item label="是否可用" prop="available" :rules="[{required: true,message: '请选择' }]">
            <CrudRadio v-model="form.available" :dic="flagOptions"></CrudRadio>
          </el-form-item>

          <el-form-item label="备注" prop="description">
            <el-input type="textarea" v-model="form.description" placeholder=""></el-input>
          </el-form-item>
        </el-form>
        <div slot="footer" class="dialog-footer">
          <el-button size="small" @click="cancel()">取 消</el-button>
          <el-button size="small" @click="resetForm()">重 置</el-button>
          <el-button size="small" type="primary" @click="save()">保 存</el-button>
        </div>
      </el-dialog>
    </basic-container>
  </div>
</template>

<script>
    import {findUser, lockUser, pageUser, removeUser, saveUser} from "./service";
    import {fetchDeptTree} from "../dept/service";
    import {deptRoleList} from "../role/service";
    import {mapGetters} from 'vuex';
    import {parseJsonItemForm, parseTreeData} from "@/util/util";
    import {isValidateMobile, isValidateUnique, toStr, validateNotNull, validateNull} from "@/util/validate";
    import CrudSelect from "@/views/avue/crud-select";
    import CrudRadio from "@/views/avue/crud-radio";

    export default {
        name: 'User',
        components: {CrudSelect, CrudRadio},
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
                    isValidateUnique(rule, value, callback, '/sys/user/checkByProperty?id=' + toStr(this.form.id))
                },
                validatePhone: (rule, value, callback) => {
                    isValidateMobile(rule, value, callback)
                },
                validatePass: (rule, value, callback) => {
                    if (validateNull(this.form.id)) {
                        if (validateNull(value)) {
                            callback(new Error('请输入密码'));
                            return;
                        }
                    }
                    callback();
                },
                validateConfirmPass: (rule, value, callback) => {
                    if (validateNotNull(this.form.password)) {
                        if (validateNull(value)) {
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
            this.getTreeDept()
            this.getList()
            this.sys_user_edit = this.permissions["sys_user_edit"];
            this.sys_user_lock = this.permissions["sys_user_lock"];
            this.sys_user_del = this.permissions["sys_user_del"];
            deptRoleList().then(response => {
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
                this.listQuery.queryConditionJson = parseJsonItemForm([{
                    fieldName: 'a.username', value: this.searchForm.username
                }, {
                    fieldName: 'a.dept_id', value: this.searchForm.deptId
                }])
                pageUser(this.listQuery).then(response => {
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
            getTreeDept() {
                fetchDeptTree().then(response => {
                    this.treeDeptData = parseTreeData(response.data);
                    this.searchForm.parentId = this.treeDeptData[0].id;
                    setTimeout(() => {
                        this.$refs.leftDeptTree.setCurrentKey(this.searchForm.parentId);
                    }, 0);
                })
            },
            filterNode(value, data) {
                if (!value) return true
                return data.label.indexOf(value) !== -1
            },
            clickNodeTreeData(data) {
                this.searchForm.deptId = data.id
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
                this.dialogStatus = row && validateNotNull(row.id) ? "update" : "create";
                if (this.dialogStatus == "create") {
                    this.dialogFormVisible = true;
                } else {
                    findUser(row.id).then(response => {
                        this.form = response.data;
                        this.form.password = undefined;
                        this.dialogFormVisible = true;
                    });
                }
            },
            handleLock: function (row) {
                lockUser(row.id).then(response => {
                    this.getList();
                });
            },
            handleDelete(row) {
                this.$confirm('此操作将永久删除, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    removeUser(row.id).then(response => {
                        this.getList();
                    })
                })
            },
            save() {
                this.$refs['form'].validate(valid => {
                    if (valid) {
                        saveUser(this.form).then(response => {
                            this.getList()
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
                }
                this.$refs['form'] && this.$refs['form'].resetFields();
            }
        }
    }
</script>

