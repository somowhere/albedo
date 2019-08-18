<template>
  <el-checkbox-group @change="handleChange" v-model="text">
    <el-checkbox :key="index" :label="item.value" v-for="(item,index) in dic">{{item.label}}</el-checkbox>
  </el-checkbox-group>
</template>

<script>
    export default {
        name: "AvueCrudCheckbox",
        data() {
            return {
                text: []
            };
        },
        props: {
            value: {
                default: () => {
                    return [];
                }
            },
            dic: {
                default: () => {
                    return [];
                }
            }
        },
        watch: {
            value: function (n, o) {
                this.text = this.value;
            }
        },
        created() {
            this.text = this.value;
        },
        mounted() {
        },
        methods: {
            handleChange(value) {
                this.$emit("input", value);
            }
        }
    };
</script>

<style>

</style>
