<template>
  <div class="top-menu">
    <el-menu :default-active="activeIndex"
             mode="horizontal"
             text-color="#333">
      <template v-for="(item,index) in items">
        <el-menu-item :index="item.parentId+''"
                      :key="index"
                      @click.native="openMenu(item)">
          <template slot="title">
            <i :class="item.icon"></i>
            <span>{{item.label}}</span>
          </template>
        </el-menu-item>
      </template>
    </el-menu>
  </div>
</template>

<script>
    import {mapGetters} from "vuex";

    export default {
        name: "top-menu",
        data() {
            return {
                activeIndex: "0",
                items: []
            };
        },
        created() {
        },
        computed: {
            ...mapGetters(["tagCurrent", "menu"])
        },
        methods: {
            openMenu(item) {
                this.$store.dispatch("getUserMenu", item.parentId).then(response => {
                    if (response.length !== 0) {
                        this.$router.$avueRouter.formatRoutes(response, true);
                    }
                    let itemActive,
                        childItemActive = 0;
                    if (item.path) {
                        itemActive = item;
                    } else {
                        if (this.menu[childItemActive].length == 0) {
                            itemActive = this.menu[childItemActive];
                        } else {
                            itemActive = this.menu[childItemActive].children[childItemActive];
                        }
                    }
                    this.$router.push({
                        path: this.$router.$avueRouter.getPath({
                            name: itemActive.label,
                            src: itemActive.path
                        })
                    });
                });
            }
        }
    };
</script>
