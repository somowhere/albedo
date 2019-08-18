<template>
  <el-radio-group :disabled="disabled" @change="handleChange" v-model="text">
    <el-radio :key="index" :label="item.value" v-for="(item,index) in dic">{{item.label}}</el-radio>
  </el-radio-group>
</template>

<script>
    export default {
        name: "AvueCrudRadio",
        data() {
            return {
                text: ""
            };
        },
        props: {
            value: {
                default: ""
            },
            disabled: {
                type: Boolean,
                default: false
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
