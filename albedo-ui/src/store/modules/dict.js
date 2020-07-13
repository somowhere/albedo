import loginService from '@/api/login'
import { MSG_TYPE_SUCCESS } from '@/const/common'

const dict = {
  state: {
    dicts: {}
  },
  mutations: {
    SET_DICTS: (state, dicts) => {
      state.dicts = dicts
    }
  },
  actions: {
    // 获取字典数据
    GetDicts({ commit }) {
      return new Promise((resolve, reject) => {
        loginService.getDicts().then(res => {
          if (res.code === MSG_TYPE_SUCCESS) {
            commit('SET_DICTS', res.data)
            resolve()
          }
        }).catch(error => {
          reject(error)
        })
      })
    }
  }
}

export default dict
