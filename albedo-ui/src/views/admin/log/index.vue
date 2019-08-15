<template>
  <div class="app-container calendar-list-container">
    <basic-container>
      <el-row>
        <el-col>
          <div class="table-responsive" v-show="!updatingLogs">
            <p>共有 {{ loggers.length }} 条日志.</p>

            <span>过滤</span>
            <el-input v-model="filter"></el-input>

            <table class="el-table">
              <thead>
              <tr title="click to order">
                <th><span>名称</span></th>
                <th><span>等级</span></th>
              </tr>
              </thead>

              <tr v-bind:key="index" v-for="(logger, index) in loggers">
                <td><small>{{logger.name}}</small></td>
                <td>
                  <el-button-group>
                    <el-button :type="(logger.level=='TRACE') ? 'primary' : ''"
                               @click="changeLevel(logger.name, 'TRACE')" size="mini">TRACE
                    </el-button>
                    <el-button :type="(logger.level=='DEBUG') ? 'success' : ''"
                               @click="changeLevel(logger.name, 'DEBUG')" size="mini">DEBUG
                    </el-button>
                    <el-button :type="(logger.level=='INFO') ? 'info' : ''" @click="changeLevel(logger.name, 'INFO')"
                               size="mini">INFO
                    </el-button>
                    <el-button :type="(logger.level=='WARN') ? 'warning' : ''" @click="changeLevel(logger.name, 'WARN')"
                               size="mini">WARN
                    </el-button>
                    <el-button :type="(logger.level=='ERROR') ? 'danger' : ''"
                               @click="changeLevel(logger.name, 'ERROR')" size="mini">ERROR
                    </el-button>
                  </el-button-group>
                </td>
              </tr>
            </table>
          </div>
        </el-col>
      </el-row>
    </basic-container>
  </div>
</template>

<script>
    import {changeLevelLogs, findAllLogs} from "./service";

    export default {
        components: {},
        name: "admin_logs",
        directives: {},
        data() {
            return {
                updatingLogs: true,
                filter: null,
                loggers: []

            };
        },
        computed: {
            // ...mapGetters(['authorities'])
        },
        watch: {
            filter(val) {
                let array = [];
                for (const key in this.loggers) {
                    let item = this.loggers[key];
                    if (item.name.indexOf(val) != -1) {
                        array.push(item);
                    }
                }
                this.loggers = array;
            }
        },
        created() {
            this.initPageData();

        },
        methods: {
            changeLevel(name, level) {
                changeLevelLogs({name: name, level: level}).then(() => {
                    this.initPageData();
                });
            },
            initPageData() {
                this.updatingLogs = true;
                findAllLogs().then(loggers => {
                    this.loggers = loggers;
                    this.updatingLogs = false;
                });
            }

        }
    };
</script>
