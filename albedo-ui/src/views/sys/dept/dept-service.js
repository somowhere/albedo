import request from '@/utils/request'
import qs from 'qs'

export function getDepts(query) {
  return request({
    url: '/sys/dept/tree',
    method: 'get',
    params: query
  })
}

export function page(params) {
  return request({
    url: '/sys/dept/?' + qs.stringify(params, { indices: false }),
    method: 'get'
  })
}

export function get(id) {
  return request({
    url: '/sys/dept/' + id,
    method: 'get'
  })
}

export function save(data) {
  return request({
    url: '/sys/dept',
    method: 'post',
    data
  })
}

export function del(ids) {
  return request({
    url: '/sys/dept',
    method: 'delete',
    data: ids
  })
}

export function lock(ids) {
  return request({
    url: '/sys/dept',
    method: 'put',
    data: ids
  })
}

export default { page, save, lock, del, get, getDepts }
