import request from '@/router/axios'

export function pageTable(query) {
  return request({
    url: '/gen/table/',
    method: 'get',
    params: query
  })
}

export function saveTable(obj) {
  return request({
    url: '/gen/table/',
    method: 'post',
    data: obj
  })
}

export function findTable(query) {
  return request({
    url: '/gen/table/form-data',
    method: 'get',
    params: query
  })
}

export function findSelectTable() {
  return request({
    url: '/gen/table/table-list',
    method: 'get'
  })
}

export function removeTable(id) {
  return request({
    url: '/gen/table/' + id,
    method: 'delete'
  })
}


