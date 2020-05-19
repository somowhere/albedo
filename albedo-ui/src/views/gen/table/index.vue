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
          style="width: 200px;"
          @keyup.enter.native="toQuery"
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
          slot="left"
          v-permission="permission.edit"
          class="filter-item"
          icon="el-icon-plus"
          plain
          size="mini"
          type="primary"
          @click="handleEdit"
        >新增
        </el-button>
        <el-tooltip
          slot="left"
          class="item"
          effect="dark"
          content="数据库中表字段变动时使用该功能"
          placement="top-start"
        >
          <el-button
            v-permission="permission.edit"
            :disabled="crud.selections.length !== 1"
            class="filter-item"
            icon="el-icon-refresh"
            plain
            size="mini"
            type="primary"
            @click="handleRefreshColumn"
          >同步
          </el-button>
        </el-tooltip>
      </crudOperation>
    </div>
    <!--Form表单-->
    <el-dialog
      :title="'选择表'"
      :visible.sync="dialogBeforeFormVisible"
      width="570px"
    >
      <el-form ref="formSelect" :model="formSelect" label-width="100px">
        <el-form-item :rules="[{required: true,message: '请选择表名'}]" label="表名" prop="name">
          <el-select
            v-model="formSelect.name"
            clearable
            placeholder="请选择表名"
            size="small"
            style="width: 90%"
          >
            <el-option v-for="(item,index) in selectTableList" :key="index" :label="item.label" :value="item.value" />
          </el-select>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogBeforeFormVisible = false">取 消</el-button>
        <el-button type="primary" @click="showNextForm()">下一步</el-button>
      </div>
    </el-dialog>
    <!--表格渲染-->
    <el-table
      ref="table"
      v-loading="crud.loading"
      :data="crud.data"
      style="width: 100%;"
      @selection-change="crud.selectionChangeHandler"
    >
      <el-table-column type="selection" width="55" />
      <el-table-column :show-overflow-tooltip="true" label="表名" prop="name" />
      <el-table-column :show-overflow-tooltip="true" label="说明" prop="comments" />
      <el-table-column :show-overflow-tooltip="true" label="类名" prop="className" />
      <el-table-column :show-overflow-tooltip="true" label="父表名" prop="parentTable" />
      <el-table-column :show-overflow-tooltip="true" label="描述" prop="description" />
      <el-table-column :show-overflow-tooltip="true" label="创建日期" prop="createdDate" width="136px">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.createdDate) }}</span>
        </template>
      </el-table-column>
      <el-table-column
        v-permission="[permission.edit, permission.del]"
        align="center"
        fixed="right"
        label="操作"
        width="170px"
      >
        <template slot-scope="scope">
          <udOperation
            :data="scope.row"
            :permission="permission"
          >
            <el-button
              slot="left"
              v-permission="[permission.edit]"
              icon="el-icon-edit"
              plain
              size="mini"
              type="primary"
              @click="handleEdit(scope.row)"
            />
          </udOperation>
        </template>
      </el-table-column>
    </el-table>
    <!--分页组件-->
    <pagination />
  </div>
</template>

<script>
import crudTable from '@/views/gen/table/table-service'
import CRUD, { crud, header, presenter } from '@crud/crud'
import rrOperation from '@crud/RR.operation'
import udOperation from '@crud/UD.operation'
import crudOperation from '@crud/CRUD.operation'
import pagination from '@crud/Pagination'
import { mapGetters } from 'vuex'
import validate from '@/utils/validate'

export default {
  name: 'Timing',
  components: { pagination, crudOperation, udOperation, rrOperation },
  cruds() {
    return CRUD({ title: '业务表管理', crudMethod: { ...crudTable }})
  },
  mixins: [presenter(), header(), crud()],
  data() {
    return {
      delLoading: false,
      dialogBeforeFormVisible: false,
      formSelect: { name: null },
      selectTableList: [],
      dialogStatus: 'create',
      permission: {
        edit: 'gen_table_edit',
        del: 'gen_table_del'
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
      add: false,
      edit: false,
      del: true
    }
  },
  methods: {
    handleEdit(row) {
      this.dialogStatus = row && !validate.checkNull(row.id) ? 'update' : 'create'
      if (this.dialogStatus === 'create') {
        crudTable.findSelect().then(response => {
          this.selectTableList = response.data
          this.dialogBeforeFormVisible = true
        })
      } else {
        this.showEditForm({ id: row.id })
      }
    },
    handleRefreshColumn() {
      crudTable.refreshColumn(this.crud.selections[0].id).then(response => {
      })
    },
    showEditForm(params) {
      this.dialogBeforeFormVisible = false
      this.$router.push({ path: '/gen/edit', query: params })
    },
    showNextForm() {
      this.$refs['formSelect'].validate(valid => {
        if (valid) {
          this.showEditForm({ name: this.formSelect.name })
        }
      })
    }
  }
}
</script>
