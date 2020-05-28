import request from '@/utils/request'
import qs from 'qs'

export function save(obj) {
  return request({
    url: '/sys/user/',
    method: 'post',
    data: obj
  })
}

export function saveInfo(obj) {
  return request({
    url: '/sys/user/info',
    method: 'post',
    data: obj
  })
}

export function del(ids) {
  return request({
    url: '/sys/user/',
    method: 'delete',
    data: ids
  })
}

export function page(params) {
  return request({
    url: '/sys/user/?' + qs.stringify(params, { indices: false }),
    method: 'get'
  })
}

export function get(id) {
  return request({
    url: '/sys/user/' + id,
    method: 'get'
  })
}

export function lock(ids) {
  return request({
    url: '/sys/user/',
    method: 'put',
    data: ids
  })
}

export function download(params) {
  return request({
    url: '/sys/user/download?' + qs.stringify(params, { indices: false }),
    method: 'get',
    responseType: 'blob'
  })
}

export default { page, save, lock, del, get, download, saveInfo }

