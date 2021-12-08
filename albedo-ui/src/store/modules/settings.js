import variables from '@/assets/styles/element-variables.scss'
import { getLanguage } from '@/lang/index'
import defaultSettings from '@/settings'
import storeApi from '@/utils/store'

const { tagsView, fixedHeader, sidebarLogo, uniqueOpened, showFooter, footerTxt, caseNumber } = defaultSettings

const state = {
  theme: variables.theme,
  language: getLanguage(),
  showSettings: false,
  tagsView: tagsView,
  fixedHeader: fixedHeader,
  sidebarLogo: sidebarLogo,
  uniqueOpened: uniqueOpened,
  showFooter: showFooter,
  footerTxt: footerTxt,
  caseNumber: caseNumber
}

const mutations = {
  CHANGE_SETTING: (state, { key, value }) => {
    if (state.hasOwnProperty(key)) {
      console.log(key, value)
      state[key] = value
      if (key === 'language') {
        storeApi.set(
          { name: 'LANGUAGE',
            content: value,
            type: 'session' })
        console.log(storeApi.get({ name: 'LANGUAGE' }))
      }
    }
  }
}

const actions = {
  changeSetting({ commit }, data) {
    commit('CHANGE_SETTING', data)
  }
}

export default {
  namespaced: true,
  state,
  mutations,
  actions
}

