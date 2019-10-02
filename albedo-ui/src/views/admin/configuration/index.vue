<template>
  <div class="app-container calendar-list-container">
    <basic-container>
      <el-row>
        <el-col>
          <div v-if="allConfiguration && configuration">
            <el-input placeholder="过滤 (按前缀)" v-model="filter"/>
            <div class="table-menu" style="margin: 10px 0 0 ">
              <div class="table-menu-left">
              </div>
              <div class="table-menu-right">
                <el-button-group>
                  <el-button @click="handleRefresh" icon="el-icon-refresh" size="mini" type="primary">刷新
                  </el-button>
                </el-button-group>
              </div>
            </div>
            <table class="el-table" v-bind:key="index" v-for="(entry, index) in configuration">
              <thead>
              <tr>
                <th @click="orderProp = 'prefix'; reverse=!reverse" class="w-40"><span>前缀</span></th>
                <th @click="orderProp = 'properties'; reverse=!reverse" class="w-60"><span>属性</span></th>
              </tr>
              </thead>
              <tbody>
              <tr v-bind:key="j" v-for="(item, j) in entry.beans">
                <td><span>{{item.prefix}}</span></td>
                <td>
                  <div v-bind:key="index" v-for="(itemChild, key, index) in item.properties">
                    <el-row :gutter="30" :span="24">
                      <el-col :span="8">{{key}}</el-col>
                      <el-col :span="16">
                        <span class="float-right badge badge-secondary break">{{itemChild | json }}</span>
                      </el-col>
                    </el-row>
                  </div>
                </td>
              </tr>
              </tbody>
            </table>
            <div v-bind:key="index" v-for="(item, key,index) in allConfiguration">
              <label><span>{{key}}</span></label>
              <table class="el-table">
                <thead>
                <tr>
                  <th class="w-40">Property</th>
                  <th class="w-60">Value</th>
                </tr>
                </thead>
                <tbody>
                <tr v-bind:key="index" v-for="(temp, key, index) in item">
                  <td class="break w-40">{{key}}</td>
                  <td class="break w-60">
                    <span class="float-right badge badge-secondary break">{{temp}}</span>
                  </td>
                </tr>
                </tbody>
              </table>
            </div>
          </div>
        </el-col>
      </el-row>
    </basic-container>
  </div>
</template>

<script>
  import {getConfigprops, getEnv} from "./service";

  export default {
    components: {},
    name: "admin_configuration",
    directives: {},
    data() {
      return {
        allConfiguration: {},
        configuration: {},
        configurationBak: {},
        configKeys: [],
        filter: undefined,
        orderProp: undefined,
        reverse: false,
        searchForm: {}
      };
    },
    computed: {
      // ...mapGetters(['authorities'])
    },
    filters: {
      json(value) {
        return JSON.stringify(value)
      },
    },
    watch: {
      filter(val) {
        let array = [];
        for (const key in this.configurationBak) {
          let item = this.configurationBak[key];
          if (item.prefix.indexOf(val) != -1) {
            array.push(item);
          }
        }
        this.configuration = array;
      }
    },
    created() {
      this.initPageData();
    },
    methods: {
      initPageData() {
        this.configKeys = [];
        getConfigprops().then(data => {
          const configuration = data.contexts;
          this.configuration = configuration;
          this.configurationBak = configuration;
          for (const key in configuration) {
            const config = configuration[key];
            if (config.beans !== undefined) {
              this.configKeys.push(Object.keys(config.beans));
            }
          }
          console.log(this.configKeys);
          console.log(this.configuration)
        });
        getEnv().then(configuration => {
          this.allConfiguration = configuration;
        });
      },
      handleRefresh() {
        this.initPageData()
      }

    }
  };
</script>
