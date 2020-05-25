<template>
  <div class="app-container">
    <!--工具栏-->
    <div class="head-container">
      <div v-if="crud.props.searchToggle">
        <!-- 搜索 -->
        <el-input
          v-model="query.blurry"
          class="filter-item"
          clearable
          placeholder="模糊搜索"
          size="small"
          style="width: 200px;"
          @keyup.enter.native="toQuery"
        />
        <el-date-picker
          v-model="query.createdDate"
          :default-time="['00:00:00','23:59:59']"
          class="date-item"
          end-placeholder="结束日期"
          range-separator=":"
          size="small"
          start-placeholder="开始日期"
          type="daterange"
          value-format="yyyy-MM-dd HH:mm:ss"
        />
        <rrOperation />
      </div>
      <crudOperation :permission="permission">
        <!-- 任务日志 -->
        <el-button
          slot="right"
          plain
          class="filter-item"
          icon="el-icon-tickets"
          size="mini"
          type="primary"
          @click="editSort"
        >更新排序
        </el-button>
      </crudOperation>
    </div>
    <!--表单渲染-->
    <el-dialog
      :before-close="crud.cancelCU"
      :close-on-click-modal="false"
      :name="crud.status.name"
      :visible.sync="crud.status.cu > 0"
      append-to-body
      width="580px"
    >
      <el-form ref="form" :inline="true" :model="form" label-width="80px" size="small">
        <el-form-item label="上级菜单" prop="parentId" :rules="[{ required: true, message: '请选择上级菜单', trigger: 'blur' }]">
          <treeselect v-model="form.parentId" :options="menus" placeholder="选择上级类目" style="width: 450px;" />
        </el-form-item>
        <el-form-item label="名称" prop="name" :rules="[{ required: true, message: '请填写名称', trigger: 'blur' }]">
          <el-input v-model="form.name" placeholder="名称" />
        </el-form-item>
        <el-form-item label="菜单类型" prop="type" :rules="[{ required: true, message: '请选择菜单类型', trigger: 'change' }]">
          <el-radio-group v-model="form.type" size="mini">
            <el-radio-button v-for="item in typeOptions" :key="item.value" :label="item.value">{{ item.label }}</el-radio-button>
          </el-radio-group>
        </el-form-item>
        <el-form-item v-show="form.type !== '2'" label="菜单图标" prop="icon">
          <el-popover
            placement="bottom-start"
            trigger="click"
            width="450"
            @show="$refs['iconSelect'].reset()"
          >
            <IconSelect ref="iconSelect" @selected="selected" />
            <el-input slot="reference" v-model="form.icon" placeholder="点击选择图标" readonly style="width: 450px;">
              <svg-icon
                v-if="form.icon"
                slot="prefix"
                :icon-class="form.icon"
                class="el-input__icon"
                style="height: 32px;width: 16px;"
              />
              <i v-else slot="prefix" class="el-icon-search el-input__icon" />
            </el-input>
          </el-popover>
        </el-form-item>
        <el-form-item label="权限标识" prop="permission">
          <el-input v-model="form.permission" placeholder="权限标识" style="width: 178px;" />
        </el-form-item>
        <el-form-item v-if="form.type !== '2'" label="链接地址" :rules="[{ required: true, message: '请填写链接地址', trigger: 'blur' }]" prop="path">
          <el-input v-model="form.path" placeholder="链接地址" style="width: 178px;" />
        </el-form-item>
        <el-form-item
          v-if="form.type !== '2'"
          :rules="[{ required: true, message: '请选择外链菜单', trigger: 'change' }]"
          label="外链菜单"
          prop="iframe"
        >
          <el-radio-group v-model="form.iframe" size="mini">
            <el-radio-button v-for="item in flagOptions" :key="item.value" :label="item.value">{{ item.label }}</el-radio-button>
          </el-radio-group>
        </el-form-item>
        <el-form-item
          v-if="form.type !== '2'"
          :rules="[{ required: true, message: '请选择菜单缓存', trigger: 'change' }]"
          label="菜单缓存"
          prop="cache"
        >
          <el-radio-group v-model="form.cache" size="mini">
            <el-radio-button v-for="item in flagOptions" :key="item.value" :label="item.value">{{ item.label }}</el-radio-button>
          </el-radio-group>
        </el-form-item>
        <el-form-item
          :rules="[{ required: true, message: '请选择是否隐藏', trigger: 'change' }]"
          label="是否隐藏"
          prop="hidden"
        >
          <el-radio-group v-model="form.hidden" size="mini">
            <el-radio-button v-for="item in flagOptions" :key="item.value" :label="item.value">{{ item.label }}</el-radio-button>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="菜单排序" prop="sort">
          <el-input-number
            v-model.number="form.sort"
            :max="999"
            :min="0"
            :step="5"
            controls-position="right"
            style="width: 178px;"
          />
        </el-form-item>
        <el-form-item
          v-if="form.iframe!=null && form.iframe.toString() === '0' && form.type !== '2'"
          label="组件路径"
          prop="component"
        >
          <el-input v-model="form.component" placeholder="组件路径" style="width: 178px;" />
        </el-form-item>
        <el-form-item label="备注" prop="description">
          <el-input v-model="form.description" type="textarea" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="text" @click="crud.cancelCU">取消</el-button>
        <el-button :loading="crud.status.cu === 2" type="primary" @click="crud.submitCU">确认</el-button>
      </div>
    </el-dialog>
    <!--表格渲染-->
    <el-table ref="table" v-loading="crud.loading" :data="crud.data" row-key="id" @select="crud.selectChange" @select-all="crud.selectAllChange" @selection-change="crud.selectionChangeHandler">
      <el-table-column type="selection" width="55" />
      <el-table-column :show-overflow-tooltip="true" label="菜单标题" prop="name" />
      <el-table-column align="center" label="图标" prop="icon" width="60px">
        <template slot-scope="scope">
          <svg-icon :icon-class="scope.row.icon ? scope.row.icon : ''" />
        </template>
      </el-table-column>
      <el-table-column label="菜单类型" prop="typeText" width="75px" />
      <el-table-column align="center" label="排序" prop="sort" width="125px">
        <template slot-scope="scope">
          <span>
            <el-input-number
              v-model="scope.row.sort"
              :max="999"
              style="width:115px"
              :min="0"
              :step="5"
              size="mini"
              controls-position="right"
              @blur="updateSortData(scope.row.id, scope.row.sort)"
            />
          </span>
        </template>
      </el-table-column>
      <el-table-column :show-overflow-tooltip="true" label="路由地址" prop="path" />
      <el-table-column :show-overflow-tooltip="true" label="权限标识" prop="permission" />
      <el-table-column :show-overflow-tooltip="true" label="组件路径" prop="component" />
      <el-table-column label="是否外链" prop="iframeText" width="75px" />
      <el-table-column label="是否缓存" prop="cacheText" width="75px" />
      <el-table-column label="是否隐藏" prop="hiddenText" width="75px" />
      <el-table-column
        :show-overflow-tooltip="true"
        label="创建日期"
        prop="createdDate"
        width="140"
      />
      <el-table-column
        v-permission="[permission.edit, permission.del]"
        f
        align="center"
        fixed="right"
        label="操作"
        width="130px"
      >
        <template slot-scope="scope">
          <udOperation
            :data="scope.row"
            :permission="permission"
            msg="确定删除吗,如果存在下级节点则一并删除，此操作不能撤销！"
          />
        </template>
      </el-table-column>
    </el-table>
  </div>
</template>

<script>
import crudMenu from '@/views/sys/menu/menu-service'
import IconSelect from '@/components/IconSelect'
import Treeselect from '@riophae/vue-treeselect'
import '@riophae/vue-treeselect/dist/vue-treeselect.css'
import CRUD, { crud, form, header, presenter } from '@crud/crud'
import rrOperation from '@crud/RR.operation'
import crudOperation from '@crud/CRUD.operation'
import udOperation from '@crud/UD.operation'
import { mapGetters } from 'vuex'
import validate from '../../../utils/validate'

// crud交由presenter持有
const defaultForm = {
  id: null,
  name: null,
  sort: 30,
  path: null,
  component: null,
  iframe: null,
  roles: [],
  parentId: -1,
  icon: null,
  cache: null,
  hidden: null,
  type: '0',
  permission: null,
  description: null
}
export default {
  name: 'Menu',
  components: { Treeselect, IconSelect, crudOperation, rrOperation, udOperation },
  cruds() {
    return CRUD({ name: '菜单', crudMethod: { ...crudMenu }})
  },
  mixins: [presenter(), header(), form(defaultForm), crud()],
  data() {
    return {
      menus: [],
      permission: {
        edit: 'sys_menu_edit',
        del: 'sys_menu_del'
      },
      sortData: [],
      flagOptions: [],
      typeOptions: []
    }
  },
  computed: {
    ...mapGetters([
      'dicts'
    ])
  },
  created() {
    this.flagOptions = this.dicts['sys_flag']
    this.typeOptions = this.dicts['sys_menu_type']
  },
  methods: {
    // 新增与编辑前做的操作
    [CRUD.HOOK.afterToCU](crud, form) {
      crudMenu.getTree({ notId: form.id }).then(res => {
        this.menus = []
        const menu = { id: -1, label: '顶级类目', children: [] }
        menu.children = res.data
        this.menus.push(menu)
      })
    },
    updateSortData(id, sort) {
      const obj = this.sortData.find(item => {
        const flag = (item.id === id)
        if (flag) {
          item.sort = sort
        }
        return flag
      })
      if (validate.checkNull(obj)) {
        this.sortData.push({ id: id, sort: sort })
      }
      console.log(this.sortData)
    },
    editSort() {
      if (validate.checkNull(this.sortData)) {
        this.$message({
          message: '请编辑需要更新的排序',
          type: 'warning'
        })
        return false
      }
      crudMenu.sortUpdate({ menuSortList: this.sortData }).then(response => {
        this.crud.refresh()
      })
    },
    // 选中图标
    selected(name) {
      this.form.icon = name
    }
  }
}
</script>

