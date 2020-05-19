import request from '@/utils/request'
import qs from 'qs'

// 获取所有的Role
export function getAll() {
  return request({
    url: '/sys/role/all',
    method: 'get'
  })
}

export function save(data) {
  return request({
    url: '/sys/role',
    method: 'post',
    data
  })
}

export function page(params) {
  return request({
    url: '/sys/role/?' + qs.stringify(params, { indices: false }),
    method: 'get'
  })
}
export function get(id) {
  return request({
    url: '/sys/role/' + id,
    method: 'get'
  })
}

export function getLevel() {
  return request({
    url: '/sys/role/level',
    method: 'get'
  })
}

export function del(ids) {
  return request({
    url: '/sys/role',
    method: 'delete',
    data: ids
  })
}

export function lock(ids) {
  return request({
    url: '/sys/role/',
    method: 'put',
    data: ids
  })
}

export function editMenu(data) {
  return request({
    url: '/sys/role/menu',
    method: 'put',
    data
  })
}

export default { page, save, lock, del, get, editMenu, getLevel }
