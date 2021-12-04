import commonUtil from '@/utils/common'
import commonService from '@/api/common'
import storeApi from '@/utils/store'
import { MSG_TYPE_SUCCESS } from '@/const/common'
import validate from '../../utils/validate'

const user = {
  state: {
    user: {},
    roles: [],
    tenant: storeApi.get({
      name: 'tenant'
    }) || '',
    permissions: [],
    loginSuccess: storeApi.get({
      name: 'loginSuccess'
    }) || false,
    requestAuthenticate: false
  },

  mutations: {
    SET_USER: (state, user) => {
      state.user = user
    },
    SET_TENANT: (state, tenant) => {
      state.tenant = tenant
      storeApi.set({
        name: 'tenant',
        content: state.tenant,
        type: 'session'
      })
    },
    SET_ROLES: (state, roles) => {
      state.roles = roles
    },
    SET_PERMISSIONS: (state, permissions) => {
      state.permissions = permissions
    },
    SET_REQUEST_AUTHENTICATE: (state, requestAuthenticate) => {
      state.requestAuthenticate = requestAuthenticate
    },
    SET_LOGIN_SUCCESS: (state, loginSuccess) => {
      state.loginSuccess = loginSuccess
      storeApi.set({
        name: 'loginSuccess',
        content: state.loginSuccess,
        type: 'session'
      })
    }
  },

  actions: {
    // 登录
    Login({ commit }, user) {
      commit('SET_TENANT', user.tenant)
      const params = commonUtil.encryption({
        data: user,
        key: 'somewhere-albedo',
        param: ['password']
      })
      return new Promise((resolve, reject) => {
        commonService.login(params).then(res => {
          if (res.code === MSG_TYPE_SUCCESS) {
            commit('SET_LOGIN_SUCCESS', true)
            resolve()
          }
        }).catch(error => {
          reject(error)
        })
      })
    },
    // 获取用户信息
    isAuthenticate({ commit }) {
      return new Promise((resolve, reject) => {
        commonService.isAuthenticate().then((res) => {
          if (validate.checkNotNull(res.data)) {
            commit('SET_LOGIN_SUCCESS', true)
          }
          commit('SET_REQUEST_AUTHENTICATE', true)
          resolve()
        }).catch((err) => {
          reject(err)
        })
      })
    },
    // 获取用户信息
    GetUser({ commit }) {
      return new Promise((resolve, reject) => {
        commonService.getUser().then((res) => {
          const data = res.data || {}
          setUserInfo(data, commit)
          resolve(data)
        }).catch((err) => {
          reject(err)
        })
      })
    },
    // 登出
    LogOut({ commit }) {
      return new Promise((resolve, reject) => {
        commonService.logout().then(res => {
          logOut(commit)
          resolve()
        }).catch(error => {
          logOut(commit)
          reject(error)
        })
      })
    }
  }
}

export const logOut = (commit) => {
  commit('SET_LOGIN_SUCCESS', false)
  commit('SET_USER', {})
  commit('SET_ROLES', [])
  commit('SET_PERMISSIONS', [])
}

export const setUserInfo = (res, commit) => {
  commit('SET_USER', res.user)
  commit('SET_ROLES', res.roles || [])
  commit('SET_PERMISSIONS', res.permissions || [])
}

export default user
