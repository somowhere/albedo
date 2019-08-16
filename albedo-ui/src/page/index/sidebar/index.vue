<template>
  <div class="avue-sidebar">
    <logo></logo>
    <el-scrollbar style="height:100%">
      <div class="avue-sidebar--tip"
           v-if="checkNull(menu)">没有发现菜单
      </div>
      <el-menu :collapse="keyCollapse"
               :default-active="nowTagValue"
               :show-timeout="200"
               mode="vertical"
               unique-opened>
        <sidebar-item :collapse="keyCollapse"
                      :menu="menu"
                      :props="website.menu.props"
                      :screen="screen"
                      first></sidebar-item>
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
            this.$store.dispatch("getUserMenu").then(response => {
                if (response.length === 0) return;
                console.log(response);
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

