<template>
  <div class="app-container">
    <div class="head-container">
      <div v-if="crud.props.searchToggle">
        <el-input v-model="query.blurry" clearable size="small" placeholder="全表模糊搜索" style="width: 200px;" class="filter-item" @keyup.enter.native="crud.toQuery" />
        <rrOperation />
      </div>
      <crudOperation>
        <el-button
          slot="left"
          v-permission="[permission.del]"
          plain
          class="filter-item"
          type="danger"
          icon="el-icon-delete"
          size="mini"
          :loading="delLoading"
          :disabled="crud.selections.length === 0"
          @click="doDel(crud.selections)"
        >
          删除
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
      <el-table-column prop="series" label="令牌" />
      <el-table-column prop="username" label="用戶名" />
      <el-table-column prop="ipAddress" label="IP" />
      <el-table-column :show-overflow-tooltip="true" prop="loginLocation" label="登录地点" />
      <el-table-column :show-overflow-tooltip="true" prop="userAgent" label="用户代理" />
      <el-table-column prop="browser" label="浏览器" />
      <el-table-column prop="os" label="操作系统" />
      <el-table-column prop="tokenDate" label="创建时间" />
      <el-table-column v-permission="[permission.del]" label="操作" width="70px" fixed="right">
        <template slot-scope="scope">
          <el-popover
            :ref="scope.$index"
            v-permission="[permission.del]"
            placement="top"
            width="180"
          >
            <p>确定强制删除该令牌吗？</p>
            <div style="text-align: right; margin: 0">
              <el-button size="mini" type="text" @click="$refs[scope.$index].doClose()">取消</el-button>
              <el-button :loading="delLoading" type="primary" size="mini" @click="delMethod(scope.row.series, scope.$index)">确定</el-button>
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
import crudPersistentToken from '@/views/monitor/persistent-token/persistent-token-service'
import CRUD, { presenter, header, crud } from '@crud/crud'
import rrOperation from '@crud/RR.operation'
import crudOperation from '@crud/CRUD.operation'
import pagination from '@crud/Pagination'

export default {
  name: 'OnlineUser',
  components: { pagination, crudOperation, rrOperation },
  cruds() {
    return CRUD({ title: '令牌管理', crudMethod: { ...crudPersistentToken }})
  },
  mixins: [presenter(), header(), crud()],
  data() {
    return {
      delLoading: false,
      permission: {
        del: 'sys_persistentToken_del'
      }
    }
  },
  created() {
    this.crud.optShow = {
      add: false,
      edit: false,
      del: false
    }
  },
  methods: {
    doDel(datas) {
      this.$confirm(`确认删除选中的${datas.length}个令牌?`, '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.delMethod(datas)
      }).catch(() => {})
    },
    // 踢出用户
    delMethod(key, index) {
      const ids = []
      if (key instanceof Array) {
        key.forEach(val => {
          ids.push(val.series)
        })
      } else ids.push(key)
      this.delLoading = true
      crudPersistentToken.del(ids).then(() => {
        this.delLoading = false
        if (this.$refs[index]) {
          this.$refs[index].doClose()
        }
        this.crud.dleChangePage(1)
        this.crud.toQuery()
      }).catch(() => {
        this.delLoading = false
        if (this.$refs[index]) {
          this.$refs[index].doClose()
        }
      })
    }
  }
}
</script>
