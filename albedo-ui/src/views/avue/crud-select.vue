<template>
  <el-select :clearable="clearable" :disabled="disabled" :filterable="filterable" :multiple="multiple"
             :placeholder="placeholder?placeholder:`请选择${label}`"
             :size="size"
             @change="handleChange" v-model="text">
    <el-option :key="index" :label="item.label" :value="item.value" v-for="(item,index) in dic">
    </el-option>
  </el-select>
</template>
<script>
    export default {
        name: 'CrudSelect',
        data() {
            return {
                text: ''
            }
        },
        props: {
            value: {
                default() {
                    return this.multiple ? [] : ''
                }
            },
            // multiple: {
            //   type: Function,
            //   default: false
            // },
            multiple: {
                type: Boolean,
                default: false
            },
            clearable: {
                type: Boolean,
                default: true
            },
            filterable: {
                type: Boolean,
                default: false
            },
            placeholder: {
                type: String,
                default: ''
            },
            label: {
                type: String,
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
            dic: {
                default: () => {
                    return []
                }
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
