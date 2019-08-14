<template>
  <div class="app-container calendar-list-container">
    <basic-container>
      <el-row :gutter="20">
        <el-col :span="6">
          <el-card class="box-card">
            <div slot="header" class="clearfix">
              <span>字典</span>
              <el-button type="text" class="card-heard-btn" icon="icon-filesearch" title="搜索"
                         @click="searchTree=(searchTree ? false:true)"></el-button>
              <el-button type="text" class="card-heard-btn" icon="icon-reload" title="刷新"
                         @click="getTreeDict()"></el-button>
            </div>
            <el-input v-show="searchTree"
                      placeholder="输入关键字进行过滤"
                      v-model="filterTreeDictText">
            </el-input>
            <el-tree
              class="filter-tree"
              :data="treeDictData"
              ref="leftDictTree"
              node-key="id"
              highlight-current default-expand-all
              :expand-on-click-node="false"
              :filter-node-method="filterNode"
              @node-click="clickNodeTreeData">
            </el-tree>
          </el-card>
        </el-col>
        <el-col :span="18">
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
              <el-button size="mini" v-if="sys_dict_edit" @click="handleEdit" type="primary" icon="el-icon-plus">添加
              </el-button>
            </div>
            <div class="table-menu-right">
              <el-button icon="el-icon-search" circle size="mini"
                         @click="searchFilterVisible= !searchFilterVisible"></el-button>
            </div>
          </div>
          <el-table :key='tableKey' @sort-change="sortChange" :default-sort="{prop:'dict.sort'}" :data="list"
                    v-loading="listLoading" element-loading-text="加载中..." fit highlight-current-row>
            <el-table-column
              type="index" fixed="left" width="40">
            </el-table-column>
            <el-table-column align="center" label="上级字典" width="100">
              <template slot-scope="scope">
                <span>{{scope.row.parentName}}</span>
              </template>
            </el-table-column>

            <el-table-column align="center" label="名称" width="150" prop="dict.name" sortable="custom">
              <template slot-scope="scope">
              <span>
                {{scope.row.name}}
              </span>
              </template>
            </el-table-column>
            <el-table-column align="center" label="编码" width="140">
              <template slot-scope="scope">
                <span>{{scope.row.code}}</span>
              </template>
            </el-table-column>
            <el-table-column align="center" label="值" width="140">
              <template slot-scope="scope">
                <span>{{scope.row.val}}</span>
              </template>
            </el-table-column>
            <el-table-column align="center" label="是否显示" width="80">
              <template slot-scope="scope">
                <el-tag>{{scope.row.showText}}</el-tag>
              </template>
            </el-table-column>
            <el-table-column align="center" label="序号" width="100" prop="dict.sort" sortable="custom">
              <template slot-scope="scope">
              <span>
                {{scope.row.sort}}
              </span>
              </template>
            </el-table-column>
            <el-table-column align="center" label="创建时间" prop="dict.created_date" sortable="custom">
              <template slot-scope="scope">
                <span>{{scope.row.createdDate}}</span>
              </template>
            </el-table-column>


            <el-table-column align="center" fixed="right" width="100" label="操作" v-if="sys_dict_edit || sys_dict_del">
              <template slot-scope="scope">
                <el-button v-if="sys_dict_edit" icon="icon-edit" title="编辑" type="text" @click="handleEdit(scope.row)">
                </el-button>
                <el-button v-if="sys_dict_del" icon="icon-delete" title="删除" type="text"
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
      <el-dialog title="选择字典" :visible.sync="dialogDictVisible">
        <el-input placeholder="输入关键字进行过滤"
                  v-model="filterParentTreeDictText">
        </el-input>
        <el-tree class="filter-tree" ref="selectParentDictTree" default-expand-all :data="treeDictSelectData"
                 :default-checked-keys="checkedKeys"
                 check-strictly node-key="id" highlight-current @node-click="clickNodeSelectData"
                 :filter-node-method="filterNode">
        </el-tree>
      </el-dialog>
      <el-dialog :title="textMap[dialogStatus]" :visible.sync="dialogFormVisible">
        <el-form :model="form" ref="form" label-width="100px">
          <el-form-item label="所属字典" prop="parentName">
            <el-input v-model="form.parentName" placeholder="选择字典" @focus="handleParentDictTree()"
                      :disabled="disableSelectParent" readonly>
            </el-input>
            <input type="hidden" v-model="form.parentId"/>
          </el-form-item>

          <el-form-item label="字典" prop="name" :rules="[{required: true,message: '请输入字典'}]">
            <el-input v-model="form.name" placeholder="请输入字典"></el-input>
          </el-form-item>

          <el-form-item label="编码" prop="code" :rules="[ {required: true,validator:validateUnique}]">
            <el-input v-model="form.code" placeholder="请输入编码"></el-input>
          </el-form-item>
          <el-form-item label="值" prop="val">
            <el-input v-model="form.val"></el-input>
          </el-form-item>
          <el-form-item label="排序" prop="sort">
            <el-input v-model="form.sort"></el-input>
          </el-form-item>
          <el-form-item label="是否显示" prop="show" :rules="[{required: true,message: '请选择' }]">
            <CrudRadio v-model="form.show" :dic="flagOptions"></CrudRadio>
          </el-form-item>
          <el-form-item label="备注" prop="description">
            <el-input type="textarea" v-model="form.remark" placeholder=""></el-input>
          </el-form-item>
          <el-form-item label="描述" prop="description">
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
    import {fetchDictTree, findDict, lockDict, pageDict, removeDict, saveDict} from "./service";
    import {mapGetters} from 'vuex';
    import {parseJsonItemForm, parseTreeData} from "@/util/util";
    import {isValidateUnique, toStr, validateNotNull} from "@/util/validate";
    import CrudSelect from "@/views/avue/crud-select";
    import CrudRadio from "@/views/avue/crud-radio";
    import {objectToString} from "../../../util/validate";

    export default {
        name: 'Dict',
        components: {CrudSelect, CrudRadio},
        data() {
            return {
                treeDictData: [],
                treeDictSelectData: [],
                treeParentDictData: [],
                dialogDictVisible: false,
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
                filterTreeDictText: '',
                filterParentTreeDictText: '',
                formStatus: '',
                flagOptions: [],
                rolesOptions: [],
                searchTree: false,
                labelPosition: 'right',
                disableSelectParent: false,
                form: {
                    name: undefined,
                    parentId: undefined,
                    code: undefined,
                    val: undefined,
                    show: undefined,
                    sort: undefined,
                    remark: undefined,
                    description: undefined
                },
                validateUnique: (rule, value, callback) => {
                    isValidateUnique(rule, value, callback, '/sys/dict/checkByProperty?id=' + toStr(this.form.id))
                },
                dialogStatus: 'create',
                textMap: {
                    update: '编辑',
                    create: '创建'
                },
                sys_dict_edit: false,
                sys_dict_del: false,
                currentNode: {},
                tableKey: 0
            }
        },
        watch: {
            filterTreeDictText(val) {
                this.$refs['leftDictTree'].filter(val);
            },
            filterParentTreeDictText(val) {
                this.$refs['selectParentDictTree'].filter(val);
            }
        },
        created() {
            this.getTreeDict()
            this.sys_dict_edit = this.permissions["sys_dict_edit"];
            this.sys_dict_del = this.permissions["sys_dict_del"];
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
                    fieldName: 'name', value: this.searchForm.name
                }, {
                    fieldName: 'parent_id', value: this.searchForm.parentId, operate: 'eq'
                }])
                pageDict(this.listQuery).then(response => {
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
            getTreeDict() {
                fetchDictTree().then(response => {
                    this.treeDictData = parseTreeData(response.data);
                    this.currentNode = this.treeDictData[0];
                    this.searchForm.parentId = this.treeDictData[0].id;
                    setTimeout(() => {
                        this.$refs['leftDictTree'].setCurrentKey(this.searchForm.parentId);
                    }, 0);
                    this.getList();
                })
            },
            filterNode(value, data) {
                if (!value) return true
                return data.label.indexOf(value) !== -1
            },
            clickNodeTreeData(data) {
                this.searchForm.parentId = data.id
                this.currentNode = data;
                this.getList()
            },
            clickNodeSelectData(data) {
                this.form.parentId = data.id;
                this.form.parentName = data.label;
                this.dialogDictVisible = false;
            },
            handleParentDictTree() {
                fetchDictTree({extId: this.form.id}).then(response => {
                    this.treeDictSelectData = parseTreeData(response.data);
                    this.dialogDictVisible = true;
                    setTimeout(() => {
                        this.$refs['selectParentDictTree'].setCurrentKey(this.form.parentId ? this.form.parentId : null);
                    }, 100)
                })
            },
            //搜索清空
            searchReset() {
                this.$refs['searchForm'].resetFields();
                this.searchForm.parentId = undefined;
                this.$refs['leftDictTree'].setCurrentKey(null);
                this.currentNode = undefined;
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
                    if (this.currentNode) {
                        this.form.parentId = this.currentNode.id;
                        this.form.parentName = this.currentNode.label;
                    }
                    this.dialogFormVisible = true;
                } else {
                    findDict(row.id).then(response => {
                        this.form = response.data;
                        this.disableSelectParent = this.form.parentName ? false : true;
                        this.form.show = objectToString(this.form.show);
                        this.dialogFormVisible = true;
                    });
                }
            },
            handleLock: function (row) {
                lockDict(row.id).then(response => {
                    this.getList();
                });
            },
            handleDelete(row) {
                this.$confirm('此操作将永久删除, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    removeDict(row.id).then(response => {
                        this.getList();
                    })
                })
            },
            save() {
                this.$refs['form'].validate(valid => {
                    if (valid) {
                        saveDict(this.form).then(response => {
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
                    parentId: undefined,
                    code: undefined,
                    val: undefined,
                    show: undefined,
                    sort: undefined,
                    remark: undefined,
                    description: undefined
                }
                this.$refs['form'] && this.$refs['form'].resetFields();
            }
        }
    }
</script>

