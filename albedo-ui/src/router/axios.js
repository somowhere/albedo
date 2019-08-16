import util from '@/util/util'
import NProgress from 'nprogress' // progress bar
import errorCode from '@/const/errorCode'
import router from "@/router/router"
import 'nprogress/nprogress.css'
import store from "@/store";
import validate from "@/util/validate";
import {Message} from 'element-ui'
import {MSG_TYPE_FAIL, MSG_TYPE_SUCCESS} from "../const/common";
import {baseUrl} from "../config/env"; // progress bar style
axios.defaults.timeout = 30000;
// 返回其他状态吗
axios.defaults.validateStatus = function (status) {
  return status >= 200 && status <= 500 // 默认的
};
// 跨域请求，允许保存cookie
axios.defaults.withCredentials = true;
// NProgress Configuration
NProgress.configure({
  showSpinner: false
});

// HTTPrequest拦截
axios.interceptors.request.use(config => {
  NProgress.start(); // start progress bar
  config.url = baseUrl + config.url;
  const isToken = (config.headers || {}).isToken === false;
  let token = store.getters.access_token;
  if (token && !isToken) {
    config.headers['Authorization'] = 'Bearer ' + token// token
  }
  // headers中配置serialize为true开启序列化
  if (config.methods === 'post' && config.headers.serialize) {
    config.data = util.serialize(config.data);
    delete config.data.serialize
  }
  return config
}, error => {
  return Promise.reject(error)
});


// HTTPresponse拦截
axios.interceptors.response.use(res => {
  NProgress.done();
  const status = Number(res.status) || 200;
  const message = res.data.message || errorCode[status] || errorCode['default'];
  if (status === 401) {
    store.dispatch('fedLogOut').then(() => {
      router.push({path: '/login'})
    });
    Message({
      message: message,
      type: 'error'
    });
    return
  }

  if (status !== 200 || (res.data && res.data.code === MSG_TYPE_FAIL)) {
    Message({
      message: message,
      type: 'error'
    });
    return Promise.reject(new Error(message))
  }
  if (status === 200 && (res.data && res.data.code === MSG_TYPE_SUCCESS) && validate.checkNotNull(res.data.message)) {
    Message({
      message: res.data.message,
      type: 'success'
    })
  }
  return res.data
}, error => {
  NProgress.done();
  return Promise.reject(new Error(error))
});

export default axios
