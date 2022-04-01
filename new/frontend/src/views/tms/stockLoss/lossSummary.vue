<template> 
  <div class="app-container">
    <el-card class="filter-container" shadow="never">

      <div>
        <i class="el-icon-tickets"></i>
        <span>库损汇总列表</span>
      </div>
      <div style="float:left;margin-top: 8px">
        <el-form :inline="true" :model="listQuery" size="small">
          <el-form-item>
            <el-input v-model="listQuery.keyword" class="input-width" placeholder="耗材编号/耗材名称"
                      clearable @keyup.enter.native="handleSearchList"></el-input>
          </el-form-item>
        </el-form>
      </div>
      <el-button size="small" style="float:right;margin-right: 15px;margin-top: 8px"
                 type="primary" :loading="loading"
                 @click.native.prevent="handleSearchList">查询搜索
      </el-button>
      <el-button
        style="float:right;margin-right: 10px;margin-top: 8px"
        @click="handleResetSearch()"
        size="small">
        重置
      </el-button>
    </el-card>
    <div class="table-container">
      <el-table ref="StockCentreTable"
                :data="list"
                max-height="600"
                :row-class-name="rowClassName"
                style="width: 100%;"
                v-loading="listLoading" border>
        <el-table-column prop="newId" align="center" label="序号" width="60"></el-table-column>
        <el-table-column label="耗材名称" min-width="160%" align="center">
          <template slot-scope="scope">{{ scope.row.reagentName }}</template>
        </el-table-column>
        <el-table-column label="耗材状态" align="center">
          <template slot-scope="scope">
            {{ statusData[(scope.row.reagentStatus)].label }}
          </template>
        </el-table-column>
        <el-table-column label="库损数量"  align="center">
          <template slot-scope="scope">{{ scope.row.statusCount }}</template>
        </el-table-column>

        <el-table-column label="操作" align="center">
          <template slot-scope="scope">
            <el-button size="mini"
                       type="primary"
                       @click="handleViewStock(scope.$index, scope.row)">查看
            </el-button>
          </template>
        </el-table-column>
      </el-table>
    </div>
    <el-button style="margin-top: 20px" size="small" @click="back()">返回</el-button>
    <div class="pagination-container">
      <el-pagination
        background
        @size-change="handleSizeChange"
        @current-change="handleCurrentChange"
        layout="total, sizes,prev, pager, next,jumper"
        :current-page.sync="listQuery.pageNum"
        :page-size="listQuery.pageSize"
        :page-sizes="[50,100,200]"
        :total="total">
      </el-pagination>
    </div>

  </div>
</template>
<script>
import {lossSummary} from '@/api/stockDetail'
import {formatDate} from '@/utils/date';
import {getCookie} from '@/utils/support';

const defaultListQuery = {
  pageNum: 1,
  pageSize: 50,
  keyword: null,
  username: getCookie("username")
};
export default {
  name: 'StockCentreList',
  data() {
    return {
      listQuery: Object.assign({}, defaultListQuery),
      list: null,
      total: null,
      loading: false,
      listLoading: false,
      //试剂状态
      statusData: [
        {
          value: '0',
          label: '丢失'
        }, {
          value: '1',
          label: '破损'
        }, {
          value: '2',
          label: '过期'
        }, {
          value: '4',
          label: '其他原因库损'
        },
      ],
    }
  },
  created() {
    this.getList();
  },
  filters: {
    formatDateTime(time) {
      if (time == null || time === '') {
        return 'N/A';
      }
      let date = new Date(time);
      return formatDate(date, 'yyyy-MM-dd hh:mm:ss')
    }
  },
  methods: {
    rowClassName({row, rowIndex}) {
      //把每一行的索引放进row.id
      row.newId = (this.listQuery.pageSize * (this.listQuery.pageNum - 1) ) + rowIndex + 1;
    },
    back() {
      if (window.history.length <= 1) {
        this.$router.push({path: '/'})
        return false
      } else {
        this.$router.go(-1)
      }
    },
    handleViewStock(index, row) {
      this.$router.push({
        path: '/tms/stockLoss',
        query: {reagentId: row.reagentId,reagentStatus: row.reagentStatus}})
    },
    handleResetSearch() {
      this.listQuery = Object.assign({}, defaultListQuery);
    },
    handleSearchList() {
      this.listQuery.pageNum = 1;
      this.getList();
    },
    handleSizeChange(val) {
      this.listQuery.pageNum = 1;
      this.listQuery.pageSize = val;
      this.getList();
    },
    handleCurrentChange(val) {
      this.listQuery.pageNum = val;
      this.getList();
    },
    getList() {
      this.listLoading = true;
      lossSummary(this.listQuery).then(response => {
        this.listLoading = false;
        this.list = response.data.list;
        this.total = response.data.total;
      });
    },
  }
}
</script>
<style>
.stock-width {
  width: 120px;
}
</style>


