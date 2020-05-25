const validate = {
  /**
   * @param {string} path
   * @returns {Boolean}
   */
  isExternal(path) {
    return /^(https?:|mailto:|tel:)/.test(path)
  },

  /**
   * @param {string} str
   * @returns {Boolean}
   */
  validUsername(str) {
    const valid_map = ['admin', 'editor']
    return valid_map.indexOf(str.trim()) >= 0
  },

  /**
   * @param {string} url
   * @returns {Boolean}
   */
  validURL(url) {
    const reg = /^(https?|ftp):\/\/([a-zA-Z0-9.-]+(:[a-zA-Z0-9.&%$-]+)*@)*((25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9][0-9]?)(\.(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])){3}|([a-zA-Z0-9-]+\.)*[a-zA-Z0-9-]+\.(com|edu|gov|int|mil|net|org|biz|arpa|info|name|pro|aero|coop|museum|[a-zA-Z]{2}))(:[0-9]+)*(\/($|[a-zA-Z0-9.,?'\\+&%$#=~_-]+))*$/
    return reg.test(url)
  },

  /**
   * @param {string} str
   * @returns {Boolean}
   */
  validLowerCase(str) {
    const reg = /^[a-z]+$/
    return reg.test(str)
  },

  /**
   * @param {string} str
   * @returns {Boolean}
   */
  validUpperCase(str) {
    const reg = /^[A-Z]+$/
    return reg.test(str)
  },

  /**
   * @param {string} str
   * @returns {Boolean}
   */
  validAlphabets(str) {
    const reg = /^[A-Za-z]+$/
    return reg.test(str)
  },

  /**
   * @param {string} email
   * @returns {Boolean}
   */
  validEmail(email) {
    const reg = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
    return reg.test(email)
  },

  isvalidPhone(phone) {
    const reg = /^1[3|4|5|7|8][0-9]\d{8}$/
    return reg.test(phone)
  },

  /**
   * @param {string} str
   * @returns {Boolean}
   */
  isString(str) {
    if (typeof str === 'string' || str instanceof String) {
      return true
    }
    return false
  },

  /**
   * @param {Array} arg
   * @returns {Boolean}
   */
  isArray(arg) {
    if (typeof Array.isArray === 'undefined') {
      return Object.prototype.toString.call(arg) === '[object Array]'
    }
    return Array.isArray(arg)
  },

  /**
   * 是否合法IP地址
   * @param rule
   * @param value
   * @param callback
   */
  validateIP(rule, value, callback) {
    if (value === '' || value === undefined || value === null) {
      callback()
    } else {
      const reg = /^(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])$/
      if ((!reg.test(value)) && value !== '') {
        callback(new Error('请输入正确的IP地址'))
      } else {
        callback()
      }
    }
  },

  /* 是否手机号码或者固话*/
  validatePhoneTwo(rule, value, callback) {
    const reg = /^((0\d{2,3}-\d{7,8})|(1[34578]\d{9}))$/
    if (value === '' || value === undefined || value === null) {
      callback()
    } else {
      if ((!reg.test(value)) && value !== '') {
        callback(new Error('请输入正确的电话号码或者固话号码'))
      } else {
        callback()
      }
    }
  },

  /* 是否固话*/
  validateTelephone(rule, value, callback) {
    const reg = /0\d{2}-\d{7,8}/
    if (value === '' || value === undefined || value === null) {
      callback()
    } else {
      if ((!reg.test(value)) && value !== '') {
        callback(new Error('请输入正确的固话（格式：区号+号码,如010-1234567）'))
      } else {
        callback()
      }
    }
  },

  /* 是否手机号码*/
  validatePhone(rule, value, callback) {
    const reg = /^[1][3,4,5,7,8][0-9]{9}$/
    if (value === '' || value === undefined || value === null) {
      callback()
    } else {
      if ((!reg.test(value)) && value !== '') {
        callback(new Error('请输入正确的电话号码'))
      } else {
        callback()
      }
    }
  },

  /* 是否身份证号码*/
  validateIdNo(rule, value, callback) {
    const reg = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/
    if (value === '' || value === undefined || value === null) {
      callback()
    } else {
      if ((!reg.test(value)) && value !== '') {
        callback(new Error('请输入正确的身份证号码'))
      } else {
        callback()
      }
    }
  },

  /**
   * 判断是否为空
   */
  checkNull(val) {
    if (typeof val === 'boolean') {
      return false
    }
    if (typeof val === 'number') {
      return false
    }
    if (val instanceof Array) {
      if (val.length === 0) return true
    } else if (val instanceof Object) {
      if (JSON.stringify(val) === '{}') return true
    } else {
      if (val === 'null' || val === null || val === 'undefined' || val === undefined || val === '') return true
      return false
    }
    return false
  },

  /**
   * 判断是否为空
   */
  checkNotNull(val) {
    return !this.checkNull(val)
  },

  /**
   * 判断是否为整数
   */
  isDigits(rule, value, callback) {
    if (this.checkNotNull(value)) {
      const rs = this.checkDigits(value)
      if (rs) {
        callback(new Error(this.checkNotNull(rule.message) ? rule.message : '请输入整数'))
        return
      }
    }
    callback()
  },

  /**
   * 判断是否为整数
   */
  checkDigits(num) {
    const regName = /[^\d]/g
    if (!regName.test(num)) return false
    return true
  },

  isNumber(rule, value, callback) {
    if (this.checkNotNull(value)) {
      const rs = this.checkNumber(value)
      if (rs) {
        callback(new Error(this.checkNotNull(rule.message) ? rule.message : '请输入数字'))
        return
      }
    }
    callback()
  },

  /**
   * 判断是否为小数
   */
  checkNumber(num) {
    const regName = /[^\d.]/g
    if (!regName.test(num)) return false
    return true
  }
}

export default validate
