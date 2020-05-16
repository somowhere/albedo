import request from '@/utils/request'

export function getMenuTree(query) {
  return request({
    url: '/sys/menu/tree',
    method: 'get',
    params: query
  })
}
export function get(id) {
  return request({
    url: '/sys/menu/' + id,
    method: 'get'
  })
}
export function pageMenu(params) {
  return request({
    url: '/sys/menu/',
    method: 'get',
    params
  })
}
export function buildMenus() {
  return request({
    url: '/sys/menu/user-menu',
    method: 'get'
  })
}

export function save(data) {
  return request({
    url: '/sys/menu',
    method: 'post',
    data
  })
}

export function del(ids) {
  return request({
    url: '/sys/menu',
    method: 'delete',
    data: ids
  })
}

export function sortUpdate(data) {
  return request({
    url: '/sys/menu/sort-update',
    method: 'post',
    data: data
  })
}

export default { get, save, del, getMenuTree, pageMenu, sortUpdate }
