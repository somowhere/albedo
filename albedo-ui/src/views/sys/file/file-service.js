import request from '@/utils/request'
import qs from 'qs'

export function page(params) {
  return request({
    url: '/file/?' + qs.stringify(params, { indices: false }),
    method: 'get'
  })
}

export function del(ids) {
  return request({
    url: '/file',
    method: 'delete',
    data: ids
  })
}

export function download(ids) {
  return request({
    url: '/file/download',
    method: 'post',
    responseType: 'blob',
    data: ids
  })
}
export default { page, del, download }
