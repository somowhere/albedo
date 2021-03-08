<template>
  <el-dialog :visible.sync="dialog" append-to-body title="Redis 详细信息" width="88%">
    <!-- 搜索 -->
    <div class="head-container" />
    <!--表格渲染-->
    <el-table v-loading="loading" :data="data" style="width: 100%;margin-top: -10px;">
      <el-table-column :show-overflow-tooltip="true" label="键" prop="key" width="220px" />
      <el-table-column :show-overflow-tooltip="true" label="值" prop="value" width="280px" />
      <el-table-column :show-overflow-tooltip="true" label="描述" prop="description" />
    </el-table>
  </el-dialog>
</template>

<script>
import crud from '@/mixins/crud'

export default {
  mixins: [crud],
  data() {
    return {
      title: 'Redis 详细信息'
    }
  },
  computed: {
  },
  created() {
  },
  methods: {
    doInit() {
      this.$nextTick(() => {
        this.init()
      })
    },
    // 获取数据前设置好接口地址
    beforeInit() {
      this.url = '/actuator/redis/detail'
      return true
    }
  }
}
</script>

