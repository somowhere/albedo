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

export function pageRole(query) {
  return request({
    url: '/sys/role/',
    method: 'get',
    params: query
  })
}

export function deptRoleList() {
  return request({
    url: '/sys/role/combo-data',
    method: 'get'
  })
}

export function findRole(id) {
  return request({
    url: '/sys/role/' + id,
    method: 'get'
  })
}

export function saveRole(obj) {
  return request({
    url: '/sys/role',
    method: 'post',
    data: obj
  })
}

export function removeRole(id) {
  return request({
    url: '/sys/role/' + id,
    method: 'delete'
  })
}

export function permissionUpd(roleId, menuIds) {
  return request({
    url: '/sys/role/menu',
    method: 'put',
    params: {
      roleId: roleId,
      menuIds: menuIds
    }
  })
}

export function fetchRoleTree(roleName) {
  return request({
    url: '/sys/menu/tree/' + roleName,
    method: 'get'
  })
}

export function lockRole(id) {
  return request({
    url: '/sys/role/' + id,
    method: 'put'
  })
}
