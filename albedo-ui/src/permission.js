/**
 * 全站权限配置
 *
 */
import router from './router/router'
import store from '@/store'
import {validateNull} from '@/util/validate'
import NProgress from 'nprogress' // progress bar
import 'nprogress/nprogress.css'
import {validateNotNull} from "./util/validate"; // progress bar style
NProgress.configure({showSpinner: false});
const lockPage = store.getters.website.lockPage; // 锁屏页

/**
 * 导航守卫，相关内容可以参考:
 * https://router.vuejs.org/zh/guide/advanced/navigation-guards.html
 */
router.beforeEach((to, from, next) => {
  // 缓冲设置
  if (to.meta.keepAlive === true && store.state.tags.tagList.some(ele => {
    return ele.value === to.fullPath
  })) {
    to.meta.$keepAlive = true
  } else {
    NProgress.start();
    if (to.meta.keepAlive === true && validateNull(to.meta.$keepAlive)) {
      to.meta.$keepAlive = true
    } else {
      to.meta.$keepAlive = false
    }
  }
  const meta = to.meta || {};
  let addTag = function () {
    const value = to.query.src || to.fullPath;
    const label = to.query.label || to.name;
    if (meta.isTab !== false && !validateNull(value) && !validateNull(label)) {
      store.commit('ADD_TAG', {
        label: label,
        value: value,
        params: to.params,
        query: to.query,
        group: router.$avueRouter.group || []
      })
    }
  };
  if (!(to.path === '/login')) {
    if (validateNull(store.getters.userVo)) {
      store.dispatch('GetUserVo').then(() => {
        if (validateNotNull(store.getters.userVo)) {
          if (to.path === '/login') {
            next({path: '/'})
          } else {
            addTag();
            next()
          }
        } else {
          if (meta.isAuth === false) {
            addTag();
            next()
          } else {
            next('/login')
          }
        }
      }).catch((e) => {
        store.dispatch('FedLogOut').then(() => {
          next({path: '/login'})
        })
      })
    } else {
      addTag();
      next()
    }
  } else {
    if (validateNull(store.getters.userVo)) {
      addTag();
      next()
    } else {
      next({path: '/'})
    }
  }

});

router.afterEach(() => {
  NProgress.done();
  const title = store.getters.tag.label;
  router.$avueRouter.setTitle(title)
});
