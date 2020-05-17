import request from '@/utils/request'

export function del(ids) {
  return request({
    url: '/sys/persistent-token',
    method: 'delete',
    data: ids
  })
}

export default { del }
