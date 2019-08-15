import request from '@/router/axios';

export function pageLogLogin(query) {
  return request({
    url: '/sys/log-login/',
    method: 'get',
    params: query
  })
}

export function exportLogLogin(query) {
  return request({
    url: '/sys/log-login/export',
    method: 'get',
    params: query
  })
}
export function removeLogLogin(id) {
  return request({
    url: '/sys/log-login/' + id,
    method: 'delete'
  })
}

