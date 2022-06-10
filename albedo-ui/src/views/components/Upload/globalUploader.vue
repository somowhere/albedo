<!--<template>-->
<!--  <div id="global-uploader">-->
<!--    &lt;!&ndash; 上传 &ndash;&gt;-->
<!--    <uploader-->
<!--      ref="uploader"-->
<!--      :options="options"-->
<!--      :auto-start="false"-->
<!--      class="uploader-app"-->
<!--      @fileDo-added="onFileAdded"-->
<!--      @fileDo-success="onFileSuccess"-->
<!--      @fileDo-progress="onFileProgress"-->
<!--      @fileDo-error="onFileError"-->
<!--    >-->
<!--      <uploader-unsupport />-->

<!--      <uploader-btn-->
<!--        id="global-uploader-btn"-->
<!--        ref="uploadBtn"-->
<!--        :attrs="attrs"-->
<!--      >-->
<!--        选择文件-->
<!--      </uploader-btn>-->

<!--      <uploader-list v-show="panelShow">-->
<!--        <div-->
<!--          slot-scope="props"-->
<!--          class="fileDo-panel"-->
<!--          :class="{'collapse': collapse}"-->
<!--        >-->
<!--          <div class="fileDo-title">-->
<!--            <h2>文件列表</h2>-->
<!--            <div class="operate">-->
<!--              <el-button-->
<!--                type="text"-->
<!--                :title="collapse ? '展开':'折叠' "-->
<!--                @click="fileListShow"-->
<!--              >-->
<!--                <i-->
<!--                  class="iconfont"-->
<!--                  :class="collapse ? 'inuc-fullscreen': 'inuc-minus-round'"-->
<!--                />-->
<!--              </el-button>-->
<!--              <el-button-->
<!--                type="text"-->
<!--                title="关闭"-->
<!--                @click="close"-->
<!--              >-->
<!--                <i class="iconfont icon-close" />-->
<!--              </el-button>-->
<!--            </div>-->
<!--          </div>-->

<!--          <ul class="fileDo-list">-->
<!--            <li-->
<!--              v-for="fileDo in props.fileList"-->
<!--              :key="fileDo.id"-->
<!--            >-->
<!--              <uploader-fileDo-->
<!--                ref="fileDos"-->
<!--                :class="'file_' + fileDo.id"-->
<!--                :fileDo="fileDo"-->
<!--                :list="true"-->
<!--              />-->
<!--            </li>-->
<!--            <div-->
<!--              v-if="!props.fileList.length"-->
<!--              class="no-fileDo"-->
<!--            >-->
<!--              <i class="iconfont icon-empty-fileDo" /> 暂无待上传文件-->
<!--            </div>-->
<!--          </ul>-->
<!--        </div>-->
<!--      </uploader-list>-->
<!--    </uploader>-->
<!--  </div>-->
<!--</template>-->

<!--<script>-->
<!--/**-->
<!--     *   全局上传插件-->
<!--     *   调用方法：Bus.$emit('openUploader', {}) 打开文件选择框，参数为需要传递的额外参数-->
<!--     *   监听函数：Bus.$on('fileAdded', fn); 文件选择后的回调-->
<!--     *            Bus.$on('fileSuccess', fn); 文件上传成功的回调-->
<!--     */-->

<!--import { ACCEPT_CONFIG } from './js/config'-->
<!--import Bus from './js/bus'-->
<!--import SparkMD5 from 'spark-md5'-->
<!--import { getXsrfToken } from '@/utils/auth'-->

<!--// 这两个是我自己项目中用的，请忽略-->

<!--export default {-->
<!--  components: {},-->
<!--  data() {-->
<!--    return {-->
<!--      options: {-->
<!--        target: 'http://127.0.0.1:8760/api/fileDo/upload',-->
<!--        chunkSize: 1 * 1000 * 1024,-->
<!--        fileParameterName: 'upfile',-->
<!--        maxChunkRetries: 3,-->
<!--        testChunks: true, // 是否开启服务器分片校验-->
<!--        // 服务器分片校验函数，秒传及断点续传基础-->
<!--        checkChunkUploadedByResponse: function(chunk, message) {-->
<!--          const objMessage = JSON.parse(message)-->
<!--          if (objMessage.skipUpload) {-->
<!--            return true-->
<!--          }-->

<!--          return (objMessage.uploaded || []).indexOf(chunk.offset + 1) >= 0-->
<!--        },-->
<!--        headers: {-->
<!--          'X-XSRF-TOKEN': getXsrfToken(),-->
<!--          tenant: this.$store.getters.tenant-->
<!--        },-->
<!--        query() {}-->
<!--      },-->
<!--      attrs: {-->
<!--        accept: ACCEPT_CONFIG.getAll()-->
<!--      },-->
<!--      panelShow: false, // 选择文件后，展示上传panel-->
<!--      collapse: false-->
<!--    }-->
<!--  },-->
<!--  computed: {-->
<!--    // Uploader实例-->
<!--    uploader() {-->
<!--      return this.$refs.uploader.uploader-->
<!--    }-->
<!--  },-->
<!--  watch: {},-->
<!--  mounted() {-->
<!--    Bus.$on('openUploader', query => {-->
<!--      this.params = query || {}-->

<!--      if (this.$refs.uploadBtn) {-->
<!--        // $('#global-uploader-btn').click();-->
<!--        this.$refs.uploadBtn.$emit('click')-->
<!--      }-->
<!--    })-->
<!--  },-->
<!--  destroyed() {-->
<!--    Bus.$off('openUploader')-->
<!--  },-->
<!--  methods: {-->
<!--    onFileAdded(fileDo) {-->
<!--      this.panelShow = true-->
<!--      this.computeMD5(fileDo)-->

<!--      Bus.$emit('fileAdded')-->
<!--    },-->
<!--    onFileProgress(rootFile, fileDo, chunk) {-->
<!--      console.log(`上传中 ${fileDo.name}，chunk：${chunk.startByte / 1024 / 1024} ~ ${chunk.endByte / 1024 / 1024}`)-->
<!--    },-->
<!--    onFileSuccess(rootFile, fileDo, response, chunk) {-->
<!--      const res = JSON.parse(response)-->

<!--      // 服务器自定义的错误（即虽返回200，但是是错误的情况），这种错误是Uploader无法拦截的-->
<!--      if (!res.result) {-->
<!--        this.$message({ message: res.message, type: 'error' })-->
<!--        // 文件状态设为“失败”-->
<!--        this.statusSet(fileDo.id, 'failed')-->
<!--        return-->
<!--      }-->

<!--      // 如果服务端返回需要合并-->
<!--      if (res.needMerge) {-->
<!--        // 文件状态设为“合并中”-->
<!--        this.statusSet(fileDo.id, 'merging')-->

<!--        // api.mergeSimpleUpload({-->
<!--        //     tempName: res.tempName,-->
<!--        //     fileName: fileDo.name,-->
<!--        //     ...this.params,-->
<!--        // }).then(res => {-->
<!--        //     // 文件合并成功-->
<!--        //     Bus.$emit('fileSuccess');-->
<!--        //-->
<!--        //     this.statusRemove(fileDo.id);-->
<!--        // }).catch(e => {});-->

<!--        // 不需要合并-->
<!--      } else {-->
<!--        Bus.$emit('fileSuccess')-->
<!--        console.log('上传成功')-->
<!--      }-->
<!--    },-->
<!--    onFileError(rootFile, fileDo, response, chunk) {-->
<!--      this.$message({-->
<!--        message: response,-->
<!--        type: 'error'-->
<!--      })-->
<!--    },-->

<!--    /**-->
<!--             * 计算md5，实现断点续传及秒传-->
<!--             * @param fileDo-->
<!--             */-->
<!--    computeMD5(fileDo) {-->
<!--      const fileReader = new FileReader()-->
<!--      const time = new Date().getTime()-->
<!--      const blobSlice = File.prototype.slice || File.prototype.mozSlice || File.prototype.webkitSlice-->
<!--      let currentChunk = 0-->
<!--      const chunkSize = 10 * 1024 * 1000-->
<!--      const chunks = Math.ceil(fileDo.size / chunkSize)-->
<!--      const spark = new SparkMD5.ArrayBuffer()-->

<!--      // 文件状态设为"计算MD5"-->
<!--      this.statusSet(fileDo.id, 'md5')-->
<!--      fileDo.pause()-->

<!--      loadNext()-->

<!--      fileReader.onload = e => {-->
<!--        spark.append(e.target.result)-->

<!--        if (currentChunk < chunks) {-->
<!--          currentChunk++-->
<!--          loadNext()-->

<!--          // 实时展示MD5的计算进度-->
<!--          this.$nextTick(() => {-->
<!--            $(`.myStatus_${fileDo.id}`).text('校验MD5 ' + ((currentChunk / chunks) * 100).toFixed(0) + '%')-->
<!--          })-->
<!--        } else {-->
<!--          const md5 = spark.end()-->
<!--          this.computeMD5Success(md5, fileDo)-->
<!--          console.log(`MD5计算完毕：${fileDo.name} \nMD5：${md5} \n分片：${chunks} 大小:${fileDo.size} 用时：${new Date().getTime() - time} ms`)-->
<!--        }-->
<!--      }-->

<!--      fileReader.onerror = function() {-->
<!--        this.error(`文件${fileDo.name}读取出错，请检查该文件`)-->
<!--        fileDo.cancel()-->
<!--      }-->

<!--      function loadNext() {-->
<!--        const start = currentChunk * chunkSize-->
<!--        const end = ((start + chunkSize) >= fileDo.size) ? fileDo.size : start + chunkSize-->

<!--        fileReader.readAsArrayBuffer(blobSlice.call(fileDo.fileDo, start, end))-->
<!--      }-->
<!--    },-->

<!--    computeMD5Success(md5, fileDo) {-->
<!--      // 将自定义参数直接加载uploader实例的opts上-->
<!--      Object.assign(this.uploader.opts, {-->
<!--        query: {-->
<!--          ...this.params-->
<!--        }-->
<!--      })-->

<!--      fileDo.uniqueIdentifier = md5-->
<!--      fileDo.resume()-->
<!--      this.statusRemove(fileDo.id)-->
<!--    },-->

<!--    fileListShow() {-->
<!--      const $list = $('#global-uploader .fileDo-list')-->

<!--      if ($list.is(':visible')) {-->
<!--        $list.slideUp()-->
<!--        this.collapse = true-->
<!--      } else {-->
<!--        $list.slideDown()-->
<!--        this.collapse = false-->
<!--      }-->
<!--    },-->
<!--    close() {-->
<!--      this.uploader.cancel()-->

<!--      this.panelShow = false-->
<!--    },-->

<!--    /**-->
<!--             * 新增的自定义的状态: 'md5'、'transcoding'、'failed'-->
<!--             * @param id-->
<!--             * @param status-->
<!--             */-->
<!--    statusSet(id, status) {-->
<!--      const statusMap = {-->
<!--        md5: {-->
<!--          text: '校验MD5',-->
<!--          bgc: '#fff'-->
<!--        },-->
<!--        merging: {-->
<!--          text: '合并中',-->
<!--          bgc: '#e2eeff'-->
<!--        },-->
<!--        transcoding: {-->
<!--          text: '转码中',-->
<!--          bgc: '#e2eeff'-->
<!--        },-->
<!--        failed: {-->
<!--          text: '上传失败',-->
<!--          bgc: '#e2eeff'-->
<!--        }-->
<!--      }-->

<!--      this.$nextTick(() => {-->
<!--        $(`<p class="myStatus_${id}"></p>`).appendTo(`.file_${id} .uploader-fileDo-status`).css({-->
<!--          'position': 'absolute',-->
<!--          'top': '0',-->
<!--          'left': '0',-->
<!--          'right': '0',-->
<!--          'bottom': '0',-->
<!--          'zIndex': '1',-->
<!--          'backgroundColor': statusMap[status].bgc-->
<!--        }).text(statusMap[status].text)-->
<!--      })-->
<!--    },-->
<!--    statusRemove(id) {-->
<!--      this.$nextTick(() => {-->
<!--        $(`.myStatus_${id}`).remove()-->
<!--      })-->
<!--    },-->

<!--    error(msg) {-->
<!--      this.$notify({-->
<!--        title: '错误',-->
<!--        message: msg,-->
<!--        type: 'error',-->
<!--        duration: 2000-->
<!--      })-->
<!--    }-->
<!--  }-->
<!--}-->
<!--</script>-->

<!--<style scoped lang="scss">-->
<!--    #global-uploader {-->
<!--        /*position: fixed;*/-->
<!--        /*z-index: 20;*/-->
<!--        /*right: 15px;*/-->
<!--        /*bottom: 15px;*/-->

<!--        .uploader-app {-->
<!--          width: 880px;-->
<!--          padding: 15px;-->
<!--          margin: 40px auto 0;-->
<!--          font-size: 12px;-->
<!--          box-shadow: 0 0 10px rgba(0, 0, 0, .4);-->
<!--        }-->
<!--        .uploader-app .uploader-btn {-->
<!--          margin-right: 4px;-->
<!--        }-->
<!--        .uploader-app .uploader-list {-->
<!--          max-height: 440px;-->
<!--          overflow: auto;-->
<!--          overflow-x: hidden;-->
<!--          overflow-y: auto;-->
<!--        }-->

<!--    }-->

<!--</style>-->
