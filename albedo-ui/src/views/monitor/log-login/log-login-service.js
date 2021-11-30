import request from '@/utils/request'
import qs from 'qs'

export function page(params) {
  return request({
    url: '/sys/log-login/?' + qs.stringify(params, { indices: false }),
    method: 'get'
  })
}

export function del(ids) {
  return request({
    url: '/sys/log-login',
    method: 'delete',
    data: ids
  })
}

export function download(params) {
  return request({
    url: '/sys/log-login/download?' + qs.stringify(params, { indices: false }),
    method: 'get',
    responseType: 'blob'
  })
}

export default { page, del, download }
