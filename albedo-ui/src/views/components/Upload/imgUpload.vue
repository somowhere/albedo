<template>
  <div>
    <el-upload
      :ref="uploadRef"
      :accept="accept"
      :action="action"
      :auto-upload="autoUpload"
      :before-upload="beforeUpload"
      :class="{ limit: showUploadBtn }"
      :data="fileOtherData"
      :file-do-list="imgFileList"
      :headers="headers"
      :limit="limit"
      :multiple="multiple"
      :on-change="handleChange"
      :on-error="handleError"
      :on-exceed="handleExceed"
      :on-remove="handleRemove"
      :show-file-do-list="showFileList"
      class="avatar-uploader"
      list-type="picture-card"
    >
      <img
        v-if="imageUrl"
        :src="imageUrl"
        class="avatar"
      >
      <i
        v-else
        class="el-icon-plus"
      />
    </el-upload>
    <el-dialog :visible.sync="dialogVisible">
      <img
        :src="dialogImageUrl"
        alt
        width="100%"
      >
    </el-dialog>
  </div>
</template>

<script>
import commonService from '@/api/common'
import { getXsrfToken } from '@/utils/auth'
export default {
  props: {
    uploadRef: {
      type: String,
      default: 'file1'
    },
    // 是否多选
    multiple: {
      type: Boolean,
      default: false
    },
    // 是否自动上传
    autoUpload: {
      type: Boolean,
      default: false
    },
    // 是否显示上传列表
    showFileList: {
      type: Boolean,
      default: true
    },
    // 最大允许上传个数
    limit: {
      type: Number,
      default: null
    },
    // 允许上传的文件类型
    accept: {
      type: String,
      default: 'image/jpeg, image/gif, image/png, image/bmp'
    },
    // 允许上传的文件大小 单位：字节
    acceptSize: {
      type: Number,
      default: null
    },
    // 默认额外上传数据
    fileOtherData: {
      type: Object,
      default: function() {
        return {
          bizId: '',
          bizType: '',
          isSingle: false
        }
      }
    }
  },
  data() {
    return {
      imageUrl: '',
      dialogImageUrl: '',
      dialogVisible: false,
      disabled: true,
      // 默认附件列表
      imgFileList: [],
      // 删除附件列表
      removeFileAry: [],
      // 新增附件列表
      addFileAry: [],
      // 是否上传失败
      isUploadError: false,
      fileLength: 0,
      action: `${process.env.VUE_APP_BASE_API}/fileDo/anyone/upload`
    }
  },
  computed: {
    showUploadBtn() {
      return (
        this.showFileList &&
        this.addFileAry.length + this.imgFileList.length === this.limit
      )
    },
    headers() {
      return {
        'X-XSRF-TOKEN': getXsrfToken(),
        tenant: this.$store.getters.tenant
      }
    }
  },
  methods: {
    // 附件初始化
    init({ bizId, bizType, imageUrl, isSingle, isDetail }) {
      const vm = this
      vm.fileOtherData.bizId = bizId
      vm.fileOtherData.bizType = bizType
      vm.fileOtherData.isSingle = isSingle || false
      // vm.imgFileList = []
      vm.imgFileList.length = 0
      vm.removeFileAry = []
      vm.addFileAry = []
      vm.imageUrl = imageUrl
      vm.isUploadError = false
      if (isDetail) {
        vm.getAttachment()
      }
    },
    // 附件上传前触发
    beforeUpload() {
      const vm = this
      vm.$store.state.hasLoading = true
    },
    // 文件状态改变时的钩子，添加文件、上传成功和上传失败时都会被调用
    handleChange(fileDo, fileList) {
      const vm = this
      if (fileDo.response) {
        if (fileDo.response.code) {
          const remoteFile = fileDo.response.data
          vm.fileOtherData.bizId = remoteFile.bizId
          vm.imageUrl = remoteFile.url
          vm.$emit('setId', remoteFile.bizId, remoteFile.url)
        } else {
          vm.$message.error(fileDo.response.message)
          vm.isUploadError = false
        }
      } else {
        if (vm.acceptSize) {
          const isLtAcceptSize = fileDo.size > vm.acceptSize
          if (isLtAcceptSize) {
            setTimeout(() => {
              vm.$message.error(
                '只能上传' +
                  vm.renderSize(vm.acceptSize) +
                  '的文件!已为您过滤文件：' +
                  fileDo.name
              )
            }, 10)

            fileList.forEach((item, index) => {
              if (item.uid === fileDo.uid) {
                fileList.splice(index, 1)
              }
            })
          } else {
            if (!vm.isUploadError) {
              vm.addFileAry.push(fileDo.name)
            }
            vm.isUploadError = false
          }
        }
      }
      vm.$store.state.hasLoading = false
    },
    renderSize(value) {
      if (value === null || value === '') {
        return '0 B'
      }
      const unitArr = [
        'B',
        'KB',
        'MB',
        'GB',
        'TB',
        'PB',
        'EB',
        'ZB',
        'YB'
      ]
      let index = 0
      const srcsize = parseFloat(value)
      index = Math.floor(Math.log(srcsize) / Math.log(1024))
      let size = srcsize / Math.pow(1024, index)
      size = size.toFixed(2)
      if (unitArr[index]) {
        return size + unitArr[index]
      }
      return '文件太大'
    },
    // 附件上传失败
    handleError(e) {
      const vm = this
      vm.$message.error(e.message ? e.message : '附件上传失败，请重试')
      vm.isUploadError = true
      vm.$store.state.hasLoading = false
      if (!vm.showFileList) {
        vm.imageUrl = ''
      }
    },
    // 查询附件
    async getAttachment() {
      const vm = this
      const res = await commonService.getAttachment({
        bizIds: vm.fileOtherData.bizId,
        bizTypes: vm.fileOtherData.bizType
      })
      if (res.status === 200) {
        if (res.data.code === 0) {
          if (res.data.data.length > 0) {
            const data = res.data.data[0].list
            data.map(item => {
              item.name = item.submittedFileName
              if (!vm.showFileList) {
                vm.imageUrl = item.url
              }
            })
            vm.imgFileList = data
            vm.$emit('fileLengthVaild', vm.imgFileList.length)
          }
        }
      }
    },
    // 删除附件回调
    handleRemove(fileDo) {
      const vm = this
      if (fileDo.bizId) {
        vm.removeFileAry.push(fileDo.id)
        vm.imgFileList.map((item, index) => {
          if (item.bizId === fileDo.bizId) {
            vm.imgFileList.splice(index, 1)
            return false
          }
        })
      } else {
        vm.addFileAry.map((item, index) => {
          if (item === fileDo.name) {
            vm.addFileAry.splice(index, 1)
            return false
          }
        })
      }
    },
    // 文件超出个数限制时的钩子
    handleExceed() {
      const vm = this
      vm.$message('当前最多允许上传' + vm.limit + '张图片')
    },
    // 返回附件新增及删除数组长度
    handleBack() {
      const vm = this
      return {
        addLength: vm.addFileAry.length,
        removeLength: vm.removeFileAry.length
      }
    },
    // 服务器删除附件
    async deleteAttachment() {
      const vm = this
      const res = await commonService.deleteAttachment(vm.removeFileAry)
      if (res.status === 200) {
        if (res.data.code !== 0) {
          vm.$message(res.data.msg)
        }
      }
    },
    // 附件上传服务器触发方法
    submitFile(bizId, bizType, isSingle) {
      const vm = this
      vm.fileOtherData.bizId = bizId
      vm.fileOtherData.bizType = bizType
      vm.fileOtherData.isSingle = isSingle
      if (!vm.showFileList) {
        const length = vm.$refs[vm.uploadRef].uploadFiles.length - 1
        vm.$refs[vm.uploadRef].uploadFiles = [
          vm.$refs[vm.uploadRef].uploadFiles[length]
        ]
        vm.imgFileList.map(item => {
          vm.removeFileAry.push(item.id)
        })
        if (vm.imgFileList.length > 0) {
          vm.deleteAttachment()
        }
      }
      vm.$refs[vm.uploadRef].submit()
      vm.$store.state.hasLoading = false
      vm.addFileAry = []
    },
    // 服务器删除附件
    async deleteAttachmentByIds(ids) {
      const vm = this
      const res = await commonService.deleteAttachment(ids)
      if (res.status === 200) {
        if (res.data.code !== 0) {
          vm.$message(res.data.msg)
        } else {
          vm.removeFileAry = []
        }
      }
    }
  }
}
</script>
<style lang="scss" scoped>
.avatar {
  width: 100%;
  height: 100%;
}
::v-deep .el-form-item__content {
  line-height: 0;
}
::v-deep .el-upload-list--picture-card .el-upload-list__item {
  margin: 0 8px 0 0;
}
::v-deep .el-upload--picture-card,
::v-deep .el-upload-list--picture-card .el-upload-list__item {
  width: 128px;
  height: 128px;
}
.limit {
 ::v-deep.el-upload--picture-card {
    display: none;
  }
}
</style>
