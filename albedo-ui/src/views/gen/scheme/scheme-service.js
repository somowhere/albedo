import request from '@/router/axios'

const schemeService = {
  page(query) {
    return request({
      url: '/gen/scheme/',
      method: 'get',
      params: query
    })
  },

  save(obj) {
    return request({
      url: '/gen/scheme/',
      method: 'post',
      data: obj
    })
  },

  genMenu(obj) {
    return request({
      url: '/gen/scheme/gen-menu',
      method: 'post',
      data: obj
    })
  },

  genCode(obj) {
    return request({
      url: '/gen/scheme/gen-code',
      method: 'put',
      data: obj
    })
  },


  find(query) {
    return request({
      url: '/gen/scheme/form-data',
      method: 'get',
      params: query
    })
  },

  previewCode(id) {
    return request({
      url: '/gen/scheme/preview/' + id,
      method: 'get'
    })
  },

  remove(id) {
    return request({
      url: '/gen/scheme/' + id,
      method: 'delete'
    })
  },
};
export default schemeService

