import request from '@/router/axios';

const jobLogService = {
  page(query) {
    return request({
      url: '/quartz/job-log/',
      method: 'get',
      params: query
    })
  },

  export(query) {
    return request({
      url: '/quartz/job-log/export',
      method: 'get',
      params: query
    })
  },

  clean() {
    return request({
      url: '/quartz/job-log/clean',
      method: 'post'
    })
  },

  remove(id) {
    return request({
      url: '/quartz/job-log/' + id,
      method: 'delete'
    })
  },

};
export default jobLogService
