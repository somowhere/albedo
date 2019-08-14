<template>
  <div class="avue-sidebar">
    <logo></logo>
    <el-scrollbar style="height:100%">
      <div v-if="validateNull(menu)"
           class="avue-sidebar--tip">没有发现菜单
      </div>
      <el-menu unique-opened
               :default-active="nowTagValue"
               mode="vertical"
               :show-timeout="200"
               :collapse="keyCollapse">
        <sidebar-item :menu="menu"
                      :screen="screen"
                      first
                      :props="website.menu.props"
                      :collapse="keyCollapse"></sidebar-item>
      </el-menu>
    </el-scrollbar>
  </div>
</template>

<script>
    import {mapGetters} from "vuex";
    import logo from "../logo";
    import sidebarItem from "./sidebarItem";

    export default {
        name: "sidebar",
        components: {sidebarItem, logo},
        data() {
            return {};
        },
        created() {
            this.$store.dispatch("GetUserMenu").then(response => {
                if (response.length === 0) return;
                console.log(response)
                this.$router.$avueRouter.formatRoutes(response, true);
            });
        },
        computed: {
            ...mapGetters(["website", "menu", "tag", "keyCollapse", "screen"]),
            nowTagValue: function () {
                return this.$router.$avueRouter.getValue(this.$route);
            }
        },
        mounted() {
        },
        methods: {}
    };
</script>
<style lang="scss" scoped>
</style>

