<template>
  <div class="ace-container">
    <div class="ace-editor" ref="ace"></div>

    <div class="config-panel" v-show="toggle">
      <div>
        <div class="item">
          <label class="title">语言</label>
          <el-select @change="handleModelPathChange" class="value" size="mini" v-model="modePath" value-key="name">
            <el-option :key="mode.name"
                       :label="mode.name"
                       :value="mode.path"
                       v-for="mode in modeArray">
            </el-option>
          </el-select>
        </div>

        <div class="item">
          <label class="title">换行</label>
          <el-select @change="handleWrapChange" class="value" size="mini" v-model="wrap" value-key="name">
            <el-option :key="wrap.name"
                       :label="wrap.name"
                       :value="wrap.value"
                       v-for="wrap in wrapArray">
            </el-option>
          </el-select>
        </div>
      </div>
    </div>

    <div @click="toggleConfigPanel" class="bookmarklet"></div>
  </div>
</template>

<script>
    import ace from 'ace-builds'
    import 'ace-builds/src-noconflict/snippets/javascript'
    import 'ace-builds/src-noconflict/snippets/html'
    import 'ace-builds/src-noconflict/snippets/css'
    import 'ace-builds/src-noconflict/snippets/scss'
    import 'ace-builds/src-noconflict/snippets/json'
    import 'ace-builds/src-noconflict/snippets/java'
    import 'ace-builds/src-noconflict/snippets/text'
    import 'ace-builds/webpack-resolver'
    import 'ace-builds/src-noconflict/ext-language_tools'
    import 'ace-builds/src-noconflict/theme-monokai'
    import 'ace-builds/src-noconflict/mode-javascript'

    // const themeArray = [{
    //   name: 'monokai',
    //   path: 'ace/theme/monokai'
    // }]

    const wrapArray = [{
        name: '开启',
        value: true
    }, {
        name: '关闭',
        value: false
    }];

    const modeArray = [{
        name: 'JavaScript',
        path: 'ace/mode/javascript'
    }, {
        name: 'HTML',
        path: 'ace/mode/html'
    }, {
        name: 'CSS',
        path: 'ace/mode/css'
    }, {
        name: 'SCSS',
        path: 'ace/mode/scss'
    }, {
        name: 'Json',
        path: 'ace/mode/json'
    }, {
        name: 'Java',
        path: 'ace/mode/java'
    }, {
        name: 'Text',
        path: 'ace/mode/text'
    }];

    export default {
        props: {
            value: String
        },
        mounted() {
            this.aceEditor = ace.edit(this.$refs.ace, {
                maxLines: 60,
                minLines: 20,
                fontSize: 14,
                value: this.value ? this.value : '',
                theme: this.themePath,
                mode: this.modePath,
                wrap: this.wrap,
                tabSize: 4
            });
            // 激活自动提示
            this.aceEditor.setOptions({
                enableSnippets: true,
                enableLiveAutocompletion: true,
                enableBasicAutocompletion: true
            });
            this.aceEditor.getSession().on('change', this.change)
        },
        data() {
            return {
                aceEditor: null,
                toggle: false,
                wrap: true,
                themePath: 'ace/theme/monokai',
                modePath: 'ace/mode/java',
                modeArray: modeArray,
                wrapArray: wrapArray
            }
        },
        methods: {
            toggleConfigPanel() {
                this.toggle = !this.toggle
            },
            change() {
                this.$emit('input', this.aceEditor.getSession().getValue())
            },
            handleModelPathChange(modelPath) {
                this.aceEditor.getSession().setMode(modelPath)
            },
            handleWrapChange(wrap) {
                this.aceEditor.getSession().setUseWrapMode(wrap)
            }
        }
    }
</script>

<style lang='scss' scoped>
  .ace-container {
    position: relative;

    .config-panel {
      position: absolute;
      right: 0;
      bottom: 0;
      width: 50%;
      height: 100%;
      overflow: scroll;
      box-shadow: grey -5px 2px 3px;
      background-color: rgba(255, 255, 255, 0.5);
      z-index: 1;

      .item {
        margin: 10px auto;
        text-align: center;

        .title {
          color: white;
          margin: 0 10px;
          font-size: 14px;
        }
      }
    }

    .bookmarklet {
      position: absolute;
      right: 0;
      bottom: 0;
      width: 20px;
      height: 20px;
      z-index: 2;
      cursor: pointer;
      border-width: 9px;
      border-style: solid;
      border-color: lightblue gray gray rgb(206, 173, 230);
      border-image: initial;
    }
  }
</style>
