<template>
  <div class="app-container">
    <!--工具栏-->
    <div class="head-container">
      <div v-if="crud.props.searchToggle">
        <!-- 搜索 -->
        <el-input
          v-model="query.blurry"
          class="filter-item"
          clearable
          placeholder="模糊搜索"
          size="small"
          style="width: 250px;"
          @keyup.enter.native="crud.toQuery"
        />
        <el-date-picker
          v-model="query.createdDate"
          :default-time="['00:00:00','23:59:59']"
          class="date-item"
          end-placeholder="结束日期"
          range-separator=":"
          size="small"
          start-placeholder="开始日期"
          type="daterange"
          value-format="yyyy-MM-dd HH:mm:ss"
        />
        <rrOperation />
      </div>
      <crudOperation :permission="permission">
        <el-button
          slot="right"
          v-permission="permission.menu"
          :disabled="crud.selections.length !== 1"
          class="filter-item"
          icon="el-icon-info"
          plain
          size="mini"
          type="primary"
          @click="handleGenMenuDialog"
        >生成菜单
        </el-button>
        <el-button
          slot="right"
          v-permission="permission.menu"
          :disabled="crud.selections.length !== 1"
          class="filter-item"
          icon="el-icon-info"
          plain
          size="mini"
          type="primary"
          @click="handleCodePreviewDialog"
        >代码预览
        </el-button>
        <el-button
          slot="right"
          v-permission="[permission.code]"
          :disabled="crud.selections.length !== 1"
          class="filter-item"
          icon="el-icon-position"
          plain
          size="mini"
          type="primary"
          @click="handleGenCodeDialog"
        >生成代码</el-button>
      </crudOperation>
    </div>
    <!--表单渲染-->
    <el-dialog
      :before-close="crud.cancelCU"
      :close-on-click-modal="false"
      :title="crud.status.title"
      :visible.sync="crud.status.cu > 0"
      append-to-body
      width="640px"
    >
      <el-form ref="form" :model="form" label-width="110px" size="small">
        <el-form-item
          :rules="[{required: true,message: '请输入方案名称'}]"
          inline-message="生成结构：(包名)/(模块名)/(分层(dao,entity,service,web))/(子模块名)/(java类)"
          label="方案名称"
          prop="name"
        >
          <el-input v-model="form.name" />
        </el-form-item>
        <el-form-item
          :rules="[{required: true,message: '请选择模块分类'}]"
          label="模块分类"
          prop="category"
        >
          <el-select v-model="form.category" style="width: 100%">
            <el-option v-for="(item,index) in categoryList" :key="index" :label="item.label" :value="item.value" />
          </el-select>
        </el-form-item>
        <el-form-item
          :rules="[{required: true,message: '请输入生成包路径'}]"
          label="生成包路径"
          prop="packageName"
        >
          <el-input v-model="form.packageName" />
        </el-form-item>
        <el-form-item
          :rules="[{required: true,message: '请输入生成模块名'}]"
          label="生成模块名"
          prop="moduleName"
        >
          <el-input v-model="form.moduleName" />
        </el-form-item>
        <el-form-item label="生成子模块名" prop="subMenuName">
          <el-input v-model="form.subMenuName" />
        </el-form-item>
        <el-form-item
          :rules="[{required: true,message: '请输入生成功能描述'}]"
          label="生成功能描述"
          prop="functionName"
        >
          <el-input v-model="form.functionName" />
        </el-form-item>
        <el-form-item
          :rules="[{required: true,message: '请输入生成功能名'}]"
          label="生成功能名"
          prop="functionNameSimple"
        >
          <el-input v-model="form.functionNameSimple" />
        </el-form-item>
        <el-form-item
          :rules="[{required: true,message: '请输入生成功能作者'}]"
          label="生成功能作者"
          prop="functionAuthor"
        >
          <el-input v-model="form.functionAuthor" />
        </el-form-item>
        <el-form-item
          :rules="[{required: true,message: '请选择业务表名'}]"
          label="业务表名"
          prop="tableId"
        >
          <el-select v-model="form.tableId" style="width: 100%">
            <el-option v-for="(item,index) in tableList" :key="index" :label="item.label" :value="item.value" />
          </el-select>
        </el-form-item>
        <el-form-item label="生成选项">
          <el-switch v-model="form.genCode" active-text="是否生成代码" />
          <el-switch v-model="form.replaceFile" active-text="是否替换现有文件" />
        </el-form-item>
        <el-form-item label="备注" prop="description">
          <el-input v-model="form.description" placeholder="" type="textarea" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="text" @click="crud.cancelCU">取消</el-button>
        <el-button :loading="crud.status.cu === 2" type="primary" @click="crud.submitCU">确认</el-button>
      </div>
    </el-dialog>
    <!--表格渲染-->
    <el-table
      ref="table"
      v-loading="crud.loading"
      :data="crud.data"
      style="width: 100%;"
      @selection-change="crud.selectionChangeHandler"
      @sort-change="crud.sortChange"
    >
      <el-table-column type="selection" width="55" />
      <el-table-column align="center" label="名称" prop="name" />

      <el-table-column align="center" label="表名" prop="tableName" />

      <el-table-column align="center" label="基础包名" prop="packageName" />

      <el-table-column align="center" label="模块" prop="moduleName" />

      <el-table-column :show-overflow-tooltip="true" align="center" label="功能名称" prop="functionName" />

      <el-table-column align="center" label="功能作者" prop="functionAuthor" />
      <el-table-column
        :show-overflow-tooltip="true"
        label="创建日期"
        prop="a.created_date"
        sortable="custom"
        width="140"
      >
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.createdDate) }}</span>
        </template>
      </el-table-column>
      <el-table-column
        v-permission="[permission.edit, permission.del]"
        align="center"
        fixed="right"
        label="操作"
        width="185"
      >
        <template slot-scope="scope">
          <udOperation
            :data="scope.row"
            :permission="permission"
          />
        </template>
      </el-table-column>
    </el-table>
    <!--分页组件-->
    <pagination />
    <el-dialog
      :visible.sync="dialogGenCodeVisible"
      title="系统提示"
      width="30%"
    >
      <span>确认要继续操作吗?</span>
      <span slot="footer" class="dialog-footer">
        <el-button size="small" @click="dialogGenCodeVisible = false">取 消</el-button>
        <el-button size="small" type="primary" @click="handleGenCode(false)">生成代码</el-button>
        <el-button size="small" type="primary" @click="handleGenCode(true)">生成代码并覆盖</el-button>
      </span>
    </el-dialog>
    <el-dialog
      :visible.sync="dialogGenMenuVisible"
      title="生成菜单"
      width="30%"
    >
      <el-form ref="genMenuForm" :model="genMenuForm" label-width="100px">
        <el-form-item label="上级菜单" :rules="[{required: true,message: '请选择上级菜单'}]" prop="parentMenuId">
          <treeselect v-model="genMenuForm.parentMenuId" :options="menus" placeholder="请选择上级菜单" />
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button size="small" @click="cancelGenMenu">取 消</el-button>
        <el-button size="small" type="primary" @click="handleGenMenu">生成菜单</el-button>
      </span>
    </el-dialog>
    <el-dialog
      :visible.sync="dialogCodePreviewVisible"
      title="代码预览"
      width="90%"
    >
      <el-tabs>
        <el-tab-pane v-for="(item, key) in tabCodePreviewMap" :key="key" :label="key">
          <Ace :value="item" :lang="key.indexOf('.java')!==-1 ? 'java' : key.indexOf('.js')!==-1 ? 'javascript' : 'html'" />
        </el-tab-pane>
      </el-tabs>
    </el-dialog>

  </div>
</template>

<script>
import crudScheme from '@/views/gen/scheme/scheme-service'
import crudMenu from '@/views/sys/menu/menu-service'
import validate from '@/utils/validate'
import CRUD, { crud, form, header, presenter } from '@crud/crud'
import rrOperation from '@crud/RR.operation'
import crudOperation from '@crud/CRUD.operation'
import udOperation from '@crud/UD.operation'
import pagination from '@crud/Pagination'
import Treeselect from '@riophae/vue-treeselect'
import Ace from '@/views/components/ace/index'
import { mapGetters } from 'vuex'
import '@riophae/vue-treeselect/dist/vue-treeselect.css'

const defaultForm = {
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
}
export default {
  name: 'Scheme',
  components: { Treeselect, crudOperation, rrOperation, udOperation, pagination, Ace },
  cruds() {
    return CRUD({ title: '生成方案', crudMethod: { ...crudScheme }})
  },
  mixins: [presenter(), header(), form(defaultForm), crud()],
  // 数据字典
  data() {
    // 自定义验证
    return {
      tabCodePreviewMap: {},
      viewTypeList: [],
      categoryList: [],
      tableList: [],
      menus: [],
      dialogGenCodeVisible: false,
      dialogGenMenuVisible: false,
      dialogCodePreviewVisible: false,
      genMenuForm: {
        id: undefined,
        parentMenuId: undefined
      },
      permission: {
        edit: 'gen_scheme_edit',
        del: 'gen_scheme_del',
        menu: 'gen_scheme_menu',
        code: 'gen_scheme_code'
      }
    }
  },
  computed: {
    ...mapGetters([
      'dicts', 'permissions'
    ])
  },
  created() {
    this.crud.optShow = {
      add: true,
      edit: true,
      del: true
    }
  },
  methods: {
    // 新增与编辑前做的操作
    [CRUD.HOOK.beforeToCU](crud, form, id) {
      crudScheme.findFormData(id).then(response => {
        const data = response.data
        this.viewTypeList = data.viewTypeList
        this.categoryList = data.categoryList
        this.tableList = data.tableList
        if (validate.checkNotNull(data.schemeVo)) {
          this.crud.resetForm(data.schemeVo)
        }
      })
      return false
    },
    handleGenCodeDialog() {
      this.dialogGenCodeVisible = true
    },
    handleGenCode(replaceFile) {
      const select = this.crud.selections
      if (select.length !== 1 || validate.checkNull(select[0]) || validate.checkNull(select[0].id)) {
        this.$message({
          message: '无法获取选中信息',
          type: 'warning'
        })
        return
      }
      crudScheme.genCode({ id: select[0].id, replaceFile: replaceFile }).then(response => {
        this.dialogGenCodeVisible = false
        this.crud.refresh()
      })
    },
    handleGenMenuDialog() {
      crudMenu.getTree().then(res => {
        this.menus = res.data
        this.genMenuForm.id = this.crud.selections[0].id
        this.genMenuForm.parentMenuId = undefined
        this.dialogGenMenuVisible = true
      })
    },
    handleCodePreviewDialog() {
      crudScheme.previewCode(this.crud.selections[0].id).then(response => {
        this.tabCodePreviewMap = response.data
        this.dialogCodePreviewVisible = true
      })
    },
    handleGenMenu() {
      const set = this.$refs
      set['genMenuForm'].validate(valid => {
        if (valid) {
          crudScheme.genMenu(this.genMenuForm).then(response => {
            this.cancelGenMenu()
            this.crud.refresh()
          })
        } else {
          return false
        }
      })
    },
    cancelGenMenu() {
      this.dialogGenMenuVisible = false
      this.$refs['genMenuForm'].resetFields()
    }
  }
}
</script>

<style scoped>
</style>
