import request from '@/router/axios'

export function changeLevelLogs(log) {
  return request({
    url: `/../management/logs`,
    method: 'put',
    data: log
  })
}

export function findAllLogs() {
  return request({
    url: '/../management/logs',
    method: 'get'
  })
}
