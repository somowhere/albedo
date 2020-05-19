import request from '@/utils/request'

export function get() {
  return request({
    url: '/tool/email',
    method: 'get'
  })
}

export function update(data) {
  return request({
    url: '/tool/email',
    data,
    method: 'put'
  })
}

export function send(data) {
  return request({
    url: '/tool/email',
    data,
    method: 'post'
  })
}
