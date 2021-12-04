<template>
  <div class="block">
    <el-timeline>
      <el-timeline-item
        v-for="(item,index) of timeline"
        :key="index"
        :timestamp="item.createdDate"
        placement="top"
      >
        <el-card>
          <p>
            <el-icon class="el-icon-link" />
            {{ $t('table.loginLog.ipAddress') }}：{{ item.ipAddress }}
          </p>
          <p>
            <el-icon class="el-icon-location-outline" />
            {{ $t('table.loginLog.ipLocation') }}：{{ item.ipLocation }}
          </p>
          <p>
            <el-icon class="el-icon-bangzhu" />
            {{ $t('table.loginLog.browser') }}：{{ item.browser }}
          </p>
          <p>
            <el-icon class="el-icon-monitor" />
            {{ $t('table.loginLog.os') }}：{{ item.os }}
          </p>
        </el-card>
      </el-timeline-item>
    </el-timeline>
  </div>
</template>

<script>
import crudLogLogin from '@/views/monitor/log-login/log-login-service'
export default {
  props: {
    user: {
      type: Object,
      default: () => {
        return {

        }
      }
    }
  },
  data() {
    return {
      timeline: []
    }
  },
  mounted() {
    this.getTimeLine()
  },
  methods: {
    getTimeLine() {
      crudLogLogin.page({ current: 1, size: 10, userId: this.user.id, sorts: 'createdDate,desc' })
        .then((res) => {
          this.timeline = res.data.records
        })
    }
  }
}
</script>
<style lang="scss" scoped>
.el-card.is-always-shadow {
  box-shadow: none;
}
.el-card {
  border: 1px solid #f1f1f1;
  border-radius: 2px;
}
</style>
