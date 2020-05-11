<template>
  <div class="app-container">
    <el-row :gutter="20">
      <!--侧边部门数据-->
      <el-col :xs="9" :sm="6" :md="4" :lg="4" :xl="4">
        <div class="head-container">
          <el-input
            v-model="deptName"
            clearable
            size="small"
            placeholder="输入部门名称搜索"
            prefix-icon="el-icon-search"
            class="filter-item"
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
      <el-col :xs="15" :sm="18" :md="20" :lg="20" :xl="20">
        <!--工具栏-->
        <div class="head-container">
          <div v-if="crud.props.searchToggle">
            <!-- 搜索 -->
            <el-input
              v-model="query.blurry"
              clearable
              size="small"
              placeholder="输入名称或者邮箱或手机号搜索"
              style="width: 210px;"
              class="filter-item"
              @keyup.enter.native="crud.toQuery"
            />
            <el-date-picker
              v-model="query.createdDate"
              :default-time="['00:00:00','23:59:59']"
              type="daterange"
              range-separator=":"
              size="small"
              class="date-item"
              value-format="yyyy-MM-dd HH:mm:ss"
              start-placeholder="开始日期"
              end-placeholder="结束日期"
            />
            <el-select
              v-model="query.available"
              clearable
              size="small"
              placeholder="是否可用"
              class="filter-item"
              style="width: 100px"
              @change="crud.toQuery"
            >
              <el-option v-for="(item,index) in flagOptions" :key="index" :label="item.label" :value="item.value" />
            </el-select>
            <rrOperation />
          </div>
          <crudOperation show="" :permission="permission" />
        </div>
        <!--表单渲染-->
        <el-dialog append-to-body :close-on-click-modal="false" :before-close="crud.cancelCU" :visible.sync="crud.status.cu > 0" :title="crud.status.title" width="570px">
          <el-form ref="form" :model="form" size="small" label-width="86px">
            <el-form-item label="用户名" prop="username" :rules="[
          { required: true, message: '请输入用户名', trigger: 'blur' },
          { min: 2, max: 20, message: '长度在 2 到 20 个字符', trigger: 'blur' }
        ]">
              <el-input v-model="form.username"  />
            </el-form-item>
            <el-form-item label="电话" prop="phone" :rules="[
          { required: true, trigger: 'blur', validator: validPhone }
        ]">
              <el-input v-model.number="form.phone" />
            </el-form-item>
            <el-form-item label="邮箱" prop="email" :rules="[
          { required: true, message: '请输入邮箱地址', trigger: 'blur' },
          { type: 'email', message: '请输入正确的邮箱地址', trigger: 'blur' }
        ]">
              <el-input v-model="form.email" />
            </el-form-item>
            <el-form-item label="部门" prop="deptId" :rules="[{ required: true, trigger: 'blur', message: '请选择部门'}]">
              <treeselect
                v-model="form.deptId"
                :options="depts"
                placeholder="选择部门"
              />
            </el-form-item>
            <el-form-item label="是否可用" prop="available" :rules="[{ required: true, trigger: 'blur', message: '请选择'}]">
              <el-radio-group v-model="form.available" :disabled="form.id === user.id">
                <el-radio
                  v-for="item in flagOptions"
                  :key="item.id"
                  :label="item.value"
                >{{ item.label }}</el-radio>
              </el-radio-group>
            </el-form-item>
            <el-form-item label="角色" prop="roleIdList" :rules="[{ required: true, trigger: 'blur', message: '请选择角色'}]">
              <el-select
                v-model="form.roleIdList"
                multiple
                style="width: 100%"
                placeholder="请选择"
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
              <el-input type="textarea" v-model="form.description"></el-input>
            </el-form-item>
          </el-form>
          <div slot="footer" class="dialog-footer">
            <el-button type="text" @click="crud.cancelCU">取消</el-button>
            <el-button :loading="crud.status.cu === 2" type="primary" @click="crud.submitCU">确认</el-button>
          </div>
        </el-dialog>
        <!--表格渲染-->
        <el-table ref="table" v-loading="crud.loading" :data="crud.data" style="width: 100%;" @selection-change="crud.selectionChangeHandler">
          <el-table-column :selectable="checkboxT" type="selection" width="55" />
          <el-table-column :show-overflow-tooltip="true" prop="deptName" label="部门" />
          <el-table-column :show-overflow-tooltip="true" prop="username" label="用户名" />
          <el-table-column :show-overflow-tooltip="true" prop="phone" width="100" label="电话" />
          <el-table-column :show-overflow-tooltip="true" width="135" prop="email" label="邮箱" />
          <el-table-column :show-overflow-tooltip="true" prop="roleNames" width="160" label="角色" />
          <el-table-column label="状态" align="center" prop="availableText">
            <template slot-scope="scope">
              <el-switch
                v-model="scope.row.available"
                :disabled="user.id === scope.row.id"
                active-color="#409EFF"
                inactive-color="#F56C6C"
                @change="changeAvailable(scope.row, scope.row.available)"
              />
            </template>
          </el-table-column>
          <el-table-column :show-overflow-tooltip="true" prop="createTime" width="140" label="创建日期">
            <template slot-scope="scope">
              <span>{{ parseTime(scope.row.createdDate) }}</span>
            </template>
          </el-table-column>
          <el-table-column
            v-permission="['sys_user_edit', 'sys_user_del']"
            label="操作"
            width="125"
            align="center"
            fixed="right"
          >
            <template slot-scope="scope">
              <udOperation
                :data="scope.row"
                :permission="permission"
                :disabled-dle="scope.row.id === user.id"
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
import crudUser from '@/views/sys/user/userService'
import validate from '@/utils/validate'
import { getDepts } from '@/views/sys/dept/deptService'
import { getAll, getLevel } from '@/views/sys/role/roleService'
import CRUD, { presenter, header, form, crud } from '@crud/crud'
import rrOperation from '@crud/RR.operation'
import crudOperation from '@crud/CRUD.operation'
import udOperation from '@crud/UD.operation'
import pagination from '@crud/Pagination'
import Treeselect from '@riophae/vue-treeselect'
import { mapGetters } from 'vuex'
import '@riophae/vue-treeselect/dist/vue-treeselect.css'
import commonUtil from "../../../utils/common";

const defaultForm = { id: null, username: null, email: null, available: null, roleIdList: [], deptId: null , phone: null, description: null }
export default {
  name: 'User',
  components: { Treeselect, crudOperation, rrOperation, udOperation, pagination },
  cruds() {
    return CRUD({ title: '用户', url: '/sys/user/', crudMethod: { ...crudUser }})
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
      'user', 'dicts'
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
      const params = { }
      if (this.deptName) { params['name'] = this.deptName }
      getDepts(params).then(res => {
        this.deptDatas = res.data
      })
    },
    // 获取弹窗内部门数据
    getDepts() {
      getDepts({ available: 1 }).then(res => {
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
    changeAvailable(data, val) {
      this.$confirm('此操作将 "' + 'this.dict.label.user_status[val] ' + '" ' + data.username + ', 是否继续？', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        crudUser.edit(data).then(res => {
          this.crud.notify('this.dict.label.user_status[val]' + '成功', CRUD.NOTIFICATION_TYPE.SUCCESS)
        }).catch(() => {
          data.available = !data.available
        })
      }).catch(() => {
        data.available = !data.available
      })
    },
    // 获取弹窗内角色数据
    getRoles() {
      getAll().then(res => {
        this.roles = res.data
      }).catch(() => { })
    },
    // 获取权限级别
    getRoleLevel() {
      getLevel().then(res => {
        this.level = res.data
      }).catch(() => { })
    },
    checkboxT(row, rowIndex) {
      return row.id !== this.user.id
    }
  }
}
</script>

<style scoped>
</style>
