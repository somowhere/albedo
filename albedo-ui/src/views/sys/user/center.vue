<template>
  <div class="app-container">
    <el-row :gutter="20">
      <el-col :lg="6" :md="8" :sm="24" :xl="5" :xs="24" style="margin-bottom: 10px">
        <el-card class="box-card">
          <div slot="header" class="clearfix">
            <span>个人信息</span>
          </div>
          <div>
            <div style="text-align: center">
              <el-upload
                :action="updateAvatarApi"
                :headers="headers"
                :on-error="handleError"
                :on-success="handleSuccess"
                :show-file-list="false"
                class="avatar-uploader"
              >
                <img
                  :src="user.avatarName ? baseApi + '/avatar/' + user.avatarName : Avatar"
                  class="avatar"
                  title="点击上传头像"
                >
              </el-upload>
            </div>
            <ul class="user-info">
              <li>
                <div style="height: 100%">
                  <svg-icon icon-class="login" />
                  登录账号
                  <div class="user-right">{{ user.username }}</div>
                </div>
              </li>
              <li>
                <svg-icon icon-class="user1" />
                用户昵称
                <div class="user-right">{{ user.nickname }}</div>
              </li>
              <li>
                <svg-icon icon-class="dept" />
                所属部门
                <div class="user-right"> {{ user.deptName }}</div>
              </li>
              <li>
                <svg-icon icon-class="phone" />
                手机号码
                <div class="user-right">{{ user.phone }}</div>
              </li>
              <li>
                <svg-icon icon-class="email" />
                用户邮箱
                <div class="user-right">{{ user.email }}</div>
              </li>
              <li>
                <svg-icon icon-class="anq" />
                安全设置
                <div class="user-right">
                  <a @click="$refs.pass.dialog = true">修改密码</a>
                  <a @click="$refs.email.dialog = true">修改邮箱</a>
                </div>
              </li>
            </ul>
          </div>
        </el-card>
      </el-col>
      <el-col :lg="18" :md="16" :sm="24" :xl="19" :xs="24">
        <!--    用户资料    -->
        <el-card class="box-card">
          <el-tabs v-model="activeName" @tab-click="handleClick">
            <el-tab-pane label="用户资料" name="first">
              <el-form
                ref="form"
                :model="form"
                :rules="rules"
                label-width="65px"
                size="small"
                style="margin-top: 10px;"
              >
                <el-form-item label="昵称" prop="nickName">
                  <el-input v-model="form.nickName" style="width: 35%" />
                  <span style="color: #C0C0C0;margin-left: 10px;">用户昵称不作为登录使用</span>
                </el-form-item>
                <el-form-item label="手机号" prop="phone">
                  <el-input v-model="form.phone" style="width: 35%;" />
                  <span style="color: #C0C0C0;margin-left: 10px;">手机号码不能重复</span>
                </el-form-item>
                <!--                <el-form-item label="性别">-->
                <!--                  <el-radio-group v-model="form.gender" style="width: 178px">-->
                <!--                    <el-radio label="男">男</el-radio>-->
                <!--                    <el-radio label="女">女</el-radio>-->
                <!--                  </el-radio-group>-->
                <!--                </el-form-item>-->
                <el-form-item label="">
                  <el-button :loading="saveLoading" size="mini" type="primary" @click="doSubmit">保存配置</el-button>
                </el-form-item>
              </el-form>
            </el-tab-pane>
            <!--    操作日志    -->
            <el-tab-pane label="操作日志" name="second">
              <el-table v-loading="loading" :data="data" style="width: 100%;">
                <el-table-column label="行为">
                  <template slot-scope="scope">
                    {{ scope.row.title }}{{ scope.row.businessTypeText }}
                  </template>
                </el-table-column>
                <el-table-column label="IP" prop="ipAddress" />
                <el-table-column :show-overflow-tooltip="true" label="IP来源" prop="ipLocation" />
                <el-table-column label="浏览器" prop="browser" />
                <el-table-column align="center" label="请求耗时" prop="time">
                  <template slot-scope="scope">
                    <el-tag v-if="scope.row.time <= 300">{{ scope.row.time }}ms</el-tag>
                    <el-tag v-else-if="scope.row.time <= 1000" type="warning">{{ scope.row.time }}ms</el-tag>
                    <el-tag v-else type="danger">{{ scope.row.time }}ms</el-tag>
                  </template>
                </el-table-column>
                <el-table-column
                  align="right"
                >
                  <template slot="header">
                    <div style="display:inline-block;float: right;cursor: pointer" @click="init">创建日期<i
                      class="el-icon-refresh"
                      style="margin-left: 40px"
                    /></div>
                  </template>
                  <template slot-scope="scope">
                    <span>{{ parseTime(scope.row.createdDate) }}</span>
                  </template>
                </el-table-column>
              </el-table>
              <!--分页组件-->
              <el-pagination
                :current-page="page + 1"
                :total="total"
                layout="total, prev, pager, next, sizes"
                style="margin-top: 8px;"
                @current-change="pageChange"
                @size-change="sizeChange"
              />
            </el-tab-pane>
          </el-tabs>
        </el-card>
      </el-col>
    </el-row>
    <updateEmail ref="email" :email="user.email" />
    <updatePass ref="pass" />
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import updatePass from './center/updatePass'
import updateEmail from './center/updateEmail'
import { getToken } from '@/utils/auth'
import store from '@/store'
import validate from '@/utils/validate'
import commonUtil from '@/utils/common'
import crud from '@/mixins/crud'
import { editUser } from '@/views/sys/user'
import Avatar from '@/assets/images/avatar.png'

const parseTime = commonUtil.parseTime
export default {
  name: 'Center',
  components: { updatePass, updateEmail },
  mixins: [crud],
  data() {
    // 自定义验证
    const validPhone = (rule, value, callback) => {
      if (!value) {
        callback(new Error('请输入电话号码'))
      } else if (!validate.isvalidPhone(value)) {
        callback(new Error('请输入正确的11位手机号码'))
      } else {
        callback()
      }
    }
    return {
      Avatar: Avatar,
      activeName: 'first',
      saveLoading: false,
      headers: {
        'Authorization': getToken()
      },
      form: {},
      rules: {
        nickName: [
          { required: true, message: '请输入用户昵称', trigger: 'blur' },
          { min: 2, max: 20, message: '长度在 2 到 20 个字符', trigger: 'blur' }
        ],
        phone: [
          { required: true, trigger: 'blur', validator: validPhone }
        ]
      }
    }
  },
  computed: {
    ...mapGetters([
      'user',
      'updateAvatarApi',
      'baseApi'
    ])
  },
  created() {
    this.form = { id: this.user.id, nickName: this.user.nickName, gender: this.user.gender, phone: this.user.phone }
    store.dispatch('GetUser').then(() => {
    })
  },
  methods: {
    parseTime,
    handleClick(tab, event) {
      if (tab.name === 'second') {
        this.init()
      }
    },
    beforeInit() {
      this.url = '/sys/log-operate/user'
      return true
    },
    handleSuccess(response, file, fileList) {
      this.$notify({
        title: '头像修改成功',
        type: 'success',
        duration: 2500
      })
      store.dispatch('GetUser').then(() => {
      })
    },
    // 监听上传失败
    handleError(e, file, fileList) {
      const msg = JSON.parse(e.message)
      this.$notify({
        title: msg.message,
        type: 'error',
        duration: 2500
      })
    },
    doSubmit() {
      if (this.$refs['form']) {
        this.$refs['form'].validate((valid) => {
          if (valid) {
            this.saveLoading = true
            editUser(this.form).then(() => {
              this.editSuccessNotify()
              store.dispatch('GetUser').then(() => {
              })
              this.saveLoading = false
            }).catch(() => {
              this.saveLoading = false
            })
          }
        })
      }
    }
  }
}
</script>

<style lang="scss" rel="stylesheet/scss">
  .avatar-uploader-icon {
    font-size: 28px;
    width: 120px;
    height: 120px;
    line-height: 120px;
    text-align: center
  }

  .avatar {
    width: 120px;
    height: 120px;
    display: block;
    border-radius: 50%
  }

  .user-info {
    padding-left: 0;
    list-style: none;

    li {
      border-bottom: 1px solid #F0F3F4;
      padding: 11px 0;
      font-size: 13px;
    }

    .user-right {
      float: right;

      a {
        color: #317EF3;
      }
    }
  }
</style>
