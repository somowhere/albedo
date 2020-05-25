<template>
  <div class="app-container">
    <el-form ref="form" :model="form" label-width="100px">
      <el-tabs v-model="activeName">
        <el-tab-pane label="基本信息" name="first">
          <div style="width: 60%;">
            <el-form-item :rules="[{required: true,message: '请输入名称'}]" label="名称" prop="name">
              <el-input v-model="form.name" placeholder="请输名称" />
            </el-form-item>
            <el-form-item :rules="[{required: true,message: '请输入说明'}]" label="说明" prop="comments">
              <el-input v-model="form.comments" />
            </el-form-item>
            <el-form-item :rules="[{required: true,message: '请输入类名'}]" label="类名" prop="className">
              <el-input v-model="form.className" />
            </el-form-item>
            <el-form-item label="父表表名" prop="parentTable">
              <el-select v-model="form.parentTable" clearable style="width: 100%">
                <el-option v-for="(item,index) in tableList" :key="index" :label="item.label" :value="item.value" />
              </el-select>
            </el-form-item>
            <el-form-item label="当前表外键" prop="parentTableFk">
              <el-select v-model="form.parentTableFk" clearable style="width: 100%">
                <el-option v-for="(item,index) in columnList" :key="index" :label="item.label" :value="item.value" />
              </el-select>
            </el-form-item>
            <el-form-item label="备注" prop="description">
              <el-input v-model="form.description" type="textarea" />
            </el-form-item>
          </div>
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
                  Java属性名称 <i class="icon-question-sign" /></th>
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
              <tr
                v-for=" (column,i) in form.columnFormList"
                :key="column.id"
                :class="column.status=='-1'? 'error':''"
                :title="column.status=='-1'? '已删除的列，保存之后消失！':''"
              >
                <td>
                  <el-input v-model="form.columnFormList[i].name" class="input-small" readonly="readonly" />
                </td>
                <td>
                  <el-input v-model="form.columnFormList[i].title" class="input-small" />
                </td>
                <td>
                  <el-input v-model="form.columnFormList[i].comments" class="input-small" />
                </td>
                <td>
                  <el-input v-model="form.columnFormList[i].jdbcType" class="input-small" />
                </td>
                <td>
                  <el-select v-model="form.columnFormList[i].javaType" class="input-mini">
                    <el-option v-for="(item,index) in javaTypeList" :key="index" :label="item.label" :value="item.value" />
                  </el-select>
                </td>
                <td>
                  <el-input v-model="form.columnFormList[i].javaField" class="input-small" />
                </td>
                <td>
                  <el-checkbox v-model="form.columnFormList[i].pk" :checked="form.columnFormList[i].pk" />
                </td>
                <td>
                  <el-checkbox
                    v-model="form.columnFormList[i].null"
                    :checked="form.columnFormList[i].null"
                  />
                </td>
                <td>
                  <el-checkbox
                    v-model="form.columnFormList[i].unique"
                    :checked="form.columnFormList[i].unique"
                  />
                </td>
                <td>
                  <el-checkbox
                    v-model="form.columnFormList[i].insert"
                    :checked="form.columnFormList[i].insert"
                  />
                </td>
                <td>
                  <el-checkbox
                    v-model="form.columnFormList[i].edit"
                    :checked="form.columnFormList[i].edit"
                  />
                </td>
                <td>
                  <el-checkbox
                    v-model="form.columnFormList[i].list"
                    :checked="form.columnFormList[i].list"
                  />
                </td>
                <td>
                  <el-checkbox
                    v-model="form.columnFormList[i].query"
                    :checked="form.columnFormList[i].query"
                  />
                </td>
                <td>
                  <el-select v-model="form.columnFormList[i].queryType" class="input-mini">
                    <el-option v-for="(item,index) in queryTypeList" :key="index" :label="item.label" :value="item.value" />
                  </el-select>
                </td>
                <td>
                  <el-select v-model="form.columnFormList[i].showType" class="input-mini">
                    <el-option v-for="(item,index) in showTypeList" :key="index" :label="item.label" :value="item.value" />
                  </el-select>
                </td>
                <td>
                  <el-input v-model="form.columnFormList[i].dictType" class="input-small" />
                </td>
                <td>
                  <el-input v-model="form.columnFormList[i].sort" class="input-small" />
                </td>
              </tr>
            </tbody>
          </table>

        </el-tab-pane>

      </el-tabs>
      <el-row :gutter="20" style="margin-top: 20px">
        <el-col :offset="10" :span="6">
          <el-button size="small" @click="back()">返 回</el-button>
          <el-button size="small" @click="cancel()">重 置</el-button>
          <el-button size="small" type="primary" @click="save()">保 存</el-button>
        </el-col>
      </el-row>

    </el-form>
  </div>
</template>

<script>
import crudTable from '@/views/gen/table/table-service'
import { mapGetters } from 'vuex'

export default {
  name: 'Table',
  data() {
    return {
      searchFilterVisible: true,
      javaTypeList: [],
      queryTypeList: [],
      showTypeList: [],
      tableList: [],
      selectTableList: [],
      columnList: [],
      formSelect: { name: null },
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
    }
  },
  computed: {
    ...mapGetters(['permissions', 'dicts'])
  },
  created() {
    this.showEditForm(this.$route.query)
  },
  methods: {
    showEditForm(params) {
      crudTable.findFormData(params).then(response => {
        const data = response.data
        this.form = data.tableVo
        this.javaTypeList = data.javaTypeList
        this.queryTypeList = data.queryTypeList
        this.showTypeList = data.showTypeList
        this.tableList = data.tableList
        this.columnList = data.columnList
      })
    },
    cancel() {
      this.showEditForm(this.$route.query)
    },
    back() {
      this.$refs['form'].resetFields()
      this.$store.state.tagsView.visitedViews.forEach(view => {
        if (view.path === '/gen/edit') {
          this.$store.dispatch('tagsView/delView', view)
        }
      })
      this.$router.push({ path: '/gen/table' })
    },
    save() {
      const set = this.$refs
      set['form'].validate(valid => {
        if (valid) {
          crudTable.save(this.form).then(response => {
            this.$store.state.tagsView.visitedViews.forEach(view => {
              if (view.path === '/gen/edit') {
                this.$store.dispatch('tagsView/delView', view)
              }
            })
            this.$router.push({ path: '/gen/table' })
          })
        } else {
          this.activeName = 'first'
          return false
        }
      })
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
      }
      this.$refs['form'] && this.$refs['form'].resetFields()
    }
  }
}
</script>
<style>
  .input-mini{
    width: 100px;
  }
</style>
