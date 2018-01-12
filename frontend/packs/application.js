import "./application.css";
import Vue from "vue/dist/vue.esm";
import App from './app.vue'

document.addEventListener('DOMContentLoaded', () => {
  document.body.appendChild(document.createElement('app'))
  const app = new Vue({
    render: h => h(App)
  }).$mount('app')

  console.log(app)
})
