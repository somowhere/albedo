import request from '@/utils/request'
import qs from 'qs'

export function getDicts(query) {
  return request({
    url: '/sys/dict/tree',
    method: 'get',
    params: query
  })
}

export function page(params) {
  return request({
    url: '/sys/dict/?' + qs.stringify(params, { indices: false }),
    method: 'get'
  })
}
export function get(id) {
  return request({
    url: '/sys/dict/' + id,
    method: 'get'
  })
}

export function save(data) {
  return request({
    url: '/sys/dict',
    method: 'post',
    data
  })
}

export function del(ids) {
  return request({
    url: '/sys/dict',
    method: 'delete',
    data: ids
  })
}

export function lock(ids) {
  return request({
    url: '/sys/dict',
    method: 'put',
    data: ids
  })
}

export default { page, save, lock, del, get, getDicts }
