<template>
  <div class="app-container calendar-list-container">
    <basic-container>
      <el-form :model="form" ref="form" label-width="100px">
        <el-tabs v-model="activeName">
          <el-tab-pane label="基本信息" name="first">
            <el-form-item label="名称" prop="name" :rules="[{required: true,message: '请输入名称'}]">
              <el-input v-model="form.name" placeholder="请输名称"></el-input>
            </el-form-item>
            <el-form-item label="说明" prop="comments" :rules="[{required: true,message: '请输入说明'}]">
              <el-input v-model="form.comments"></el-input>
            </el-form-item>
            <el-form-item label="类名" prop="className" :rules="[{required: true,message: '请输入类名'}]">
              <el-input v-model="form.className"></el-input>
            </el-form-item>
            <el-form-item label="父表表名" prop="parentTable">
              <CrudSelect v-model="form.parentTable" clearable :dic="tableList"></CrudSelect>
            </el-form-item>
            <el-form-item label="当前表外键" prop="parentTableFk">
              <CrudSelect v-model="form.parentTableFk" :dic="columnList"></CrudSelect>
            </el-form-item>
            <el-form-item label="备注" prop="description">
              <el-input type="textarea" v-model="form.description"></el-input>
            </el-form-item>
          </el-tab-pane>
          <el-tab-pane label="字段信息" name="second">
            <table id="contentTable" class="el-table-padding">
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
              <tr v-for=" (column,i) in form.columnFormList" v-bind:key="column.id"
                  :class="column.status=='-1'? 'error':''" :title="column.status=='-1'? '已删除的列，保存之后消失！':''">
                <td>
                  <el-input v-model="form.columnFormList[i].name" readonly="readonly" class="input-small"></el-input>
                </td>
                <td>
                  <el-input v-model="form.columnFormList[i].title" class="input-small"></el-input>
                </td>
                <td>
                  <el-input v-model="form.columnFormList[i].comments" class="input-small"></el-input>
                </td>
                <td>
                  <el-input v-model="form.columnFormList[i].jdbcType" class="input-small"></el-input>
                </td>
                <td>
                  <CrudSelect v-model="form.columnFormList[i].javaType" class="input-mini"
                              :dic="javaTypeList"></CrudSelect>
                </td>
                <td>
                  <el-input v-model="form.columnFormList[i].javaField" class="input-small"></el-input>
                </td>
                <td>
                  <el-checkbox v-model="form.columnFormList[i].pk" :checked="form.columnFormList[i].pk"></el-checkbox>
                </td>
                <td>
                  <el-checkbox v-model="form.columnFormList[i].null"
                               :checked="form.columnFormList[i].null"></el-checkbox>
                </td>
                <td>
                  <el-checkbox v-model="form.columnFormList[i].unique"
                               :checked="form.columnFormList[i].unique"></el-checkbox>
                </td>
                <td>
                  <el-checkbox v-model="form.columnFormList[i].insert"
                               :checked="form.columnFormList[i].insert"></el-checkbox>
                </td>
                <td>
                  <el-checkbox v-model="form.columnFormList[i].edit"
                               :checked="form.columnFormList[i].edit"></el-checkbox>
                </td>
                <td>
                  <el-checkbox v-model="form.columnFormList[i].list"
                               :checked="form.columnFormList[i].list"></el-checkbox>
                </td>
                <td>
                  <el-checkbox v-model="form.columnFormList[i].query"
                               :checked="form.columnFormList[i].query"></el-checkbox>
                </td>
                <td>
                  <CrudSelect v-model="form.columnFormList[i].queryType" class="input-mini"
                              :dic="queryTypeList"></CrudSelect>
                </td>
                <td>
                  <CrudSelect v-model="form.columnFormList[i].showType" class="input-mini"
                              :dic="showTypeList"></CrudSelect>
                </td>
                <td>
                  <el-input v-model="form.columnFormList[i].dictType" class="input-small"></el-input>
                </td>
                <td>
                  <el-input v-model="form.columnFormList[i].sort" class="input-small"></el-input>
                </td>
              </tr>
              </tbody>
            </table>


          </el-tab-pane>

        </el-tabs>
        <el-row :gutter="20" style="margin-top: 20px">
          <el-col :span="6" :offset="10">
            <el-button size="small" @click="cancel()">取 消</el-button>
            <el-button size="small" type="primary" @click="save()">保 存</el-button>
          </el-col>
        </el-row>

      </el-form>

    </basic-container>
  </div>
</template>

<script>
    import {findTable, saveTable} from "./service";
    import {mapGetters} from 'vuex';
    import CrudSelect from "@/views/avue/crud-select";
    import CrudRadio from "@/views/avue/crud-radio";

    export default {
        components: {CrudSelect, CrudRadio},
        name: "Table",
        data() {
            return {
                searchFilterVisible: true,
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
                tableKey: 0,
                activeName: 'first'
            };
        },
        computed: {
            ...mapGetters(["permissions", "dicts"])
        },
        created() {
            this.showEditForm(this.$route.query)
        },
        methods: {
            showEditForm(params) {
                findTable(params).then(response => {
                    let data = response.data;
                    this.form = data.tableVo;
                    this.javaTypeList = data.javaTypeList
                    this.queryTypeList = data.queryTypeList
                    this.showTypeList = data.showTypeList
                    this.tableList = data.tableList
                    this.columnList = data.columnList
                });
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
                        saveTable(this.form).then(response => {
                            this.cancel('form')
                            this.$store.commit("DEL_TAG", this.$store.getters.tag);
                            this.$router.push({path: '/gen/table'})
                        });
                    } else {
                        this.activeName = 'first'
                        return false;
                    }
                });
            },
            resetForm() {
                this.form = {
                    name: undefined,
                    comments: undefined,
                    className: undefined,
                    parentTable: undefined,
                    parentTableFk: undefined,
                    columnFormList: [],
                    status: undefined,
                    description: undefined
                };
                this.$refs['form'] && this.$refs['form'].resetFields();
            }
        }
    };
</script>
