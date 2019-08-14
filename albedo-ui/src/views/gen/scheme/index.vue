<template>
  <div class="app-container calendar-list-container">
    <basic-container>
      <div class="filter-container" v-show="searchFilterVisible">
        <el-form ref="searchForm" :model="searchForm" :inline="true">
          <el-form-item label="名称" prop="name">
            <el-input size="small" class="filter-item input-normal" v-model="searchForm.name"></el-input>
          </el-form-item>
          <el-form-item label="表名" ref="tableName">
            <el-input size="small" class="filter-item input-normal" v-model="searchForm.tableName"></el-input>
          </el-form-item>
          <el-form-item label="功能名称" prop="functionName">
            <el-input size="small" class="filter-item input-normal" v-model="searchForm.functionName"></el-input>
          </el-form-item>
          <el-form-item label="功能作者" prop="functionAuthor">
            <el-input size="small" class="filter-item input-normal" v-model="searchForm.functionAuthor"></el-input>
          </el-form-item>
          <el-form-item>
            <el-button size="small" class="filter-item" type="primary" icon="el-icon-search" @click="handleFilter">查询
            </el-button>
            <el-button size="small" @click="searchReset" icon="icon-rest">重置</el-button>
          </el-form-item>
        </el-form>
      </div>
      <!-- 表格功能列 -->
      <div class="table-menu">
        <div class="table-menu-left">
          <el-button-group>
            <el-button size="mini" v-if="gen_scheme_edit" @click="handleEdit" type="primary" icon="el-icon-plus">添加
            </el-button>
            <el-button size="mini" v-if="gen_scheme_menu" @click="handleGenMenuDialog" type="primary"
                       icon="icon-filesync">生成菜单
            </el-button>
          </el-button-group>
        </div>
        <div class="table-menu-right">
          <el-button icon="el-icon-search" circle size="mini"
                     @click="searchFilterVisible= !searchFilterVisible"></el-button>
        </div>
      </div>
      <el-table :key='tableKey' :data="list" v-loading="listLoading"
                @current-change="handleSelect" element-loading-text="加载中..." fit highlight-current-row>
        <el-table-column align="center" label="名称">
          <template slot-scope="scope">
            <span>{{scope.row.name}}</span>
          </template>
        </el-table-column>

        <el-table-column align="center" label="表名">
          <template slot-scope="scope">
            <span>{{scope.row.tableName}}</span>
          </template>
        </el-table-column>

        <el-table-column align="center" label="基础包名">
          <template slot-scope="scope">
          <span>
            {{scope.row.packageName}}
          </span>
          </template>
        </el-table-column>

        <el-table-column align="center" label="模块">
          <template slot-scope="scope">
            <span>{{scope.row.moduleName}}</span>
          </template>
        </el-table-column>

        <el-table-column align="center" label="功能名称">
          <template slot-scope="scope">
            <span>{{scope.row.functionName}}</span>
          </template>
        </el-table-column>

        <el-table-column align="center" label="功能作者">
          <template slot-scope="scope">
            <span>{{scope.row.functionAuthor}}</span>
          </template>
        </el-table-column>

        <el-table-column align="center" label="操作">
          <template slot-scope="scope">
            <el-button v-if="gen_scheme_edit" icon="icon-edit" title="编辑" type="text" @click="handleEdit(scope.row)">
            </el-button>
            <el-button v-if="gen_scheme_edit" icon="icon-block" title="生成代码" type="text"
                       @click="handleGenCodeDialog(scope.row)">
            </el-button>
            <el-button v-if="gen_scheme_del" icon="icon-delete" title="删除" type="text" @click="handleDelete(scope.row)">
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

      <el-dialog :title="textMap[dialogStatus]" :visible.sync="dialogFormVisible">
        <el-form :model="form" ref="form" label-width="120px">
          <el-form-item label="方案名称"
                        inline-message="生成结构：(包名)/(模块名)/(分层(dao,entity,service,web))/(子模块名)/(java类)"
                        prop="name" :rules="[{required: true,message: '请输入方案名称'}]">
            <el-input v-model="form.name"></el-input>
          </el-form-item>
          <el-form-item label="模块分类" prop="category"
                        :rules="[{required: true,message: '请选择模块分类'}]">
            <CrudSelect v-model="form.category" :dic="categoryList"></CrudSelect>
          </el-form-item>
          <el-form-item label="生成包路径" prop="packageName"
                        :rules="[{required: true,message: '请输入生成包路径'}]">
            <el-input v-model="form.packageName"></el-input>
          </el-form-item>
          <el-form-item label="生成模块名" prop="moduleName"
                        :rules="[{required: true,message: '请输入生成模块名'}]">
            <el-input v-model="form.moduleName"></el-input>
          </el-form-item>
          <el-form-item label="生成子模块名" prop="subMenuName">
            <el-input v-model="form.subMenuName"></el-input>
          </el-form-item>
          <el-form-item label="生成功能描述" prop="functionName"
                        :rules="[{required: true,message: '请输入生成功能描述'}]">
            <el-input v-model="form.functionName"></el-input>
          </el-form-item>
          <el-form-item label="生成功能名" prop="functionNameSimple"
                        :rules="[{required: true,message: '请输入生成功能名'}]">
            <el-input v-model="form.functionNameSimple"></el-input>
          </el-form-item>
          <el-form-item label="生成功能作者" prop="functionAuthor"
                        :rules="[{required: true,message: '请输入生成功能作者'}]">
            <el-input v-model="form.functionAuthor"></el-input>
          </el-form-item>
          <el-form-item label="业务表名" prop="tableId"
                        :rules="[{required: true,message: '请选择业务表名'}]">
            <CrudSelect v-model="form.tableId" :dic="tableList"></CrudSelect>
          </el-form-item>
          <el-form-item label="生成选项">
            <el-switch v-model="form.genCode" active-text="是否生成代码">
            </el-switch>
            <el-switch v-model="form.replaceFile" active-text="是否替换现有文件">
            </el-switch>
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


      <el-dialog title="系统提示" :visible.sync="dialogGenCodeVisible"
                 width="30%">
        <span>确认要继续操作吗?</span>
        <span slot="footer" class="dialog-footer">
          <el-button size="small" @click="dialogGenCodeVisible = false">取 消</el-button>
          <el-button size="small" type="primary" @click="handleGenCode(false)">生成代码</el-button>
          <el-button size="small" type="primary" @click="handleGenCode(true)">生成代码并覆盖</el-button>
        </span>
      </el-dialog>

      <el-dialog title="选择菜单" :visible.sync="dialogMenuVisible">
        <el-input placeholder="输入关键字进行过滤"
                  v-model="filterFormText">
        </el-input>
        <el-tree class="filter-tree" ref="formTree" :data="treeMenuData"
                 check-strictly node-key="id" highlight-current @node-click="getNodeData"
                 :filter-node-method="filterNode">
        </el-tree>
      </el-dialog>

      <el-dialog title="生成菜单" :visible.sync="dialogGenMenuVisible"
                 width="30%">
        <el-form :model="genMenuForm" ref="genMenuForm" label-width="100px">
          <el-form-item label="上级菜单" prop="parentMenuId" :rules="[{required: true,message: '请选择上级菜单'}]">
            <el-input v-model="genMenuForm.parentMenuName" placeholder="选择菜单" @focus="handleMenu()" readonly></el-input>
            <input type="hidden" v-model="genMenuForm.parentMenuId"/>
          </el-form-item>
        </el-form>
        <span slot="footer" class="dialog-footer">
          <el-button size="small" @click="cancelGenMenu">取 消</el-button>
          <el-button size="small" type="primary" @click="handleGenMenu">生成菜单</el-button>
        </span>
      </el-dialog>

    </basic-container>
  </div>
</template>

<script>
    import {findGenScheme, genCode, genMenu, pageGenScheme, removeGenScheme, saveGenScheme} from "./service";
    import {mapGetters} from "vuex";
    import {validateNotNull, validateNull} from "@/util/validate";
    import {parseJsonItemForm, parseTreeData} from "@/util/util";
    import {fetchMenuTree} from "../../sys/menu/service";
    import CrudSelect from "@/views/avue/crud-select";
    import CrudRadio from "@/views/avue/crud-radio";

    export default {
        components: {CrudSelect, CrudRadio},
        name: "Scheme",
        data() {
            return {
                searchFilterVisible: true,
                treeMenuData: [],
                checkedKeys: [],
                defaultProps: {
                    children: "children",
                    label: "label"
                },
                list: null,
                total: null,
                listLoading: true,
                searchForm: {},
                listQuery: {
                    page: 1,
                    size: 20
                },
                viewTypeList: [],
                categoryList: [],
                tableList: [],
                form: {
                    name: undefined,
                    tableName: undefined,
                    packageName: undefined,
                    moduleName: undefined,
                    subMenuName: undefined,
                    functionName: undefined,
                    functionNameSimple: undefined,
                    functionAuthor: undefined,
                    tableId: undefined,
                    genCode: undefined,
                    replaceFile: undefined,
                    syncMenu: undefined,
                    status: undefined,
                    description: undefined
                },
                genMenuForm: {
                    id: undefined,
                    parentMenuName: undefined,
                    parentMenuId: undefined,
                },
                statusOptions: [],
                filterFormText: '',
                dialogFormVisible: false,
                dialogMenuVisible: false,
                dialogGenCodeVisible: false,
                dialogGenMenuVisible: false,
                currentRow: {},
                schemeAdd: false,
                schemeUpd: false,
                schemeDel: false,
                dialogStatus: 'create',
                textMap: {
                    update: '编辑',
                    create: '创建'
                },
                isDisabled: {
                    0: false,
                    1: true
                },
                tableKey: 0
            };
        },
        computed: {
            ...mapGetters(["permissions", "dicts"])
        },
        watch: {
            filterFormText(val) {
                this.$refs['formTree'].filter(val);
            }
        },
        created() {
            this.getList();
            this.gen_scheme_menu = this.permissions["gen_scheme_menu"];
            this.gen_scheme_edit = this.permissions["gen_scheme_edit"];
            this.gen_scheme_del = this.permissions["gen_scheme_del"];
        },
        methods: {
            getList() {
                this.listLoading = true;
                this.listQuery.queryConditionJson = parseJsonItemForm([{
                    fieldName: 'name', value: this.searchForm.name
                }, {
                    fieldName: 'table.name', value: this.searchForm.tableName
                }, {
                    fieldName: 'functionName', value: this.searchForm.functionName
                }, {
                    fieldName: 'functionAuthor', value: this.searchForm.functionAuthor
                }])
                pageGenScheme(this.listQuery).then(response => {
                    this.list = response.data.records;
                    this.total = response.data.total;
                    this.listLoading = false;
                });
            },
            //搜索清空
            searchReset() {
                this.$refs['searchForm'].resetFields();
            },
            getNodeData(data) {
                this.dialogMenuVisible = false;
                this.genMenuForm.parentMenuId = data.id;
                this.genMenuForm.parentMenuName = data.label;
            },
            filterNode(value, data) {
                if (!value) return true
                return data.label.indexOf(value) !== -1
            },
            handleMenu() {
                fetchMenuTree({extId: this.form.id}).then(response => {
                    this.treeMenuData = parseTreeData(response.data);
                    this.dialogMenuVisible = true;
                })
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
            handleSelect(row) {
                this.currentRow = row;
            },
            handleGenMenu() {
                if (validateNull(this.currentRow) || validateNull(this.currentRow.id)) {
                    this.$message({
                        message: '请选择方案',
                        type: 'warning'
                    })
                    return;
                }
                this.genMenuForm.id = this.currentRow.id;
                const set = this.$refs;
                set['genMenuForm'].validate(valid => {
                    if (valid) {
                        genMenu(this.genMenuForm).then(response => {
                            this.getList();
                            this.cancelGenMenu()
                        });
                    } else {
                        return false;
                    }
                });
            },
            handleGenMenuDialog() {
                if (validateNull(this.currentRow) || validateNull(this.currentRow.id)) {
                    this.$message({
                        message: '请选择方案',
                        type: 'warning'
                    })
                    return;
                }
                this.genMenuForm.id = undefined;
                this.genMenuForm.parentMenuId = undefined;
                this.genMenuForm.parentMenuName = undefined;
                this.dialogGenMenuVisible = true;
            },
            handleEdit(row) {
                this.dialogStatus = row && !validateNull(row.id) ? "update" : "create";
                let params;
                if (this.dialogStatus == "update") {
                    params = {id: row.id};
                }
                findGenScheme(params).then(response => {
                    var data = response.data;
                    this.viewTypeList = data.viewTypeList
                    this.categoryList = data.categoryList
                    this.tableList = data.tableList
                    if (validateNotNull(data.schemeVo)) {
                        this.resetForm();
                        this.form = data.schemeVo;
                        // this.form.genCode = true
                        // this.form.replaceFile= false
                        // this.form.syncMenu=  false
                    }
                    this.dialogFormVisible = true;
                });
            },
            cancelGenMenu() {
                this.dialogGenMenuVisible = false;
                this.$refs['genMenuForm'].resetFields();
            },
            cancel() {
                this.dialogFormVisible = false;
                this.$refs['form'].resetFields();
            },
            save() {
                const set = this.$refs;
                set['form'].validate(valid => {
                    if (valid) {
                        // this.form.password = undefined;
                        saveGenScheme(this.form).then(response => {
                            this.getList();
                            this.cancel()
                        });
                    } else {
                        return false;
                    }
                });
            },
            handleGenCodeDialog(row) {
                this.currentRow = row;
                this.dialogGenCodeVisible = true;
            },
            handleGenCode(replaceFile) {
                if (validateNull(this.currentRow) || validateNull(this.currentRow.id)) {
                    this.$message({
                        message: '无法获取选中信息',
                        type: 'warning'
                    })
                    return;
                }
                genCode({id: this.currentRow.id, replaceFile: replaceFile}).then(response => {
                    this.dialogGenCodeVisible = false;
                    this.getList();
                });
            },
            handleDelete(row) {
                this.$confirm(
                    "此操作将永久删除该方案(" + row.name + "), 是否继续?",
                    "提示",
                    {
                        confirmButtonText: "确定",
                        cancelButtonText: "取消",
                        type: "warning"
                    }
                ).then(() => {
                    removeGenScheme(row.id).then(response => {
                        this.getList();
                    });
                });
            },
            resetForm() {
                this.form = {
                    name: undefined,
                    tableName: undefined,
                    packageName: undefined,
                    moduleName: undefined,
                    subMenuName: undefined,
                    functionName: undefined,
                    functionNameSimple: undefined,
                    functionAuthor: undefined,
                    tableId: undefined,
                    genCode: false,
                    replaceFile: false,
                    syncMenu: false,
                    parentMenuName: undefined,
                    parentMenuId: undefined,
                    status: undefined,
                    description: undefined
                };
                this.$refs['form'] && this.$refs['form'].resetFields();
            }
        }
    };
</script>
