<template>
  <div class="app-container calendar-list-container">
    <div class="table-responsive">
      <el-form :inline="true">
        <el-form-item label="过滤根据日期">
          <el-date-picker
            end-placeholder="结束日期"
            range-separator="至"
            start-placeholder="开始日期"
            type="daterange"
            v-model="dateRange">
          </el-date-picker>
        </el-form-item>
        <el-form-item>
          <el-button @click="handleFilter" class="filter-item" icon="el-icon-search" type="primary">查询</el-button>
        </el-form-item>
      </el-form>
      <div class="table-responsive">
        <el-table :data="tableData" style="width: 100%" v-loading="listLoading">
          <el-table-column
            label="日期"
            prop="timestamp"
            sortable
            width="180">
          </el-table-column>
          <el-table-column
            label="用户"
            prop="principal"
            sortable
            width="180">
          </el-table-column>
          <el-table-column
            label="状态"
            prop="type">
          </el-table-column>
          <el-table-column
            :formatter="formatter"
            label="其他"
            prop="other">
          </el-table-column>
        </el-table>
        <div class="pagination-container" v-show="!listLoading">
          <el-pagination :current-page.sync="listQuery.page" :page-size="listQuery.size"
                         :page-sizes="[10,20,30, 50]" :total="total" @current-change="handleCurrentChange"
                         @size-change="handleSizeChange" layout="total, sizes, prev, pager, next, jumper">
          </el-pagination>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
    import {findAllAudits} from "./service";
    import validate from "@/util/validate";

    export default {
        name: "admin_audits",
        data() {
            return {
                listLoading: true,
                total: null,
                listQuery: {
                    page: 1,
                    size: 20
                },
                dateRange: null,
                tableData: []
            };
        },
        created() {
            this.initPageData();
        },
        watch: {},
        methods: {

            handleFilter: function () {
                this.listQuery.page = 1;
                this.listQuery.fromDate = formatDateDay(this.dateRange[0]);
                this.listQuery.toDate = formatDateDay(this.dateRange[1]);
                this.initPageData();
            },
            formatter(row, column) {
                if (validate.checkNull(row.data)) {
                    return "";
                } else {
                    return util.objToStr(row.data.message) + ' 远程地址:' + util.objToStr(row.data.remoteAddress);
                }
            },
            handleSizeChange(val) {
                this.listQuery.size = val;
                this.initPageData();
            },
            handleCurrentChange(val) {
                this.listQuery.page = val;
                this.initPageData();
            },
            initPageData() {
                this.listLoading = true;
                findAllAudits(this.listQuery).then(response => {
                    this.tableData = response.data;
                    this.total = response.total;
                    this.listLoading = false;
                });
            }
        }
    };
</script>
