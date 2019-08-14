import request from '@/router/axios'

export function getConfigprops() {
  return request({
    url: `/../management/configprops`,
    method: 'get'
  })
}

export function getEnv() {
  return request({
    url: '/../management/env',
    method: 'get'
  })
}
