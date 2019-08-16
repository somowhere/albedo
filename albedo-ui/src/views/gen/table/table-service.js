import request from '@/router/axios'

const tableService = {
  page(query) {
    return request({
      url: '/gen/table/',
      method: 'get',
      params: query
    })
  },

  save(obj) {
    return request({
      url: '/gen/table/',
      method: 'post',
      data: obj
    })
  },

  find(query) {
    return request({
      url: '/gen/table/form-data',
      method: 'get',
      params: query
    })
  },

  findSelect() {
    return request({
      url: '/gen/table/table-list',
      method: 'get'
    })
  },

  remove(id) {
    return request({
      url: '/gen/table/' + id,
      method: 'delete'
    })
  }
};
export default tableService


