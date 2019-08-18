<template>
  <div class="app-container calendar-list-container">
    <basic-container>
      <div class="filter-container" v-show="searchFilterVisible">
        <el-form :inline="true" :model="searchForm" ref="searchForm">
          <el-form-item label="名称" prop="name">
            <el-input class="filter-item input-normal" size="small" v-model="searchForm.name"></el-input>
          </el-form-item>
          <el-form-item label="表名" ref="tableName">
            <el-input class="filter-item input-normal" size="small" v-model="searchForm.tableName"></el-input>
          </el-form-item>
          <el-form-item label="功能名称" prop="functionName">
            <el-input class="filter-item input-normal" size="small" v-model="searchForm.functionName"></el-input>
          </el-form-item>
          <el-form-item label="功能作者" prop="functionAuthor">
            <el-input class="filter-item input-normal" size="small" v-model="searchForm.functionAuthor"></el-input>
          </el-form-item>
          <el-form-item>
            <el-button @click="handleFilter" class="filter-item" icon="el-icon-search" size="small" type="primary">查询
            </el-button>
            <el-button @click="searchReset" icon="icon-rest" size="small">重置</el-button>
          </el-form-item>
        </el-form>
      </div>
      <!-- 表格功能列 -->
      <div class="table-menu">
        <div class="table-menu-left">
          <el-button-group>
            <el-button @click="handleEdit" icon="el-icon-plus" size="mini" type="primary" v-if="gen_scheme_edit">添加
            </el-button>
            <el-button @click="handleGenMenuDialog" icon="icon-filesync" size="mini" type="primary"
                       v-if="gen_scheme_menu">生成菜单
            </el-button>
            <el-button @click="handleCodePreviewDialog" icon="icon-filesync" size="mini" type="primary"
                       v-if="gen_scheme_menu">代码预览
            </el-button>
          </el-button-group>
        </div>
        <div class="table-menu-right">
          <el-button @click="searchFilterVisible= !searchFilterVisible" circle icon="el-icon-search"
                     size="mini"></el-button>
        </div>
      </div>
      <el-table :data="list" :key='tableKey' @current-change="handleSelect"
                element-loading-text="加载中..." fit highlight-current-row v-loading="listLoading">
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
            <el-button @click="handleEdit(scope.row)" icon="icon-edit" title="编辑" type="text" v-if="gen_scheme_edit">
            </el-button>
            <el-button @click="handleGenCodeDialog(scope.row)" icon="icon-block" title="生成代码" type="text"
                       v-if="gen_scheme_edit">
            </el-button>
            <el-button @click="handleDelete(scope.row)" icon="icon-delete" title="删除" type="text" v-if="gen_scheme_del">
            </el-button>
          </template>
        </el-table-column>

      </el-table>

      <div class="pagination-container" v-show="!listLoading">
        <el-pagination :current-page.sync="listQuery.page" :page-size="listQuery.size"
                       :page-sizes="[10,20,30, 50]" :total="total" @current-change="handleCurrentChange"
                       @size-change="handleSizeChange" layout="total, sizes, prev, pager, next, jumper">
        </el-pagination>
      </div>

      <el-dialog :title="textMap[dialogStatus]" :visible.sync="dialogFormVisible">
        <el-form :model="form" label-width="120px" ref="form">
          <el-form-item :rules="[{required: true,message: '请输入方案名称'}]"
                        inline-message="生成结构：(包名)/(模块名)/(分层(dao,entity,service,web))/(子模块名)/(java类)"
                        label="方案名称" prop="name">
            <el-input v-model="form.name"></el-input>
          </el-form-item>
          <el-form-item :rules="[{required: true,message: '请选择模块分类'}]" label="模块分类"
                        prop="category">
            <CrudSelect :dic="categoryList" v-model="form.category"></CrudSelect>
          </el-form-item>
          <el-form-item :rules="[{required: true,message: '请输入生成包路径'}]" label="生成包路径"
                        prop="packageName">
            <el-input v-model="form.packageName"></el-input>
          </el-form-item>
          <el-form-item :rules="[{required: true,message: '请输入生成模块名'}]" label="生成模块名"
                        prop="moduleName">
            <el-input v-model="form.moduleName"></el-input>
          </el-form-item>
          <el-form-item label="生成子模块名" prop="subMenuName">
            <el-input v-model="form.subMenuName"></el-input>
          </el-form-item>
          <el-form-item :rules="[{required: true,message: '请输入生成功能描述'}]" label="生成功能描述"
                        prop="functionName">
            <el-input v-model="form.functionName"></el-input>
          </el-form-item>
          <el-form-item :rules="[{required: true,message: '请输入生成功能名'}]" label="生成功能名"
                        prop="functionNameSimple">
            <el-input v-model="form.functionNameSimple"></el-input>
          </el-form-item>
          <el-form-item :rules="[{required: true,message: '请输入生成功能作者'}]" label="生成功能作者"
                        prop="functionAuthor">
            <el-input v-model="form.functionAuthor"></el-input>
          </el-form-item>
          <el-form-item :rules="[{required: true,message: '请选择业务表名'}]" label="业务表名"
                        prop="tableId">
            <CrudSelect :dic="tableList" v-model="form.tableId"></CrudSelect>
          </el-form-item>
          <el-form-item label="生成选项">
            <el-switch active-text="是否生成代码" v-model="form.genCode">
            </el-switch>
            <el-switch active-text="是否替换现有文件" v-model="form.replaceFile">
            </el-switch>
          </el-form-item>
          <el-form-item label="备注" prop="description">
            <el-input placeholder="" type="textarea" v-model="form.description"></el-input>
          </el-form-item>
        </el-form>
        <div class="dialog-footer" slot="footer">
          <el-button @click="cancel()" size="small">取 消</el-button>
          <el-button @click="save()" size="small" type="primary">保 存</el-button>
        </div>
      </el-dialog>


      <el-dialog :visible.sync="dialogGenCodeVisible" title="系统提示"
                 width="30%">
        <span>确认要继续操作吗?</span>
        <span class="dialog-footer" slot="footer">
          <el-button @click="dialogGenCodeVisible = false" size="small">取 消</el-button>
          <el-button @click="handleGenCode(false)" size="small" type="primary">生成代码</el-button>
          <el-button @click="handleGenCode(true)" size="small" type="primary">生成代码并覆盖</el-button>
        </span>
      </el-dialog>

      <el-dialog :visible.sync="dialogMenuVisible" title="选择菜单">
        <el-input placeholder="输入关键字进行过滤"
                  v-model="filterFormText">
        </el-input>
        <el-tree :data="treeMenuData" :filter-node-method="filterNode" @node-click="getNodeData"
                 check-strictly class="filter-tree" highlight-current node-key="id"
                 ref="formTree">
        </el-tree>
      </el-dialog>

      <el-dialog :visible.sync="dialogGenMenuVisible" title="生成菜单"
                 width="30%">
        <el-form :model="genMenuForm" label-width="100px" ref="genMenuForm">
          <el-form-item :rules="[{required: true,message: '请选择上级菜单'}]" label="上级菜单" prop="parentMenuId">
            <el-input @focus="handleMenu()" placeholder="选择菜单" readonly v-model="genMenuForm.parentMenuName"></el-input>
            <input type="hidden" v-model="genMenuForm.parentMenuId"/>
          </el-form-item>
        </el-form>
        <span class="dialog-footer" slot="footer">
          <el-button @click="cancelGenMenu" size="small">取 消</el-button>
          <el-button @click="handleGenMenu" size="small" type="primary">生成菜单</el-button>
        </span>
      </el-dialog>

      <el-dialog :visible.sync="dialogCodePreviewVisible" title="代码预览"
                 width="90%">
        <el-tabs>
          <el-tab-pane :key="key" :label="key" v-for="(value, key) in tabCodePreviewMap">
            <Ace :value="value"></Ace>
          </el-tab-pane>
        </el-tabs>
      </el-dialog>

    </basic-container>
  </div>
</template>

<script>
    import schemeService from "./scheme-service";
    import {mapGetters} from "vuex";
    import validate from "@/util/validate";
    import util from "@/util/util";
    import menuService from "@/views/sys/menu/menu-service";
    import CrudSelect from "@/components/avue/crud-select";
    import CrudRadio from "@/components/avue/crud-radio";
    import Ace from "@/components/ace/index";

    export default {
        components: {CrudSelect, CrudRadio, Ace},
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
                dialogCodePreviewVisible: false,
                currentRow: {},
                tabCodePreviewMap: {},
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
                this.listQuery.queryConditionJson = util.parseJsonItemForm([{
                    fieldName: 'name', value: this.searchForm.name
                }, {
                    fieldName: 'table.name', value: this.searchForm.tableName
                }, {
                    fieldName: 'functionName', value: this.searchForm.functionName
                }, {
                    fieldName: 'functionAuthor', value: this.searchForm.functionAuthor
                }]);
                schemeService.page(this.listQuery).then(response => {
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
                if (!value) return true;
                return data.label.indexOf(value) !== -1
            },
            handleMenu() {
                menuService.fetchTree({extId: this.form.id}).then(response => {
                    this.treeMenuData = util.parseTreeData(response.data);
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
                if (validate.checkNull(this.currentRow) || validate.checkNull(this.currentRow.id)) {
                    this.$message({
                        message: '请选择方案',
                        type: 'warning'
                    });
                    return;
                }
                this.genMenuForm.id = this.currentRow.id;
                const set = this.$refs;
                set['genMenuForm'].validate(valid => {
                    if (valid) {
                        schemeService.genMenu(this.genMenuForm).then(response => {
                            this.getList();
                            this.cancelGenMenu()
                        });
                    } else {
                        return false;
                    }
                });
            },
            handleGenMenuDialog() {
                if (validate.checkNull(this.currentRow) || validate.checkNull(this.currentRow.id)) {
                    this.$message({
                        message: '请选择方案',
                        type: 'warning'
                    });
                    return;
                }
                this.genMenuForm.id = undefined;
                this.genMenuForm.parentMenuId = undefined;
                this.genMenuForm.parentMenuName = undefined;
                this.dialogGenMenuVisible = true;
            },
            handleCodePreviewDialog() {
                if (validate.checkNull(this.currentRow) || validate.checkNull(this.currentRow.id)) {
                    this.$message({
                        message: '请选择方案',
                        type: 'warning'
                    });
                    return;
                }
                schemeService.previewCode(this.currentRow.id).then(response => {
                    this.tabCodePreviewMap = response.data;
                    this.dialogCodePreviewVisible = true;
                })
            },
            handleEdit(row) {
                this.dialogStatus = row && !validate.checkNull(row.id) ? "update" : "create";
                let params;
                if (this.dialogStatus == "update") {
                    params = {id: row.id};
                }
                schemeService.find(params).then(response => {
                    let data = response.data;
                    this.viewTypeList = data.viewTypeList;
                    this.categoryList = data.categoryList;
                    this.tableList = data.tableList;
                    if (validate.checkNotNull(data.schemeVo)) {
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
                        schemeService.save(this.form).then(response => {
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
                if (validate.checkNull(this.currentRow) || validate.checkNull(this.currentRow.id)) {
                    this.$message({
                        message: '无法获取选中信息',
                        type: 'warning'
                    });
                    return;
                }
                schemeService.genCode({id: this.currentRow.id, replaceFile: replaceFile}).then(response => {
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
                    schemeService.remove(row.id).then(response => {
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
