import request from '@/utils/request'
import qs from 'qs'

export function page(params) {
  return request({
    url: '/gen/scheme/?' + qs.stringify(params, { indices: false }),
    method: 'get'
  })
}
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

export default { page, save, del, get, genMenu, genCode, previewCode, findFormData }

