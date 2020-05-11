import store from '@/store'
import validate from "../../utils/validate";

export default {
  inserted(el, binding, vnode) {
    const { value } = binding
    const permissions = store.getters && store.getters.permissions
    if (validate.checkNotNull(value)) {
      const hasPermission = value instanceof Array ? permissions.some(item => {
        return value.includes(item)
      }) : permissions.includes(value)
      if (!hasPermission) {
        el.parentNode && el.parentNode.removeChild(el)
      }
    }
    else {
      console.log(value, el)
      throw new Error(`使用方式： v-permission="'edit'"`)
    }
  }
}
