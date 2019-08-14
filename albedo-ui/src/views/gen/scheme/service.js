import request from '@/router/axios'

export function pageGenScheme(query) {
  return request({
    url: '/gen/scheme/',
    method: 'get',
    params: query
  })
}

export function saveGenScheme(obj) {
  return request({
    url: '/gen/scheme/',
    method: 'post',
    data: obj
  })
}

export function genMenu(obj) {
  return request({
    url: '/gen/scheme/gen-menu',
    method: 'post',
    data: obj
  })
}

export function genCode(obj) {
  return request({
    url: '/gen/scheme/gen-code',
    method: 'put',
    data: obj
  })
}


export function findGenScheme(query) {
  return request({
    url: '/gen/scheme/form-data',
    method: 'get',
    params: query
  })
}

export function removeGenScheme(id) {
  return request({
    url: '/gen/scheme/' + id,
    method: 'delete'
  })
}


