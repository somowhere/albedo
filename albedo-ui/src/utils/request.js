import axios from 'axios'
import router from '@/router/routers'
import { MessageBox, Notification } from 'element-ui'
import store from '../store'
import Config from '@/settings'
import commonUtil from './common'
import { MSG_TYPE_FAIL, MSG_TYPE_SUCCESS } from '@/const/common'
import validate from './validate'

export const errorCode = {
  '000': '操作太频繁，请勿重复请求',
  '401': '登录状态已过期，您可以继续留在该页面，或者重新登录',
  '403': '当前操作没有权限',
  '404': '资源不存在',
  '417': '未绑定登录账号，请使用密码登录后绑定',
  '423': '演示环境不能操作，如需了解联系somewhere',
  '426': '用户名不存在或密码错误',
  '428': '验证码错误,请重新输入',
  '429': '请求过频繁',
  '479': '演示环境，没有权限操作',
  'default': '系统未知错误,请反馈给管理员'
}
// 创建axios实例
const service = axios.create({
  baseURL: process.env.NODE_ENV === 'production' ? process.env.VUE_APP_BASE_URL : '/', // api 的 base_url
  timeout: Config.timeout // 请求超时时间
})

// request拦截器
service.interceptors.request.use(
  config => {
    config.url = Config.api + config.url
    const isToken = (config.headers || {}).isToken === false
    const token = store.getters.access_token
    if (token && !isToken) {
      config.headers['Authorization'] = 'Bearer ' + token// token
    }
    config.headers['Content-Type'] = 'application/json'
    // headers中配置serialize为true开启序列化
    if (config.method === 'post' && config.headers.serialize) {
      config.data = commonUtil.serialize(config.data)
    }
    return config
  },
  error => {
    // Do something with request error
    console.log(error) // for debug
    Promise.reject(error)
  }
)

// response 拦截器
service.interceptors.response.use(
  response => {
    const status = Number(response.status) || 200
    const code = Number(response.data.code)
    const message = errorCode[response.data.message] || response.data.message || errorCode[response.status]
    if (code === MSG_TYPE_FAIL) {
      Notification.error({
        title: message
      })
      return Promise.reject('error')
    } else {
      if (status === 200 && (response.data && response.data.code === MSG_TYPE_SUCCESS) && validate.checkNotNull(response.data.message)) {
        Notification.success(response.data.message)
      }
      return response.data
    }
  },
  error => {
    let message
    let status = 0
    try {
      status = error.response.status
      message = error.response.data.message || errorCode[status] || errorCode['default']
    } catch (e) {
      if (error.toString().indexOf('Error: timeout') !== -1) {
        Notification.error({
          title: '网络请求超时',
          duration: 5000
        })
        return Promise.reject(error)
      }
    }
    if (status) {
      if (status === 401) {
        MessageBox.confirm(
          message,
          '系统提示',
          {
            confirmButtonText: '重新登录',
            cancelButtonText: '取消',
            type: 'warning'
          }
        ).then(() => {
          store.dispatch('LogOut').then(() => {
            location.reload() // 为了重新实例化vue-router对象 避免bug
          })
        })
      } else if (status === 403) {
        router.push({ path: '/401' })
      } else {
        const errorMsg = error.response.data.message
        if (errorMsg !== undefined) {
          Notification.error({
            title: errorMsg,
            duration: 5000
          })
        }
      }
    } else {
      Notification.error({
        title: message,
        duration: 5000
      })
    }
    return Promise.reject(error)
  }
)
export default service
