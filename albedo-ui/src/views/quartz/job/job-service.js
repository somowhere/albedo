import request from '@/router/axios';
import validate from "@/util/validate";

let beforeCronValue = {};
const jobService = {
  page(query) {
    return request({
      url: '/quartz/job/',
      method: 'get',
      params: query
    })
  },

  save(obj) {
    return request({
      url: '/quartz/job/',
      method: 'post',
      data: obj
    })
  },

  find(id) {
    return request({
      url: '/quartz/job/' + id,
      method: 'get'
    })
  },

  remove(id) {
    return request({
      url: '/quartz/job/' + id,
      method: 'delete'
    })
  },

  run(id) {
    return request({
      url: '/quartz/job/run/' + id,
      method: 'post'
    })
  },

  concurrent(id) {
    return request({
      url: '/quartz/job/concurrent/' + id,
      method: 'post'
    })
  },

  available(id) {
    return request({
      url: '/quartz/job/available/' + id,
      method: 'post'
    })
  },


  validateUnique(rule, value, callback, id) {
    validate.isUnique(rule, value, callback, '/quartz/job/checkByProperty?id=' + util.objToStr(id))
  },
  validateCronExpression(rule, value, callback) {
    if (validate.checkNotNull(value) && value != beforeCronValue[rule.field]) {
      let url = '/quartz/job/check-cron-expression' + rule.field + '=' + value;
      request({
        url: url,
        method: 'get'
      }).then(rs => {
        beforeCronValue[rule.field] = value;
        if (!rs) {
          callback(new Error(validate.checkNotNull(rule.message) ? rule.message : "cron表达式不合法"))
        } else {
          callback()
        }
      });
    } else {
      callback()
    }
  }
};

export default jobService
