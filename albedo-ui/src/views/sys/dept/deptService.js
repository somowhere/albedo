import request from '@/utils/request'

export function getDepts(query) {
  return request({
    url: '/sys/dept/user-tree',
    method: 'get',
    params: query
  })
}

export function add(data) {
  return request({
    url: '/sys/dept',
    method: 'post',
    data
  })
}

export function del(ids) {
  return request({
    url: '/sys/dept',
    method: 'delete',
    data: ids
  })
}

export function edit(data) {
  return request({
    url: '/sys/dept',
    method: 'put',
    data
  })
}

export default { add, edit, del, getDepts }
