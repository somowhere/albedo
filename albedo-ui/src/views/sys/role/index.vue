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
          placeholder="输入名称或者描述搜索"
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
        <rrOperation />
      </div>
      <crudOperation :permission="permission" />
    </div>
    <!-- 表单渲染 -->
    <el-dialog
      :before-close="crud.cancelCU"
      :close-on-click-modal="false"
      :title="crud.status.title"
      :visible.sync="crud.status.cu > 0"
      append-to-body
      width="520px"
    >
      <el-form ref="form" :model="form" label-width="86px" size="small">
        <el-form-item label="角色名称" prop="name" :rules="[{ required: true, message: '请输入名称', trigger: 'blur' }]">
          <el-input v-model="form.name" />
        </el-form-item>
        <el-form-item label="角色级别" prop="level">
          <el-input-number v-model.number="form.level" :min="1" controls-position="right" :rules="[{ required: true, message: '请输入角色级别', trigger: 'blur' }]" />
        </el-form-item>
        <el-form-item label="数据范围" prop="dataScope" :rules="[{ required: true, message: '请选择数据范围', trigger: 'blur' }]">
          <el-select
            v-model="form.dataScope"
            placeholder="请选择数据范围"
            style="width: 100%"
            @change="changeScope"
          >
            <el-option
              v-for="item in dateScopeOptions"
              :key="item.id"
              :label="item.label"
              :value="item.value"
            />
          </el-select>
        </el-form-item>
        <el-form-item v-if="form.dataScope === '5'" label="数据权限" prop="deptIdList">
          <treeselect v-model="form.deptIdList" :options="depts" multiple placeholder="请选择" />
        </el-form-item>
        <el-form-item label="描述信息" prop="description">
          <el-input v-model="form.description" rows="5" type="textarea" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="text" @click="crud.cancelCU">取消</el-button>
        <el-button :loading="crud.status.cu === 2" type="primary" @click="crud.submitCU">确认</el-button>
      </div>
    </el-dialog>
    <el-row :gutter="15">
      <!--角色管理-->
      <el-col :lg="18" :md="16" :sm="24" :xl="17" :xs="24" style="margin-bottom: 10px">
        <el-card class="box-card" shadow="never">
          <div slot="header" class="clearfix">
            <span class="card-span">角色列表</span>
          </div>
          <el-table
            ref="table"
            v-loading="crud.loading"
            :data="crud.data"
            highlight-current-row
            style="width: 100%;"
            @current-change="handleCurrentChange"
            @selection-change="crud.selectionChangeHandler"
            @sort-change="crud.sortChange"
          >
            <el-table-column :selectable="checkboxT" type="selection" width="55" />
            <el-table-column label="名称" prop="name" />
            <el-table-column label="数据权限" prop="dataScopeText" />
            <el-table-column label="角色级别" prop="level" width="80" />
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
            <el-table-column :show-overflow-tooltip="true" :visible="false" label="描述" prop="description" />
            <el-table-column
              :show-overflow-tooltip="true"
              label="创建日期"
              prop="createdDate"
              sortable="custom"
              width="140"
            />
            <el-table-column
              v-permission="[permission.edit, permission.del]"
              align="center"
              fixed="right"
              label="操作"
              width="130px"
            >
              <template slot-scope="scope">
                <udOperation
                  v-if="scope.row.level >= level"
                  :data="scope.row"
                  :permission="permission"
                />
              </template>
            </el-table-column>
          </el-table>
          <!--分页组件-->
          <pagination />
        </el-card>
      </el-col>
      <!-- 菜单授权 -->
      <el-col :lg="6" :md="8" :sm="24" :xl="7" :xs="24">
        <el-card class="box-card" shadow="never">
          <div slot="header" class="clearfix">
            <el-tooltip class="item" content="选择指定角色分配菜单" effect="dark" placement="top">
              <span class="card-span">菜单分配</span>
            </el-tooltip>
            <el-button
              v-permission="'sys_role_edit'"
              :disabled="!showButton"
              :loading="menuLoading"
              icon="el-icon-check"
              size="mini"
              class="card-btn-span"
              type="text"
              @click="saveMenu"
            >保存
            </el-button>
          </div>
          <el-tree
            ref="menu"
            :data="menus"
            :default-checked-keys="menuIdList"
            accordion
            check-strictly
            node-key="id"
            show-checkbox
          />
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script>
import crudRole from '@/views/sys/role/role-service'
import { getDepts } from '@/views/sys/dept/dept-service'
import { getTree } from '@/views/sys/menu/menu-service'
import CRUD, { crud, form, header, presenter } from '@crud/crud'
import rrOperation from '@crud/RR.operation'
import crudOperation from '@crud/CRUD.operation'
import udOperation from '@crud/UD.operation'
import pagination from '@crud/Pagination'
import Treeselect from '@riophae/vue-treeselect'
import commonUtil from '@/utils/common'
import { NO, YES } from '@/const/common'
import '@riophae/vue-treeselect/dist/vue-treeselect.css'
import { mapGetters } from 'vuex'
import validate from '@/utils/validate'

const defaultForm = {
  id: null,
  name: null,
  deptIdList: [],
  available: null,
  description: null,
  dataScope: null,
  level: 3
}
export default {
  name: 'Role',
  components: { Treeselect, pagination, crudOperation, rrOperation, udOperation },
  cruds() {
    return CRUD({ title: '角色', sort: 'level,asc', crudMethod: { ...crudRole }})
  },
  mixins: [presenter(), header(), form(defaultForm), crud()],
  data() {
    return {
      level: 3,
      currentId: 0, menuLoading: false, showButton: false,
      menus: [], menuIdList: [], depts: [],
      permission: {
        edit: 'sys_role_edit',
        lock: 'sys_role_lock',
        del: 'sys_role_del'
      },
      flagOptions: [],
      dateScopeOptions: []
    }
  },
  computed: {
    ...mapGetters([
      'dicts', 'permissions'
    ])
  },
  created() {
    this.getMenus()
    this.flagOptions = this.dicts['sys_flag']
    this.dateScopeOptions = this.dicts['sys_data_scope']
    crudRole.getLevel().then(response => {
      this.level = response.data
    })
  },
  methods: {// 新增与编辑前做的操作
    [CRUD.HOOK.afterToCU](crud, form) {
      form.available = commonUtil.objToStr(form.available)
    },
    [CRUD.HOOK.afterRefresh]() {
      this.$refs.menu.setCheckedKeys([])
    },
    // 编辑前
    [CRUD.HOOK.beforeToEdit](crud, form) {
      if (form.dataScope === '5') {
        this.getDepts()
      }
    },
    // 提交前做的操作
    [CRUD.HOOK.afterValidateCU](crud) {
      if (crud.form.dataScope === '5' && crud.form.deptIdList.length === 0) {
        this.$message({
          message: '自定义数据权限不能为空',
          type: 'warning'
        })
        return false
      }
      return true
    },
    // 获取所有菜单
    getMenus() {
      getTree().then(res => {
        this.menus = res.data
      })
    },
    // 触发单选
    handleCurrentChange(val) {
      if (validate.checkNotNull(val)) {
        const _this = this
        // 清空菜单的选中
        this.$refs.menu.setCheckedKeys([])
        // 保存当前的角色id
        this.currentId = val.id
        this.showButton = this.level <= val.level
        // 初始化
        this.menuIdList = []
        // 菜单数据需要特殊处理
        crudRole.get(val.id).then((res) => {
          _this.menuIdList = res.data.menuIdList
        })
      }
    },
    // 保存菜单
    saveMenu() {
      this.menuLoading = true
      const role = { roleId: this.currentId, menuIdList: [] }
      // 得到半选的父节点数据，保存起来
      // this.$refs.menu.getHalfCheckedNodes().forEach(function(data, index) {
      //   role.menuIdList.push(data.id)
      // })
      // 得到已选中的 key 值
      this.$refs.menu.getCheckedKeys().forEach(function(data, index) {
        role.menuIdList.push(data)
      })
      if (role.menuIdList.length === 0) {
        this.menuLoading = false
        this.$message({
          message: '角色菜单不能为空',
          type: 'warning'
        })
        return false
      }
      crudRole.editMenu(role).then(() => {
        this.menuLoading = false
        this.update()
      }).catch(err => {
        this.menuLoading = false
        console.log(err.response.data.message)
      })
    },
    // 改变数据
    update() {
      // 无刷新更新 表格数据
      crudRole.get(this.currentId).then(res => {
        for (let i = 0; i < this.crud.data.length; i++) {
          if (res.id === this.crud.data[i].id) {
            this.crud.data[i] = res
            break
          }
        }
      })
    },
    // 获取部门数据
    getDepts() {
      getDepts({ available: true }).then(res => {
        this.depts = res.data
      })
    },
    // 如果数据权限为自定义则获取部门数据
    changeScope() {
      if (this.form.dataScope === '5') {
        this.getDepts()
      }
    },
    checkboxT(row, rowIndex) {
      return row.level >= this.level
    },
    // 改变状态
    changeAvailable(data) {
      const flag = data.available === YES
      this.$confirm('此操作将 "' + (flag ? '启用' : '锁定') + '" ' + data.name + ', 是否继续？', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        crudRole.lock([data.id]).then(res => {
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

<style lang="scss" rel="stylesheet/scss">

</style>

<style lang="scss" rel="stylesheet/scss" scoped>
  /deep/ .el-input-number .el-input__inner {
    text-align: left;
  }
</style>
