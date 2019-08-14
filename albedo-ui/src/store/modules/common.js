import {getStore, removeStore, setStore} from '@/util/store'
import website from '@/const/website'

const common = {

  state: {
    isCollapse: false,
    isFullScreen: false,
    isShade: false,
    screen: -1,
    isLock: getStore({name: 'isLock'}) || false,
    showTag: true,
    showCollapse: true,
    showFullScren: true,
    website: website
  },
  actions: {},
  mutations: {
    SET_SHADE: (state, active) => {
      state.isShade = active
    },
    SET_COLLAPSE: (state) => {
      state.isCollapse = !state.isCollapse
    },
    SET_FULLSCREN: (state) => {
      state.isFullScreen = !state.isFullScreen
    },
    SET_SHOWCOLLAPSE: (state, active) => {
      state.showCollapse = active
      setStore({
        name: 'showCollapse',
        content: state.showCollapse
      })
    },
    SET_SHOWTAG: (state, active) => {
      state.showTag = active
      setStore({
        name: 'showTag',
        content: state.showTag
      })
    },
    SET_SHOWMENU: (state, active) => {
      state.showMenu = active
      setStore({
        name: 'showMenu',
        content: state.showMenu
      })
    },
    SET_SHOWLOCK: (state, active) => {
      state.showLock = active
      setStore({
        name: 'showLock',
        content: state.showLock
      })
    },
    SET_SHOWSEARCH: (state, active) => {
      state.showSearch = active
      setStore({
        name: 'showSearch',
        content: state.showSearch
      })
    },
    SET_SHOWFULLSCREN: (state, active) => {
      state.showFullScren = active
      setStore({
        name: 'showFullScren',
        content: state.showFullScren
      })
    },
    SET_SHOWDEBUG: (state, active) => {
      state.showDebug = active
      setStore({
        name: 'showDebug',
        content: state.showDebug
      })
    },
    SET_SHOWTHEME: (state, active) => {
      state.showTheme = active
      setStore({
        name: 'showTheme',
        content: state.showTheme
      })
    },
    SET_SHOWCOLOR: (state, active) => {
      state.showColor = active
      setStore({
        name: 'showColor',
        content: state.showColor
      })
    },
    SET_LOCK: (state) => {
      state.isLock = true
      setStore({
        name: 'isLock',
        content: state.isLock,
        type: 'session'
      })
    },
    SET_SCREEN: (state, screen) => {
      state.screen = screen
    },
    SET_THEME: (state, color) => {
      state.theme = color
      setStore({
        name: 'theme',
        content: state.theme
      })
    },
    SET_THEME_NAME: (state, themeName) => {
      state.themeName = themeName
      setStore({
        name: 'themeName',
        content: state.themeName
      })
    },
    SET_LOCK_PASSWD: (state, lockPasswd) => {
      state.lockPasswd = lockPasswd
      setStore({
        name: 'lockPasswd',
        content: state.lockPasswd,
        type: 'session'
      })
    },
    CLEAR_LOCK: (state) => {
      state.isLock = false
      state.lockPasswd = ''
      removeStore({
        name: 'lockPasswd'
      })
      removeStore({
        name: 'isLock'
      })
    }
  }
}
export default common
