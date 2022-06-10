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
      :model="attachment"
      :rules="rules"
      label-position="right"
      label-width="100px"
    >
      <el-form-item
        :label="$t('table.attachment.bizType')"
        prop="bizType"
        :hidden="true"
      >
        <el-input v-model="attachment.bizType" />
      </el-form-item>
      <el-form-item
        label="文件"
        prop="fileLength"
      >
        <fileUpload
          ref="fileRef"
          :accept-size="2*1024*1024"
          :auto-upload="false"
          :limit="5"
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
            文件不超过2MB
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
  name: 'AttachmentEdit',
  directives: { elDragDialog, fileUpload },
  components: { fileUpload },
  props: {
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
      accept: 'image/jpeg, image/gif, image/png',
      attachment: this.initAttachment(),
      screenWidth: 0,
      width: this.initWidth(),
      fileLength: 0,
      disabled: false,
      rules: {
        bizType: [
          { required: true, message: this.$t('rules.require'), trigger: 'blur' },
          { min: 0, max: 255, message: this.$t('rules.range0to255'), trigger: 'blur' }
        ],
        bizId: { min: 0, max: 255, message: this.$t('rules.range0to255'), trigger: 'blur' },
        fileLength: { required: true, trigger: 'change',
          validator: (rule, value, callback) => {
            const vm = this
            if (vm.fileLength === 0) {
              callback(new Error('请上传文件'))
            } else if (vm.fileLength > 5) {
              callback(new Error('一次性只能上传5个文件'))
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
  watch: {

  },
  mounted() {
    window.onresize = () => {
      return (() => {
        this.width = this.initWidth()
      })()
    }
  },
  methods: {
    initAttachment() {
      return {
        bizType: 'BASE_FILE',
        file: null
      }
    },
    handleDrag() {
      console.log(`我被拖动了`)
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
    setAttachment(val) {
      const vm = this
      if (val) {
        vm.attachment = { ...val }
      }
    },
    close() {
      this.$emit('close')
    },
    reset() {
      // 先清除校验，再清除表单，不然有奇怪的bug
      this.$refs.form.clearValidate()
      this.$refs.form.resetFields()
      this.attachment = this.initAttachment()
      this.$refs.fileRef.init({
        id: '',
        bizId: '',
        bizType: ''
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
      vm.$refs.fileRef.submitFile(this.attachment.id, this.attachment.bizId, this.attachment.bizType)
    },
    setIdAndSubmit(isUploadCompleted) {
      const vm = this
      if (isUploadCompleted) {
        vm.disabled = false
        vm.isVisible = false
        vm.$message({
          message: vm.$t('tips.createSuccess'),
          type: 'success'
        })
        vm.$emit('success')
      }
    }

  }
}
</script>
<style lang="scss" scoped>
</style>
