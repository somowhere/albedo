import request from '@/utils/request'

// eslint-disable-next-line no-unused-vars
const loginService = {

  getDicts() {
    return request({
      url: '/sys/dict/codes',
      method: 'get'
    })
  },
  login(user) {
    return request({
      url: '/authenticate',
      method: 'post',
      params: user
    })
  },
  getUser() {
    return request({
      url: '/sys/user/info',
      method: 'get'
    })
  },
  isAuthenticate() {
    return request({
      url: '/authenticate',
      method: 'get'
    })
  },
  logout() {
    return request({
      url: '/logout',
      method: 'post'
    })
  }
}

export default loginService
