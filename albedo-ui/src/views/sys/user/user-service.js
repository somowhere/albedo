import request from '@/utils/request'
import { encrypt } from '@/utils/rsaEncrypt'
import qs from 'qs'

export function save(obj) {
  return request({
    url: '/sys/user/',
    method: 'post',
    data: obj
  })
}

export function del(ids) {
  return request({
    url: '/sys/user/',
    method: 'delete',
    data: ids
  })
}

export function page(params) {
  return request({
    url: '/sys/user/?' + qs.stringify(params, { indices: false }),
    method: 'get'
  })
}

export function get(id) {
  return request({
    url: '/sys/user/' + id,
    method: 'get'
  })
}

export function lock(ids) {
  return request({
    url: '/sys/user/',
    method: 'put',
    data: ids
  })
}

export function download(params) {
  return request({
    url: '/sys/user/download?' + qs.stringify(params, { indices: false }),
    method: 'get',
    responseType: 'blob'
  })
}

export function editUser(data) {
  return request({
    url: '/sys/user/center',
    method: 'put',
    data
  })
}

export function updatePass(user) {
  const data = {
    oldPass: encrypt(user.oldPass),
    newPass: encrypt(user.newPass)
  }
  return request({
    url: '/sys/user/updatePass/',
    method: 'post',
    data
  })
}

export function updateEmail(form) {
  const data = {
    password: encrypt(form.pass),
    email: form.email
  }
  return request({
    url: '/sys/user/updateEmail/' + form.code,
    method: 'post',
    data
  })
}

export default { page, save, lock, del, get, download }

