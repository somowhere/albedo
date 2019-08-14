import request from '@/router/axios'

export function getMetrics() {
  return request({
    url: `/management/metrics`,
    method: 'get'
  })
}

export function threadDump() {
  return request({
    url: '../management/dump',
    method: 'get'
  })
}
