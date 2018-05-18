<template lang='pug'>
.container-fluid
  .list-group
    .list-group-item(v-for='(screenshots, file) in files')
      router-link(:to="{name: 'file', params: { file_path: file }}")
        |{{file}}
      .float-right: span.badge.badge-primary
        |{{file.length}}


</template>

<script>
import { mapGetters } from 'vuex'


export default {
  name: 'home',
  mounted() {
  },
  computed: {
    ...mapGetters(['files'])
  }
}
</script>
