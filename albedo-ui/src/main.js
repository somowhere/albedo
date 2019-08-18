import 'babel-polyfill'
import 'classlist-polyfill'
import Vue from 'vue'
import axios from './router/axios'
import VueAxios from 'vue-axios'
import App from './App'
import './permission' // 权限
import './error' // 日志
import router from './router/router'
import store from './store'
import util from '@/util/util'
import * as urls from '@/config/env'
import {iconfontUrl, iconfontVersion} from '@/config/env'
import * as filters from './filters' // 全局filter
import './styles/common.scss'
// 引入avue的包
import Avue from '@smallwei/avue/lib/index.js'
// 引入avue的样式文件
import '@smallwei/avue/lib/theme-chalk/index.css'
import basicContainer from './components/basic-container/main'

import validate from '@/util/validate'

import ace from 'ace-builds'


Vue.prototype.checkNull = validate.checkNull;

Vue.use(Avue, {menuType: 'text'});

Vue.use(router);

Vue.use(VueAxios, axios);

Vue.use(ace);

// 注册全局容器
Vue.component('basicContainer', basicContainer);

// 加载相关url地址
Object.keys(urls).forEach(key => {
  Vue.prototype[key] = urls[key]
});

//加载过滤器
Object.keys(filters).forEach(key => {
  Vue.filter(key, filters[key])
});

// 动态加载阿里云字体库
iconfontVersion.forEach(ele => {
  util.loadStyle(iconfontUrl.replace('$key', ele))
});

Vue.config.productionTip = false;

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app');
