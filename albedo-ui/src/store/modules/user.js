import {getStore, setStore} from '@/util/store'
import validate from '@/util/validate'
import {loginApi} from '@/api/login'
import util from '@/util/util'
import webiste from '@/const/website'
import menuService from '@/views/sys/menu/menu-service'

function addPath(ele, first) {
  const propsConfig = webiste.menu.props;
  const propsDefault = {
    label: propsConfig.label || 'label',
    path: propsConfig.path || 'path',
    icon: propsConfig.icon || 'icon',
    children: propsConfig.children || 'children'
  };
  const isChild = ele[propsDefault.children] && ele[propsDefault.children].length !== 0;
  if (!isChild && first) {
    ele[propsDefault.path] = ele[propsDefault.path] + '/index';
    return
  }
  ele[propsDefault.children].forEach(child => {
    if (!validate.isURL(child[propsDefault.path])) {
      child[propsDefault.path] = `${ele[propsDefault.path]}/${child[propsDefault.path] ? child[propsDefault.path] : 'index'}`
    }
    addPath(child)
  })
}

const user = {
  state: {
    user: getStore({
      name: 'user'
    }) || {},
    permissions: getStore({
      name: 'permissions'
    }) || {},
    dicts: getStore({
      name: 'dicts'
    }) || [],
    roles: getStore({
      name: 'roles'
    }) || [],
    menu: getStore({
      name: 'menu'
    }) || [],
    menuAll: [],
    expires_in: getStore({
      name: 'expires_in'
    }) || '',
    access_token: getStore({
      name: 'access_token'
    }) || '',
    refresh_token: getStore({
      name: 'refresh_token'
    }) || ''
  },
  actions: {
    // 根据用户名登录
    loginByUsername({commit}, user) {
      const params = util.encryption({
        data: user,
        key: 'somewhere-albedo',
        param: ['password']
      });
      return new Promise((resolve, reject) => {
        loginApi.loginByUsername(params).then(response => {
          const data = response.data || {};
          // commit('SET_ACCESS_TOKEN', data.access_token)
          // commit('SET_REFRESH_TOKEN', response.refresh_token)
          // commit('SET_EXPIRES_IN', data.expires_in)
          commit('CLEAR_LOCK');
          resolve()
        }).catch(error => {
          reject(error)
        })
      })
    },
    getUser({commit}) {
      return new Promise((resolve, reject) => {
        loginApi.getUser().then((res) => {
          const data = res.data || {};
          commit('SET_USERVO', data.user);
          commit('SET_ROLES', data.roles || []);
          commit('SET_PERMISSIONS', data.permissions || []);
          resolve(data)
        }).catch((err) => {
          reject()
        })
      })
    },
    // 刷新token
    refreshToken({commit, state}) {
      return new Promise((resolve, reject) => {
        loginApi.refreshToken(state.refresh_token).then(response => {
          const data = response.data;
          commit('SET_ACCESS_TOKEN', data.access_token);
          // commit('SET_REFRESH_TOKEN', data.refresh_token)
          commit('SET_EXPIRES_IN', data.expires_in);
          commit('CLEAR_LOCK');
          resolve()
        }).catch(error => {
          reject(error)
        })
      })
    },
    // 登出
    logOut({commit}) {
      return new Promise((resolve, reject) => {
        loginApi.logout().then(() => {
          commit('SET_MENU', []);
          commit('SET_DICTS', []);
          commit('SET_PERMISSIONS', []);
          commit('SET_USERVO', {});
          commit('SET_ACCESS_TOKEN', '');
          // commit('SET_REFRESH_TOKEN', '')
          commit('SET_EXPIRES_IN', '');
          commit('SET_ROLES', []);
          commit('DEL_ALL_TAG');
          commit('CLEAR_LOCK');
          resolve()
        }).catch(error => {
          reject(error)
        })
      })
    },
    // 注销session
    fedLogOut({commit}) {
      return new Promise(resolve => {
        commit('SET_MENU', []);
        commit('SET_DICTS', []);
        commit('SET_PERMISSIONS', []);
        commit('SET_USERVO', {});
        commit('SET_ACCESS_TOKEN', '');
        commit('SET_REFRESH_TOKEN', '');
        commit('SET_ROLES', []);
        commit('DEL_ALL_TAG');
        commit('CLEAR_LOCK');
        resolve()
      })
    },
    // 获取系统菜单
    getUserMenu({
                  commit
                }) {
      return new Promise(resolve => {
        menuService.getUser().then((res) => {
          const data = res.data;
          let menu = util.deepClone(data);
          menu.forEach(ele => {
            addPath(ele)
          });
          commit('SET_MENU', menu);
          resolve(menu)
        })
      })
    },
    // 获取系统菜单
    async getDicts({commit}) {
      let res = await loginApi.getDicts();
      commit('SET_DICTS', res.data)
    }

  },
  mutations: {
    SET_ACCESS_TOKEN: (state, access_token) => {
      state.access_token = access_token;
      setStore({
        name: 'access_token',
        content: state.access_token,
        type: 'session'
      })
    },
    SET_EXPIRES_IN: (state, expires_in) => {
      state.expires_in = expires_in;
      setStore({
        name: 'expires_in',
        content: state.expires_in,
        type: 'session'
      })
    },
    SET_REFRESH_TOKEN: (state, rfToken) => {
      state.refresh_token = rfToken;
      setStore({
        name: 'refresh_token',
        content: state.refresh_token,
        type: 'session'
      })
    },
    SET_USERVO: (state, user) => {
      state.user = user;
      setStore({
        name: 'user',
        content: state.user,
        type: 'session'
      })
    },
    SET_DICTS: (state, dicts) => {
      state.dicts = dicts;
      setStore({
        name: 'dicts',
        content: state.dicts,
        type: 'session'
      })
    },
    SET_MENU: (state, menu) => {
      state.menu = menu;
      setStore({
        name: 'menu',
        content: state.menu,
        type: 'session'
      })
    },
    SET_MENU_ALL: (state, menuAll) => {
      state.menuAll = menuAll
    },
    SET_ROLES: (state, roles) => {
      state.roles = roles;
      setStore({
        name: 'roles',
        content: state.roles,
        type: 'session'
      })
    },
    SET_PERMISSIONS: (state, permissions) => {
      const list = {};
      for (let i = 0; i < permissions.length; i++) {
        list[permissions[i]] = true
      }
      state.permissions = list;
      setStore({
        name: 'permissions',
        content: state.permissions,
        type: 'session'
      })
    }
  }

};
export default user
