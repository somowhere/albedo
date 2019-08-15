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

const scope = 'server';

// export const loginByUsername = (username, password, code, randomStr) => {
//   const grant_type = 'password'
//
//   return request({
//     url: '/auth/oauth/token',
//     headers: {
//       isToken:false,
//       'Authorization': 'Basic YWxiZWRvOmFsYmVkbw=='
//     },
//     method: 'post',
//     params: { username, password, randomStr, code, grant_type, scope }
//   })
// }
//
// export const refreshToken = (refresh_token) => {
//   const grant_type = 'refresh_token'
//   return request({
//     url: '/auth/oauth/token',
//     headers: {
//       'isToken': false,
//       'Authorization': 'Basic YWxiZWRvOmFsYmVkbw==',
//     },
//     method: 'post',
//     params: { refresh_token, grant_type, scope }
//   })
// }

const loginApi = {
  getDicts() {
    return request({
      url: '/sys/dict/codes',
      method: 'get'
    })
  },
  refreshToken() {
    return request({
      url: '/refresh-token',
      method: 'get'
    })
  },
  loginByUsername(user) {
    return request({
      url: '/authenticate',
      method: 'post',
      params: user
    })
  },
  getUserVo() {
    return request({
      url: '/sys/user/info',
      method: 'get'
    })
  },
  logout() {
    return request({
      url: '/logout',
      method: 'post'
    })
  }
};
export {loginApi}

