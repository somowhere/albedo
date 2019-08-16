<template>
  <el-form :model="loginForm"
           :rules="loginRules"
           class="login-form"
           label-width="0"
           ref="loginForm"
           status-icon>
    <el-form-item prop="username">
      <el-input @keyup.enter.native="handleLogin"
                auto-complete="off"
                placeholder="请输入用户名"
                size="small"
                v-model="loginForm.username">
        <i class="icon-yonghu"
           slot="prefix"></i>
      </el-input>
    </el-form-item>
    <el-form-item prop="password">
      <el-input :type="passwordType"
                @keyup.enter.native="handleLogin"
                auto-complete="off"
                placeholder="请输入密码"
                size="small"
                v-model="loginForm.password">
        <i @click="showPassword"
           class="el-icon-view el-input__icon"
           slot="suffix"></i>
        <i class="icon-mima"
           slot="prefix"></i>
      </el-input>
    </el-form-item>
    <el-form-item prop="code">
      <el-row :span="24">
        <el-col :span="16">
          <el-input :maxlength="code.len"
                    @keyup.enter.native="handleLogin"
                    auto-complete="off"
                    placeholder="请输入验证码"
                    size="small"
                    v-model="loginForm.code">
            <i class="icon-yanzhengma"
               slot="prefix"></i>
          </el-input>
        </el-col>
        <el-col :span="8">
          <div class="login-code">
            <span @click="refreshCode"
                  class="login-code-img"
                  v-if="code.type == 'text'">{{code.value}}</span>
            <img :src="code.src"
                 @click="refreshCode"
                 class="login-code-img"
                 v-else/>
          </div>
        </el-col>
      </el-row>

    </el-form-item>
    <el-form-item prop="rememberMe">
      <el-row :span="24">
        <el-col :span="16">
          <el-checkbox v-model="loginForm.rememberMe">记住我</el-checkbox>
        </el-col>
        <el-col :span="8">
          <div class="login-code">
            <span @click="refreshCode"
                  class="login-code-img"
                  v-if="code.type == 'text'">{{code.value}}</span>
          </div>
        </el-col>
      </el-row>

    </el-form-item>
    <el-form-item>
      <el-button @click.native.prevent="handleLogin"
                 class="login-submit"
                 size="small"
                 type="primary">登录
      </el-button>
    </el-form-item>
  </el-form>
</template>

<script>
    import util from "@/util/util";
    import {mapGetters} from "vuex";

    export default {
        name: "userlogin",
        data() {

            return {
                loginForm: {
                    username: "admin",
                    password: "admin",
                    code: "",
                    rememberMe: false,
                    redomStr: ""
                },
                checked: false,
                code: {
                    src: "/code",
                    value: "",
                    len: 4,
                    type: "image"
                },
                loginRules: {
                    username: [
                        {required: true, message: "请输入用户名", trigger: "blur"}
                    ],
                    password: [
                        {required: true, message: "请输入密码", trigger: "blur"},
                        {min: 4, message: "密码长度最少为4位", trigger: "blur"}
                    ],
                    code: [
                        {required: true, message: "请输入验证码", trigger: "blur"},
                        {min: 4, max: 4, message: "验证码长度为4位", trigger: "blur"}
                    ]
                },
                passwordType: "password"
            };
        },
        created() {
            this.refreshCode();
        },
        mounted() {
        },
        computed: {
            ...mapGetters(["tagWel"])
        },
        props: [],
        methods: {
            refreshCode() {
                this.loginForm.code = '';
                this.loginForm.randomStr = util.randomLenNum(this.code.len, true);
                this.code.type === 'text'
                    ? (this.code.value = util.randomLenNum(this.code.len))
                    : (this.code.src = `${this.codeUrl}/${this.loginForm.randomStr}`)
            },
            showPassword() {
                this.passwordType == ''
                    ? (this.passwordType = 'password')
                    : (this.passwordType = '')
            },
            handleLogin() {
                this.$refs.loginForm.validate(valid => {
                    if (valid) {
                        this.$store.dispatch("loginByUsername", this.loginForm).then(() => {
                            console.log(this.tagWel.value)
                            this.$router.push({path: this.tagWel.value});
                        }).catch((e) => {
                            this.refreshCode()
                        })

                    }
                });
            }
        }
    };
</script>

<style>
</style>
