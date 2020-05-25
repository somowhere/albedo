<template>
  <div class="ace-container">
    <editor v-model="content" :lang="lang" theme="monokai" :height="height" :options="{readOnly: true, fontSize: 16}" @init="editorInit" />
  </div>
</template>

<script>

export default {
  components: {
    editor: require('vue2-ace-editor')
  },
  props: {
    value: {
      type: String,
      required: true
    },
    lang: {
      type: String,
      required: true
    }
  },
  data() {
    return {
      content: this.value,
      height: document.documentElement.clientHeight - 400
    }
  },
  watch: {
    value: function(n, o) {
      this.content = n
    }
  },
  mounted() {
    const that = this
    window.onresize = function temp() {
      that.height = document.documentElement.clientHeight - 400
    }
  },
  methods: {
    editorInit: function() {
      require('brace/ext/language_tools') // language extension prerequsite...
      require('brace/mode/html')
      require('brace/mode/java')
      require('brace/mode/javascript') // language
      require('brace/mode/less')
      require('brace/theme/chrome')
      require('brace/theme/dawn')
      require('brace/theme/monokai')
      require('brace/snippets/javascript') // snippet
    }
  }
}
</script>

<style lang='scss' scoped>
</style>
