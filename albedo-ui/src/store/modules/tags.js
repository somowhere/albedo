import storeApi from '@/util/store'
import util from '@/util/util'
import website from '@/const/website'

const isFirstPage = website.isFirstPage;
const tagWel = website.fistPage;
const tagObj = {
  label: '', // 标题名称
  value: '', // 标题的路径
  params: '', // 标题的路径参数
  query: '', // 标题的参数
  group: [] // 分组
};

// 处理首个标签
function setFistTag(list) {
  if (list.length == 1) {
    list[0].close = false
  } else {
    list.forEach(ele => {
      if (ele.value === tagWel.value && isFirstPage === false) {
        ele.close = false
      } else {
        ele.close = true
      }
    })
  }
}

const navs = {
  state: {
    tagList: storeApi.get({name: 'tagList'}) || [],
    tag: storeApi.get({name: 'tag'}) || tagObj,
    tagWel: tagWel
  },
  actions: {},
  mutations: {
    ADD_TAG: (state, action) => {
      state.tag = action;
      storeApi.set({name: 'tag', content: state.tag, type: 'session'});
      if (state.tagList.some(ele => util.diff(ele, action))) return;
      let exit = false;
      if (action.value.indexOf('?') != -1) {
        let substr = function (item) {
          let rs = item.value;
          if (rs.indexOf('?') != -1) {
            rs = rs.substring(0, rs.indexOf('?'))
          }
          return rs;
        };
        state.tagList.forEach(item => {
          if (substr(item) === substr(action)) {
            item.value = action.value;
            exit = true;
          }
        })
      }
      if (!exit) {
        state.tagList.push(action)
      }
      setFistTag(state.tagList);
      storeApi.set({name: 'tagList', content: state.tagList, type: 'session'})
    },
    DEL_TAG: (state, action) => {
      state.tagList = state.tagList.filter(item => {
        return !util.diff(item, action)
      });
      setFistTag(state.tagList);
      storeApi.set({name: 'tagList', content: state.tagList, type: 'session'})
    },
    DEL_ALL_TAG: (state) => {
      state.tagList = [state.tagWel];
      storeApi.set({name: 'tagList', content: state.tagList, type: 'session'})
    },
    DEL_TAG_OTHER: (state) => {
      state.tagList = state.tagList.filter(item => {
        if (item.value === state.tag.value) {
          return true;
        } else if (!website.isFirstPage && item.value === website.fistPage.value) {
          return true;
        }
      });
      setFistTag(state.tagList);
      storeApi.set({name: 'tagList', content: state.tagList, type: 'session'})
    }
  }
};
export default navs
