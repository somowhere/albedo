/**
 * 全站权限配置
 *
 */
import router from './router/router'
import store from '@/store'
import validate from '@/util/validate'
import NProgress from 'nprogress' // progress bar
import 'nprogress/nprogress.css'

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
    if (to.meta.keepAlive === true && validate.checkNull(to.meta.$keepAlive)) {
      to.meta.$keepAlive = true
    } else {
      to.meta.$keepAlive = false
    }
  }
  const meta = to.meta || {};
  let addTag = function () {
    const value = to.query.src || to.fullPath;
    const label = to.query.label || to.name;
    if (meta.isTab !== false && !validate.checkNull(value) && !validate.checkNull(label)) {
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
    if (validate.checkNull(store.getters.user)) {
      store.dispatch('getUser').then(() => {
        if (validate.checkNotNull(store.getters.user)) {
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
        store.dispatch('fedLogOut').then(() => {
          next({path: '/login'})
        })
      })
    } else {
      addTag();
      next()
    }
  } else {
    if (validate.checkNull(store.getters.user)) {
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
