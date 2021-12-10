<template>
  <div class="login">
    <el-form
      ref="loginForm"
      :model="loginForm"
      :rules="loginRules"
      class="login-form"
      label-position="left"
      label-width="0px"
    >
      <h3 class="title">
        Albedo 快速开发框架
      </h3>
      <lang-select class="set-language" />

      <el-form-item prop="tenant">
        <el-input v-model="loginForm.tenantView" auto-complete="off" placeholder="企业编码" type="text">
          <svg-icon slot="prefix" class="el-input__icon input-icon" icon-class="user" />
        </el-input>
      </el-form-item>
      <el-form-item prop="username">
        <el-input v-model="loginForm.username" auto-complete="off" placeholder="账号" type="text">
          <svg-icon slot="prefix" class="el-input__icon input-icon" icon-class="user" />
        </el-input>
      </el-form-item>
      <el-form-item prop="password">
        <el-input
          v-model="loginForm.password"
          :type="passwordType"
          auto-complete="off"
          placeholder="请输入密码"
          size="small"
          @keyup.enter.native="handleLogin"
        >
          <svg-icon slot="prefix" class="el-input__icon input-icon" icon-class="password" />
          <svg-icon slot="suffix" class="el-input__icon input-icon" icon-class="eye" @click="showPassword" />
        </el-input>
      </el-form-item>
      <el-form-item prop="code">
        <el-input
          v-model="loginForm.code"
          :maxlength="codeLength"
          :minlength="codeLength"
          auto-complete="off"
          placeholder="验证码"
          style="width: 63%"
          @keyup.enter.native="handleLogin"
        >
          <svg-icon slot="prefix" class="el-input__icon input-icon" icon-class="validCode" />
        </el-input>
        <div class="login-code">
          <img :src="codeUrl" @click="refreshCode">
        </div>
      </el-form-item>
      <el-checkbox v-model="loginForm.rememberMe" style="margin:0 0 25px 0;">
        记住我
      </el-checkbox>
      <el-form-item style="width:100%;">
        <el-button
          :loading="loading"
          size="medium"
          style="width:100%;"
          type="primary"
          @click.native.prevent="handleLogin"
        >
          <span v-if="!loading">登 录</span>
          <span v-else>登 录 中...</span>
        </el-button>
      </el-form-item>
    </el-form>
    <!--  底部  -->
    <div v-if="$store.state.settings.showFooter" id="el-login-footer">
      <span v-html="$store.state.settings.footerTxt" />
      <span> ⋅ </span>
      <a href="http://www.beian.miit.gov.cn" target="_blank">{{ $store.state.settings.caseNumber }}</a>
    </div>
  </div>
</template>

<script>
import commonUtil from '../utils/common'
import { Base64 } from 'js-base64'
import LangSelect from '@/components/LangSelect'

export default {
  name: 'Login',
  components: {
    LangSelect
  },
  data() {
    return {
      codeUrl: '',
      codeLength: 4,
      cookiePass: '',
      passwordType: 'password',
      loginForm: {
        tenantView: '0000',
        tenant: '',
        username: 'admin',
        password: '111111',
        rememberMe: false,
        code: '',
        randomStr: ''
      },
      loginRules: {
        username: [{ required: true, trigger: 'blur', message: '用户名不能为空' }],
        password: [{ required: true, trigger: 'blur', message: '密码不能为空' }],
        code: [{ required: true, trigger: 'blur', message: '验证码不能为空' }]
      },
      loading: false,
      redirect: undefined
    }
  },
  watch: {
    $route: {
      handler: function(route) {
        this.redirect = route.query && route.query.redirect
      },
      immediate: true
    }
  },
  created() {
    this.refreshCode()
  },
  methods: {

    showPassword() {
      this.passwordType === ''
        ? (this.passwordType = 'password')
        : (this.passwordType = '')
    },
    refreshCode() {
      this.loginForm.randomStr = commonUtil.randomLenNum(this.codeLength, true)
      this.codeUrl = process.env.VUE_APP_BASE_API + `/code/${this.loginForm.randomStr}`
      this.loginForm.code = ''
    },
    handleLogin() {
      this.$refs.loginForm.validate(valid => {
        if (valid) {
          this.loading = true
          this.loginForm.tenant = `${Base64.encode(this.loginForm.tenantView)}`
          this.$store.dispatch('Login', this.loginForm).then(() => {
            this.loading = false
            this.$router.push({ path: this.redirect || '/' })
          }).catch((e) => {
            console.log(e)
            this.loading = false
            this.refreshCode()
          })
        }
      })
    }
  }
}
</script>

<style lang="scss" rel="stylesheet/scss">
  .login {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100%;
    background-color: #f8f8f9;
    /*请更换为自己的地址，不保证该地址不被删除*/
    /*background-image:url(https://aurora-1255840532.cos.ap-chengdu.myqcloud.com/bg.jpeg);*/
    /*background-size: cover;*/
  }

  .title {
    margin: 0 auto 30px auto;
    text-align: center;
    color: #707070;
  }

  .login-form {
    border-radius: 6px;
    background: #ffffff;
    width: 385px;
    padding: 25px 25px 5px 25px;
    box-shadow: -4px 5px 10px rgba(0, 0, 0, 0.4);

    .el-input {
      height: 38px;

      input {
        height: 38px;
      }
    }

    .input-icon {
      height: 39px;
      width: 14px;
      margin-left: 2px;
    }
  }

  .login-tip {
    font-size: 13px;
    text-align: center;
    color: #bfbfbf;
  }

  .login-code {
    width: 33%;
    display: inline-block;
    height: 38px;
    float: right;

    img {
      cursor: pointer;
      vertical-align: middle
    }
  }
</style>
