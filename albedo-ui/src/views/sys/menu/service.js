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

export function GetUserMenu() {
  return request({
    url: '/sys/menu/user-menu',
    method: 'get'
  })
}

export function fetchMenuTree(query) {
  return request({
    url: '/sys/menu/tree',
    method: 'get',
    params: query
  })
}

export function pageMenu(query) {
  return request({
    url: '/sys/menu/',
    method: 'get',
    params: query
  })
}

export function saveMenu(obj) {
  return request({
    url: '/sys/menu/',
    method: 'post',
    data: obj
  })
}

export function findMenu(id) {
  return request({
    url: '/sys/menu/' + id,
    method: 'get'
  })
}

export function removeMenu(id) {
  return request({
    url: '/sys/menu/' + id,
    method: 'delete'
  })
}

export function lockMenu(id) {
  return request({
    url: '/sys/menu/' + id,
    method: 'put'
  })
}
