import request from '@/utils/request'
import qs from 'qs'

export function page(params) {
  return request({
    url: '/sys/persistent-token/?' + qs.stringify(params, { indices: false }),
    method: 'get'
  })
}

export function del(ids) {
  return request({
    url: '/sys/persistent-token',
    method: 'delete',
    data: ids
  })
}

export default { page, del }
