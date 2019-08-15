<template>
  <div class="avue-tags"
       v-if="showTag">
    <!-- tag盒子 -->
    <div :style="{left:contentmenuX+'px',top:contentmenuY+'px'}"
         class="avue-tags__contentmenu"
         v-if="contextmenuFlag">
      <div @click="closeOthersTags"
           class="item">关闭其他
      </div>
      <div @click="closeAllTags"
           class="item">关闭全部
      </div>
    </div>
    <div :class="{'avue-tags__box--close':!website.isFirstPage}"
         class="avue-tags__box">
      <el-tabs :closable="tagLen!==1"
               @contextmenu.native="handleContextmenu"
               @edit="menuTag"
               @tab-click="openTag"
               type="card"
               v-model="active">
        <el-tab-pane :key="item.value"
                     :label="item.label"
                     :name="item.value"
                     v-for="item in tagList">
        </el-tab-pane>

      </el-tabs>
      <el-dropdown class="avue-tags__menu">
        <el-button size="mini"
                   type="primary">
          更多
          <i class="el-icon-arrow-down el-icon--right"></i>
        </el-button>
        <el-dropdown-menu slot="dropdown">
          <el-dropdown-item @click.native="closeOthersTags">关闭其他</el-dropdown-item>
          <el-dropdown-item @click.native="closeAllTags">关闭全部</el-dropdown-item>
        </el-dropdown-menu>
      </el-dropdown>
    </div>

  </div>
</template>
<script>
    import {mapGetters, mapState} from "vuex";

    export default {
        name: "tags",
        data() {
            return {
                active: "",
                contentmenuX: "",
                contentmenuY: "",
                contextmenuFlag: false
            };
        },
        created() {
        },
        mounted() {
            this.setActive();
        },
        watch: {
            tag() {
                this.setActive();
            },
            contextmenuFlag() {
                window.addEventListener("mousedown", this.watchContextmenu);
            }
        },
        computed: {
            ...mapGetters(["tagWel", "tagList", "tag", "website"]),
            ...mapState({
                showTag: state => state.common.showTag
            }),
            tagLen() {
                return this.tagList.length || 0;
            }
        },
        methods: {
            watchContextmenu() {
                if (!this.$el.contains(event.target) || event.button !== 0) {
                    this.contextmenuFlag = false;
                }

                window.removeEventListener("mousedown", this.watchContextmenu);
            },
            handleContextmenu(event) {
                let target = event.target;
                // 解决 https://github.com/d2-projects/d2-admin/issues/54
                let flag = false;
                if (target.className.indexOf("el-tabs__item") > -1) flag = true;
                else if (target.parentNode.className.indexOf("el-tabs__item") > -1) {
                    target = target.parentNode;
                    flag = true;
                }
                if (flag) {
                    event.preventDefault();
                    event.stopPropagation();
                    this.contentmenuX = event.clientX;
                    this.contentmenuY = event.clientY;
                    this.tagName = target.getAttribute("aria-controls").slice(5);
                    this.contextmenuFlag = true;
                }
            },
            //激活当前选项
            setActive() {
                this.active = this.tag.value;
            },
            menuTag(value, action) {
                if (action === "remove") {
                    let {tag, key} = this.findTag(value);
                    this.$store.commit("DEL_TAG", tag);
                    if (tag.value === this.tag.value) {
                        tag = this.tagList[key === 0 ? key : key - 1]; //如果关闭本标签让前推一个
                        this.openTag(tag);
                    }
                }
            },
            openTag(item) {
                let tag;
                if (item.name) {
                    tag = this.findTag(item.name).tag;
                } else {
                    tag = item;
                }
                this.$router.push({
                    path: this.$router.$avueRouter.getPath({
                        name: tag.label,
                        src: tag.value
                    }),
                    query: tag.query
                });
            },
            closeOthersTags() {
                this.contextmenuFlag = false;
                this.$store.commit("DEL_TAG_OTHER");
            },
            findTag(value) {
                let tag, key;
                this.tagList.map((item, index) => {
                    if (item.value === value) {
                        tag = item;
                        key = index;
                    }
                });
                return {tag: tag, key: key};
            },
            closeAllTags() {
                this.contextmenuFlag = false;
                this.$store.commit("DEL_ALL_TAG");
                this.$router.push({
                    path: this.$router.$avueRouter.getPath({
                        src: this.tagWel.value
                    }),
                    query: this.tagWel.query
                });
            }
        }
    };
</script>


