import Vue from 'vue'
import Router from 'vue-router'
import Home from './views/Home.vue'
import File from './views/File.vue'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'home',
      component: Home
    },
    {
      path: '/files/:file_path',
      name: 'file',
      component: File,
      props: true
    }
  ]
})
