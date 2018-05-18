<template lang='pug'>
  div#app
    b-navbar(toggleable="md" type="dark" variant='dark')
      b-navbar-toggle(target="nav_collapse")
      b-navbar-brand(href="/") Screenshots
      b-collapse(is-nav id="nav_collapse")
        b-navbar-nav
          b-nav-item(to="/") Home
    main(style='margin-top: 50px')
      router-view
</template>

<script>
export default {
  name: 'app',
  mounted() {
    this.$http.get('index.json').then((r) => {
      this.$store.commit('setScreenshots', r.data)
    })
  }
}
</script>
