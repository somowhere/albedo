<template>
  <div class="login-container"
       @keyup.enter.native="handleLogin">
    <div class="login-weaper  animated bounceInDown">
      <div class="login-left">
        <img class="img"
             src="/img/logo.png"
             alt="">
        <p class="title">{{website.infoTitle}}</p>
        <p>©2019 v2.3.0</p>
      </div>
      <div class="login-border">
        <div class="login-main">
          <userLogin v-if="activeName==='user'"></userLogin>
          <div class="login-menu">
            <a href="http://localhost:8061/swagger-ui.html" target="_blank">swagger api</a>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
    import '@/styles/login.scss'
    import userLogin from "./userlogin";
    import {mapGetters} from "vuex";

    export default {
        name: "login",
        components: {
            userLogin
        },
        data() {
            return {
                activeName: "user"
            };
        },
        watch: {},
        created() {
        },
        mounted() {
        },
        computed: {
            ...mapGetters(["website"])
        },
        props: [],
        methods: {}
    };
</script>

