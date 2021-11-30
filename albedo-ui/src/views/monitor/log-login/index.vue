<template>
  <div class="app-container">
    <!--工具栏-->
    <div class="head-container">
      <div v-if="crud.props.searchToggle">
        <el-input v-model="query.title" class="filter-item input-small" clearable size="small" placeholder="输入日志标题搜索" @keyup.enter.native="toQuery" />
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
      <el-table-column align="center" label="日志标题" :show-overflow-tooltip="true" prop="title" />
      <el-table-column align="center" label="用户名" :show-overflow-tooltip="true" prop="username" />
      <el-table-column align="center" label="IP地址" :show-overflow-tooltip="true" prop="ipAddress" />
      <el-table-column align="center" label="登录地点" :show-overflow-tooltip="true" prop="ipLocation" />
      <el-table-column align="center" label="浏览器类型" :show-overflow-tooltip="true" prop="browser" />
      <el-table-column align="center" label="操作系统" :show-overflow-tooltip="true" prop="os" />
      <el-table-column align="center" label="用户代理" :show-overflow-tooltip="true" prop="userAgent" />
      <el-table-column align="center" label="请求URI" :show-overflow-tooltip="true" prop="requestUri" />
      <el-table-column align="center" label="执行时间" :show-overflow-tooltip="true" prop="executeTime" />
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
import crudLogLogin from '@/views/monitor/log-login/log-login-service'
import CRUD, { crud, header, presenter } from '@crud/crud'
import rrOperation from '@crud/RR.operation'
import udOperation from '@crud/UD.operation'
import crudOperation from '@crud/CRUD.operation'
import pagination from '@crud/Pagination'
import { mapGetters } from 'vuex'
import commonUtil from '@/utils/common'

export default {
  name: 'LogLogin',
  components: { crudOperation, rrOperation, udOperation, pagination },
  cruds() {
    return CRUD({ sorts: ['createdDate,desc'], title: '登录日志', crudMethod: { ...crudLogLogin }})
  },
  mixins: [presenter(), header(), crud()],
  // 数据字典
  data() {
    return {
      permission: {
        export: 'sys_logLogin_export',
        del: 'sys_logLogin_del'
      }
    }
  },
  computed: {
    ...mapGetters(['permissions', 'dicts'])
  },
  created() {
  },
  methods: {
    download() {
      crud.downloadLoading = true
      crudLogLogin.download(this.crud.getQueryParams()).then(response => {
        commonUtil.downloadFile(response, '登录日志数据', 'xlsx')
        crud.downloadLoading = false
      }).catch(() => {
        crud.downloadLoading = false
      })
    }
  }
}
</script>
