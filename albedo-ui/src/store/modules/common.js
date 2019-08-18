import storeApi from '@/util/store'
import website from '@/const/website'

const common = {

  state: {
    isCollapse: false,
    isFullScreen: false,
    isShade: false,
    screen: -1,
    isLock: storeApi.get({name: 'isLock'}) || false,
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
      state.showCollapse = active;
      storeApi.set({
        name: 'showCollapse',
        content: state.showCollapse
      })
    },
    SET_SHOWTAG: (state, active) => {
      state.showTag = active;
      storeApi.set({
        name: 'showTag',
        content: state.showTag
      })
    },
    SET_SHOWMENU: (state, active) => {
      state.showMenu = active;
      storeApi.set({
        name: 'showMenu',
        content: state.showMenu
      })
    },
    SET_SHOWLOCK: (state, active) => {
      state.showLock = active;
      storeApi.set({
        name: 'showLock',
        content: state.showLock
      })
    },
    SET_SHOWSEARCH: (state, active) => {
      state.showSearch = active;
      storeApi.set({
        name: 'showSearch',
        content: state.showSearch
      })
    },
    SET_SHOWFULLSCREN: (state, active) => {
      state.showFullScren = active;
      storeApi.set({
        name: 'showFullScren',
        content: state.showFullScren
      })
    },
    SET_SHOWDEBUG: (state, active) => {
      state.showDebug = active;
      storeApi.set({
        name: 'showDebug',
        content: state.showDebug
      })
    },
    SET_SHOWTHEME: (state, active) => {
      state.showTheme = active;
      storeApi.set({
        name: 'showTheme',
        content: state.showTheme
      })
    },
    SET_SHOWCOLOR: (state, active) => {
      state.showColor = active;
      storeApi.set({
        name: 'showColor',
        content: state.showColor
      })
    },
    SET_LOCK: (state) => {
      state.isLock = true;
      storeApi.set({
        name: 'isLock',
        content: state.isLock,
        type: 'session'
      })
    },
    SET_SCREEN: (state, screen) => {
      state.screen = screen
    },
    SET_THEME: (state, color) => {
      state.theme = color;
      storeApi.set({
        name: 'theme',
        content: state.theme
      })
    },
    SET_THEME_NAME: (state, themeName) => {
      state.themeName = themeName;
      storeApi.set({
        name: 'themeName',
        content: state.themeName
      })
    },
    SET_LOCK_PASSWD: (state, lockPasswd) => {
      state.lockPasswd = lockPasswd;
      storeApi.set({
        name: 'lockPasswd',
        content: state.lockPasswd,
        type: 'session'
      })
    },
    CLEAR_LOCK: (state) => {
      state.isLock = false;
      state.lockPasswd = '';
      storeApi.remove({
        name: 'lockPasswd'
      });
      storeApi.remove({
        name: 'isLock'
      })
    }
  }
};
export default common
