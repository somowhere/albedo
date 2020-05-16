import request from '@/utils/request'

export function getDicts(query) {
  return request({
    url: '/sys/dict/tree',
    method: 'get',
    params: query
  })
}
export function pageDict(params) {
  return request({
    url: '/sys/dict/',
    method: 'get',
    params
  })
}

export function get(id) {
  return request({
    url: '/sys/dict/' + id,
    method: 'get'
  })
}

export function save(data) {
  return request({
    url: '/sys/dict',
    method: 'post',
    data
  })
}

export function del(ids) {
  return request({
    url: '/sys/dict',
    method: 'delete',
    data: ids
  })
}

export function lock(ids) {
  return request({
    url: '/sys/dict',
    method: 'put',
    data: ids
  })
}

export default { save, lock, del, get, getDicts, pageDict }
