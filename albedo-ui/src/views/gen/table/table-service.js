import request from '@/utils/request'

export function save(data) {
  return request({
    url: '/gen/table',
    method: 'post',
    data
  })
}

export function del(ids) {
  return request({
    url: '/gen/table',
    method: 'delete',
    data: ids
  })
}

export function get(id) {
  return request({
    url: '/gen/table/' + id,
    method: 'get'
  })
}

export function findSelect() {
  return request({
    url: '/gen/table/table-list',
    method: 'get'
  })
}
export function findFormData(query) {
  return request({
    url: '/gen/table/form-data',
    method: 'get',
    params: query
  })
}

export default { del, save, get, findFormData, findSelect }
