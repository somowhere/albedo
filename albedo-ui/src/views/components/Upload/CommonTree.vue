<template>
  <div class="common-tree">
    <el-tree
      :ref="treeRef"
      :data="treeData"
      :check-strictly="checkStrictly"
      show-checkbox
      :accordion="false"
      node-key="id"
      default-expand-all
      :highlight-current="true"
      :expand-on-click-node="false"
      :filter-node-method="filterNodeMethod"
      @check-change="checkChange"
      @node-click="nodeClick"
      @current-change="currentChange"
    >
      <span
        slot-scope="{ data, node }"
        class="custom-tree-node"
      >
        <span style="margin-right: 15px;">{{ data.label }}</span>
        <slot
          :data="data"
          :node="node"
        />
        <!-- <template v-if='data.id !== "0"'> -->
        <!-- <span class='ope-btn' title='添加' @click='modify("onAdd", data, node)'>
            <i class='el-icon-plus' />
          </span>
          <span class='ope-btn' title='修改' @click='modify("onEdit", data, node)'>
            <i class='el-icon-edit' />
          </span>
          <span
            class='ope-btn ope-btn-remove'
            title='删除'
            @click='modify("onDelete", data, node)'
            v-if='!data.children'
          >
            <i class='el-icon-delete' />
        </span>-->
        <!-- </template> -->
      </span>
    </el-tree>
  </div>
</template>
<script>
export default {
  props: {
    treeRef: {
      type: String,
      default: 'treeRef'
    },
    treeData: {
      type: Array,
      required: true,
      default() {
        return []
      }
    },
    checkStrictly: {
      type: Boolean,
      default() {
        return true
      }
    },
    opeBtns: {
      type: Array,
      default() {
        return ['add', 'edit', 'remove']
      }
    }
  },
  methods: {
    modify(type, data, node) {
      window.event.stopPropagation()
      this.$emit(type, data, node)
    },
    checkChange(data, checked, childrenChecked) {
      this.$emit('checkChange', data, checked, childrenChecked)
    },
    nodeClick(data, node, tree) {
      this.$emit('nodeClick', data, node, tree)
    },
    currentChange(data, node) {
      this.$emit('currentChange', data, node)
    },
    filterNodeMethod(value, data) {
      // reutrn this.$emit('filterNodeMethod', value, data, node)
      if (!value) return true
      return data.label.indexOf(value) !== -1
    }
  }
}
</script>
<style lang="scss">
.common-tree {
  .el-tree-node__content {
    height: 28px;
    .custom-tree-node {
      font-size: 14px;
      height: 28px;
      line-height: 28px;
      width: 100%;
      .status-item {
        top: 4px;
      }
      .tree-icon {
        vertical-align: middle;
        float: right;
        margin-right: 10px;
        box-sizing: border-box;
      }
    }
  }
}
</style>
