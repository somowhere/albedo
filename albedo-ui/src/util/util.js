import validate from './validate'

const util = {
  /**
   * 表单序列化
   * @param data
   * @returns {string}
   */
  serialize(data) {
    let list = [];
    Object.keys(data).forEach(ele => {
      list.push(`${ele}=${data[ele]}`)
    });
    return list.join('&')
  },
  /**
   *
   * @param obj
   * @returns {string|*}
   */
  getObjType(obj) {
    let toString = Object.prototype.toString;
    let map = {
      '[object Boolean]': 'boolean',
      '[object Number]': 'number',
      '[object String]': 'string',
      '[object Function]': 'function',
      '[object Array]': 'array',
      '[object Date]': 'date',
      '[object RegExp]': 'regExp',
      '[object Undefined]': 'undefined',
      '[object Null]': 'null',
      '[object Object]': 'object'
    };
    if (obj instanceof Element) {
      return 'element'
    }
    return map[toString.call(obj)]
  },
  /**
   * 对象深拷贝
   */
  deepClone(data) {
    let type = this.getObjType(data);
    let obj;
    if (type === 'array') {
      obj = []
    } else if (type === 'object') {
      obj = {}
    } else {
      // 不再具有下一层次
      return data
    }
    if (type === 'array') {
      for (let i = 0, len = data.length; i < len; i++) {
        obj.push(this.deepClone(data[i]))
      }
    } else if (type === 'object') {
      for (let key in data) {
        obj[key] = this.deepClone(data[key])
      }
    }
    return obj
  },
  /**
   * 判断路由是否相等
   * @param obj1
   * @param obj2
   * @returns {boolean|*}
   */
  diff(obj1, obj2) {
    delete obj1.close;
    let o1 = obj1 instanceof Object;
    let o2 = obj2 instanceof Object;
    if (!o1 || !o2) { /*  判断不是对象  */
      return obj1 === obj2
    }

    if (Object.keys(obj1).length !== Object.keys(obj2).length) {
      return false
      // Object.keys() 返回一个由对象的自身可枚举属性(key值)组成的数组,例如：数组返回下表：let arr = ["a", "b", "c"];console.log(Object.keys(arr))->0,1,2;
    }

    for (let attr in obj1) {
      let t1 = obj1[attr] instanceof Object;
      let t2 = obj2[attr] instanceof Object;
      if (t1 && t2) {
        return this.diff(obj1[attr], obj2[attr])
      } else if (obj1[attr] !== obj2[attr]) {
        return false
      }
    }
    return true
  },
  /**
   * 设置灰度模式
   * @param status
   */
  toggleGrayMode(status) {
    if (status) {
      document.body.className = document.body.className + ' grayMode'
    } else {
      document.body.className = document.body.className.replace(' grayMode', '')
    }
  },
  /**
   * 设置主题
   * @param name
   */
  setTheme(name) {
    document.body.className = name
  },

  /**
   * 加密处理
   * @param params
   * @returns {any}
   */
  encryption(params) {
    let {
      data,
      type,
      param,
      key
    } = params;
    const result = JSON.parse(JSON.stringify(data));
    if (type === 'Base64') {
      param.forEach(ele => {
        result[ele] = btoa(result[ele])
      })
    } else {
      param.forEach(ele => {
        let data = result[ele];
        key = CryptoJS.enc.Latin1.parse(key);
        let iv = key;
        // 加密
        let encrypted = CryptoJS.AES.encrypt(
          data,
          key, {
            iv: iv,
            mode: CryptoJS.mode.CBC,
            padding: CryptoJS.pad.ZeroPadding
          });
        result[ele] = encrypted.toString()
      })
    }
    return result
  },

  /**
   * 浏览器判断是否全屏
   */
  fullscreenToggel() {
    if (this.fullscreenEnable()) {
      this.exitFullScreen();
    } else {
      this.reqFullScreen();
    }
  },
  /**
   * esc监听全屏
   * @param callback
   */
  listenfullscreen(callback) {
    function listen() {
      callback()
    }

    document.addEventListener("fullscreenchange", function () {
      listen();
    });
    document.addEventListener("mozfullscreenchange", function () {
      listen();
    });
    document.addEventListener("webkitfullscreenchange", function () {
      listen();
    });
    document.addEventListener("msfullscreenchange", function () {
      listen();
    });
  },
  /**
   * 浏览器判断是否全屏
   */
  fullscreenEnable() {
    return document.isFullScreen || document.mozIsFullScreen || document.webkitIsFullScreen
  },

  /**
   * 浏览器全屏
   */
  reqFullScreen() {
    if (document.documentElement.requestFullScreen) {
      document.documentElement.requestFullScreen();
    } else if (document.documentElement.webkitRequestFullScreen) {
      document.documentElement.webkitRequestFullScreen();
    } else if (document.documentElement.mozRequestFullScreen) {
      document.documentElement.mozRequestFullScreen();
    }
  },
  /**
   * 浏览器退出全屏
   */
  exitFullScreen() {
    if (document.documentElement.requestFullScreen) {
      document.exitFullScreen();
    } else if (document.documentElement.webkitRequestFullScreen) {
      document.webkitCancelFullScreen();
    } else if (document.documentElement.mozRequestFullScreen) {
      document.mozCancelFullScreen();
    }
  },
  /**
   * 递归寻找子类的父类
   * @param menu
   * @param id
   * @returns {*|undefined}
   */

  findParent(menu, id) {
    for (let i = 0; i < menu.length; i++) {
      if (menu[i].children.length != 0) {
        for (let j = 0; j < menu[i].children.length; j++) {
          if (menu[i].children[j].id == id) {
            return menu[i]
          } else {
            if (menu[i].children[j].children.length != 0) {
              return this.findParent(menu[i].children[j].children, id)
            }
          }
        }
      }
    }
  },

  /**
   * 动态插入css
   * @param url
   */
  loadStyle(url) {
    const link = document.createElement('link');
    link.type = 'text/css';
    link.rel = 'stylesheet';
    link.href = url;
    const head = document.getElementsByTagName('head')[0];
    head.appendChild(link)
  },
  /**
   * 判断路由是否相等
   * @param a
   * @param b
   * @returns {boolean}
   */
  isObjectValueEqual(a, b) {
    let result = true;
    Object.keys(a).forEach(ele => {
      const type = typeof (a[ele]);
      if (type === 'string' && a[ele] !== b[ele]) result = false;
      else if (type === 'object' && JSON.stringify(a[ele]) !== JSON.stringify(b[ele])) result = false
    });
    return result
  },
  /**
   * 根据字典的value显示label
   * @param dic
   * @param value
   * @returns {string|*}
   */
  findByValue(dic, value) {
    let result = '';
    if (validate.checkNull(dic)) return value;
    if (typeof (value) === 'string' || typeof (value) === 'number' || typeof (value) === 'boolean') {
      let index = 0;
      index = this.findArray(dic, value);
      if (index != -1) {
        result = dic[index].label
      } else {
        result = value
      }
    } else if (value instanceof Array) {
      result = [];
      let index = 0;
      value.forEach(ele => {
        index = this.findArray(dic, ele);
        if (index != -1) {
          result.push(dic[index].label)
        } else {
          result.push(value)
        }
      });
      result = result.toString()
    }
    return result
  },
  /**
   * 根据字典的value查找对应的index
   * @param dic
   * @param value
   * @returns {number}
   */
  findArray(dic, value) {
    for (let i = 0; i < dic.length; i++) {
      if (dic[i].value == value) {
        return i
      }
    }
    return -1
  },
  /**
   * 生成随机len位数字
   * @param len
   * @param date
   * @returns {string}
   */
  randomLenNum(len, date) {
    let random = '';
    random = Math.ceil(Math.random() * 100000000000000).toString().substr(0, len || 4);
    if (date) random = random + Date.now();
    return random
  },

  /**
   * 表单条件json转换
   * @param formItems
   * @returns {string|null}
   */
  parseJsonItemForm(formItems) {
    let i = 0, json_list = [];
    if (validate.checkNull(formItems)) {
      return null;
    }
    let option =
      formItems.forEach(item => {
        let filterItem = {};
        if (item instanceof String) {
          filterItem = {
            format: '',
            fieldName: item,
            attrType: 'String',
            fieldNode: '',
            operate: 'like',
            weight: 0,
            value: formItems[item],
            endValue: '',
          }
        } else {
          filterItem = Object.assign({
            format: '',
            fieldName: '',
            attrType: 'String',
            fieldNode: '',
            operate: 'like',
            weight: 0,
            value: '',
            endValue: '',
          }, item)
        }

        if (validate.checkNotNull(filterItem.value)) {
          json_list[i++] = filterItem;
        }
      });
    return JSON.stringify(json_list);
  },
  /**
   * tree数据解析
   * @param dataList
   * @returns {[]}
   */
  parseTreeData(dataList) {
    let treeData = [], getChild = function (id) {
      return dataList.filter((item) => {
        return item.pid == id
      })
    }, parseData = function (item) {
      let childs = getChild(item.id);
      if (!validate.checkNull(childs)) {
        item.children = childs;
        childs.forEach(temp => {
          parseData(temp)
        })
      }
    };
    dataList.forEach(item => {
      if (item.id == 1 || validate.checkNull(item.pid) || item.pid == 0) {
        parseData(item);
        treeData.push(item)
      }
    });
    return treeData;
  },
  objToStr(val) {
    return validate.checkNotNull(val) ? val.toString() : '';
  }
};
export default util
