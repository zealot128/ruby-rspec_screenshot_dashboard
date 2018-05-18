import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)
import groupBy from 'lodash/groupBy'

const store = new Vuex.Store({
  state: {
    screenshots: []
  },
  mutations: {
    setScreenshots(state, screenshots) {
      state.screenshots = [...screenshots]
    }
  },
  getters: {
    files(state) {
      return groupBy(state.screenshots, (file) => file.test_file)
    }
  }
})
export default store
