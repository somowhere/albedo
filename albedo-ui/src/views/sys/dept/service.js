/*
 *    Copyright (c) 2018-2025, lengleng All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * Redistributions of source code must retain the above copyright notice,
 * this list of conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright
 * notice, this list of conditions and the following disclaimer in the
 * documentation and/or other materials provided with the distribution.
 * Neither the name of the pig4cloud.com developer nor the names of its
 * contributors may be used to endorse or promote products derived from
 * this software without specific prior written permission.
 * Author: lengleng (wangiegie@gmail.com)
 */

import request from '@/router/axios'

export function fetchDeptTree(query) {
  return request({
    url: '/sys/dept/user-tree',
    method: 'get',
    params: query
  })
}

export function fetchTree(query) {
  return request({
    url: '/sys/dept/tree',
    method: 'get',
    params: query
  })
}

export function saveDept(obj) {
  return request({
    url: '/sys/dept/',
    method: 'post',
    data: obj
  })
}

export function getDept(id) {
  return request({
    url: '/sys/dept/' + id,
    method: 'get'
  })
}

export function removeDept(id) {
  return request({
    url: '/sys/dept/' + id,
    method: 'delete'
  })
}

export function lockDept(obj) {
  return request({
    url: '/sys/dept',
    method: 'put',
    data: obj
  })
}
