<template>
  <div class="app-container calendar-list-container">
    <basic-container>
      <el-row>
        <el-col>
          <div class="table-responsive">
            <table class="el-table" id="healthCheck">
              <thead>
              <tr>
                <th>服务名称</th>
                <th class="text-center">状态</th>
                <th class="text-center">详细情况</th>
              </tr>
              </thead>
              <tbody>
              <tr v-bind:key="index" v-for="(health,index) in healthData">
                <td>{{baseName(health.name)}} {{subSystemName(health.name)}}</td>
                <td class="text-center">
                  <el-tag :type="getBadgeClass(health.status.status)">{{health.status.status}}</el-tag>
                </td>
                <td class="text-center">
                  <a @click="showHealth(health)" class="hand">
                    <i class="icon-eye"></i>
                  </a>
                </td>
              </tr>
              </tbody>
            </table>

            <el-dialog :title="baseName(currentHealth.name)+' '+subSystemName(currentHealth.name)"
                       :visible.sync="dialogVisible">

              <div v-show="currentHealth.details">
                <div class="table-responsive">
                  <table class="el-table">
                    <thead>
                    <tr>
                      <th class="text-left">名称</th>
                      <th class="text-left">值</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr v-bind:key="index" v-for="(entry, key,index) in currentHealth.details.details">
                      <td class="text-left">{{key}}</td>
                      <td class="text-left">{{readableValue(entry)}}</td>
                    </tr>
                    </tbody>
                  </table>
                </div>
              </div>
              <div v-show="currentHealth.error">
                <h4>Error</h4>
                <pre>{{currentHealth.error}}</pre>
              </div>
              <div class="dialog-footer" slot="footer">
                <el-button @click="dialogVisible=false">取 消</el-button>
              </div>
            </el-dialog>
          </div>
        </el-col>
      </el-row>
    </basic-container>
  </div>
</template>

<script>
    import {findHealth, getBaseName, getSubSystemName, transformHealthData} from "./service";

    export default {
        name: "admin_audits",
        data() {
            return {
                dialogVisible: false,
                listLoading: true,
                healthData: {},
                currentHealth: {details: {}}
            };
        },
        created() {
            this.initPageData();
        },
        methods: {
            baseName(name) {
                return getBaseName(name);
            },
            subSystemName(name) {
                return getSubSystemName(name);
            },
            getBadgeClass(statusState) {
                if (statusState === 'UP') {
                    return 'badge-success';
                } else {
                    return 'badge-danger';
                }
            },
            showHealth(health) {
                this.currentHealth = health;
                this.dialogVisible = true;
            },
            readableValue(value) {
                if (this.currentHealth.name !== 'diskSpace') {
                    return value.toString();
                }
                // Should display storage space in an human readable unit
                const val = value / 1073741824;
                if (val > 1) { // Value
                    return val.toFixed(2) + ' GB';
                } else {
                    return (value / 1048576).toFixed(2) + ' MB';
                }
            },
            initPageData() {
                this.listLoading = true;
                findHealth().then(rs => {
                    this.healthData = transformHealthData(rs);
                    this.listLoading = false;
                });
            }
        }
    };
</script>
