<template>
  <div class="app-container calendar-list-container">
    <basic-container>
      <div class="filter-container" v-show="searchFilterVisible">
        <el-form :inline="true" :model="searchForm" ref="searchForm">
          <el-form-item label="表名" prop="name">
            <el-input class="filter-item input-normal" size="small" v-model="searchForm.name"></el-input>
          </el-form-item>
          <el-form-item label="说明" prop="comments">
            <el-input class="filter-item input-normal" size="small" v-model="searchForm.comments"></el-input>
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
          <el-button @click="handleEdit" class="filter-item" icon="el-icon-plus" size="mini" type="primary"
                     v-if="gen_table_edit">添加
          </el-button>
        </div>
        <div class="table-menu-right">
          <el-button @click="searchFilterVisible= !searchFilterVisible" circle icon="el-icon-search"
                     size="mini"></el-button>
        </div>
      </div>
      <el-table :data="list" :key='tableKey' element-loading-text="加载中..." fit highlight-current-row
                v-loading="listLoading">

        <el-table-column align="center" label="表名">
          <template slot-scope="scope">
            <span>{{scope.row.name}}</span>
          </template>
        </el-table-column>


        <el-table-column align="center" label="说明">
          <template slot-scope="scope">
            <span>
              {{scope.row.comments}}
            </span>
          </template>
        </el-table-column>

        <el-table-column align="center" label="类名">
          <template slot-scope="scope">
            <span>{{scope.row.className}}</span>
          </template>
        </el-table-column>
        <el-table-column align="center" label="父表名">
          <template slot-scope="scope">
            <span>{{scope.row.parentTable}}</span>
          </template>
        </el-table-column>
        <!--        <el-table-column align="center" label="类名">-->
        <!--          <template slot-scope="scope">-->
        <!--            <span>{{scope.row.className}}</span>-->
        <!--          </template>-->
        <!--        </el-table-column>-->

        <el-table-column align="center" label="创建时间">
          <template slot-scope="scope">
            <span>{{scope.row.createdDate}}</span>
          </template>
        </el-table-column>

        <el-table-column align="center" label="操作">
          <template slot-scope="scope">
            <el-button @click="handleEdit(scope.row)" icon="icon-edit" title="编辑" type="text" v-if="gen_table_edit">
            </el-button>
            <el-button @click="handleDelete(scope.row)" icon="icon-delete" title="删除" type="text" v-if="gen_table_del">
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

      <el-dialog :title="'选择表'" :visible.sync="dialogBeforeFormVisible">
        <el-form :model="formSelect" label-width="100px" ref="formSelect">
          <el-form-item :rules="[{required: true,message: '请选择表名'}]" label="表名" prop="name">
            <CrudSelect :dic="selectTableList" :filterable="true" v-model="formSelect.name"></CrudSelect>
          </el-form-item>
        </el-form>
        <div class="dialog-footer" slot="footer">
          <el-button @click="dialogBeforeFormVisible = false" size="small">取 消</el-button>
          <el-button @click="showNextForm()" size="small" type="primary">下一步</el-button>
        </div>
      </el-dialog>

      <el-dialog :fullscreen="true" :title="textMap[dialogStatus]" :visible.sync="dialogFormVisible">
        <el-form :model="form" label-width="100px" ref="form">
          <el-form-item :rules="[{required: true,message: '请输入名称'}]" label="名称" prop="name">
            <el-input placeholder="请输名称" v-model="form.name"></el-input>
          </el-form-item>
          <el-form-item :rules="[{required: true,message: '请输入说明'}]" label="说明" prop="comments">
            <el-input v-model="form.comments"></el-input>
          </el-form-item>
          <el-form-item :rules="[{required: true,message: '请输入类名'}]" label="类名" prop="className">
            <el-input v-model="form.className"></el-input>
          </el-form-item>
          <el-form-item label="父表表名" prop="parentTable">
            <CrudSelect :dic="tableList" clearable v-model="form.parentTable"></CrudSelect>
          </el-form-item>
          <el-form-item label="当前表外键" prop="parentTableFk">
            <CrudSelect :dic="columnList" v-model="form.parentTableFk"></CrudSelect>
          </el-form-item>
          <el-form-item label="备注" prop="description">
            <el-input type="textarea" v-model="form.description"></el-input>
          </el-form-item>
          <table class="el-table-padding" id="contentTable">
            <thead>
            <tr>
              <th title="数据库字段名">列名</th>
              <th title="默认读取数据库字段备注">标题</th>
              <th title="描述字段">说明</th>
              <th title="数据库中设置的字段类型及长度">物理类型</th>
              <th title="实体对象的属性字段类型">Java类型</th>
              <th title="实体对象的属性字段（对象名.属性名|属性名2|属性名3，例如：用户user.id|name|loginName，属性名2和属性名3为Join时关联查询的字段）">
                Java属性名称 <i class="icon-question-sign"></i></th>
              <th title="是否是数据库主键">主键</th>
              <th title="字段是否可为空值，不可为空字段自动进行空值验证">可空</th>
              <th title="字段是否唯一，唯一空字段自动进行唯一性验证">唯一</th>
              <th title="选中后该字段被加入到insert语句里">插入</th>
              <th title="选中后该字段被加入到update语句里">编辑</th>
              <th title="选中后该字段被加入到查询列表里">列表</th>
              <th title="选中后该字段被加入到查询条件里">查询</th>
              <th title="该字段为查询字段时的查询匹配放松">查询匹配方式</th>
              <th title="字段在表单中显示的类型">显示表单类型</th>
              <th title="显示表单类型设置为“下拉框、复选框、点选框”时，需设置字典的类型">字典类型</th>
              <th>排序</th>
            </tr>
            </thead>
            <tbody>
            <tr :class="column.status=='-1'? 'error':''" :title="column.status=='-1'? '已删除的列，保存之后消失！':''"
                v-bind:key="column.id" v-for=" (column,i) in form.columnFormList">
              <td>
                <el-input class="input-small" readonly="readonly" v-model="form.columnFormList[i].name"></el-input>
              </td>
              <td>
                <el-input class="input-small" v-model="form.columnFormList[i].title"></el-input>
              </td>
              <td>
                <el-input class="input-small" v-model="form.columnFormList[i].comments"></el-input>
              </td>
              <td>
                <el-input class="input-small" v-model="form.columnFormList[i].jdbcType"></el-input>
              </td>
              <td>
                <CrudSelect :dic="javaTypeList" class="input-mini"
                            v-model="form.columnFormList[i].javaType"></CrudSelect>
              </td>
              <td>
                <el-input class="input-small" v-model="form.columnFormList[i].javaField"></el-input>
              </td>
              <td>
                <el-checkbox :checked="form.columnFormList[i].pk" v-model="form.columnFormList[i].pk"></el-checkbox>
              </td>
              <td>
                <el-checkbox :checked="form.columnFormList[i].null" v-model="form.columnFormList[i].null"></el-checkbox>
              </td>
              <td>
                <el-checkbox :checked="form.columnFormList[i].unique"
                             v-model="form.columnFormList[i].unique"></el-checkbox>
              </td>
              <td>
                <el-checkbox :checked="form.columnFormList[i].insert"
                             v-model="form.columnFormList[i].insert"></el-checkbox>
              </td>
              <td>
                <el-checkbox :checked="form.columnFormList[i].edit" v-model="form.columnFormList[i].edit"></el-checkbox>
              </td>
              <td>
                <el-checkbox :checked="form.columnFormList[i].list" v-model="form.columnFormList[i].list"></el-checkbox>
              </td>
              <td>
                <el-checkbox :checked="form.columnFormList[i].query"
                             v-model="form.columnFormList[i].query"></el-checkbox>
              </td>
              <td>
                <CrudSelect :dic="queryTypeList" class="input-mini"
                            v-model="form.columnFormList[i].queryType"></CrudSelect>
              </td>
              <td>
                <CrudSelect :dic="showTypeList" class="input-mini"
                            v-model="form.columnFormList[i].showType"></CrudSelect>
              </td>
              <td>
                <el-input class="input-small" v-model="form.columnFormList[i].dictType"></el-input>
              </td>
              <td>
                <el-input class="input-small" v-model="form.columnFormList[i].sort"></el-input>
              </td>
            </tr>
            </tbody>
          </table>
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
    import tableService from "./table-service";
    import {mapGetters} from 'vuex';
    import CrudSelect from "@/components/avue/crud-select";
    import CrudRadio from "@/components/avue/crud-radio";
    import validate from "@/util/validate";
    import util from "@/util/util";

    export default {
        components: {CrudSelect, CrudRadio},
        name: "Table",
        data() {
            return {
                searchFilterVisible: true,
                list: null,
                total: null,
                listLoading: true,
                searchForm: {},
                listQuery: {
                    page: 1,
                    size: 20
                },
                javaTypeList: [],
                queryTypeList: [],
                showTypeList: [],
                tableList: [],
                selectTableList: [],
                columnList: [],
                formSelect: {name: null},
                form: {
                    name: undefined,
                    comments: undefined,
                    className: undefined,
                    parentTable: undefined,
                    parentTableFk: undefined,
                    columnFormList: [],
                    status: undefined,
                    description: undefined
                },
                dialogFormVisible: false,
                dialogBeforeFormVisible: false,
                dialogStatus: 'create',
                textMap: {
                    update: '编辑表',
                    create: '创建表'
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
        created() {
            this.getList();
            this.gen_table_edit = this.permissions["gen_table_edit"];
            this.gen_table_del = this.permissions["gen_table_del"];
        },
        methods: {
            getList() {
                this.listLoading = true;
                this.listQuery.queryConditionJson = util.parseJsonItemForm([{
                    fieldName: 'name', value: this.searchForm.name
                }, {
                    fieldName: 'comments', value: this.searchForm.comments
                }]);
                tableService.page(this.listQuery).then(response => {
                    this.list = response.data.records;
                    this.total = response.data.total;
                    this.listLoading = false;
                });
            },
            //搜索清空
            searchReset() {
                this.$refs['searchForm'].resetFields();
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
                this.dialogStatus = row && !validate.checkNull(row.id) ? "update" : "create";
                if (this.dialogStatus == "create") {
                    tableService.findSelect().then(response => {
                        this.selectTableList = response.data;
                        this.dialogBeforeFormVisible = true;
                    });
                } else {
                    this.showEditForm({id: row.id})
                }
            },
            showEditForm(params) {
                this.dialogBeforeFormVisible = false;
                this.dialogFormVisible = false;
                this.$router.push({path: '/gen/edit', query: params})
            },
            showNextForm() {
                const set = this.$refs;
                set['formSelect'].validate(valid => {
                    if (valid) {
                        this.showEditForm({name: this.formSelect.name})
                    }
                });
            },
            cancel() {
                this.dialogFormVisible = false;
                this.$refs['form'].resetFields();
            },
            handleDelete(row) {
                this.$confirm(
                    "此操作将永久删除该表(表名:" + row.name + "), 是否继续?",
                    "提示",
                    {
                        confirmButtonText: "确定",
                        cancelButtonText: "取消",
                        type: "warning"
                    }
                ).then(() => {
                    tableService.remove(row.id).then(response => {
                        this.getList();
                    });
                });
            }
        }
    };
</script>
