const getters = {
  deployUploadApi: state => state.api.deployUploadApi,
  databaseUploadApi: state => state.api.databaseUploadApi,
  size: state => state.app.size,
  sidebar: state => state.app.sidebar,
  device: state => state.app.device,
  token: state => state.user.token,
  visitedViews: state => state.tagsView.visitedViews,
  cachedViews: state => state.tagsView.cachedViews,
  roles: state => state.user.roles,
  user: state => state.user.user,
  loadMenus: state => state.user.loadMenus,
  loginSuccess: state => state.user.loginSuccess,
  dicts: state => state.dict.dicts,
  permissions: state => state.user.permissions,
  permission_routers: state => state.permission.routers,
  addRouters: state => state.permission.addRouters,
  socketApi: state => state.api.socketApi,
  baseApi: state => state.api.baseApi,
  baseUrl: state => state.api.baseUrl,
  fileUploadApi: state => state.api.fileUploadApi,
  swaggerApi: state => state.api.swaggerApi
}
export default getters
