<template>
  <div class="app-container calendar-list-container">
    <basic-container>
      <el-row>
        <el-col>
          <div v-if="allConfiguration && configuration">
            <span>过滤 (按前缀)</span>
            <el-input v-model="filter"/>
            <h2>Spring configuration</h2>
            <table class="el-table">
              <thead>
              <tr>
                <th @click="orderProp = 'prefix'; reverse=!reverse" class="w-40"><span>前缀</span></th>
                <th @click="orderProp = 'properties'; reverse=!reverse" class="w-60"><span>属性</span></th>
              </tr>
              </thead>
              <tbody>
              <tr v-bind:key="index" v-for="(entry, index) in configuration">
                <td><span>{{entry.prefix}}</span></td>
                <td>
                  <div v-bind:key="index" v-for="(item, key,index) in entry.properties">
                    <el-row :gutter="30" :span="24">
                      <el-col :span="8">{{key}}</el-col>
                      <el-col :span="16">
                        <span class="float-right badge badge-secondary break">{{item | json }}</span>
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
                reverse: false
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
                getConfigprops().then(configuration => {
                    this.configuration = configuration;
                    this.configurationBak = configuration;
                    for (const config in configuration) {
                        if (config.properties !== undefined) {
                            this.configKeys.push(Object.keys(config.properties));
                        }
                    }
                });
                getEnv().then(configuration => {
                    this.allConfiguration = configuration;
                });
            }

        }
    };
</script>
