<template>
  <div>
    <basic-container>
      <div class="banner-text">
        <span>
          <img alt="Downloads" src="https://img.shields.io/badge/Spring%20Boot-2.1.2.RELEASE-yellowgreen.svg">
          <img alt="Coverage Status" src="https://img.shields.io/badge/Spring%20Cloud-Greenwich.RELEASE-blue.svg">
        </span>
        <br/>
        <span>
          <el-collapse v-model="activeNames">
            <el-collapse-item name="1" title="Albedo 2.0 pro - 单体应用">
              <div>做最实用的企业级框架</div>
              <div>- 基于 Spring Boot 2.1.6 、Spring Security 的RBAC权限管理系统  </div>
              <div>- 基于数据驱动视图的理念封装 Element-ui，即使没有 vue 的使用经验也能快速上手  </div>
              <div>- 提供 lambda 、stream api 、webflux 的生产实践   </div>
              <div>Spring Boot |  2.1.6.RELEASE</div>
              <div>Mybatis Plus | 3.1.2</div>
              <div>hutool | 4.5.16</div>
              <div>Avue | 1.6.0</div>
            </el-collapse-item>
            <el-collapse-item name="2" title="代码生成">
              <div>可配置，可视化，可复制</div>
            </el-collapse-item>
            <el-collapse-item name="4" title="其他功能">
              <div>完善的单元测试体系</div>
            </el-collapse-item>
          </el-collapse>
        </span>
      </div>

    </basic-container>
  </div>
</template>

<script>
    import {mapGetters} from 'vuex';

    export default {
        name: 'wel',
        data() {
            return {
                activeNames: ['1', '2', '3', '4'],
                DATA: [],
                text: '',
                actor: '',
                count: 0,
                isText: false
            }
        },
        computed: {
            ...mapGetters(['website'])
        },
        methods: {
            getData() {
                if (this.count < this.DATA.length - 1) {
                    this.count++
                } else {
                    this.count = 0
                }
                this.isText = true;
                this.actor = this.DATA[this.count]
            },
            setData() {
                let num = 0;
                let count = 0;
                let active = false;
                let timeoutstart = 5000;
                let timeoutend = 1000;
                let timespeed = 10;
                setInterval(() => {
                    if (this.isText) {
                        if (count == this.actor.length) {
                            active = true
                        } else {
                            active = false
                        }
                        if (active) {
                            num--;
                            this.text = this.actor.substr(0, num);
                            if (num == 0) {
                                this.isText = false;
                                setTimeout(() => {
                                    count = 0;
                                    this.getData()
                                }, timeoutend)
                            }
                        } else {
                            num++;
                            this.text = this.actor.substr(0, num);
                            if (num == this.actor.length) {
                                this.isText = false;
                                setTimeout(() => {
                                    this.isText = true;
                                    count = this.actor.length
                                }, timeoutstart)
                            }
                        }
                    }
                }, timespeed)
            }
        }
    }
</script>

<style lang="scss" scoped="scoped">
  .wel-contailer {
    position: relative;
  }

  .banner-text {
    position: relative;
    padding: 0 20px;
    font-size: 20px;
    text-align: center;
    color: #333;
  }

  .banner-img {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    opacity: 0.8;
    display: none;
  }

  .actor {
    height: 250px;
    overflow: hidden;
    font-size: 18px;
    color: #333;
  }

  .actor:after {
    content: '';
    width: 3px;
    height: 25px;
    vertical-align: -5px;
    margin-left: 5px;
    background-color: #333;
    display: inline-block;
    animation: blink 0.4s infinite alternate;
  }

  .typeing:after {
    animation: none;
  }

  @keyframes blink {
    to {
      opacity: 0;
    }
  }
</style>
