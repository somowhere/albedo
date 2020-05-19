import request from '@/utils/request'
import qs from 'qs'

export function page(params) {
  return request({
    url: '/gen/table/?' + qs.stringify(params, { indices: false }),
    method: 'get'
  })
}

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
export function refreshColumn(id) {
  return request({
    url: '/gen/table/refresh-column/' + id,
    method: 'put'
  })
}

export default { page, del, save, get, findFormData, findSelect, refreshColumn }
