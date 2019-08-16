<template>
  <div class="app-container calendar-list-container">
    <div class="avue-data-display">
      <h3>JVM 资源监控</h3>
      <el-row :gutter="30" :span="24">
        <el-col :span="8">
          <b>内存{{getVal(metrics.gauges['jvm.memory.total.used']) * 100 /
            getVal(metrics.gauges['jvm.memory.total.max']) | numFilter}}</b>
          <p><span>总内存</span> ({{getVal(metrics.gauges['jvm.memory.total.used']) / 1000000 }}M /
            {{getVal(metrics.gauges['jvm.memory.total.max']) / 1000000 }}M)</p>
          <el-progress :percentage="getVal(metrics.gauges['jvm.memory.total.used']) * 100 /
                        getVal(metrics.gauges['jvm.memory.total.max']) | numFilter" :stroke-width="18"
                       :text-inside="true"
                       status="success">
          </el-progress>
          <p><span>堆内存</span> ({{getVal(metrics.gauges['jvm.memory.heap.used']) / 1000000}}M /
            {{getVal(metrics.gauges['jvm.memory.heap.max']) / 1000000}}M)</p>
          <el-progress :percentage="getVal(metrics.gauges['jvm.memory.heap.used'])  * 100 /
                       getVal(metrics.gauges['jvm.memory.heap.max']) | numFilter" :stroke-width="18" :text-inside="true"
                       status="success">
            <span>%</span>
          </el-progress>
          <p><span>非堆内存</span> ({{getVal(metrics.gauges['jvm.memory.non-heap.used']) / 1000000}}M /
            {{getVal(metrics.gauges['jvm.memory.non-heap.committed']) / 1000000}}M)</p>
          <el-progress :percentage="getVal(metrics.gauges['jvm.memory.non-heap.used'])  * 100 /
                        getVal(metrics.gauges['jvm.memory.non-heap.committed']) | numFilter" :stroke-width="18"
                       :text-inside="true"
                       status="success">
          </el-progress>
        </el-col>
        <el-col :span="8">
          <b>线程</b> (Total: {{getVal(metrics.gauges['jvm.threads.count']) }})
          <a @click="showDialog()" class="hand"><i class="icon-eye"></i></a>
          <p><span>可运行</span> {{getVal(metrics.gauges['jvm.threads.runnable.count']) }}</p>
          <el-progress :percentage="getVal(metrics.gauges['jvm.threads.runnable.count'])  * 100 /
                       getVal(metrics.gauges['jvm.threads.count']) | numFilter" :stroke-width="18" :text-inside="true"
                       status="success">
          </el-progress>
          <p><span>定时等待</span> ({{getVal(metrics.gauges['jvm.threads.timed_waiting.count']) }})</p>
          <el-progress :percentage="getVal(metrics.gauges['jvm.threads.timed_waiting.count'])  * 100 /
                       getVal(metrics.gauges['jvm.threads.count']) | numFilter" :stroke-width="18" :text-inside="true"
                       status="warning">
          </el-progress>
          <p><span>等待中</span> ({{getVal(metrics.gauges['jvm.threads.waiting.count']) }})</p>
          <el-progress :percentage="getVal(metrics.gauges['jvm.threads.waiting.count'])  * 100 /
                                  getVal(metrics.gauges['jvm.threads.count']) | numFilter" :stroke-width="18"
                       :text-inside="true"
                       status="warning">
          </el-progress>
          <p><span>阻塞中</span> ({{getVal(metrics.gauges['jvm.threads.blocked.count']) }})</p>
          <el-progress :percentage="getVal(metrics.gauges['jvm.threads.blocked.count'])  * 100 /
                       getVal(metrics.gauges['jvm.threads.count']) | numFilter" :stroke-width="18" :text-inside="true"
                       status="success">
          </el-progress>
        </el-col>
        <el-col :span="8">
          <b>垃圾回收</b>
          <div class="row">
            <div class="col-md-9">标记清除次数</div>
            <div class="col-md-3 text-right">
              <el-tag>{{getVal(metrics.gauges['jvm.garbage.PS-MarkSweep.count']) }}</el-tag>
            </div>
          </div>
          <div class="row">
            <div class="col-md-9">标记清除耗时</div>
            <div class="col-md-3 text-right">
              <el-tag>{{getVal(metrics.gauges['jvm.garbage.PS-MarkSweep.time']) }}ms</el-tag>
            </div>
          </div>
          <div class="row">
            <div class="col-md-9">回收次数</div>
            <div class="col-md-3 text-right">
              <el-tag>{{getVal(metrics.gauges['jvm.garbage.PS-Scavenge.count']) }}</el-tag>
            </div>
          </div>
          <div class="row">
            <div class="col-md-9">回收耗时</div>
            <div class="col-md-3 text-right">
              <el-tag>{{getVal(metrics.gauges['jvm.garbage.PS-Scavenge.time']) }}ms</el-tag>
            </div>
          </div>
        </el-col>
      </el-row>
      <h3>HTTP 请求 (事件 / 秒)</h3>
      <p v-show="metrics.counters">
        <span>使用中请求:</span> <b>{{getValByKey(metrics.counters['com.codahale.metrics.servlet.InstrumentedFilter.activeRequests'],
        'count')}}</b> -
        <span>请求总数</span> <b>{{getValByKey(metrics.timers['com.codahale.metrics.servlet.InstrumentedFilter.requests'],
        'count')}}</b>
      </p>
      <div class="table-responsive" v-show="!updatingMetrics">
        <table class="el-table">
          <thead>
          <tr>
            <th>状态码</th>
            <th>次数</th>
            <th class="text-right">平均数</th>
            <th class="text-right"><span>平均值</span> (1 min)</th>
            <th class="text-right"><span>平均值</span> (5 min)</th>
            <th class="text-right"><span>平均值</span> (15 min)</th>
          </tr>
          </thead>
          <tbody>
          <tr>
            <td>2xx (成功)</td>
            <td>
              <el-progress :percentage="getValByKey(metrics.meters['com.codahale.metrics.servlet.InstrumentedFilter.responseCodes.ok'],'count') * 100 /
                        getValByKey(metrics.timers['com.codahale.metrics.servlet.InstrumentedFilter.requests'],'count') | numFilter"
                           :stroke-width="18" :text-inside="true"
                           status="success">
              </el-progress>
            </td>
            <td class="text-right">
              {{getValByKey(metrics.meters['com.codahale.metrics.servlet.InstrumentedFilter.responseCodes.ok'],'mean_rate')}}
            </td>
            <td class="text-right">
              {{getValByKey(metrics.meters['com.codahale.metrics.servlet.InstrumentedFilter.responseCodes.ok'],'m1_rate')}}
            </td>
            <td class="text-right">
              {{getValByKey(metrics.meters['com.codahale.metrics.servlet.InstrumentedFilter.responseCodes.ok'],'m5_rate')}}
            </td>
            <td class="text-right">
              {{getValByKey(metrics.meters['com.codahale.metrics.servlet.InstrumentedFilter.responseCodes.ok'],'m15_rate')}}
            </td>
          </tr>
          <tr>
            <td>4xx (请求错误)</td>
            <td>
              <el-progress :percentage="getValByKey(metrics.meters['com.codahale.metrics.servlet.InstrumentedFilter.responseCodes.notFound'],'count') * 100 /
                        getValByKey(metrics.timers['com.codahale.metrics.servlet.InstrumentedFilter.requests'],'count') | numFilter"
                           :stroke-width="18" :text-inside="true"
                           status="success">
              </el-progress>
            </td>
            <td class="text-right">
              {{getValByKey(metrics.meters['com.codahale.metrics.servlet.InstrumentedFilter.responseCodes.notFound'],'mean_rate')}}
            </td>
            <td class="text-right">
              {{getValByKey(metrics.meters['com.codahale.metrics.servlet.InstrumentedFilter.responseCodes.notFound'],'m1_rate')}}
            </td>
            <td class="text-right">
              {{getValByKey(metrics.meters['com.codahale.metrics.servlet.InstrumentedFilter.responseCodes.notFound'],'m5_rate')}}
            </td>
            <td class="text-right">
              {{getValByKey(metrics.meters['com.codahale.metrics.servlet.InstrumentedFilter.responseCodes.notFound'],'m15_rate')}}
            </td>
          </tr>
          <tr>
            <td>5xx (服务器错误)</td>
            <td>
              <el-progress :percentage="getValByKey(metrics.meters['com.codahale.metrics.servlet.InstrumentedFilter.responseCodes.serverError'],'count') * 100 /
                        getValByKey(metrics.timers['com.codahale.metrics.servlet.InstrumentedFilter.requests'],'count') | numFilter"
                           :stroke-width="18" :text-inside="true"
                           status="success">
              </el-progress>
            </td>
            <td class="text-right">
              {{getValByKey(metrics.meters['com.codahale.metrics.servlet.InstrumentedFilter.responseCodes.serverError'],'mean_rate')}}
            </td>
            <td class="text-right">
              {{getValByKey(metrics.meters['com.codahale.metrics.servlet.InstrumentedFilter.responseCodes.serverError'],'m1_rate')}}
            </td>
            <td class="text-right">
              {{getValByKey(metrics.meters['com.codahale.metrics.servlet.InstrumentedFilter.responseCodes.serverError'],'m5_rate')}}
            </td>
            <td class="text-right">
              {{getValByKey(metrics.meters['com.codahale.metrics.servlet.InstrumentedFilter.responseCodes.serverError'],'m15_rate')}}
            </td>
          </tr>
          </tbody>
        </table>
      </div>

      <h3>服务统计 (时间单位为毫秒)</h3>
      <div class="table-responsive" v-show="!updatingMetrics">
        <table class="el-table">
          <thead>
          <tr>
            <th>服务名称</th>
            <th class="text-right">计数</th>
            <th class="text-right">平均值</th>
            <th class="text-right">最小值</th>
            <th class="text-right">p50</th>
            <th class="text-right">p75</th>
            <th class="text-right">p95</th>
            <th class="text-right">p99</th>
            <th class="text-right">最大值</th>
          </tr>
          </thead>
          <tbody>
          <tr v-bind:key="index" v-for="(entry, key,index) in servicesStats">
            <td>{{key}}</td>
            <td class="text-right">{{getValByKey(entry,'count')}}</td>
            <td class="text-right">{{getValByKey(entry,'mean')}}</td>
            <td class="text-right">{{getValByKey(entry,'min')}}</td>
            <td class="text-right">{{getValByKey(entry,'p50')}}</td>
            <td class="text-right">{{getValByKey(entry,'p75')}}</td>
            <td class="text-right">{{getValByKey(entry,'p95')}}</td>
            <td class="text-right">{{getValByKey(entry,'p99')}}</td>
            <td class="text-right">{{getValByKey(entry,'max')}}</td>
          </tr>
          </tbody>
        </table>
      </div>

      <h3>Cache 统计</h3>
      <div class="table-responsive" v-show="!updatingMetrics">
        <table class="el-table">
          <thead>
          <tr>
            <th>缓存名称</th>
            <th class="text-right">缓存命中</th>
            <th class="text-right">缓存未命中</th>
            <th class="text-right">缓存获取</th>
            <th class="text-right">缓存装入</th>
            <th class="text-right">缓存清除</th>
            <th class="text-right">缓存Evictions(驱逐)</th>
            <th class="text-right">缓存命中 %</th>
            <th class="text-right">缓存未命中 %</th>
            <th class="text-right">平均获取时间 (µs)</th>
            <th class="text-right">平均装入时间 (µs)</th>
            <th class="text-right">平均清除时间 (µs)</th>
          </tr>
          </thead>
          <tbody>
          <tr v-bind:key="index" v-for="(entry,index) in cachesStats">
            <td>{{entry.key}}</td>
            <td class="text-right">{{getVal(metrics.gauges[entry.key + '.cache-hits'])}}</td>
            <td class="text-right">{{getVal(metrics.gauges[entry.key + '.cache-misses'])}}</td>
            <td class="text-right">{{getVal(metrics.gauges[entry.key + '.cache-gets'])}}</td>
            <td class="text-right">{{getVal(metrics.gauges[entry.key + '.cache-puts'])}}</td>
            <td class="text-right">{{getVal(metrics.gauges[entry.key + '.cache-removals'])}}</td>
            <td class="text-right">{{getVal(metrics.gauges[entry.key + '.cache-evictions'])}}</td>
            <td class="text-right">{{getVal(metrics.gauges[entry.key + '.cache-hit-percentage'])}}</td>
            <td class="text-right">{{getVal(metrics.gauges[entry.key + '.cache-miss-percentage']) }}</td>
            <td class="text-right">{{getVal(metrics.gauges[entry.key + '.average-get-time'])}}</td>
            <td class="text-right">{{getVal(metrics.gauges[entry.key + '.average-put-time'])}}</td>
            <td class="text-right">{{getVal(metrics.gauges[entry.key + '.average-remove-time']) }}</td>
          </tr>
          </tbody>
        </table>
      </div>

      <h3
        v-show="metrics.gauges && metrics.gauges['HikariPool-1.pool.TotalConnections'] && getVal(metrics.gauges['HikariPool-1.pool.TotalConnections']) > 0">
        数据源统计 (时间单位为毫秒)</h3>
      <div class="table-responsive"
           v-show="!updatingMetrics && metrics.gauges && metrics.gauges['HikariPool-1.pool.TotalConnections'] && metrics.gauges['HikariPool-1.pool.TotalConnections'].value > 0">
        <table class="el-table">
          <thead>
          <tr>
            <th><span>用法</span> ({{getVal(metrics.gauges['HikariPool-1.pool.ActiveConnections'])}} /
              {{getVal(metrics.gauges['HikariPool-1.pool.TotalConnections'])}})
            </th>
            <th class="text-right">计数</th>
            <th class="text-right">平均值</th>
            <th class="text-right">最小值</th>
            <th class="text-right">p50</th>
            <th class="text-right">p75</th>
            <th class="text-right">p95</th>
            <th class="text-right">p99</th>
            <th class="text-right">最大值</th>
          </tr>
          </thead>
          <tbody>
          <tr>
            <td>
              <div class="progress progress-striped">
                <el-progress
                  :percentage="getVal(metrics.gauges['HikariPool-1.pool.ActiveConnections']) * 100 / getVal(metrics.gauges['HikariPool-1.pool.TotalConnections']) | numFilter"
                  :stroke-width="18" :text-inside="true"
                  status="success">
                </el-progress>
              </div>
            </td>
            <td class="text-right">{{getValByKey(metrics.histograms['HikariPool-1.pool.Usage'],'count')}}</td>
            <td class="text-right">{{getValByKey(metrics.histograms['HikariPool-1.pool.Usage'],'mean')}}</td>
            <td class="text-right">{{getValByKey(metrics.histograms['HikariPool-1.pool.Usage'],'min')}}</td>
            <td class="text-right">{{getValByKey(metrics.histograms['HikariPool-1.pool.Usage'],'p50')}}</td>
            <td class="text-right">{{getValByKey(metrics.histograms['HikariPool-1.pool.Usage'],'p75')}}</td>
            <td class="text-right">{{getValByKey(metrics.histograms['HikariPool-1.pool.Usage'],'p95')}}</td>
            <td class="text-right">{{getValByKey(metrics.histograms['HikariPool-1.pool.Usage'],'p99')}}</td>
            <td class="text-right">{{getValByKey(metrics.histograms['HikariPool-1.pool.Usage'],'max')}}</td>
          </tr>
          </tbody>
        </table>
      </div>

      <el-dialog :title="'线程转储'" :visible.sync="dialogVisible">
        <el-button-group>
          <el-button @click="threadDumpFilterByState('ALL')" size="mini" type="primary">All&nbsp;<span
            class="badge badge-pill badge-default">{{threadDumpAll}}</span></el-button>
          <el-button @click="threadDumpFilterByState('RUNNABLE')" size="mini" type="success">Runnable&nbsp;<span
            class="badge badge-pill badge-default">{{threadDumpRunnable}}</span></el-button>
          <el-button @click="threadDumpFilterByState('WAITING')" size="mini" type="info">Waiting&nbsp;<span
            class="badge badge-pill badge-default">{{threadDumpWaiting}}</span></el-button>
          <el-button @click="threadDumpFilterByState('TIMED_WAITING')" size="mini" type="warning">Timed
            Waiting&nbsp;<span class="badge badge-pill badge-default">{{threadDumpTimedWaiting}}</span></el-button>
          <el-button @click="threadDumpFilterByState('BLOCKED')" size="mini" type="danger">Blocked&nbsp;<span
            class="badge badge-pill badge-default">{{threadDumpBlocked}}</span></el-button>
        </el-button-group>
        <el-input style="margin: 10px 0 10px 0;" v-model="threadDumpFilter"></el-input>
        <div style="margin-bottom: 10px;" v-bind:key="index" v-for="(entry,index) in threadDump">
          <h6>
            <span :class="getBadgeClass(entry.threadState)" class="badge">{{entry.threadState}}</span>&nbsp;{{entry.threadName}}
            (ID {{entry.threadId}})
            <el-button @click="showDetail(entry)" round size="mini">
              {{entry.show?'隐藏':'显示'}}
            </el-button>
          </h6>
          <div class="card" v-if="entry.show">
            <div class="card-body">
              <div class="break" v-bind:key="index" v-for="(st,index) in entry.stackTrace">
                <samp>{{st.className}}.{{st.methodName}}(<code>{{st.fileName}}:{{st.lineNumber}}</code>)</samp>
                <span class="mt-1"></span>
              </div>
            </div>
          </div>
          <table class="el-table">
            <thead>
            <tr>
              <th>阻塞时间</th>
              <th>阻塞次数</th>
              <th>等待时间</th>
              <th>等待次数</th>
              <th>锁名称</th>
            </tr>
            </thead>
            <tbody>
            <tr>
              <td>{{entry.blockedTime}}</td>
              <td>{{entry.blockedCount}}</td>
              <td>{{entry.waitedTime}}</td>
              <td>{{entry.waitedCount}}</td>
              <td :title="entry.lockName" class="thread-dump-modal-lock"><code>{{entry.lockName}}</code></td>
            </tr>
            </tbody>
          </table>
        </div>
        <div class="dialog-footer" slot="footer">
          <el-button @click="dialogVisible=false">取 消</el-button>
        </div>
      </el-dialog>
    </div>
  </div>
</template>

<script>
    import {getMetrics, threadDump} from "./service";

    export default {
        components: {},
        name: "admin_metrics",
        directives: {},
        data() {
            return {
                dialogVisible: false,
                threadDump: [],
                threadDumpData: [],
                threadDumpAll: 0,
                threadDumpBlocked: 0,
                threadDumpRunnable: 0,
                threadDumpTimedWaiting: 0,
                threadDumpWaiting: 0,
                threadDumpFilter: '',
                metrics: {gauges: {}, meters: {}, counters: {}, timers: {}, histograms: {}},
                cachesStats: {},
                updatingMetrics: true,
                servicesStats: {},
                JCACHE_KEY: 'net.sf.ehcache.Cache'
            };
        },
        computed: {
            // ...mapGetters(['authorities'])
        },
        filters: {
            numFilter(value) {
                if (isNaN(value)) return 0;
                let realVal = Number(value).toFixed(2);
                return Number(realVal)
            },
            filterNaN(input) {
                if (isNaN(input)) {
                    return 0;
                }
                return input;
            }
        },
        created() {
            this.initPageData();

        },
        methods: {
            numFilter(value) {
                if (isNaN(value)) return 0;
                let realVal = Number(value).toFixed(2);
                return Number(realVal)
            },
            getVal(val) {
                return this.numFilter(val && val.value);
            },
            getValByKey(val, key) {
                return this.numFilter(val && val[key]);
            },
            showDialog() {
                this.dialogVisible = true;
                threadDump().then(data => {
                    data.forEach((value) => {
                        value.show = false;
                    });
                    this.threadDump = data;
                    this.threadDumpData = data;
                    this.threadDump.forEach((value) => {
                        value.show = false;
                        if (value.threadState === 'RUNNABLE') {
                            this.threadDumpRunnable += 1;
                        } else if (value.threadState === 'WAITING') {
                            this.threadDumpWaiting += 1;
                        } else if (value.threadState === 'TIMED_WAITING') {
                            this.threadDumpTimedWaiting += 1;
                        } else if (value.threadState === 'BLOCKED') {
                            this.threadDumpBlocked += 1;
                        }
                    });

                    this.threadDumpAll = this.threadDumpRunnable + this.threadDumpWaiting +
                        this.threadDumpTimedWaiting + this.threadDumpBlocked;
                })
            },
            showDetail(entry) {
                entry.show = !entry.show;
            },
            getBadgeClass(threadState) {
                if (threadState === 'RUNNABLE') {
                    return 'badge-success';
                } else if (threadState === 'WAITING') {
                    return 'badge-info';
                } else if (threadState === 'TIMED_WAITING') {
                    return 'badge-warning';
                } else if (threadState === 'BLOCKED') {
                    return 'badge-danger';
                }
            },
            threadDumpFilterByState(state) {
                this.threadDumpFilter = state;
                let dump = [];

                this.threadDumpData.forEach((value) => {
                    if (state == 'ALL' || value.threadState == state) {
                        dump.push(value);
                    }
                });
                this.threadDump = dump;
            },
            initPageData() {

                this.updatingMetrics = true;
                getMetrics().then(metrics => {
                    this.metrics = metrics;
                    this.servicesStats = {};
                    this.cachesStats = {};
                    Object.keys(metrics.timers).forEach((key) => {
                        const value = metrics.timers[key];
                        if (key.indexOf('web') !== -1 || key.indexOf('service') !== -1) {
                            this.servicesStats[key] = value;
                        }
                    });
                    Object.keys(metrics.gauges).forEach((key) => {
                        if (key.indexOf('jcache.statistics') !== -1) {
                            const value = metrics.gauges[key].value;
                            // remove gets or puts
                            const index = key.lastIndexOf('.');
                            const newKey = key.substr(0, index);

                            // Keep the name of the domain
                            this.cachesStats[newKey] = {
                                'name': this.JCACHE_KEY.length,
                                'value': value
                            };
                        }
                    });

                    this.updatingMetrics = false;
                });
            }

        }
    };
</script>
