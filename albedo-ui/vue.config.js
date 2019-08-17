/**
 * 配置该文件可以参考:
 * https://cli.vuejs.org/zh/config/#%E7%9B%AE%E6%A0%87%E6%B5%8F%E8%A7%88%E5%99%A8
 *
 */
const url = 'http://localhost:8061'
// 基础路径，发布前修改这里,当前配置打包出来的资源都是相对路径
let publicPath = './'
module.exports = {
  publicPath: publicPath,
  lintOnSave: true,
  productionSourceMap: false,
  chainWebpack: config => {
    // 忽略的打包文件
    config.externals({
      'vue': 'Vue',
      'vue-router': 'VueRouter',
      'vuex': 'Vuex',
      'axios': 'axios',
      'element-ui': 'ELEMENT'
    })
    const entry = config.entry('app')
    entry
      .add('babel-polyfill')
      .end()
    entry
      .add('classlist-polyfill')
      .end()
  },
  // 配置转发代理
  devServer: {
    proxy: {
      '/a/': {
        target: url + '/a',
        ws: true,
        pathRewrite: {
          '^/a': '/'
        }
      },
      '/management': {
        target: url,
        ws: true,
        pathRewrite: {
          '^/management': '/management'
        }
      }
    }
  }
}
