import request from '@/utils/request'

// eslint-disable-next-line no-unused-vars
const commonService = {

  getDicts(codes) {
    return request({
      url: '/sys/dict/codes',
      method: 'get',
      params: codes
    })
  },
  login(user) {
    return request({
      url: '/authenticate',
      method: 'post',
      params: user
    })
  },
  getUser() {
    return request({
      url: '/sys/user/info',
      method: 'get'
    })
  },
  isAuthenticate() {
    return request({
      url: '/authenticate',
      method: 'get'
    })
  },
  logout() {
    return request({
      url: '/logout',
      method: 'post'
    })
  },

  // 查询附件
  getAttachment(data) {
    return request({
      url: '/file/attachment',
      method: 'get',
      data
    })
  },
  // 删除附件
  deleteAttachment(data) {
    return request({
      url: '/file/attachment',
      method: 'delete',
      data
    })
  },
  // 下载附件
  downloadAttachment(data) {
    return request({
      url: `/file/attachment/download`,
      method: 'get',
      responseType: 'blob',
      data
    })
  },
  // 根据业务类型/业务id打包下载
  downloadAttachmentBiz(data) {
    return request({
      url: `/file/attachment/download/biz`,
      method: 'get',
      responseType: 'blob',
      data
    })
  }
}

export default commonService
