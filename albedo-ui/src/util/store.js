import validate from '@/util/validate'
import website from '@/const/website'

const keyName = website.key + '-';
const storeApi = {
  /**
   * 存储localStorage
   */
  set(params = {}) {
    let {
      name,
      content,
      type,
    } = params;
    name = keyName + name;
    let obj = {
      dataType: typeof (content),
      content: content,
      type: type,
      datetime: new Date().getTime()
    };
    if (type) window.sessionStorage.setItem(name, JSON.stringify(obj));
    else window.localStorage.setItem(name, JSON.stringify(obj));
  },
  /**
   * 获取localStorage
   */

  get(params = {}) {
    let {
      name,
      debug
    } = params;
    name = keyName + name;
    let obj = {},
      content;
    obj = window.sessionStorage.getItem(name);
    if (validate.checkNull(obj)) obj = window.localStorage.getItem(name);
    if (validate.checkNull(obj)) return;
    try {
      obj = JSON.parse(obj);
    } catch {
      return obj;
    }
    if (debug) {
      return obj;
    }
    if (obj.dataType == 'string') {
      content = obj.content;
    } else if (obj.dataType == 'number') {
      content = Number(obj.content);
    } else if (obj.dataType == 'boolean') {
      content = eval(obj.content);
    } else if (obj.dataType == 'object') {
      content = obj.content;
    }
    return content;
  },
  /**
   * 删除localStorage
   */
  remove(params = {}) {
    let {
      name,
      type
    } = params;
    name = keyName + name;
    if (type) {
      window.sessionStorage.removeItem(name);
    } else {
      window.localStorage.removeItem(name);
    }

  },

  /**
   * 获取全部localStorage
   */
  getAll(params = {}) {
    let list = [];
    let {
      type
    } = params;
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
            name: window.localStorage.key(i),
          })
        })

      }
    }
    return list;

  },

  /**
   * 清空全部localStorage
   */
  clear(params = {}) {
    let {type} = params;
    if (type) {
      window.sessionStorage.clear();
    } else {
      window.localStorage.clear()
    }

  }
};
export default storeApi
