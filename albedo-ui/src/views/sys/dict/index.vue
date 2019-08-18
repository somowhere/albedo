<template>
  <div class="app-container calendar-list-container">
    <basic-container>
      <el-row :gutter="20">
        <el-col :span="6">
          <el-card class="box-card">
            <div class="clearfix" slot="header">
              <span>字典</span>
              <el-button @click="searchTree=(searchTree ? false:true)" class="card-heard-btn" icon="icon-filesearch"
                         title="搜索"
                         type="text"></el-button>
              <el-button @click="getTreeDict()" class="card-heard-btn" icon="icon-reload" title="刷新"
                         type="text"></el-button>
            </div>
            <el-input placeholder="输入关键字进行过滤"
                      v-model="filterTreeDictText"
                      v-show="searchTree">
            </el-input>
            <el-tree
              :data="treeDictData"
              :expand-on-click-node="false"
              :filter-node-method="filterNode"
              @node-click="clickNodeTreeData"
              class="filter-tree"
              highlight-current
              node-key="id"
              ref="leftDictTree">
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
                <el-button @click="handleFilter" icon="el-icon-search" size="small" type="primary">查询</el-button>
                <el-button @click="searchReset" icon="icon-rest" size="small">重置</el-button>
              </el-form-item>
            </el-form>
          </div>
          <!-- 表格功能列 -->
          <div class="table-menu">
            <div class="table-menu-left">
              <el-button @click="handleEdit" icon="el-icon-plus" size="mini" type="primary" v-if="sys_dict_edit">添加
              </el-button>
            </div>
            <div class="table-menu-right">
              <el-button @click="searchFilterVisible= !searchFilterVisible" circle icon="el-icon-search"
                         size="mini"></el-button>
            </div>
          </div>
          <el-table :data="list" :default-sort="{prop:'dict.sort'}" :key='tableKey' @sort-change="sortChange"
                    element-loading-text="加载中..." fit highlight-current-row v-loading="listLoading">
            <el-table-column
              fixed="left" type="index" width="20">
            </el-table-column>
            <el-table-column align="center" label="上级字典" width="100">
              <template slot-scope="scope">
                <span>{{scope.row.parentName}}</span>
              </template>
            </el-table-column>

            <el-table-column align="center" label="名称" prop="dict.name" sortable="custom" width="150">
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
            <el-table-column align="center" label="序号" prop="dict.sort" sortable="custom" width="100">
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


            <el-table-column align="center" fixed="right" label="操作" v-if="sys_dict_edit || sys_dict_del" width="100">
              <template slot-scope="scope">
                <el-button @click="handleEdit(scope.row)" icon="icon-edit" title="编辑" type="text" v-if="sys_dict_edit">
                </el-button>
                <el-button @click="handleDelete(scope.row)" icon="icon-delete" title="删除" type="text"
                           v-if="sys_dict_del">
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
      <el-dialog :visible.sync="dialogDictVisible" title="选择字典">
        <el-input placeholder="输入关键字进行过滤"
                  v-model="filterParentTreeDictText">
        </el-input>
        <el-tree :data="treeDictSelectData" :default-checked-keys="checkedKeys" :filter-node-method="filterNode"
                 @node-click="clickNodeSelectData"
                 check-strictly
                 class="filter-tree" default-expand-all highlight-current node-key="id"
                 ref="selectParentDictTree">
        </el-tree>
      </el-dialog>
      <el-dialog :title="textMap[dialogStatus]" :visible.sync="dialogFormVisible">
        <el-form :model="form" label-width="100px" ref="form">
          <el-form-item label="所属字典" prop="parentName">
            <el-input :disabled="disableSelectParent" @focus="handleParentDictTree()" placeholder="选择字典"
                      readonly v-model="form.parentName">
            </el-input>
            <input type="hidden" v-model="form.parentId"/>
          </el-form-item>

          <el-form-item :rules="[{required: true,message: '请输入字典'}]" label="字典" prop="name">
            <el-input placeholder="请输入字典" v-model="form.name"></el-input>
          </el-form-item>

          <el-form-item :rules="[ {required: true,validator:validateUnique}]" label="编码" prop="code">
            <el-input placeholder="请输入编码" v-model="form.code"></el-input>
          </el-form-item>
          <el-form-item label="值" prop="val">
            <el-input v-model="form.val"></el-input>
          </el-form-item>
          <el-form-item label="排序" prop="sort">
            <el-input v-model="form.sort"></el-input>
          </el-form-item>
          <el-form-item :rules="[{required: true,message: '请选择' }]" label="是否显示" prop="show">
            <CrudRadio :dic="flagOptions" v-model="form.show"></CrudRadio>
          </el-form-item>
          <el-form-item label="备注" prop="description">
            <el-input placeholder="" type="textarea" v-model="form.remark"></el-input>
          </el-form-item>
          <el-form-item label="描述" prop="description">
            <el-input placeholder="" type="textarea" v-model="form.description"></el-input>
          </el-form-item>
        </el-form>
        <div class="dialog-footer" slot="footer">
          <el-button @click="cancel()" size="small">取 消</el-button>
          <el-button @click="save()" size="small" type="primary">保 存</el-button>
        </div>
      </el-dialog>
    </basic-container>
  </div>
</template>

<script>
    import dictService from "./dict-service";
    import {mapGetters} from 'vuex';
    import util from "@/util/util";
    import validate from "@/util/validate";
    import CrudSelect from "@/components/avue/crud-select";
    import CrudRadio from "@/components/avue/crud-radio";

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
                    validate.isUnique(rule, value, callback, '/sys/dict/checkByProperty?id=' + util.objToStr(this.form.id))
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
            this.getTreeDict();
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
                this.listQuery.queryConditionJson = util.parseJsonItemForm([{
                    fieldName: 'name', value: this.searchForm.name
                }, {
                    fieldName: 'parent_id', value: this.searchForm.parentId, operate: 'eq'
                }]);
                dictService.page(this.listQuery).then(response => {
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
            getTreeDict() {
                dictService.fetchTree().then(response => {
                    this.treeDictData = util.parseTreeData(response.data);
                    this.currentNode = this.treeDictData[0];
                    this.searchForm.parentId = this.treeDictData[0].id;
                    setTimeout(() => {
                        this.$refs['leftDictTree'].setCurrentKey(this.searchForm.parentId);
                    }, 0);
                    this.getList();
                })
            },
            filterNode(value, data) {
                if (!value) return true;
                return data.label.indexOf(value) !== -1
            },
            clickNodeTreeData(data) {
                this.searchForm.parentId = data.id;
                this.currentNode = data;
                this.getList()
            },
            clickNodeSelectData(data) {
                this.form.parentId = data.id;
                this.form.parentName = data.label;
                this.dialogDictVisible = false;
            },
            handleParentDictTree() {
                fetchTree({extId: this.form.id}).then(response => {
                    this.treeDictSelectData = util.parseTreeData(response.data);
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
                this.dialogStatus = row && validate.checkNotNull(row.id) ? "update" : "create";
                if (this.dialogStatus == "create") {
                    if (this.currentNode) {
                        this.form.parentId = this.currentNode.id;
                        this.form.parentName = this.currentNode.label;
                    }
                    this.dialogFormVisible = true;
                } else {
                    dictService.find(row.id).then(response => {
                        this.form = response.data;
                        this.disableSelectParent = this.form.parentName ? false : true;
                        this.form.show = util.objToStr(this.form.show);
                        this.dialogFormVisible = true;
                    });
                }
            },
            handleLock: function (row) {
                dictService.lock(row.id).then(response => {
                    this.getList();
                });
            },
            handleDelete(row) {
                this.$confirm('此操作将永久删除, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    dictService.remove(row.id).then(response => {
                        this.getList();
                    })
                })
            },
            save() {
                this.$refs['form'].validate(valid => {
                    if (valid) {
                        dictService.save(this.form).then(response => {
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
                    name: undefined,
                    parentId: undefined,
                    code: undefined,
                    val: undefined,
                    show: undefined,
                    sort: undefined,
                    remark: undefined,
                    description: undefined
                };
                this.$refs['form'] && this.$refs['form'].resetFields();
            }
        }
    }
</script>

