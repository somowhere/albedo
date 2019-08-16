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

const roleService = {
  page(query) {
    return request({
      url: '/sys/role/',
      method: 'get',
      params: query
    })
  },

  deptRoleList() {
    return request({
      url: '/sys/role/combo-data',
      method: 'get'
    })
  },

  find(id) {
    return request({
      url: '/sys/role/' + id,
      method: 'get'
    })
  },

  save(obj) {
    return request({
      url: '/sys/role',
      method: 'post',
      data: obj
    })
  },

  remove(id) {
    return request({
      url: '/sys/role/' + id,
      method: 'delete'
    })
  },

  fetchRoleTree(roleName) {
    return request({
      url: '/sys/menu/tree/' + roleName,
      method: 'get'
    })
  },

  lock(id) {
    return request({
      url: '/sys/role/' + id,
      method: 'put'
    })
  }
};
export default roleService
