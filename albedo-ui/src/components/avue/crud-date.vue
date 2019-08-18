<template>
  <el-date-picker :disabled="disabled" :format="format" :placeholder="placeholder?placeholder:`请输入${label}`"
                  :size="size" :type="type"
                  :value-format="valueFormat" @change="handleChange"
                  v-model="text"></el-date-picker>
</template>

<script>
    export default {
        name: 'AvueCrudDate',
        data() {
            return {
                text: ''
            }
        },
        props: {
            value: {
                default: ''
            },
            type: {
                default: 'date'
            },
            valueFormat: {
                default: ''
            },
            label: {
                type: String,
                default: ''
            },
            format: {
                default: ''
            },
            size: {
                type: String,
                default: ''
            },
            disabled: {
                type: Boolean,
                default: false
            },
            placeholder: {
                type: String,
                default: ''
            }
        },
        watch: {
            value: function (n, o) {
                this.text = this.value
            }
        },
        created() {
            this.text = this.value
        },
        mounted() {
        },
        methods: {
            handleChange(value) {
                this.$emit('input', value)
            }
        }
    }
</script>

<style>
</style>
