import Vue from 'vue'

Vue.config.errorHandler = function (err, vm, info) {
  Vue.nextTick(() => {
    if (process.env.NODE_ENV === 'development') {
      console.group('>>>>>> 错误信息 >>>>>>')
      console.log(info)
      console.groupEnd()
      console.group('>>>>>> Vue 实例 >>>>>>')
      console.log(vm)
      console.groupEnd()
      console.group('>>>>>> Error >>>>>>')
      console.log(err)
      console.groupEnd()
    }
  })
}
