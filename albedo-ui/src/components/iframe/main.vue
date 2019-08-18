<template>
  <div>
    <basic-container>
      <iframe :src='$route.query.src'
              class="iframe"
              ref="iframe"
              v-if="$route.query.src"></iframe>
      <iframe :src="urlPath"
              class="iframe"
              ref="iframe"
              v-else></iframe>
    </basic-container>
  </div>
</template>

<script>
    import {mapGetters} from 'vuex'
    import validate from '@/util/validate'
    import NProgress from 'nprogress' // progress bar
    import 'nprogress/nprogress.css' // progress bar style
    export default {
        name: 'AvueIframe',
        data() {
            return {
                urlPath: this.getUrlPath() //iframe src 路径
            }
        },
        created() {
            NProgress.configure({showSpinner: false})
        },
        mounted() {
            this.load();
            this.resize()
        },
        props: ['routerPath'],
        watch: {
            $route: function () {
                this.load()
            },
            routerPath: function () {
                // 监听routerPath变化，改变src路径
                this.urlPath = this.getUrlPath()
            }
        },
        components: {
            ...mapGetters(['screen']),
        },
        methods: {
            // 显示等待框
            show() {
                NProgress.start()
            },
            // 隐藏等待狂
            hide() {
                NProgress.done()
            },
            // 加载浏览器窗口变化自适应
            resize() {
                window.onresize = () => {
                    this.iframeInit()
                }
            },
            // 加载组件
            load() {
                this.show();
                let flag = true; //URL是否包含问号
                if (this.$route.query.src.indexOf('?') == -1) {
                    flag = false
                }
                let list = [];
                for (let key in this.$route.query) {
                    if (key != 'src' && key != 'name') {
                        list.push(`${key}= this.$route.query[key]`)
                    }
                }
                list = list.join('&').toString();
                if (flag) {
                    this.$route.query.src = `${this.$route.query.src}${
                        list.length > 0 ? `&list` : ''
                    }`
                } else {
                    this.$route.query.src = `${this.$route.query.src}${
                        list.length > 0 ? `?list` : ''
                    }`
                }
                //超时5s自动隐藏等待框，加强用户体验
                let time = 5;
                const timeFunc = setInterval(() => {
                    time--;
                    if (time == 0) {
                        this.hide();
                        clearInterval(timeFunc)
                    }
                }, 1000);
                this.iframeInit()
            },
            //iframe窗口初始化
            iframeInit() {
                const iframe = this.$refs.iframe;
                const clientHeight = document.documentElement.clientHeight - (screen > 1 ? 200 : 130);
                if (validate.checkNotNull(iframe)) iframe.style.height = `${clientHeight}px`;
                if (iframe.attachEvent) {
                    iframe.attachEvent('onload', () => {
                        this.hide()
                    })
                } else {
                    iframe.onload = () => {
                        this.hide()
                    }
                }
            },
            getUrlPath: function () {
                //获取 iframe src 路径
                let url = window.location.href;
                url = url.replace('/myiframe', '');
                return url
            }
        }
    }
</script>

<style lang="scss">
  .iframe {
    width: 100%;
    height: 100%;
    border: 0;
    overflow: hidden;
    box-sizing: border-box;
  }
</style>
