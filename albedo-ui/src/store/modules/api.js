const baseUrl = process.env.VUE_APP_BASE_URL
const api = {
  state: {
    // 实时控制台
    socketApi: baseUrl + '/websocket?token=kl',
    // swagger
    swaggerApi: baseUrl + '/swagger-ui/index.html',
    // 文件上传
    fileUploadApi: process.env.VUE_APP_BASE_API + '/file/upload',
    // baseUrl，
    baseUrl: baseUrl,
    // baseApi，
    baseApi: process.env.VUE_APP_BASE_API
  }
}

export default api
