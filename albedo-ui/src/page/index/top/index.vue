<template>
  <div class="avue-top">
    <div class="top-bar__left">
      <div class="avue-breadcrumb"
           :class="[{ 'avue-breadcrumb--active': isCollapse }]"
           v-if="showCollapse">
        <i class="icon-navicon"
           @click="setCollapse"></i>
      </div>
    </div>
    <div class="top-bar__title">
      <div class="top-bar__item top-bar__item--show"
           v-if="showMenu">
        <top-menu></top-menu>
      </div>
    </div>
    <div class="top-bar__right">
      <el-tooltip v-if="showLock"
                  effect="dark"
                  content="锁屏"
                  placement="bottom">
      </el-tooltip>
      <el-tooltip v-if="showFullScren"
                  effect="dark"
                  :content="isFullScreen?'退出全屏':'全屏'"
                  placement="bottom">
        <div class="top-bar__item">
          <i :class="isFullScreen?'icon-tuichuquanping':'icon-quanping'"
             @click="handleScreen"></i>
        </div>
      </el-tooltip>
      <el-dropdown>
        <span class="el-dropdown-link">
          {{userVo.username}}
          <i class="el-icon-arrow-down el-icon--right"></i>
        </span>
        <el-dropdown-menu slot="dropdown">
          <el-dropdown-item>
            <router-link to="/">首页</router-link>
          </el-dropdown-item>
          <el-dropdown-item>
            <router-link to="/info/index">个人信息</router-link>
          </el-dropdown-item>
          <el-dropdown-item @click.native="logout"
                            divided>退出系统
          </el-dropdown-item>
        </el-dropdown-menu>
      </el-dropdown>
    </div>
  </div>
</template>
<script>
    import {mapGetters, mapState} from "vuex";
    import {fullscreenToggel, listenfullscreen} from "@/util/util";
    import topMenu from "./top-menu";

    export default {
        components: {
            topMenu
        },
        name: "top",
        data() {
            return {};
        },
        filters: {},
        created() {
        },
        mounted() {
            listenfullscreen(this.setScreen);
        },
        computed: {
            ...mapState({
                showLock: state => state.common.showLock,
                showFullScren: state => state.common.showFullScren,
                showCollapse: state => state.common.showCollapse,
                showMenu: state => state.common.showMenu,
            }),
            ...mapGetters([
                "userVo",
                "isFullScreen",
                "tagWel",
                "tagList",
                "isCollapse",
                "tag",
                "logsLen",
                "logsFlag"
            ])
        },
        methods: {
            handleScreen() {
                fullscreenToggel();
            },
            setCollapse() {
                this.$store.commit("SET_COLLAPSE");
            },
            setScreen() {
                this.$store.commit("SET_FULLSCREN");
            },
            logout() {
                this.$confirm("是否退出系统, 是否继续?", "提示", {
                    confirmButtonText: "确定",
                    cancelButtonText: "取消",
                    type: "warning"
                }).then(() => {
                    this.$store.dispatch("LogOut").then(() => {
                        this.$router.push({path: "/login"});
                    });
                });
            }
        }
    };
</script>

<style lang="scss" scoped>
</style>
