<template>
  <div class="app-container">
    <!--工具栏-->
    <div class="head-container">
      <div v-if="crud.props.searchToggle">
        <el-input
          v-model="query.name"
          class="filter-item"
          style="width: 200px;"
          clearable
          placeholder="输入名称搜索"
          @keyup.enter.native="toQuery"
        />
        <rrOperation />
      </div>
      <crudOperation :permission="permission" />
    </div>
    <!--Form表单-->
    <el-dialog
      :before-close="crud.cancelCU"
      :close-on-click-modal="false"
      :title="crud.status.title"
      :visible.sync="crud.status.cu > 0"
      append-to-body
      width="800px"
    >
      <el-form ref="form" :model="form" label-width="120px" size="small">
        <el-form-item label="名称" prop="name" :rules="[{min: 0,max: 64,pattern: /^[a-zA-Z0-9]+$/,message: '长度在 0 到 64 个数字或字母', trigger: 'blur'},]">
          <el-input v-model="form.name" class="input-small" />

        </el-form-item>
        <el-form-item label="url" prop="url" :rules="[{required: true,message: '请输入url', trigger: 'blur'},{min: 0,max: 255,message: '长度在 0 到 255 个字符', trigger: 'blur'},]">
          <el-input v-model="form.url" />

        </el-form-item>
        <el-form-item label="用户名" prop="username" :rules="[{required: true,message: '请输入用户名', trigger: 'blur'},{min: 0,max: 64,message: '长度在 0 到 64 个字符', trigger: 'blur'},]">
          <el-input v-model="form.username" class="input-small" />

        </el-form-item>
        <el-form-item label="密码" prop="password" :rules="[{required: true,min: 0,max: 64,message: '长度在 0 到 64 个字符', trigger: 'blur'},]">
          <el-input v-model="form.password" class="input-small" />

        </el-form-item>
        <el-form-item label="备注" prop="description" :rules="[{min: 0,max: 255,message: '长度在 0 到 255 个字符', trigger: 'blur'},]">
          <el-input v-model="form.description" type="textarea" />
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
      @sort-change="crud.sortChange"
      @selection-change="crud.selectionChangeHandler"
    >
      <el-table-column type="selection" width="55" />
      <el-table-column align="center" label="名称" :show-overflow-tooltip="true" prop="name" />
      <el-table-column align="center" label="url" :show-overflow-tooltip="true" prop="url" />
      <el-table-column align="center" label="用户名" :show-overflow-tooltip="true" prop="username" />
      <el-table-column align="center" label="备注" :show-overflow-tooltip="true" prop="description" />
      <el-table-column v-permission="[permission.edit,permission.del]" label="操作" width="120px" fixed="right">
        <template slot-scope="scope">
          <udOperation :data="scope.row" :permission="permission" />
        </template>
      </el-table-column>
    </el-table>
    <!--分页组件-->
    <pagination />
  </div>
</template>

<script>
import crudDatasourceConf from '@/views/gen/datasource-conf/datasource-conf-service'
import CRUD, { crud, form, header, presenter } from '@crud/crud'
import rrOperation from '@crud/RR.operation'
import udOperation from '@crud/UD.operation'
import crudOperation from '@crud/CRUD.operation'
import pagination from '@crud/Pagination'
import validate from '@/utils/validate'
import { mapGetters } from 'vuex'

const defaultForm = {
  id: null,
  name: null,
  url: null,
  username: null,
  password: null,
  description: null
}
export default {
  name: 'DatasourceConf',
  components: { crudOperation, rrOperation, udOperation, pagination },
  cruds() {
    return CRUD({ title: '数据源', crudMethod: { ...crudDatasourceConf }})
  },
  mixins: [presenter(), header(), form(defaultForm), crud()],
  // 数据字典
  data() {
    return {
      delFlagOptions: undefined,
      validateNumber: (rule, value, callback) => {
        validate.isNumber(rule, value, callback)
      },
      validateDigits: (rule, value, callback) => {
        validate.isDigits(rule, value, callback)
      },
      permission: {
        edit: 'gen_datasourceConf_edit',
        del: 'gen_datasourceConf_del'
      }
    }
  },
  computed: {
    ...mapGetters(['permissions', 'dicts'])
  },
  created() {
    this.delFlagOptions = this.dicts['sys_flag']
  },
  methods: {

  }
}
</script>
