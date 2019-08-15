import request from '@/router/axios';
import {isValidateUnique, toStr} from "@/util/validate";

export function pageJobLog(query) {
  return request({
    url: '/quartz/job-log/',
    method: 'get',
    params: query
  })
}
export function exportJobLog(query) {
  return request({
    url: '/sys/job-log/export',
    method: 'get',
    params: query
  })
}
export function cleanJobLog() {
  return request({
    url: '/sys/job-log/clean',
    method: 'get',
    params: query
  })
}
export function removeJobLog(id) {
  return request({
    url: '/quartz/job-log/' + id,
    method: 'delete'
  })
}

