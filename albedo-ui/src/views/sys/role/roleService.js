import request from '@/utils/request'

// 获取所有的Role
export function getAll() {
  return request({
    url: '/sys/role/all',
    method: 'get'
  })
}

export function add(data) {
  return request({
    url: '/sys/role',
    method: 'post',
    data
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

export function edit(data) {
  return request({
    url: '/sys/role',
    method: 'put',
    data
  })
}

export function editMenu(data) {
  return request({
    url: '/sys/role/menu',
    method: 'put',
    data
  })
}

export default { add, edit, del, get, editMenu, getLevel }
