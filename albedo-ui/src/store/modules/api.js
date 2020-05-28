const baseUrl = process.env.VUE_APP_BASE_URL
const defaultSettings = require('@/settings.js')
const api = {
  state: {
    // 实时控制台
    socketApi: baseUrl + '/websocket?token=kl',
    // 图片上传
    imagesUploadApi: baseUrl + defaultSettings.api + '/file/pictures',
    // 上传文件到七牛云
    qiNiuUploadApi: baseUrl + defaultSettings.api + '/api/qiNiuContent',
    // swagger
    swaggerApi: baseUrl + '/swagger-ui.html',
    // 文件上传
    fileUploadApi: baseUrl + defaultSettings.api + '/file/upload',
    // baseUrl，
    baseApi: baseUrl
  }
}

export default api
