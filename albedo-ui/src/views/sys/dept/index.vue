`<!--
  -    Copyright (c) 2018-2025, lengleng All rights reserved.
  -
  - Redistribution and use in source and binary forms, with or without
  - modification, are permitted provided that the following conditions are met:
  -
  - Redistributions of source code must retain the above copyright notice,
  - this list of conditions and the following disclaimer.
  - Redistributions in binary form must reproduce the above copyright
  - notice, this list of conditions and the following disclaimer in the
  - documentation and/or other materials provided with the distribution.
  - Neither the name of the pig4cloud.com developer nor the names of its
  - contributors may be used to endorse or promote products derived from
  - this software without specific prior written permission.
  - Author: lengleng (wangiegie@gmail.com)
  -->

<template>
  <div class="app-container calendar-list-container">
    <basic-container>
      <div class="filter-container">
        <el-button-group>
          <el-button type="primary"
                     v-if="sys_dept_edit"
                     icon="plus" size="small"
                     @click="handlerAdd">添加
          </el-button>
          <el-button type="primary"
                     v-if="sys_dept_edit" size="small"
                     icon="edit"
                     @click="handlerEdit">编辑
          </el-button>
          <el-button type="primary"
                     v-if="sys_dept_del" size="small"
                     icon="delete"
                     @click="handleDelete">删除
          </el-button>
        </el-button-group>
      </div>

      <el-row>
        <el-col :span="8"
                style='margin-top:15px;'>
          <el-tree class="filter-tree"
                   :data="treeDeptData"
                   node-key="id"
                   highlight-current
                   :expand-on-click-node="false"
                   :filter-node-method="filterNode"
                   @node-click="getNodeData"
                   default-expand-all>
          </el-tree>
        </el-col>
        <el-dialog title="选择父级节点" :visible.sync="dialogDeptVisible">
          <el-tree class="filter-tree" ref="selectParentDeptTree" default-expand-all :data="treeDeptSelectData"
                   check-strictly node-key="id" highlight-current @node-click="clickNodeSelectData">
          </el-tree>
        </el-dialog>
        <el-col :span="16"
                style='margin-top:15px;'>
          <el-card class="box-card">
            <el-form :label-position="labelPosition"
                     label-width="80px"
                     :rules="rules"
                     :model="form"
                     ref="form">

              <el-form-item label="父级节点" prop="parentName">
                <el-input v-model="form.parentName" placeholder="选择父级节点" @focus="handleParentDeptTree()"
                          :disabled="formEdit" readonly>
                </el-input>
                <input type="hidden" v-model="form.parentId"/>
              </el-form-item>

              <el-form-item label="节点编号"
                            prop="deptId"
                            v-if="formEdit">
                <el-input v-model="form.deptId"
                          :disabled="formEdit"
                          placeholder="节点编号"></el-input>
              </el-form-item>
              <el-form-item label="部门名称"
                            prop="name">
                <el-input v-model="form.name"
                          :disabled="formEdit"
                          placeholder="请输入名称"></el-input>
              </el-form-item>
              <el-form-item label="排序"
                            prop="orderNum">
                <el-input type="number"
                          v-model="form.sort"
                          :disabled="formEdit"
                          placeholder="请输入排序"></el-input>
              </el-form-item>
              <el-form-item label="描述" prop="description">
                <el-input type="textarea" v-model="form.description" :disabled="formEdit" placeholder=""></el-input>
              </el-form-item>
              <el-button type="primary" size="small"
                         @click="save">保存
              </el-button>
              <el-button @click="onCancel" size="small">取消</el-button>
            </el-form>
          </el-card>
        </el-col>
      </el-row>
    </basic-container>
  </div>
</template>

<script>
    import {fetchTree, getDept, removeDept, saveDept} from './service'
    import {mapGetters} from 'vuex'

    export default {
        name: 'dept',
        data() {
            return {
                dialogDeptVisible: false,
                list: null,
                total: null,
                formEdit: true,
                formAdd: true,
                formStatus: '',
                showElement: false,
                treeDeptData: [],
                treeDeptSelectData: [],
                rules: {
                    parentId: [
                        {required: true, message: '请输入父级节点', trigger: 'blur'}
                    ],
                    deptId: [
                        {required: true, message: '请输入节点编号', trigger: 'blur'}
                    ],
                    name: [
                        {required: true, message: '请输入部门名称', trigger: 'blur'}
                    ],
                },
                labelPosition: 'right',
                form: {
                    name: undefined,
                    orderNum: undefined,
                    parentId: undefined,
                    deptId: undefined,
                    description: undefined
                },
                currentId: 0,
                sys_dept_edit: false,
                sys_dept_del: false
            }
        },
        created() {
            this.getList()
            this.sys_dept_edit = this.permissions['sys_dept_edit']
            this.sys_dept_del = this.permissions['sys_dept_del']
        },
        computed: {
            ...mapGetters([
                'elements',
                'permissions'
            ])
        },
        methods: {
            getList() {
                fetchTree().then(response => {
                    this.treeDeptData = response.data
                })
            },
            filterNode(value, data) {
                if (!value) return true
                return data.label.indexOf(value) !== -1
            },
            getNodeData(data) {
                if (!this.formEdit) {
                    this.formStatus = 'update'
                }
                getDept(data.id).then(response => {
                    this.form = response.data
                })

                this.currentId = data.id
                this.showElement = true
            },
            clickNodeSelectData(data) {
                this.form.parentId = data.id;
                this.form.parentName = data.label;
                this.dialogDeptVisible = false;
            },
            handleParentDeptTree() {
                fetchTree({extId: this.form.id}).then(response => {
                    this.treeDeptSelectData = response.data;
                    this.dialogDeptVisible = true;
                    setTimeout(() => {
                        this.$refs['selectParentDeptTree'].setCurrentKey(this.form.parentId ? this.form.parentId : null);
                    }, 100)
                })
            },
            handlerEdit() {
                if (this.form.id) {
                    this.formEdit = false
                    this.formStatus = 'update'
                }
            },
            handlerAdd() {
                this.resetForm()
                this.formEdit = false
                this.formStatus = 'create'
            },
            handleDelete() {
                this.$confirm('此操作将永久删除, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    removeDept(this.currentId).then(response => {
                        this.getList()
                        this.resetForm()
                        this.onCancel()
                        this.$notify({
                            title: '成功',
                            message: '删除成功',
                            type: 'success',
                            duration: 2000
                        })
                    })
                })
            },
            save() {
                this.$refs.form.validate((valid) => {
                    if (!valid) return
                    saveDept(this.form).then(response => {
                        this.getList()
                    })
                })
            },
            onCancel() {
                this.formEdit = true
                this.formStatus = ''
            },
            resetForm() {
                this.form = {
                    parentId: this.currentId,
                }
            }
        }
    }
</script>

