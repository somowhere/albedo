<template>
  <div class="app-container">
    <!--工具栏-->
    <div class="head-container">
      <div v-if="crud.props.searchToggle">
        <!-- 搜索 -->
        <el-input
          v-model="query.jobName"
          class="filter-item"
          clearable
          placeholder="输入任务名称搜索"
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
        <!-- 任务日志 -->
        <el-button
          slot="right"
          v-permission="[permission.jobLogView]"
          plain
          class="filter-item"
          icon="el-icon-tickets"
          size="mini"
          type="info"
          @click="doLog"
        >日志
        </el-button>
      </crudOperation>
      <Log ref="log" />
    </div>
    <!--Form表单-->
    <el-dialog
      :before-close="crud.cancelCU"
      :close-on-click-modal="false"
      :title="crud.status.title"
      :visible.sync="crud.status.cu > 0"
      append-to-body
      width="730px"
    >
      <el-form ref="form" :inline="true" :model="form" label-width="110px" size="small">
        <el-form-item label="任务名称" prop="name" :rules="[{ required: true, message: '请输入任务名称', trigger: 'blur' }]">
          <el-input v-model="form.name" style="width: 220px;" />
        </el-form-item>
        <el-form-item label="任务分组" prop="group" :rules="[{ required: true, message: '请选择任务分组', trigger: 'change' }]">
          <el-select v-model="form.group" style="width: 220px">
            <el-option v-for="item in jobGroupOptions" :key="item.value" :value="item.value" :label="item.label" />
          </el-select>
        </el-form-item>
        <el-form-item label="Cron表达式" prop="cronExpression" :rules="[{ required: true, message: '请选择Cron表达式', trigger: 'blur' }]">
          <el-input v-model="form.cronExpression" style="width: 220px;" />
          <div>
            <el-tag type="info" size="mini">Cron表达式</el-tag>
          </div>
        </el-form-item>
        <el-form-item label="是否并发执行" :rules="[{ required: true, message: '请选择是否并发执行', trigger: 'change' }]">
          <el-radio-group v-model="form.concurrent" style="width: 220px">
            <el-checkbox-button v-for="item in flagOptions" :key="item.value" :label="item.value">{{ item.label }}</el-checkbox-button>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="执行错误策略" :rules="[{ required: true, message: '请选择计划执行错误策略', trigger: 'change' }]">
          <el-select v-model="form.misfirePolicy" placeholder="请选择计划执行错误策略" style="width: 220px">
            <el-option v-for="item in misfirePolicyOptions" :key="item.value" :label="item.label" :value="item.value" />
          </el-select>
        </el-form-item>
        <el-form-item label="任务状态" :rules="[{ required: true, message: '请选择任务状态', trigger: 'change' }]">
          <el-radio-group v-model="form.status" style="width: 220px">
            <el-radio-button v-for="item in jobStatusOptions" :key="item.value" :label="item.value">{{ item.label }}</el-radio-button>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="子任务ID">
          <el-input v-model="form.subTask" placeholder="多个用逗号隔开，按顺序执行" style="width: 220px;" />
        </el-form-item>
        <el-form-item label="告警邮箱" prop="email">
          <el-input v-model="form.email" placeholder="多个邮箱用逗号隔开" style="width: 220px;" />
        </el-form-item>
        <el-form-item label="调用目标" :rules="[{ required: true, message: '请选择调用目标', trigger: 'blur' }]">
          <el-input v-model="form.invokeTarget" rows="4" style="width: 566px;" type="textarea" />
        </el-form-item>
        <el-form-item label="任务描述">
          <el-input v-model="form.description" rows="4" style="width: 566px;" type="textarea" />
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
    >
      <el-table-column type="selection" width="55" />
      <el-table-column :show-overflow-tooltip="true" label="任务ID" prop="id" width="90px" />
      <el-table-column :show-overflow-tooltip="true" label="任务名称" prop="name" />
      <el-table-column :show-overflow-tooltip="true" label="任务分组" prop="groupText" width="90px" />
      <el-table-column :show-overflow-tooltip="true" label="子任务ID" prop="subTask" width="90px" />
      <el-table-column :show-overflow-tooltip="true" label="调用目标" prop="invokeTarget" />
      <el-table-column :show-overflow-tooltip="true" label="cron表达式" prop="cronExpression" width="120px" />
      <el-table-column :show-overflow-tooltip="true" label="执行失败策略" prop="misfirePolicyText" width="100px" />
      <el-table-column :show-overflow-tooltip="true" label="是否并发执行" prop="concurrentText" width="100px" />
      <el-table-column :show-overflow-tooltip="true" label="状态" prop="statusText" width="90px">
        <template slot-scope="scope">
          <el-tag :type="scope.row.status === '1' ? 'success' : 'warning'">{{ scope.row.statusText }}</el-tag>
        </template>
      </el-table-column>
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
          <el-button
            v-permission="[permission.edit]"
            size="mini"
            style="margin-right: 3px;"
            type="text"
            @click="crud.toEdit(scope.row)"
          >编辑
          </el-button>
          <el-button
            v-permission="[permission.edit]"
            size="mini"
            style="margin-left: -2px"
            type="text"
            @click="execute(scope.row.id)"
          >执行
          </el-button>
          <el-button
            v-permission="[permission.edit]"
            size="mini"
            style="margin-left: 3px"
            type="text"
            @click="updateStatus(scope.row.id)"
          >
            {{ scope.row.status === '0' ? '恢复' : '暂停' }}
          </el-button>
          <el-popover
            :ref="scope.row.id"
            v-permission="[permission.del]"
            placement="top"
            width="200"
          >
            <p>确定停止并删除该任务吗？</p>
            <div style="text-align: right; margin: 0">
              <el-button size="mini" type="text" @click="$refs[scope.row.id].doClose()">取消</el-button>
              <el-button :loading="delLoading" size="mini" type="primary" @click="delMethod(scope.row.id)">确定
              </el-button>
            </div>
            <el-button slot="reference" size="mini" type="text">删除</el-button>
          </el-popover>
        </template>
      </el-table-column>
    </el-table>
    <!--分页组件-->
    <pagination />
  </div>
</template>

<script>
import crudJob from '@/views/quartz/job/job-service'
import Log from './log'
import CRUD, { crud, form, header, presenter } from '@crud/crud'
import rrOperation from '@crud/RR.operation'
import crudOperation from '@crud/CRUD.operation'
import pagination from '@crud/Pagination'
import { mapGetters } from 'vuex'

const defaultForm = {
  id: null,
  name: null,
  group: null,
  subTask: null,
  invokeTarget: null,
  cronExpression: null,
  misfirePolicy: null,
  concurrent: null,
  status: null,
  email: null,
  description: null
}
export default {
  name: 'Timing',
  components: { Log, pagination, crudOperation, rrOperation },
  cruds() {
    return CRUD({ title: '定时任务', crudMethod: { ...crudJob }})
  },
  mixins: [presenter(), header(), form(defaultForm), crud()],
  data() {
    return {
      delLoading: false,
      permission: {
        edit: 'quartz_job_edit',
        del: 'quartz_job_del',
        jobLogView: 'quartz_jobLog_view'
      },
      jobGroupOptions: [],
      jobStatusOptions: [],
      misfirePolicyOptions: [],
      flagOptions: []
    }
  },
  computed: {
    ...mapGetters([
      'dicts', 'permissions'
    ])
  },
  created() {
    this.jobGroupOptions = this.dicts['quartz_job_group']
    this.jobStatusOptions = this.dicts['quartz_job_status']
    this.misfirePolicyOptions = this.dicts['quartz_misfire_policy']
    this.flagOptions = this.dicts['sys_flag']
  },
  methods: {
    // 执行
    execute(id) {
      crudJob.run([id]).then(res => {
      }).catch(err => {
        console.log(err.response.data.message)
      })
    },
    // 改变状态
    updateStatus(id) {
      crudJob.updateStatus([id]).then(res => {
        this.crud.toQuery()
      }).catch(err => {
        console.log(err.response.data.message)
      })
    },
    delMethod(id) {
      this.delLoading = true
      crudJob.del([id]).then(() => {
        this.delLoading = false
        this.$refs[id].doClose()
        this.crud.dleChangePage(1)
        this.crud.toQuery()
      }).catch(() => {
        this.delLoading = false
        this.$refs[id].doClose()
      })
    },
    // 显示日志
    doLog() {
      this.$refs.log.dialog = true
      this.$refs.log.doInit()
    }
  }
}
</script>
