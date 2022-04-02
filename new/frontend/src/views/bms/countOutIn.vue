<template> 
  <div class="app-container">
    <el-card class="filter-container" shadow="never">
      <i class="el-icon-tickets"></i>
      <span>时段出入库统计列表</span>
      <el-button
        style="float:right;margin-bottom: 10px"
        size="small"
        type="primary"
        @click.native.prevent="searchByDate">搜索
      </el-button>
      <el-date-picker
        size="small"
        style="float:right;margin-right: 10px"
        v-model="dateRange"
        type="datetimerange"
        start-placeholder="开始日期"
        end-placeholder="结束日期"
        :default-time="['00:00:00','23:59:59']">
      </el-date-picker>

      <div style="float:right">
        <el-form :inline="true" :model="listQuery" size="small">
          <el-form-item>
            <el-input v-model="listQuery.supplier" class="input-width" placeholder="供货商" clearable
                      @keyup.enter.native="searchByDate"></el-input>
          </el-form-item>
        </el-form>
      </div>

      <div style="margin-left: 10px;margin-top: 10px">
        <span>制表人：{{ listQuery.username }},{{ branch }},{{ listQuery.startTime|formatDate }}——{{ listQuery.endTime|formatDate }}</span>
      </div>

      <!--        <el-input v-model="filename" placeholder="Enter File Name"-->
      <!--                style="width:200px;-->
      <!--                float:right;-->
      <!--                margin-right:5px"-->
      <!--                prefix-icon="el-icon-document"-->
      <!--                size="small"/>-->
      <!--        <el-button :loading="downloadLoading"-->
      <!--                 style="margin-bottom:20px;-->
      <!--                 float:right;-->
      <!--                 margin-right:10px"-->
      <!--                 type="primary"-->
      <!--                 icon="el-icon-download"-->
      <!--                 @click="handleDownload"-->
      <!--                 size="small">导出-->
      <!--      </el-button>-->
    </el-card>

    <div class="table-container">

      <!--      <span style="float: right;margin-right: 40px;margin-bottom: 10px"></span>-->
      <el-table ref="lossTable"
                :data="list"
                max-height="550"
                stripe
                :default-sort="{scope: 'scope.row.orderDay', order: 'descending'}"
                style="width: 100%;"
                @selection-change="handleSelectionChange"
                v-loading="listLoading" border>
        <el-table-column type="selection" width="40" align="center"></el-table-column>

        <el-table-column label="类型" align="center">
          <template slot-scope="scope">{{ scope.row.reagentStatus }}</template>
        </el-table-column>
        <el-table-column label="数量" align="center">
          <template slot-scope="scope">{{ scope.row.statusCount }}</template>
        </el-table-column>
        <el-table-column label="金额" align="center">
          <template slot-scope="scope">¥ {{ scope.row.sumPrice }}</template>
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
import {countOutIn} from '@/api/stockDetail'
import {formatDate} from '@/utils/date';
import {getCookie} from '@/utils/support';
import {getBranch} from '@/api/count'

const defaultListQuery = {

  pageNum: 1,
  pageSize: 50,
  keyword: null,
  supplier: null,
  username: getCookie("username"),
  startTime: formatDate(new Date(), 'yyyy-MM-dd hh:mm:ss').split(' ')[0] + ' 00:00:00',
  endTime: formatDate(new Date(), 'yyyy-MM-dd hh:mm:ss').split(' ')[0] + ' 23:59:59',
};

export default {
  name: 'countOutIn',
  data() {
    return {
      branch: null,
      listQuery: Object.assign({}, defaultListQuery),
      list: null,
      total: null,
      loading: false,
      listLoading: false,
      dialogVisible: false,
      editDialogVisible: false,
      dateRange: '',
      filename: '',
      multipleSelection: [],
      downloadLoading: false,
    }
  },
  created() {
    this.getList();
    this.getBranch();
  },
  filters: {
    formatDateTime(time) {
      if (time == null || time === '') {
        return 'N/A';
      }
      let date = new Date(time);
      return formatDate(date, 'yyyy-MM-dd hh:mm:ss')
    },
    formatDate(time) {
      if (time == null || time === '') {
        return '/';
      }
      let date = new Date(time);
      return formatDate(date, 'yyyy年MM月dd日')
    }
  },
  methods: {
    getBranch() {
      getBranch(this.listQuery.username).then(response => {
        this.branch = response.data;
      })
      console.log(this.branch);
    },
    back() {
      if (window.history.length <= 1) {
        this.$router.push({path: '/'})
        return false
      } else {
        this.$router.go(-1)
      }
    },
    handleResetSearch() {
      this.listQuery = Object.assign({}, defaultListQuery);
    },
    handleSearchList() {
      this.listQuery.pageNum = 1;
      this.getList();
    },
    handleSelectionChange(val) {
      this.multipleSelection = val;
    },
    //根据起始结束日期查找，以进行导出表格
    searchByDate() {
      if (this.dateRange) {
        this.listQuery.startTime = formatDate(this.dateRange[0], 'yyyy-MM-dd hh:mm:ss');
        this.listQuery.endTime = formatDate(this.dateRange[1], 'yyyy-MM-dd hh:mm:ss');
      } else {
        this.listQuery.startTime = formatDate(new Date(), 'yyyy-MM-dd hh:mm:ss').split(' ')[0] + ' 00:00:00';
        this.listQuery.endTime = formatDate(new Date(), 'yyyy-MM-dd hh:mm:ss').split(' ')[0] + ' 23:59:59';
      }
      this.getList();
    },
    //导出Excel表格
    async handleDownload() {
      if (this.multipleSelection.length) {
        this.downloadLoading = true;
        import('@/vendor/Export2Excel').then(excel => {
          //对应表格输出的title
          const multiHeader = [[' ', '时段耗材出入库统计表', ' '],
            [' 年    月    日 至', '  年    月    日', '制表人: ', '供货商:']];
          const header = ['类型', '数量', '金额'];
          const filterVal = ['reagentStatus', 'statusCount', 'sumPrice'];

          const list = this.multipleSelection;
          const data = this.formatJson(filterVal, list);
          excel.export_json_to_excel({
            multiHeader,
            header,
            data,
            filename: this.filename,

          });

          //清除复选框
          this.$nextTick(() => {
            this.$refs.lossTable.clearSelection();
          });
          this.downloadLoading = false;
        })
      } else {
        this.$message({
          message: '请至少选择其中一项！',
          type: 'warning'
        })
      }
    },
    formatJson(filterVal, jsonData) {
      return jsonData.map(v => filterVal.map(j => v[j]))
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
      countOutIn(this.listQuery).then(response => {
        this.listLoading = false;
        this.list = response.data.list;
        this.total = response.data.total;
      });
    },
  }
}
</script>


