import validate from '@/utils/validate'
import Config from '@/settings'

const keyName = Config.key + '-'
const evil = function(fn) {
  const Fn = Function
  return new Fn('return ' + fn)()
}
const storeApi = {
  /**
   * 存储localStorage
   */
  set(params = {}) {
    const {
      name,
      content,
      type
    } = params
    const realName = keyName + name
    const obj = {
      dataType: typeof (content),
      content: content,
      type: type,
      datetime: new Date().getTime()
    }
    if (type) window.sessionStorage.setItem(realName, JSON.stringify(obj))
    else window.localStorage.setItem(realName, JSON.stringify(obj))
  },
  /**
   * 获取localStorage
   */

  get(params = {}) {
    const {
      name,
      debug
    } = params
    const realName = keyName + name
    let obj = {}
    let content
    obj = window.sessionStorage.getItem(realName)
    if (validate.checkNull(obj)) obj = window.localStorage.getItem(realName)
    if (validate.checkNull(obj)) return
    try {
      obj = JSON.parse(obj)
    } catch {
      return obj
    }
    if (debug) {
      return obj
    }
    if (obj.dataType === 'string') {
      content = obj.content
    } else if (obj.dataType === 'number') {
      content = Number(obj.content)
    } else if (obj.dataType === 'boolean') {
      content = evil(obj.content)
    } else if (obj.dataType === 'object') {
      content = obj.content
    }
    return content
  },
  /**
   * 删除localStorage
   */
  remove(params = {}) {
    const {
      name,
      type
    } = params
    const realName = keyName + name
    if (type) {
      window.sessionStorage.removeItem(realName)
    } else {
      window.localStorage.removeItem(realName)
    }
  },

  /**
   * 获取全部localStorage
   */
  getAll(params = {}) {
    const list = []
    const {
      type
    } = params
    if (type) {
      for (let i = 0; i <= window.sessionStorage.length; i++) {
        list.push({
          name: window.sessionStorage.key(i),
          content: this.get({
            name: window.sessionStorage.key(i),
            type: 'session'
          })
        })
      }
    } else {
      for (let i = 0; i <= window.localStorage.length; i++) {
        list.push({
          name: window.localStorage.key(i),
          content: this.get({
            name: window.localStorage.key(i)
          })
        })
      }
    }
    return list
  },

  /**
   * 清空全部localStorage
   */
  clear(params = {}) {
    const { type } = params
    if (type) {
      window.sessionStorage.clear()
    } else {
      window.localStorage.clear()
    }
  }
}
export default storeApi
