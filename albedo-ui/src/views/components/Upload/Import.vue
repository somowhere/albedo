<template>
  <el-dialog
    v-el-drag-dialog
    :close-on-click-modal="false"
    :title="title"
    :type="type"
    :visible.sync="isVisible"
    :width="width"
    top="50px"
    @dragDialog="handleDrag"
  >
    <el-form
      ref="form"
      :model="model"
      :rules="rules"
      label-position="right"
      label-width="100px"
    >
      <el-form-item
        label="文件"
        prop="fileLength"
      >
        <fileUpload
          ref="fileRef"
          :accept-size="acceptSize"
          :auto-upload="false"
          :limit="1"
          :accept="accept"
          :action="action"
          @fileLengthVaild="fileLengthVaild"
          @setId="setIdAndSubmit"
        >
          <el-button
            slot="trigger"
            size="small"
            type="primary"
          >
            选取文件
          </el-button>
          <div
            slot="tip"
            class="el-upload__tip"
          >
            文件不超过100MB
          </div>
        </fileUpload>
      </el-form-item>
    </el-form>
    <div
      slot="footer"
      class="dialog-footer"
    >
      <el-button
        plain
        type="warning"
        @click="isVisible = false"
      >
        {{ $t('common.cancel') }}
      </el-button>
      <el-button
        :disabled="disabled"
        plain
        type="primary"
        @click="submitForm"
      >
        {{ $t('common.confirm') }}
      </el-button>
    </div>
  </el-dialog>
</template>
<script>
import elDragDialog from '@/directive/el-drag-dialog'
import fileUpload from '@/views/components/Upload/fileUpload'

export default {
  name: 'CommonImport',
  directives: { elDragDialog, fileUpload },
  components: { fileUpload },
  props: {
    action: {
      type: String,
      required: true
    },
    // 允许上传的文件大小 单位：字节
    acceptSize: {
      type: Number,
      default: 50 * 1024 * 1024
    },
    accept: {
      type: String,
      default: '.xls,.xlsx'
    },
    dialogVisible: {
      type: Boolean,
      default: false
    },
    type: {
      type: String,
      default: 'add'
    }
  },
  data() {
    return {
      model: this.initImport(),
      screenWidth: 0,
      width: this.initWidth(),
      fileLength: 0,
      disabled: false,
      rules: {
        fileLength: {
          required: true, trigger: 'change',
          validator: (rule, value, callback) => {
            const vm = this
            if (vm.fileLength === 0) {
              callback(new Error('请上传文件'))
            } else if (vm.fileLength > 1) {
              callback(new Error('一次性只能上传1个文件'))
            } else {
              callback()
            }
          }
        }
      }
    }
  },
  computed: {
    isVisible: {
      get() {
        return this.dialogVisible
      },
      set() {
        this.close()
        this.reset()
      }
    },
    title() {
      return this.$t('common.upload')
    }
  },
  watch: {},
  mounted() {
    window.onresize = () => {
      return (() => {
        this.width = this.initWidth()
      })()
    }
  },
  methods: {
    initImport() {
      return {
        id: '',
        bizId: '',
        bizType: '',
        file: null,
        isSingle: false
      }
    },
    handleDrag() {
    },
    // 附件长度校验
    fileLengthVaild(data) {
      const vm = this
      vm.fileLength = data || 0
    },
    initWidth() {
      this.screenWidth = document.body.clientWidth
      if (this.screenWidth < 991) {
        return '90%'
      } else if (this.screenWidth < 1400) {
        return '45%'
      } else {
        return '800px'
      }
    },
    setModel(val) {
      const vm = this
      if (val) {
        vm.model = { ...val }
      }
    },
    close() {
      this.$emit('close')
    },
    reset() {
      // 先清除校验，再清除表单，不然有奇怪的bug
      this.$refs.form.clearValidate()
      this.$refs.form.resetFields()
      this.disabled = false
      this.model = this.initImport()
      this.$refs.fileRef.init({
        id: ''
      })
    },
    submitForm() {
      const vm = this
      this.$refs.form.validate((valid) => {
        if (valid) {
          vm.editSubmit()
        } else {
          return false
        }
      })
    },
    editSubmit() {
      const vm = this
      vm.disabled = true
      vm.$refs.fileRef.submitFile(this.model.id, this.model.bizId, this.model.bizType)
    },
    setIdAndSubmit(isUploadCompleted, response) {
      const vm = this
      if (isUploadCompleted) {
        vm.disabled = false
        vm.isVisible = false
        vm.$message({
          message: vm.$t('tips.createSuccess'),
          type: 'success'
        })
        vm.$emit('success')
      } else if (response && response['code'] === -9 && response['data']) {
        // 原本是想要下载数据，但存在一些问题
        // commonApi.export(this.exportErrorUrl, {failList: response['data']})
        //   .then(response => {
        //   downloadFile(response);
        // });
      }
    }
  }
}
</script>
<style lang="scss" scoped>
</style>
