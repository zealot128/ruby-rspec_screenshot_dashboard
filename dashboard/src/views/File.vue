<template lang='pug'>
.container-fluid
  h3 {{file_path}}
  .list-group
    .list-group-item(v-for='(screenshots, example) in examples')
      .float-right
        span.badge.badge-secondary {{screenshots.length}}
      p
        a(@click.prevent='collapsed[example] = !collapsed[example]')
          strong {{example}}
      b-collapse(visible v-model='collapsed[example]' :id='example')
        .screenshot(v-for='s in screenshots')
          img.img-fluid(:src='"screenshots/" + s.local_image')
          .overlay
            dl
              dt Line
              dd {{s.line_number}}
              dt Url
              dd {{s.url}}
            code: pre
              |{{s.snippet}}


</template>

<script>

import groupBy from 'lodash/groupBy'
import sortBy from 'lodash/sortBy'
export default {
  data() {
    return {
      collapsed: {}
    }
  },
  name: 'FileRoute',
  props: ['file_path'],
  computed: {
    screenshots() {
      return sortBy(this.$store.getters.files[this.file_path], e => e.line_number)
    },
    examples() {
      return groupBy(this.screenshots, (s) => [...s.group_description, s.example_description].join('/'))
    }
  }

}
</script>

<style lang='scss'>
.screenshot {
  position: relative;
}
.overlay {
  position: absolute;
  padding: 15px;
  right: 0;
  bottom: 5px;
  opacity: 0.3;
  max-width: 300px;
  transition: all 0.2s ease-in-out;
  pre {
    overflow: hidden;
  }
  &:hover {
    pre {
      overflow: auto;
    }
    box-shadow: 1px 1px 2px #555;
    background: #ddd;
    max-width: 800px;
    opacity: 0.95;
  }
}
.img-fluid {
  max-height: 100vh;
}

</style>


