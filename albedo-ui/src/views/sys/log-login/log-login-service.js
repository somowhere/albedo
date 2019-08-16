import request from '@/router/axios';

const logLoginService = {
  page(query) {
    return request({
      url: '/sys/log-login/',
      method: 'get',
      params: query
    })
  },

  export(query) {
    return request({
      url: '/sys/log-login/export',
      method: 'get',
      params: query
    })
  },

  remove(id) {
    return request({
      url: '/sys/log-login/' + id,
      method: 'delete'
    })
  }
};
export default logLoginService
