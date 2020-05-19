import request from '@/utils/request'
import qs from 'qs'

export function save(data) {
  return request({
    url: '/quartz/job',
    method: 'post',
    data
  })
}

export function del(ids) {
  return request({
    url: '/quartz/job',
    method: 'delete',
    data: ids
  })
}

export function page(params) {
  return request({
    url: '/quartz/job/?' + qs.stringify(params, { indices: false }),
    method: 'get'
  })
}

export function get(id) {
  return request({
    url: '/quartz/job/' + id,
    method: 'get'
  })
}

export function updateStatus(ids) {
  return request({
    url: '/quartz/job/update-status',
    method: 'put',
    data: ids
  })
}

export function run(ids) {
  return request({
    url: '/quartz/job/run/',
    method: 'put',
    data: ids
  })
}

export function downloadLog(params) {
  return request({
    url: '/quartz/job-log/download?' + qs.stringify(params, { indices: false }),
    method: 'get',
    responseType: 'blob'
  })
}
export default { page, del, updateStatus, run, save, get, downloadLog }
