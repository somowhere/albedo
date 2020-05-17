import request from '@/utils/request'

export function del(ids) {
  return request({
    url: '/sys/user-online',
    method: 'delete',
    data: ids
  })
}

export function batchForceLogout(ids) {
  return request({
    url: '/sys/user-online/batch-force-logout',
    method: 'put',
    data: ids
  })
}

export default { del, batchForceLogout }
