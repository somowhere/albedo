import request from '@/router/axios';
import {isValidateUnique, toStr} from "@/util/validate";

export function pageJobLog(query) {
  return request({
    url: '/quartz/job-log/',
    method: 'get',
    params: query
  })
}

export function saveJobLog(obj) {
  return request({
    url: '/quartz/job-log/',
    method: 'post',
    data: obj
  })
}

export function findJobLog(id) {
  return request({
    url: '/quartz/job-log/' + id,
    method: 'get'
  })
}

export function removeJobLog(id) {
  return request({
    url: '/quartz/job-log/' + id,
    method: 'delete'
  })
}

export function validateUniqueJobLog(rule, value, callback, id) {
  isValidateUnique(rule, value, callback, '/quartz/job-log/checkByProperty?id='+toStr(id))
}