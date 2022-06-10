<template>
  <div class="app-container">
    <!--工具栏-->
    <div class="head-container">
      <div v-if="crud.props.searchToggle">
        <el-input
          v-model="query.bizType"
          class="filter-item input-small"
          clearable
          placeholder="输入业务类型搜索"
          size="small"
          @keyup.enter.native="toQuery"
        />
        <el-input
          v-model="query.originalFileName"
          class="filter-item input-small"
          clearable
          placeholder="输入原始文件名搜索"
          size="small"
          @keyup.enter.native="toQuery"
        />
        <el-select
          v-model="query.fileType"
          class="filter-item"
          clearable
          placeholder="文件类型"
          size="small"
          style="width: 100px"
          @change="crud.toQuery"
        >
          <el-option v-for="(item,index) in fileTypeOptions" :key="index" :label="item.label" :value="item.value" />
        </el-select>

        <el-select
          v-model="query.storageType"
          class="filter-item"
          clearable
          placeholder="存储类型"
          size="small"
          style="width: 100px"
          @change="crud.toQuery"
        >
          <el-option v-for="(item,index) in storageTypeOptions" :key="index" :label="item.label" :value="item.value" />
        </el-select>
        <rrOperation />
      </div>
      <crudOperation :permission="permission">
        <el-button
          slot="right"
          plain
          class="filter-item"
          icon="el-icon-tickets"
          size="mini"
          @click="upload"
        >上传
        </el-button>

        <el-button
          slot="right"
          :disabled="crud.selections.length < 1"
          plain
          class="filter-item"
          icon="el-icon-tickets"
          size="mini"
          @click="batchDownload()"
        >下载
        </el-button>
      </crudOperation>
    </div>
    <attachment-edit
      ref="edit"
      :dialog-visible="dialog.isVisible"
      :type="dialog.type"
      @close="editClose"
      @success="editSuccess"
    />
    <!--表格渲染-->
    <el-table
      ref="table"
      v-loading="crud.loading"
      :data="crud.data"
      style="width: 100%;"
      :default-sort="{prop:'createdDate',order:'descending'}"
      @sort-change="crud.sortChange"
      @selection-change="crud.selectionChangeHandler"
    >
      <el-table-column type="selection" width="55" />
      <el-table-column :show-overflow-tooltip="true" align="center" label="业务类型" prop="bizType" />
      <el-table-column :show-overflow-tooltip="true" align="center" label="文件类型" prop="fileType">
        <template slot-scope="scope">
          <el-tag>{{ scope.row.fileTypeText }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column :show-overflow-tooltip="true" align="center" label="存储类型" prop="storageType">
        <template slot-scope="scope">
          <el-tag>{{ scope.row.storageTypeText }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column :show-overflow-tooltip="true" align="center" label="桶" prop="bucket" />
      <el-table-column :show-overflow-tooltip="true" align="center" label="文件相对地址" prop="path" />
      <el-table-column :show-overflow-tooltip="true" align="center" label="文件访问地址" prop="url" />
      <el-table-column :show-overflow-tooltip="true" align="center" label="唯一文件名" prop="uniqueFileName" />
      <el-table-column :show-overflow-tooltip="true" align="center" label="文件md5" prop="fileMd5" />
      <el-table-column :show-overflow-tooltip="true" align="center" label="原始文件名" prop="originalFileName" />
      <el-table-column :show-overflow-tooltip="true" align="center" label="文件内容类型" prop="contentType" />
      <el-table-column :show-overflow-tooltip="true" align="center" label="后缀" prop="suffix" />
      <el-table-column :show-overflow-tooltip="true" align="center" label="大小" prop="size" />
      <el-table-column prop="createdDate" label="创建时间" sortable="custom" />
      <el-table-column v-permission="[permission.del]" fixed="right" label="操作" width="180px">
        <template slot-scope="scope">
          <udOperation :data="scope.row" :permission="permission">
            <el-button
              slot="right"
              plain
              class="filter-item"
              size="mini"
              @click="download([scope.row.id])"
            >下载
            </el-button>
          </udOperation>
        </template>
      </el-table-column>
    </el-table>
    <!--分页组件-->
    <pagination />
  </div>
</template>

<script>
import crudFile from '@/views/sys/fileDo/fileDo-service'
import CRUD, { crud, form, header, presenter } from '@crud/crud'
import rrOperation from '@crud/RR.operation'
import udOperation from '@crud/UD.operation'
import crudOperation from '@crud/CRUD.operation'
import pagination from '@crud/Pagination'
import validate from '@/utils/validate'
import { mapGetters } from 'vuex'
import AttachmentEdit from './edit'
import commonUtil from '@/utils/common'

const defaultForm = {
  bizType: null,
  fileType: null,
  storageType: null,
  bucket: null,
  path: null,
  url: null,
  uniqueFileName: null,
  fileMd5: null,
  originalFileName: null,
  contentType: null,
  suffix: null,
  size: null,
  description: null
}
export default {
  name: 'File',
  components: { crudOperation, rrOperation, udOperation, pagination, AttachmentEdit },
  cruds() {
    return CRUD({ sorts: ['createdDate,desc'], title: '附件管理', crudMethod: { ...crudFile }})
  },
  mixins: [presenter(), header(), form(defaultForm), crud()],
  // 数据字典
  data() {
    return {
      dialog: {
        isVisible: false,
        type: 'add'
      },
      fileTypeOptions: undefined,
      storageTypeOptions: undefined,
      delFlagOptions: undefined,
      validateNumber: (rule, value, callback) => {
        validate.isNumber(rule, value, callback)
      },
      validateDigits: (rule, value, callback) => {
        validate.isDigits(rule, value, callback)
      },
      permission: {
        add: 'sys_file_add',
        del: 'sys_file_del'
      }
    }
  },
  computed: {
    ...mapGetters(['permissions', 'dicts'])
  },
  created() {
    this.crud.optShow = {
      add: false,
      edit: false,
      del: true
    }
    this.fileTypeOptions = this.dicts['file_type']
    this.storageTypeOptions = this.dicts['file_storage_type']
    this.delFlagOptions = this.dicts['sys_flag']
  },
  methods: {
    editClose() {
      this.dialog.isVisible = false
    },
    editSuccess() {
      this.crud.refresh()
    },
    upload() {
      this.dialog.type = 'upload'
      this.dialog.isVisible = true
      this.$refs.edit.setAttachment(false)
    },
    batchDownload() {
      const ids = []
      this.crud.selections.forEach(item => {
        ids.push(item.id)
      })
      this.download(ids)
    },
    download(ids) {
      crudFile.download(ids).then(response => {
        commonUtil.downloadFileParse(response)
      })
    }
  }
}
</script>
