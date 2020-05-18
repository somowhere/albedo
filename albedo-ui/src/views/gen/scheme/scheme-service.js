import request from '@/utils/request'

export function save(obj) {
  return request({
    url: '/gen/scheme/',
    method: 'post',
    data: obj
  })
}

export function del(ids) {
  return request({
    url: '/gen/scheme/',
    method: 'delete',
    data: ids
  })
}

export function get(id) {
  return request({
    url: '/gen/scheme/' + id,
    method: 'get',
    params: { id: id }
  })
}

export function findFormData(id) {
  return request({
    url: '/gen/scheme/form-data',
    method: 'get',
    params: { id: id }
  })
}
export function genMenu(obj) {
  return request({
    url: '/gen/scheme/gen-menu',
    method: 'post',
    data: obj
  })
}

export function genCode(obj) {
  return request({
    url: '/gen/scheme/gen-code',
    method: 'put',
    data: obj
  })
}

export function previewCode(id) {
  return request({
    url: '/gen/scheme/preview/' + id,
    method: 'get'
  })
}

export default { save, del, get, genMenu, genCode, previewCode, findFormData }

