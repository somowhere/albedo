<template>
  <div class="menu-wrapper">
    <template v-for="item in menu">
      <el-menu-item :class="{'is-active':vaildAvtive(item)}"
                    :index="item[pathKey]"
                    :key="item[labelKey]"
                    @click="open(item)"
                    v-if="checkNull(item[childrenKey]) && vaildRoles(item) && vaildMenuType(item)">
        <i :class="item[iconKey]"></i>
        <span :alt="item[pathKey]"
              slot="title">{{item[labelKey]}}</span>
      </el-menu-item>
      <el-submenu :index="item[pathKey]"
                  :key="item[labelKey]"
                  v-else-if="!checkNull(item[childrenKey])&& vaildRoles(item) && vaildMenuType(item)">
        <template slot="title">
          <i :class="item[iconKey]"></i>
          <span :class="{'el-menu--display':collapse && first}"
                slot="title">{{item[labelKey]}}</span>
        </template>
        <template v-for="(child,cindex) in item[childrenKey]">
          <el-menu-item :class="{'is-active':vaildAvtive(child)}"
                        :index="child[pathKey],cindex"
                        :key="child[labelKey]"
                        @click="open(child)"
                        v-if="checkNull(child[childrenKey]) && vaildMenuType(child) ">
            <i :class="child[iconKey]"></i>
            <span slot="title">{{child[labelKey]}}</span>
          </el-menu-item>
          <sidebar-item :collapse="collapse"
                        :key="cindex"
                        :menu="[child]"
                        :props="props"
                        :screen="screen"
                        v-else></sidebar-item>
        </template>
      </el-submenu>
    </template>
  </div>
</template>
<script>
    import {mapGetters} from "vuex";
    import validate from "@/util/validate";
    import config from "./config.js";

    export default {
        name: "sidebarItem",
        data() {
            return {
                config: config
            };
        },
        props: {
            menu: {
                type: Array
            },
            screen: {
                type: Number
            },
            first: {
                type: Boolean,
                default: false
            },
            props: {
                type: Object,
                default: () => {
                    return {};
                }
            },
            collapse: {
                type: Boolean
            }
        },
        created() {
        },
        mounted() {
        },
        computed: {
            ...mapGetters(["roles"]),
            labelKey() {
                return this.props.label || this.config.propsDefault.label;
            },
            pathKey() {
                return this.props.path || this.config.propsDefault.path;
            },
            iconKey() {
                return this.props.icon || this.config.propsDefault.icon;
            },
            childrenKey() {
                return this.props.children || this.config.propsDefault.children;
            },
            nowTagValue() {
                return this.$router.$avueRouter.getValue(this.$route);
            }
        },
        methods: {
            vaildAvtive(item) {
                const groupFlag = (item["group"] || []).some(ele =>
                    this.$route.path.includes(ele)
                );
                return this.nowTagValue === item[this.pathKey] || groupFlag;
            },
            vaildRoles(item) {
                item.meta = item.meta || {};
                return item.meta.roles ? item.meta.roles.includes(this.roles) : true;
            },
            vaildMenuType(item) {
                return item.type === "0";
            },
            checkNull(val) {
                return validate.checkNull(val);
            },
            open(item) {
                if (this.screen <= 1) this.$store.commit("SET_COLLAPSE");
                this.$router.$avueRouter.group = item.group;
                this.$router.push({
                    path: this.$router.$avueRouter.getPath({
                        name: item[this.labelKey],
                        src: item[this.pathKey]
                    }),
                    query: item.query
                });
            }
        }
    };
</script>

