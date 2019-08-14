<template>
  <div class="app-container calendar-list-container">
    <basic-container>
      <el-row :gutter="20">
        <el-col :span="5">
          <el-card class="box-card">
            <div slot="header" class="clearfix">
              <span>测试树</span>
              <el-button type="text" class="card-heard-btn" icon="icon-filesearch" title="搜索"
                         @click="searchTree=(searchTree ? false:true)"></el-button>
              <el-button type="text" class="card-heard-btn" icon="icon-reload" title="刷新"
                         @click="getTestTreeBookTree()"></el-button>
            </div>
            <el-input v-show="searchTree"
                      placeholder="输入关键字进行过滤"
                      v-model="filterTreeTestTreeBookText">
            </el-input>
            <el-tree
              class="filter-tree"
              :data="treeTestTreeBookData"
              ref="leftTestTreeBookTree"
              node-key="id"
              highlight-current
              :expand-on-click-node="false"
              :filter-node-method="filterNode"
              @node-click="getNodeData">
            </el-tree>
          </el-card>
        </el-col>
        <el-col :span="19">
          <div class="filter-container">
            <el-form :inline="true" :model="searchTestTreeBookForm" ref="searchTestTreeBookForm"
                     v-show="searchFilterVisible">
              <el-form-item label="部门名称" prop="name">
                <el-input class="filter-item input-normal" v-model="searchTestTreeBookForm.name"></el-input>
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
                <el-button size="mini" v-if="test_testTreeBook_edit" class="filter-item" @click="handleEdit"
                           type="primary" icon="edit">添加
                </el-button>
              </el-button-group>
            </div>
            <div class="table-menu-right">
              <el-button icon="el-icon-search" circle size="mini"
                         @click="searchFilterVisible= !searchFilterVisible"></el-button>
            </div>
          </div>
          <el-table :data="list" @sort-change="sortChange" v-loading="listLoading" element-loading-text="加载中..." border
                    fit highlight-current-row style="width: 99%">
            <el-table-column type="index" fixed="left" width="60"></el-table-column>
            <el-table-column align="center" label="部门名称">
              <template slot-scope="scope">
                <span>{{scope.row.name}}</span>
              </template>
            </el-table-column>
            <el-table-column align="center" label="排序">
              <template slot-scope="scope">
                <span>{{scope.row.sort}}</span>
              </template>
            </el-table-column>
            <el-table-column align="center" label="1 叶子节点 0 非叶子节点">
              <template slot-scope="scope">
                <span>{{scope.row.leaf}}</span>
              </template>
            </el-table-column>
            <el-table-column align="center" label="作者">
              <template slot-scope="scope">
                <span>{{scope.row.author}}</span>
              </template>
            </el-table-column>
            <el-table-column align="center" label="邮箱">
              <template slot-scope="scope">
                <span>{{scope.row.email}}</span>
              </template>
            </el-table-column>
            <el-table-column align="center" label="手机">
              <template slot-scope="scope">
                <span>{{scope.row.phone}}</span>
              </template>
            </el-table-column>
            <el-table-column align="center" label="activated_">
              <template slot-scope="scope">
                <span>{{scope.row.activated}}</span>
              </template>
            </el-table-column>
            <el-table-column align="center" label="key">
              <template slot-scope="scope">
                <span>{{scope.row.number}}</span>
              </template>
            </el-table-column>
            <el-table-column align="center" label="money_">
              <template slot-scope="scope">
                <span>{{scope.row.money}}</span>
              </template>
            </el-table-column>
            <el-table-column align="center" label="amount_">
              <template slot-scope="scope">
                <span>{{scope.row.amount}}</span>
              </template>
            </el-table-column>
            <el-table-column align="center" label="reset_date">
              <template slot-scope="scope">
                <span>{{scope.row.resetDate}}</span>
              </template>
            </el-table-column>
            <el-table-column align="center" fixed="right" label="操作"
                             v-if="test_testTreeBook_edit || test_testTreeBook_del">
              <template slot-scope="scope">
                <el-button v-if="test_testTreeBook_edit" icon="icon-edit" title="编辑" type="text"
                           @click="handleEdit(scope.row)">
                </el-button>
                <el-button v-if="test_testTreeBook_del" icon="icon-delete" title="删除" type="text"
                           @click="handleDelete(scope.row)">
                </el-button>
              </template>
            </el-table-column>

          </el-table>
          <div v-show="!listLoading" class="pagination-container">
            <el-pagination @size-change="handleSizeChange" @current-change="handleCurrentChange"
                           :current-page.sync="listQuery.page" :page-sizes="[10,20,30, 50]" :page-size="listQuery.size"
                           layout="total, sizes, prev, pager, next, jumper" :total="total">
            </el-pagination>
          </div>
        </el-col>
      </el-row>
      <el-dialog title="选择测试树" :visible.sync="dialogTestTreeBookVisible">
        <el-input placeholder="输入关键字进行过滤"
                  v-model="filterParentTreeTestTreeBookText">
        </el-input>
        <el-tree class="filter-tree" ref="selectParentTestTreeBookTree" :data="treeTestTreeBookSelectData"
                 check-strictly node-key="id" highlight-current @node-click="getNodeFormData"
                 :filter-node-method="filterNode" default-expand-all>
        </el-tree>
      </el-dialog>
      <el-dialog :title="textMap[dialogStatus]" :visible.sync="dialogFormVisible">
        <el-form :label-position="labelPosition" label-width="80px" :model="form" ref="form">
          <el-form-item label="上级测试树" prop="parentName">
            <el-input v-model="form.parentName" placeholder="选择测试树" @focus="handleParentTestTreeBookTree()"
                      :disabled="disableSelectTestTreeBookParent" readonly></el-input>
            <input type="hidden" v-model="form.parentId"/>
          </el-form-item>
          <el-form-item label="部门名称" prop="name" :rules="[{min: 0,max: 50,message: '长度在 0 到 50 个字符'},]">
            <el-input v-model="form.name"></el-input>
          </el-form-item>
          <el-form-item label="排序" prop="sort" :rules="[{validator:validateDigits},]">
            <el-input v-model="form.sort"></el-input>
          </el-form-item>
          <el-form-item label="作者" prop="author"
                        :rules="[{required: true,message: '请输入作者'},{min: 0,max: 50,message: '长度在 0 到 50 个字符'},]">
            <el-input v-model="form.author"></el-input>
          </el-form-item>
          <el-form-item label="邮箱" prop="email" :rules="[{min: 0,max: 100,message: '长度在 0 到 100 个字符'},]">
            <el-input v-model="form.email"></el-input>
          </el-form-item>
          <el-form-item label="手机" prop="phone" :rules="[{min: 0,max: 32,message: '长度在 0 到 32 个字符'},]">
            <el-input v-model="form.phone"></el-input>
          </el-form-item>
          <el-form-item label="activated_" prop="activated"
                        :rules="[{required: true,message: '请输入activated_'},{validator:validateDigits},]">
            <el-input v-model="form.activated"></el-input>
          </el-form-item>
          <el-form-item label="key" prop="number" :rules="[{validator:validateDigits},]">
            <el-input v-model="form.number"></el-input>
          </el-form-item>
          <el-form-item label="money_" prop="money" :rules="[{ validator:validateNumber},]">
            <el-input v-model="form.money"></el-input>
          </el-form-item>
          <el-form-item label="amount_" prop="amount" :rules="[{ validator:validateNumber},]">
            <el-input v-model="form.amount"></el-input>
          </el-form-item>
          <el-form-item label="reset_date" prop="resetDate" :rules="[]">
            <el-date-picker v-model="form.resetDate" type="datetime">
            </el-date-picker>
          </el-form-item>
          <el-form-item label="备注" prop="description" :rules="[{min: 0,max: 100,message: '长度在 0 到 100 个字符'},]">
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
        fetchTestTreeBookTree,
        findTestTreeBook,
        pageTestTreeBook,
        removeTestTreeBook,
        saveTestTreeBook,
        validateUniqueTestTreeBook
    } from "./service";
    import {mapGetters} from "vuex";
    import {isValidateDigits, isValidateNumber, objectToString, validateNotNull} from "@/util/validate";
    import {parseJsonItemForm, parseTreeData} from "@/util/util";
    import CrudSelect from "@/views/avue/crud-select";
    import CrudCheckbox from "@/views/avue/crud-checkbox";
    import CrudRadio from "@/views/avue/crud-radio";

    export default {
        name: "table_test_testTreeBook",
        components: {CrudSelect, CrudCheckbox, CrudRadio},
        data() {
            return {
                dialogTestTreeBookVisible: false,
                disableSelectTestTreeBookParent: false,
                treeTestTreeBookData: [],
                treeTestTreeBookSelectData: [],
                dialogFormVisible: false,
                searchFilterVisible: true,
                list: null,
                total: null,
                listLoading: true,
                searchTestTreeBookForm: {},
                listQuery: {
                    page: 1,
                    size: 20
                },
                formEdit: true,
                filterTreeTestTreeBookText: '',
                filterParentTreeTestTreeBookText: '',
                formStatus: '',
                searchTree: false,
                labelPosition: 'right',
                form: {
                    name: undefined,
                    sort: undefined,
                    author: undefined,
                    email: undefined,
                    phone: undefined,
                    activated: undefined,
                    number: undefined,
                    money: undefined,
                    amount: undefined,
                    resetDate: undefined,
                    description: undefined,
                },
                validateUnique: (rule, value, callback) => {
                    validateUniqueTestTreeBook(rule, value, callback, this.form.id)
                },
                validateNumber: (rule, value, callback) => {
                    isValidateNumber(rule, value, callback)
                },
                validateDigits: (rule, value, callback) => {
                    isValidateDigits(rule, value, callback)
                },
                delFlagOptions: undefined,
                dialogStatus: 'create',
                textMap: {
                    update: '编辑测试树',
                    create: '创建测试树'
                },
                currentNode: {}
            }
        },
        watch: {
            filterTreeTestTreeBookText(val) {
                this.$refs['leftTestTreeBookTree'].filter(val);
            },
            filterParentTreeTestTreeBookText(val) {
                this.$refs['selectParentTestTreeBookTree'].filter(val);
            }
        },
        created() {
            this.getTestTreeBookTree()
            this.getList()
            this.test_testTreeBook_edit = this.permissions["test_testTreeBook_edit"];
            this.test_testTreeBook_del = this.permissions["test_testTreeBook_del"];
            this.delFlagOptions = this.dicts["sys_flag"];
        },
        computed: {
            ...mapGetters(["permissions", "dicts"])
        },
        methods: {
            getList() {
                this.listLoading = true;
                this.listQuery.isAsc = false;
                this.listQuery.queryConditionJson = parseJsonItemForm([
                    {fieldName: 'name', value: this.searchTestTreeBookForm.name, operate: 'like', attrType: 'String'},
                    {fieldName: 'parentId', value: this.searchTestTreeBookForm.parentId, attrType: 'eq'},
                ])
                pageTestTreeBook(this.listQuery).then(response => {
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
            getTestTreeBookTree() {
                fetchTestTreeBookTree({all: true}).then(response => {
                    this.treeTestTreeBookData = parseTreeData(response.data);
                })
            },
            filterNode(value, data) {
                if (!value) return true
                return data.label.indexOf(value) !== -1
            },
            getNodeData(data) {
                this.searchTestTreeBookForm.parentId = data.id
                this.currentNode = data;
                this.getList()
            },
            getNodeFormData(data) {
                this.dialogTestTreeBookVisible = false;
                this.form.parentId = data.id;
                this.form.parentName = data.label;
            },
            searchReset() {
                this.$refs['searchTestTreeBookForm'].resetFields();
                this.searchTestTreeBookForm.parentId = undefined;
                this.$refs['leftTestTreeBookTree'].setCurrentKey(null);
                this.currentNode = undefined;
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
                this.dialogStatus = row && validateNotNull(row.id) ? "update" : "create";
                if (this.dialogStatus == "create") {
                    this.dialogFormVisible = true;
                    this.form.parentId = this.currentNode.id
                    this.form.parentName = this.currentNode.label;
                } else {
                    findTestTreeBook(row.id).then(response => {
                        this.form = response.data;
                        this.form.delFlag = objectToString(this.form.delFlag);
                        this.disableSelectTestTreeBookParent = this.form.parentName ? false : true;
                        this.dialogFormVisible = true;
                    });
                }
            },
            handleParentTestTreeBookTree() {
                fetchTestTreeBookTree({extId: this.form.id}).then(response => {
                    this.treeTestTreeBookSelectData = parseTreeData(response.data);
                    this.dialogTestTreeBookVisible = true;
                    setTimeout(() => {
                        this.$refs['selectParentTestTreeBookTree'].setCurrentKey(this.form.parentId ? this.form.parentId : null);
                    }, 100)
                })
            },
            handleDelete(row) {
                this.$confirm('此操作将永久删除, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    removeTestTreeBook(row.id).then(() => {
                        this.getList();
                    })
                })
            },
            save() {
                const set = this.$refs;
                set['form'].validate(valid => {
                    if (valid) {
                        saveTestTreeBook(this.form).then(() => {
                            this.getList()
                            this.cancel()
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
                    name: "",
                    sort: "",
                    author: "",
                    email: "",
                    phone: "",
                    activated: "",
                    number: "",
                    money: "",
                    amount: "",
                    resetDate: "",
                    description: "",
                }
                if (this.$refs['form']) {
                    this.$refs['form'].resetFields();
                }
            }
        }
    }
</script>
