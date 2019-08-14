import Layout from '@/page/index/'

export default [{
  path: '/wel',
  component: Layout,
  redirect: '/wel/index',
  children: [{
    path: 'index',
    name: '首页',
    component: () =>
      import ( /* webpackChunkName: "views" */ '@/page/wel')
  }]
}, {
  path: '/info',
  component: Layout,
  redirect: '/info/index',
  children: [{
    path: 'index',
    name: '个人信息',
    component: () =>
      import ( /* webpackChunkName: "page" */ '@/views/sys/user/info'),
  }]
}]
