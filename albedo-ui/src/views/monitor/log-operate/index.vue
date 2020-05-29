<template>
  <div class="app-container">
    <div class="head-container">
      <div v-if="crud.props.searchToggle">
        <el-input
          v-model="query.blurry"
          clearable
          size="small"
          placeholder="全表模糊搜索"
          style="width: 200px;"
          class="filter-item"
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
          v-model="query.logType"
          class="filter-item"
          clearable
          placeholder="日志类型"
          size="small"
          style="width: 100px"
          @change="crud.toQuery"
        >
          <el-option value="INFO">INFO</el-option>
          <el-option value="ERROR">ERROR</el-option>
        </el-select>
        <!--        <el-select-->
        <!--          v-model="query.businessType"-->
        <!--          class="filter-item"-->
        <!--          clearable-->
        <!--          placeholder="业务类型"-->
        <!--          size="small"-->
        <!--          style="width: 100px"-->
        <!--          @change="crud.toQuery"-->
        <!--        >-->
        <!--          <el-option v-for="(item,index) in businessTypeOptions" :key="index" :label="item.label" :value="item.value" />-->
        <!--        </el-select>-->
        <el-select
          v-model="query.operatorType"
          class="filter-item"
          clearable
          placeholder="操作类别"
          size="small"
          style="width: 100px"
          @change="crud.toQuery"
        >
          <el-option v-for="(item,index) in operatorTypeOptions" :key="index" :label="item.label" :value="item.value" />
        </el-select>
        <rrOperation />
      </div>
      <crudOperation>
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
    <!--表格渲染-->
    <el-table
      ref="table"
      v-loading="crud.loading"
      :data="crud.data"
      style="width: 100%;"
      :default-sort="{prop:'createdDate',order:'descending'}"
      @sort-change="crud.sortChange"
      @selection-change="crud.selectionChangeHandler"
    >
      <el-table-column type="expand" width="55">
        <template slot-scope="props">
          <el-form label-position="left" inline class="log-table-expand">
            <el-form-item label="请求URL">
              <span>{{ props.row.requestUri }}</span>
            </el-form-item>
            <el-form-item label="请求方法">
              <span>{{ props.row.method }}</span>
            </el-form-item>
            <el-form-item label="请求参数">
              <span>{{ props.row.params }}</span>
            </el-form-item>
            <el-form-item label="用户代理">
              <span>{{ props.row.userAgent }}</span>
            </el-form-item>
            <el-form-item label="登录地点">
              <span>{{ props.row.ipLocation }}</span>
            </el-form-item>
          </el-form>
        </template>
      </el-table-column>
      <el-table-column type="selection" width="55" />
      <el-table-column prop="title" label="标题" />
      <el-table-column prop="logType" label="日志类型" width="90px">
        <template slot-scope="scope">
          <el-tag v-if="scope.row.logType === 'INFO'">{{ scope.row.logType }}</el-tag>
          <el-tag v-else type="danger">{{ scope.row.logType }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="operatorTypeText" label="业务类型" width="90px" />
      <el-table-column prop="ipAddress" label="IP" />
      <el-table-column :show-overflow-tooltip="true" prop="browser" label="浏览器" />
      <el-table-column :show-overflow-tooltip="true" prop="os" label="操作系统" />
      <el-table-column prop="time" label="执行时间" sortable="custom">
        <template slot-scope="scope">
          <el-tag v-if="scope.row.time <= 300">{{ scope.row.time }}ms</el-tag>
          <el-tag v-else-if="scope.row.time <= 1000" type="warning">{{ scope.row.time }}ms</el-tag>
          <el-tag v-else type="danger">{{ scope.row.time }}ms</el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="username" label="操作人" />
      <el-table-column prop="createdDate" label="创建时间" sortable="custom" />
      <el-table-column v-permission="[permission.del]" label="操作" width="120px" fixed="right">
        <template slot-scope="scope">
          <udOperation
            :data="scope.row"
            :permission="permission"
          >
            <el-button
              v-if="scope.row.logType === 'ERROR'"
              slot="left"
              plain
              size="mini"
              type="primary"
              icon="el-icon-info"
              @click="info(scope.row.exception)"
            />

          </udOperation>
        </template>
      </el-table-column>
    </el-table>
    <el-dialog :visible.sync="errorDialog" append-to-body title="异常详情" width="85%">
      <pre v-highlightjs="errorInfo"><code class="java" /></pre>
    </el-dialog>
    <!--分页组件-->
    <pagination />
  </div>
</template>

<script>
import crudLogOperate from '@/views/monitor/log-operate/log-operate-service'
import CRUD, { presenter, header, crud } from '@crud/crud'
import rrOperation from '@crud/RR.operation'
import crudOperation from '@crud/CRUD.operation'
import udOperation from '@crud/UD.operation'
import pagination from '@crud/Pagination'
import commonUtil from '@/utils/common'
import { mapGetters } from 'vuex'

export default {
  name: 'OnlineUser',
  components: { pagination, crudOperation, udOperation, rrOperation },
  cruds() {
    return CRUD({ sorts: ['createdDate,desc'], title: '令牌管理', crudMethod: { ...crudLogOperate }})
  },
  mixins: [presenter(), header(), crud()],
  data() {
    return {
      errorInfo: '', errorDialog: false, delLoading: false,
      // businessTypeOptions: [],
      operatorTypeOptions: [],
      permission: {
        export: 'sys_logOperate_export',
        del: 'sys_logOperate_del'
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
    // this.businessTypeOptions = this.dicts['sys_business_type']
    this.operatorTypeOptions = this.dicts['sys_operator_type']
  },
  methods: {
    // 获取异常详情
    info(errorInfo) {
      this.errorDialog = true
      this.errorInfo = errorInfo
    },
    download() {
      crud.downloadLoading = true
      crudLogOperate.download(this.crud.getQueryParams()).then(response => {
        commonUtil.downloadFile(response, '操作日志数据', 'xlsx')
        crud.downloadLoading = false
      }).catch(() => {
        crud.downloadLoading = false
      })
    }
  }
}
</script>
<style>
  .log-table-expand {
    font-size: 0;
  }
  .log-table-expand label {
    width: 70px;
    color: #99a9bf;
  }
  .log-table-expand .el-form-item {
    margin-right: 0;
    margin-bottom: 0;
    width: 100%;
  }
  .log-table-expand .el-form-item__content {
    font-size: 12px;
  }
</style>
