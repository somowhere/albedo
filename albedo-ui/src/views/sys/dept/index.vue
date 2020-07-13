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
          placeholder="输入部门名称或者描述搜索"
          size="small"
          style="width: 200px;"
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
        <el-select
          v-model="query.available"
          class="filter-item"
          clearable
          placeholder="状态"
          size="small"
          style="width: 90px"
          @change="crud.toQuery"
        >
          <el-option v-for="(item,index) in flagOptions" :key="index" :label="item.label" :value="item.value" />
        </el-select>
        <rrOperation />
      </div>
      <crudOperation :permission="permission" />
    </div>
    <!--表单组件-->
    <el-dialog
      :before-close="crud.cancelCU"
      :close-on-click-modal="false"
      :title="crud.status.title"
      :visible.sync="crud.status.cu > 0"
      append-to-body
      width="500px"
    >
      <el-form ref="form" :model="form" label-width="80px" size="small">
        <el-form-item :rules="[{ required: true, trigger: 'change', message: '请选择上级部门'}]" label="上级部门" prop="parentId">
          <treeselect v-model="form.parentId" :options="depts" placeholder="选择上级类目" />
        </el-form-item>
        <el-form-item :rules="[{ required: true, trigger: 'blur', message: '请输入部门名称'}]" label="部门名称" prop="name">
          <el-input v-model="form.name" />
        </el-form-item>
        <el-form-item label="菜单排序" prop="sort">
          <el-input-number
            v-model.number="form.sort"
            :max="999"
            :min="0"
            controls-position="right"
          />
        </el-form-item>
        <el-form-item label="备注" prop="description">
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
      default-expand-all
      :data="crud.data"
      row-key="id"
      @select="crud.selectChange"
      @select-all="crud.selectAllChange"
      @selection-change="crud.selectionChangeHandler"
    >
      <el-table-column type="selection" width="55" />
      <el-table-column label="名称" prop="name" />
      <el-table-column label="序号" prop="sort" />
      <el-table-column align="center" label="是否可用" prop="available">
        <template slot-scope="scope">
          <el-switch
            v-model="scope.row.available"
            v-permission="[permission.lock]"
            :active-value="1"
            :inactive-value="0"
            @change="changeAvailable(scope.row)"
          />
          <span v-show="!permissions.includes(permission.lock)">{{ scope.row.availableText }}</span>
        </template>
      </el-table-column>
      <el-table-column label="描述" prop="description" />
      <el-table-column label="创建日期" prop="createdDate">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.createdDate) }}</span>
        </template>
      </el-table-column>
      <el-table-column
        v-permission="[permission.edit, permission.del]"
        align="center"
        fixed="right"
        label="操作"
        width="130px"
      >
        <template slot-scope="scope">
          <udOperation
            :data="scope.row"
            :disabled-dle="scope.row.id === 1"
            :permission="permission"
            msg="确定删除吗,如果存在下级节点则一并删除，此操作不能撤销！"
          />
        </template>
      </el-table-column>
    </el-table>
  </div>
</template>

<script>
import crudDept from '@/views/sys/dept/dept-service'
import Treeselect from '@riophae/vue-treeselect'
import '@riophae/vue-treeselect/dist/vue-treeselect.css'
import CRUD, { crud, form, header, presenter } from '@crud/crud'
import rrOperation from '@crud/RR.operation'
import crudOperation from '@crud/CRUD.operation'
import udOperation from '@crud/UD.operation'
import { NO, YES } from '@/const/common'
import { mapGetters } from 'vuex'

const defaultForm = { id: null, name: null, parentId: -1, description: null }
export default {
  name: 'Dept',
  components: { Treeselect, crudOperation, rrOperation, udOperation },
  cruds() {
    return CRUD({ title: '部门', crudMethod: { ...crudDept }})
  },
  mixins: [presenter(), header(), form(defaultForm), crud()],
  data() {
    return {
      depts: [],
      permission: {
        edit: 'sys_dept_edit',
        lock: 'sys_dept_lock',
        del: 'sys_dept_del'
      },
      flagOptions: []
    }
  },
  computed: {
    ...mapGetters([
      'dicts', 'permissions'
    ])
  },
  created() {
    this.flagOptions = this.dicts['sys_flag']
  },
  methods: {
    // 新增与编辑前做的操作
    [CRUD.HOOK.afterToCU](crud, form) {
      // 获取所有部门
      crudDept.getDepts({ notId: form.id, available: 1 }).then(res => {
        this.depts = []
        const dept = { id: -1, label: '顶级类目', children: [] }
        dept.children = res.data
        this.depts.push(dept)
      })
    },
    // 提交前的验证
    [CRUD.HOOK.afterValidateCU]() {
      if (!this.form.parentId && this.form.id !== 1) {
        this.$message({
          message: '上级部门不能为空',
          type: 'warning'
        })
        return false
      }
      return true
    },
    // 改变状态
    changeAvailable(data) {
      const flag = data.available === YES
      this.$confirm('此操作将 "' + (flag ? '启用' : '锁定') + '" ' + data.name + ', 是否继续？', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        crudDept.lock([data.id]).then(res => {
        }).catch(() => {
          data.available = flag ? NO : YES
        })
      }).catch(() => {
        data.available = flag ? NO : YES
      })
    }
  }
}
</script>

<style scoped>
</style>
