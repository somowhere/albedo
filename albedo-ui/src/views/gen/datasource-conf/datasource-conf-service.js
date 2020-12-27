import request from '@/utils/request'
import qs from 'qs'

export function page(params) {
  return request({
    url: '/gen/datasource-conf/?' + qs.stringify(params, { indices: false }),
    method: 'get'
  })
}

export function save(data) {
  return request({
    url: '/gen/datasource-conf',
    method: 'post',
    data
  })
}

export function del(ids) {
  return request({
    url: '/gen/datasource-conf',
    method: 'delete',
    data: ids
  })
}

export function get(id) {
  return request({
    url: '/gen/datasource-conf/' + id,
    method: 'get'
  })
}

export default { page, del, save, get }
