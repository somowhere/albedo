<template>
  <div class="app-container">
    <el-row :gutter="20">
      <!--侧边部门数据-->
      <el-col :lg="4" :md="4" :sm="6" :xl="4" :xs="9">
        <div class="head-container">
          <el-input
            v-model="deptName"
            class="filter-item"
            clearable
            placeholder="输入部门名称搜索"
            prefix-icon="el-icon-search"
            size="small"
            @input="getDeptDatas"
          />
        </div>
        <el-tree
          :data="deptDatas"
          :expand-on-click-node="false"
          default-expand-all
          @node-click="handleNodeClick"
        />
      </el-col>
      <!--用户数据-->
      <el-col :lg="20" :md="20" :sm="18" :xl="20" :xs="15">
        <!--工具栏-->
        <div class="head-container">
          <div v-if="crud.props.searchToggle">
            <!-- 搜索 -->
            <el-input
              v-model="query.blurry"
              class="filter-item"
              clearable
              placeholder="输入名称或者邮箱或手机号搜索"
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
            <el-select
              v-model="query.available"
              class="filter-item"
              clearable
              placeholder="是否可用"
              size="small"
              style="width: 100px"
              @change="crud.toQuery"
            >
              <el-option v-for="(item,index) in flagOptions" :key="index" :label="item.label" :value="item.value" />
            </el-select>
            <rrOperation />
          </div>
          <crudOperation :permission="permission">
            <el-button
              slot="right"
              v-permission="permission.export"
              :disabled="!crud.data.length"
              :loading="crud.downloadLoading"
              class="filter-item"
              icon="el-icon-download"
              plain
              size="mini"
              type="warning"
              @click="download"
            >导出
            </el-button>
          </crudOperation>
        </div>
        <!--表单渲染-->
        <el-dialog
          :before-close="crud.cancelCU"
          :close-on-click-modal="false"
          :title="crud.status.title"
          :visible.sync="crud.status.cu > 0"
          append-to-body
          width="570px"
        >
          <el-form ref="form" :model="form" label-width="86px" size="small">
            <el-form-item
              :rules="[
                { required: true, message: '请输入用户名', trigger: 'blur' },
                { min: 2, max: 20, message: '长度在 2 到 20 个字符', trigger: 'blur' }
              ]"
              label="用户名"
              prop="username"
            >
              <el-input v-model="form.username" />
            </el-form-item>
            <el-form-item
              :rules="[
                { min: 1, max: 64, message: '长度在 1 到 64 个字符', trigger: 'blur' }
              ]"
              label="昵称"
              prop="nickname"
            >
              <el-input v-model="form.nickname" />
            </el-form-item>

            <el-form-item
              :rules="[
                { required: true, trigger: 'blur', validator: validPhone }
              ]"
              label="电话"
              prop="phone"
            >
              <el-input v-model.number="form.phone" />
            </el-form-item>
            <el-form-item
              :rules="[
                { required: true, message: '请输入邮箱地址', trigger: 'blur' },
                { type: 'email', message: '请输入正确的邮箱地址', trigger: 'blur' }
              ]"
              label="邮箱"
              prop="email"
            >
              <el-input v-model="form.email" />
            </el-form-item>
            <el-form-item :rules="[{ required: true, trigger: 'blur', message: '请选择部门'}]" label="部门" prop="deptId">
              <treeselect
                v-model="form.deptId"
                :options="depts"
                placeholder="选择部门"
              />
            </el-form-item>
            <el-form-item :rules="[{ required: true, trigger: 'blur', message: '请选择角色'}]" label="角色" prop="roleIdList">
              <el-select
                v-model="form.roleIdList"
                multiple
                placeholder="请选择"
                style="width: 100%"
              >
                <el-option
                  v-for="item in roles"
                  :key="item.name"
                  :disabled="level !== 1 && item.level <= level"
                  :label="item.name"
                  :value="item.id"
                />
              </el-select>
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
          :data="crud.data"
          style="width: 100%;"
          @selection-change="crud.selectionChangeHandler"
          @sort-change="crud.sortChange"
        >
          <el-table-column :selectable="checkboxT" type="selection" width="55" />
          <el-table-column :show-overflow-tooltip="true" label="部门" prop="deptName" />
          <el-table-column :show-overflow-tooltip="true" label="用户名" prop="a.username" sortable="custom">
            <template slot-scope="scope">
              <span>{{ scope.row.username }}</span>
            </template>
          </el-table-column>
          <el-table-column :show-overflow-tooltip="true" label="昵称" prop="nickname" width="100" />
          <el-table-column :show-overflow-tooltip="true" label="电话" prop="phone" width="100" />
          <el-table-column :show-overflow-tooltip="true" label="邮箱" prop="email" width="135" />
          <el-table-column :show-overflow-tooltip="true" label="角色" prop="roleNames" width="160" />
          <el-table-column align="center" label="是否可用" prop="available">
            <template slot-scope="scope">
              <el-switch
                v-model="scope.row.available"
                v-permission="[permission.lock]"
                :active-value="1"
                :disabled="user.id === scope.row.id"
                :inactive-value="0"
                @change="changeAvailable(scope.row)"
              />
              <span v-show="!permissions.includes(permission.lock)">{{ scope.row.availableText }}</span>
            </template>
          </el-table-column>
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
            width="125"
          >
            <template slot-scope="scope">
              <udOperation
                :data="scope.row"
                :disabled-dle="scope.row.id === user.id"
                :permission="permission"
              />
            </template>
          </el-table-column>
        </el-table>
        <!--分页组件-->
        <pagination />
      </el-col>
    </el-row>
  </div>
</template>

<script>
import crudUser from '@/views/sys/user/user-service'
import validate from '@/utils/validate'
import { getDepts } from '@/views/sys/dept/dept-service'
import { getAll, getLevel } from '@/views/sys/role/role-service'
import CRUD, { crud, form, header, presenter } from '@crud/crud'
import rrOperation from '@crud/RR.operation'
import crudOperation from '@crud/CRUD.operation'
import udOperation from '@crud/UD.operation'
import pagination from '@crud/Pagination'
import Treeselect from '@riophae/vue-treeselect'
import { mapGetters } from 'vuex'
import '@riophae/vue-treeselect/dist/vue-treeselect.css'
import commonUtil from '@/utils/common'
import { NO, YES } from '@/const/common'

const defaultForm = {
  id: null,
  username: null,
  email: null,
  available: null,
  roleIdList: [],
  deptId: null,
  phone: null,
  description: null
}
export default {
  name: 'User',
  components: { Treeselect, crudOperation, rrOperation, udOperation, pagination },
  cruds() {
    return CRUD({ title: '用户', crudMethod: { ...crudUser }})
  },
  mixins: [presenter(), header(), form(defaultForm), crud()],
  // 数据字典
  data() {
    // 自定义验证
    return {
      height: document.documentElement.clientHeight - 180 + 'px;',
      deptName: '', depts: [], deptDatas: [], jobs: [], level: 3, roles: [],
      permission: {
        edit: 'sys_user_edit',
        lock: 'sys_user_lock',
        del: 'sys_user_del',
        export: 'sys_user_export'
      },
      flagOptions: [],
      validPhone: (rule, value, callback) => {
        if (!value) {
          callback(new Error('请输入电话号码'))
        } else if (!validate.isvalidPhone(value)) {
          callback(new Error('请输入正确的11位手机号码'))
        } else {
          callback()
        }
      }
    }
  },
  computed: {
    ...mapGetters([
      'user', 'dicts', 'permissions'
    ])
  },
  created() {
    this.$nextTick(() => {
      this.getDeptDatas()
      this.flagOptions = this.dicts['sys_flag']
      this.crud.msg.add = '新增成功，默认密码：123456'
    })
  },
  mounted: function() {
    const that = this
    window.onresize = function temp() {
      that.height = document.documentElement.clientHeight - 180 + 'px;'
    }
  },
  methods: {
    // 新增与编辑前做的操作
    [CRUD.HOOK.afterToCU](crud, form) {
      this.getDepts()
      this.getRoles()
      this.getRoleLevel()
      form.available = commonUtil.objToStr(form.available)
    },
    // 提交前做的操作
    [CRUD.HOOK.afterValidateCU](crud) {
      if (!crud.form.deptId) {
        this.$message({
          message: '部门不能为空',
          type: 'warning'
        })
        return false
      } else if (crud.form.roleIdList.length === 0) {
        this.$message({
          message: '角色不能为空',
          type: 'warning'
        })
        return false
      }
      return true
    },
    // 获取左侧部门数据
    getDeptDatas() {
      const params = {}
      if (this.deptName) {
        params['name'] = this.deptName
      }
      getDepts(params).then(res => {
        this.deptDatas = res.data
      })
    },
    // 获取弹窗内部门数据
    getDepts() {
      getDepts({ available: YES }).then(res => {
        this.depts = res.data
      })
    },
    // 切换部门
    handleNodeClick(data) {
      if (data.pid === 0) {
        this.query.deptId = null
      } else {
        this.query.deptId = data.id
      }
      this.crud.toQuery()
    },
    // 改变状态
    changeAvailable(data) {
      const flag = data.available === YES
      this.$confirm('此操作将 "' + (flag ? '启用' : '锁定') + '" ' + data.username + ', 是否继续？', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        crudUser.lock([data.id]).then(res => {
        }).catch(() => {
          data.available = flag ? NO : YES
        })
      }).catch(() => {
        data.available = flag ? NO : YES
      })
    },
    // 获取弹窗内角色数据
    getRoles() {
      getAll().then(res => {
        this.roles = res.data
      }).catch(() => {
      })
    },
    // 获取权限级别
    getRoleLevel() {
      getLevel().then(res => {
        this.level = res.data
      }).catch(() => {
      })
    },
    checkboxT(row, rowIndex) {
      return row.id !== this.user.id
    },
    download() {
      crud.downloadLoading = true
      crudUser.download(this.crud.getQueryParams()).then(response => {
        commonUtil.downloadFile(response, '用户数据', 'xlsx')
        crud.downloadLoading = false
      }).catch(() => {
        crud.downloadLoading = false
      })
    }
  }
}
</script>

<style scoped>
</style>
