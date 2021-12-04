<template>
  <el-form
    ref="form"
    :model="user"
    :rules="rules"
    class="form"
    label-position="right"
    label-width="80px"
  >
    <el-form-item
      :label="$t('table.user.nickname')"
      prop="email"
    >
      <el-input v-model="user.nickname" />
    </el-form-item>
    <el-form-item
      :label="$t('table.user.email')"
      prop="email"
    >
      <el-input v-model="user.email" />
    </el-form-item>
    <el-form-item
      :label="$t('table.user.phone')"
      prop="phone"
    >
      <el-input v-model="user.phone" />
    </el-form-item>
    <el-form-item
      :label="$t('table.user.sex')"
      prop="sex"
    >
      <el-radio-group v-model="user.sex" style="width: 220px">
        <el-radio-button v-for="item in sexOptions" :key="item.value" :label="item.value">{{ item.label }}</el-radio-button>
      </el-radio-group>
    </el-form-item>
    <el-form-item
      :label="$t('table.user.description')"
      prop="description"
    >
      <el-input
        v-model="user.description"
        rows="3"
        type="textarea"
      />
    </el-form-item>
    <el-form-item>
      <el-button
        plain
        type="primary"
        @click="submit"
      >
        {{ $t('common.edit') }}
      </el-button>
    </el-form-item>
  </el-form>
</template>

<script>
import validate from '@/utils/validate'
import crudUser from '@/views/sys/user/user-service'
import store from '@/store'
import { mapGetters } from 'vuex'

export default {
  components: {},
  props: {
    user: {
      type: Object,
      default: () => {
        return {
          name: '',
          email: '',
          sex: {
            code: 'M'
          }
        }
      }
    }
  },
  data() {
    return {
      sexOptions: [],
      rules: {
        email: { type: 'email', message: this.$t('rules.email'), trigger: 'blur' },
        mobile: { validator: (rule, value, callback) => {
          if (value !== '' && validate.validatePhone(value)) {
            callback(this.$t('rules.mobile'))
          } else {
            callback()
          }
        }, trigger: 'blur'
        },
        sex: { required: true, message: this.$t('rules.require'), trigger: 'change' },
        description: { max: 255, message: '内容超过255字符', trigger: 'blur' }
      }
    }
  },
  computed: {
    ...mapGetters([
      'dicts'
    ])
  },
  mounted() {
    this.sexOptions = this.dicts['sex']
  },
  methods: {
    submit() {
      this.$refs.form.validate((valid) => {
        if (valid) {
          const temp = { ...this.user }
          temp.account = temp.status = temp.avatar = temp.avatar = null
          crudUser.saveInfo({ ...temp })
            .then(() => {
              store.dispatch('GetUser').then(() => {
              })
            })
        } else {
          return false
        }
      })
    }

  }
}
</script>
<style lang="scss" scoped>
.form {
  padding: 10px 0 0 0;
}
</style>
