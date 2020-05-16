<template>
  <el-dialog :visible.sync="dialog" append-to-body title="执行日志" width="88%">
    <!-- 搜索 -->
    <div class="head-container">
      <el-input
        v-model="query.blurry"
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
      <el-select
        v-model="query.isSuccess"
        class="filter-item"
        clearable
        placeholder="日志状态"
        size="small"
        style="width: 110px"
        @change="toQuery"
      >
        <el-option v-for="(item,index) in flagOptions" :key="index" :label="item.label" :value="item.value" />
      </el-select>
      <el-button
        plain
        class="filter-item"
        icon="el-icon-search"
        size="mini"
        type="primary"
        @click="toQuery"
      >搜索</el-button>
      <!-- 导出 -->
      <div style="display: inline-block;">
        <el-button
          v-permission="[permission.export]"
          plain
          :loading="downloadLoading"
          class="filter-item"
          icon="el-icon-download"
          size="mini"
          type="warning"
          @click="downloadLog"
        >导出
        </el-button>
      </div>
    </div>
    <!--表格渲染-->
    <el-table v-loading="loading" :data="data" style="width: 100%;margin-top: -10px;">
      <el-table-column :show-overflow-tooltip="true" label="任务名称" prop="jobName" width="120px" />
      <el-table-column :show-overflow-tooltip="true" label="任务分组" prop="jobGroup" width="100px" />
      <el-table-column :show-overflow-tooltip="true" label="调用目标字符串" prop="invokeTarget" />
      <el-table-column :show-overflow-tooltip="true" label="cron表达式" prop="cronExpression" width="120px" />
      <el-table-column :show-overflow-tooltip="true" label="日志信息" prop="jobMessage" />
      <el-table-column :show-overflow-tooltip="true" label="执行开始时间" prop="startTime" width="130px" />
      <el-table-column :show-overflow-tooltip="true" label="执行结束时间" prop="endTime" width="130px" />
      <el-table-column label="异常详情" prop="exceptionInfo" width="100px">
        <template slot-scope="scope">
          <el-button
            v-if="scope.row.exceptionInfo"
            size="mini"
            type="text"
            @click="info(scope.row.exceptionInfo)"
          >查看详情
          </el-button>
        </template>
      </el-table-column>
      <el-table-column align="center" label="状态" prop="statusText" width="80px">
        <template slot-scope="scope">
          <el-tag :type="scope.row.status === '1' ? 'success' : 'danger'">{{ scope.row.statusText }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column :show-overflow-tooltip="true" label="创建日期" prop="createdDate" width="130px" />
    </el-table>
    <el-dialog :visible.sync="errorDialog" append-to-body title="异常详情" width="85%">
      <pre v-highlightjs="errorInfo"><code class="java" /></pre>
    </el-dialog>
    <!--分页组件-->
    <el-pagination
      :current-page="page + 1"
      :page-size="6"
      :total="total"
      layout="total, prev, pager, next"
      style="margin-top:8px;"
      @current-change="pageChange"
      @size-change="sizeChange"
    />
  </el-dialog>
</template>

<script>
import crudJob from '@/views/quartz/job/job-service'
import crud from '@/mixins/crud'
import commonUtil from '@/utils/common'
import { mapGetters } from 'vuex'

export default {
  mixins: [crud],
  data() {
    return {
      title: '任务日志',
      errorInfo: '', errorDialog: false, downloadLoading: false,
      permission: {
        view: 'quartz_jobLog_view',
        export: 'quartz_jobLog_export'
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
    doInit() {
      this.$nextTick(() => {
        this.init()
      })
    },
    // 获取数据前设置好接口地址
    beforeInit() {
      this.url = '/quartz/job-log'
      this.size = 6
      return true
    },
    // 异常详情
    info(errorInfo) {
      this.errorInfo = errorInfo
      this.errorDialog = true
    },
    downloadLog() {
      // this.downloadLoading = true
      crudJob.downloadLog().then(response => {
        console.log(response)
        commonUtil.downloadFile(response, '任务调度执行日志数据', 'xlsx')
        // this.downloadLoading = false
      }).catch((e) => {
        console.log(e)
        // this.downloadLoading = false
      })
    }
  }
}
</script>

<style scoped>
  .java.hljs {
    color: #444;
    background: #ffffff !important;
  }

  /deep/ .el-dialog__body {
    padding: 0 20px 10px 20px !important;
  }
</style>
