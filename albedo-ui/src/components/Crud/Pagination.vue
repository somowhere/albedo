<!--分页-->
<template>
  <el-pagination
    :current-page.sync="page.page"
    :page-size.sync="page.size"
    :total="page.total"
    layout="total, prev, pager, next, sizes"
    style="margin-top: 8px;"
    @current-change="crud.pageChangeHandler"
    @size-change="crud.sizeChangeHandler($event)"
  />
</template>
<script>
import { pagination } from '@crud/crud'

export default {
  mixins: [pagination()]
}
</script>
