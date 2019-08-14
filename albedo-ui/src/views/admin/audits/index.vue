<template>
  <div class="app-container calendar-list-container">
    <div class="table-responsive">
      <el-form :inline="true">
        <el-form-item label="过滤根据日期">
          <el-date-picker
            v-model="dateRange"
            type="daterange"
            range-separator="至"
            start-placeholder="开始日期"
            end-placeholder="结束日期">
          </el-date-picker>
        </el-form-item>
        <el-form-item>
          <el-button class="filter-item" type="primary" icon="el-icon-search" @click="handleFilter">查询</el-button>
        </el-form-item>
      </el-form>
      <div class="table-responsive">
        <el-table :data="tableData" style="width: 100%" v-loading="listLoading">
          <el-table-column
            prop="timestamp"
            label="日期"
            sortable
            width="180">
          </el-table-column>
          <el-table-column
            prop="principal"
            label="用户"
            sortable
            width="180">
          </el-table-column>
          <el-table-column
            prop="type"
            label="状态">
          </el-table-column>
          <el-table-column
            prop="other"
            label="其他"
            :formatter="formatter">
          </el-table-column>
        </el-table>
        <div v-show="!listLoading" class="pagination-container">
          <el-pagination @size-change="handleSizeChange" @current-change="handleCurrentChange"
                         :current-page.sync="listQuery.page" :page-sizes="[10,20,30, 50]" :page-size="listQuery.size"
                         layout="total, sizes, prev, pager, next, jumper" :total="total">
          </el-pagination>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
    import {findAllAudits} from "./service";
    import {objectToString, validateNull} from "@/util/validate";

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
                if (validateNull(row.data)) {
                    return "";
                } else {
                    return objectToString(row.data.message) + ' 远程地址:' + objectToString(row.data.remoteAddress);
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
