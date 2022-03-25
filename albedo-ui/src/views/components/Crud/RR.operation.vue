<!--搜索与重置-->
<template>
  <span>
    <el-button
      class="filter-item"
      icon="el-icon-search"
      plain
      size="mini"
      type="primary"
      @click="crud.toQuery"
    >搜索</el-button>
    <el-button
      v-if="crud.optShow.reset"
      class="filter-item"
      icon="el-icon-refresh-left"
      plain
      size="mini"
      @click="crud.resetQuery()"
    >重置</el-button>
  </span>
</template>
<script>
import { crud } from '@crud/crud'

export default {
  mixins: [crud()],
  props: {
    itemClass: {
      type: String,
      required: false,
      default: ''
    }
  }
}
</script>
