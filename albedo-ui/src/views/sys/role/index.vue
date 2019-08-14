<template>
  <div class="app-container calendar-list-container">
    <basic-container>
      <el-row>

        <el-col>
          <div class="filter-container" v-show="searchFilterVisible">
            <el-form :inline="true" :model="searchForm" ref="searchForm">
              <el-form-item label="名称" prop="name">
                <el-input class="filter-item input-normal" size="small" v-model="searchForm.name"></el-input>
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
              <el-button size="mini" v-if="sys_role_edit" @click="handleEdit" type="primary" icon="el-icon-plus">添加
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
            <el-table-column align="center" label="角色名称" width="100">
              <template slot-scope="scope">
                <span>{{scope.row.name}}</span>
              </template>
            </el-table-column>

            <el-table-column align="center" label="角色标识" width="140">
              <template slot-scope="scope">
          <span>
            {{scope.row.code}}
          </span>
              </template>
            </el-table-column>
            <el-table-column align="center" label="数据权限" width="130">
              <template slot-scope="scope">
                <span>{{scope.row.dataScopeText}}</span>
              </template>
            </el-table-column>
            <el-table-column align="center" label="角色描述">
              <template slot-scope="scope">
          <span>
            {{scope.row.remark}}
          </span>
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
                             v-if="sys_role_edit || sys_role_lock || sys_role_del">
              <template slot-scope="scope">
                <el-button v-if="sys_role_edit" icon="icon-edit" title="编辑" type="text" @click="handleEdit(scope.row)">
                </el-button>
                <el-button v-if="sys_role_lock" :icon="scope.row.available == '0' ? 'icon-lock' : 'icon-unlock'"
                           :title="scope.row.available == '0' ? '锁定' : '解锁'" type="text" @click="handleLock(scope.row)">
                </el-button>
                <el-button v-if="sys_role_del" icon="icon-delete" title="删除" type="text"
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
      <el-dialog :title="textMap[dialogStatus]" :visible.sync="dialogFormVisible">
        <el-form :model="form" ref="form" label-width="100px">

          <el-form-item label="角色名称" prop="name" :rules="[
          {required: true,message: '请输入角色名称'}
        ]">
            <el-input v-model="form.name" placeholder="请输入角色名称"></el-input>
          </el-form-item>
          <el-form-item label="角色标识" prop="code" :rules="[{required: true,message: '请输入角色名称'}]">
            <el-input v-model="form.code" placeholder="请输入角色标识"></el-input>
          </el-form-item>
          <el-form-item label="数据权限" prop="dataScope" :rules="[{required: true,message: '请选择' }]">
            <CrudSelect v-model="form.dataScope" :dic="dataScopeOptions" @input="handleDataScopeChange"></CrudSelect>
          </el-form-item>

          <el-row :gutter="20" :span="24">
            <el-col :span="12">
              <el-form-item label="操作权限" prop="menuIdList">
                <el-tree class="filter-tree" :data="treeMenuData" ref="treeMenu" node-key="id"
                         show-checkbox :default-checked-keys="form.menuIdList" @check="getNodeTreeMenuData">
                </el-tree>
              </el-form-item>
            </el-col>
            <el-col :span="10" v-show="formTreeDeptDataVisible">
              <el-form-item label="机构权限" prop="orgIdList" v-show="formTreeDeptDataVisible">
                <el-tree class="filter-tree" ref="treeDept" :data="treeDeptData" node-key="id"
                         show-checkbox default-expand-all :default-checked-keys="form.deptIdList"
                         @check="getNodeTreeDeptData">
                </el-tree>
              </el-form-item>
            </el-col>
          </el-row>
          <el-form-item label="是否可用" prop="available" :rules="[{required: true,message: '请选择' }]">
            <CrudRadio v-model="form.available" :dic="flagOptions"></CrudRadio>
          </el-form-item>
          <el-form-item label="角色描述" prop="remark" :rules="[{required: true, message: '请输入角色描述'}]">
            <el-input v-model="form.remark"></el-input>
          </el-form-item>
          <el-form-item label="备注" prop="description">
            <el-input type="textarea" v-model="form.description" placeholder=""></el-input>
          </el-form-item>
        </el-form>
        <div slot="footer" class="dialog-footer">
          <el-button size="small" @click="cancel()">取 消</el-button>
          <el-button size="small" type="primary" @click="save()">保 存</el-button>
        </div>
      </el-dialog>
    </basic-container>
  </div>
</template>

<script>
    import {findRole, lockRole, pageRole, removeRole, saveRole} from "./service";
    import {fetchMenuTree} from "../menu/service";
    import {mapGetters} from 'vuex';
    import {fetchDeptTree} from "../dept/service";
    import {parseJsonItemForm, parseTreeData} from "@/util/util";
    import {objectToString, validateNotNull, validateNull} from "@/util/validate";
    import CrudSelect from "@/views/avue/crud-select";
    import CrudRadio from "@/views/avue/crud-radio";

    export default {
        name: 'Role',
        components: {CrudSelect, CrudRadio},
        data() {
            return {
                treeDept: [],
                treeMenuData: [],
                treeDeptData: [],
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
                flagOptions: [],
                dataScopeOptions: [],
                form: {
                    name: undefined,
                    dataScope: undefined,
                    code: undefined,
                    menuIdList: [],
                    deptIdList: [],
                    remark: undefined,
                    available: undefined,
                    description: undefined
                },
                dialogDeptVisible: false,
                formTreeDeptDataVisible: false,
                dialogStatus: 'create',
                textMap: {
                    update: '编辑',
                    create: '创建'
                },
                sys_role_edit: false,
                sys_role_lock: false,
                sys_role_del: false,
                currentNode: {},
                tableKey: 0
            }
        },
        watch: {},
        created() {
            this.getList()
            this.sys_role_edit = this.permissions["sys_role_edit"];
            this.sys_role_lock = this.permissions["sys_role_lock"];
            this.sys_role_del = this.permissions["sys_role_del"];
            this.flagOptions = this.dicts['sys_flag'];
            this.dataScopeOptions = this.dicts['sys_data_scope'];
            fetchMenuTree().then(rs => {
                this.treeMenuData = parseTreeData(rs.data);
            })
            fetchDeptTree().then(response => {
                this.treeDeptData = parseTreeData(response.data);
            })
        },
        computed: {
            ...mapGetters([
                "permissions", "dicts"
            ])
        },
        methods: {
            getList() {
                this.listLoading = true;
                this.listQuery.queryConditionJson = parseJsonItemForm([{
                    fieldName: 'name', value: this.searchForm.name
                }])
                pageRole(this.listQuery).then(response => {
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

            //搜索清空
            searchReset() {
                this.$refs['searchForm'].resetFields();
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
                    findRole(row.id).then(response => {
                        this.form = response.data;
                        this.dialogFormVisible = true;
                        this.formTreeDeptDataVisible = (this.form.dataScope == 5);
                        if (validateNull(this.form.deptIdList)) {
                            this.form.deptIdList = []
                        }
                        this.form.dataScope = objectToString(this.form.dataScope)
                        if (this.$refs.treeMenu) {
                            this.$refs.treeMenu.setCheckedKeys(this.form.menuIdList);
                            this.$refs.treeDept.setCheckedKeys(this.form.deptIdList);
                        }
                    });
                }
            },
            handleLock: function (row) {
                lockRole(row.id).then(response => {
                    this.getList();
                });
            },
            handleDelete(row) {
                this.$confirm('此操作将永久删除, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    removeRole(row.id).then((rs) => {
                        this.getList();
                    })
                })
            },
            handleDataScopeChange(value) {
                this.formTreeDeptDataVisible = (value == 5);
            },
            getNodeTreeMenuData(data, obj) {
                this.form.menuIdList = obj.checkedKeys;
            },
            getNodeTreeDeptData(data, obj) {
                this.form.deptIdList = obj.checkedKeys;
            },
            save() {
                this.$refs['form'].validate(valid => {
                    if (valid) {
                        saveRole(this.form).then(() => {
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
                    name: undefined,
                    dataScope: undefined,
                    code: undefined,
                    menuIdList: [],
                    deptIdList: [],
                    remark: undefined,
                    available: undefined,
                    description: undefined
                }
                this.$refs['form'] && this.$refs['form'].resetFields();
                // this.$refs.treeMenu.setCheckedKeys([]);
                // this.$refs.treeDept.setCheckedKeys([]);
            }
        }
    }
</script>

