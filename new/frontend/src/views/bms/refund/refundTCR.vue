<template> 
  <div class="app-container">
    <el-card class="filter-container" shadow="never">
      <i class="el-icon-tickets"></i>
      <span>时段退货统计列表</span>

      <el-button
        style="float:right;margin-bottom: 10px"
        size="large"
        type="primary"
        @click="searchByDate()">搜索
      </el-button>
      <el-date-picker
        style="float:right;margin-right: 10px"
        v-model="dateRange"
        type="datetimerange"
        start-placeholder="开始日期"
        end-placeholder="结束日期"
        :default-time="['00:00:00','23:59:59']">
      </el-date-picker>
      <div style="margin-left: 10px;margin-top: 10px">
        <span>{{ listQuery.startTime|formatDate }}——{{ listQuery.endTime|formatDate }}</span>
      </div>
      <!--      <el-input v-model="filename" placeholder="Enter File Name"-->
      <!--                style="width:200px;-->
      <!--                float:right;-->
      <!--                margin-right:5px"-->
      <!--                prefix-icon="el-icon-document"-->
      <!--                size="small"/>-->
      <!--      <el-button :loading="downloadLoading"-->
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
      <el-table ref="refundTable"
                :data="list"
                max-height="550"
                :summary-method="getSummaries"
                show-summary
                stripe
                :default-sort="{scope: 'scope.row.orderDay', order: 'descending'}"
                style="width: 100%;"
                @selection-change="handleSelectionChange"
                v-loading="listLoading" border>
        <el-table-column type="selection" width="40" align="center"></el-table-column>

        <!--        <el-table-column label="编号" width="60" align="center">-->
        <!--          <template slot-scope="scope">{{ scope.row.id }}</template>-->
        <!--        </el-table-column>-->
        <el-table-column label="退货单详细编号" min-width="160%" align="center">
          <template slot-scope="scope">{{ scope.row.refundDetailId }}</template>
        </el-table-column>
        <el-table-column label="耗材名称" min-width="160%" align="center">
          <template slot-scope="scope">{{ scope.row.reagentName }}</template>
        </el-table-column>
        <el-table-column label="供货商名" align="center">
          <template slot-scope="scope">{{ scope.row.supplierShortName }}</template>
        </el-table-column>
        <el-table-column label="生产厂家" min-width="110%" align="center">
          <template slot-scope="scope">{{ scope.row.factory }}</template>
        </el-table-column>
        <el-table-column label="单价" align="center">
          <template slot-scope="scope">¥ {{ scope.row.reagentPrice }}</template>
        </el-table-column>
        <el-table-column prop="quantity" label="退货数量" align="center">
          <template slot-scope="scope">{{ scope.row.quantity }}</template>
        </el-table-column>
        <el-table-column prop="total" label="金额" align="center">
          <template slot-scope="scope">¥ {{ scope.row.total }}</template>
        </el-table-column>
        <el-table-column label="退货时间" min-width="160%" align="center">
          <template slot-scope="scope">{{ scope.row.createTime | formatRefundTime }}</template>
        </el-table-column>
        <el-table-column label="退货人" align="center">
          <template slot-scope="scope">{{ scope.row.createBy }}</template>
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
import {countRefund, searchByDate} from '@/api/refund'
import {formatDate} from '@/utils/date';
import {getCookie} from '@/utils/support';

const defaultListQuery = {
  pageNum: 1,
  pageSize: 50,
  keyword: null,
  applyType: null,
  startTime: formatDate(new Date(), 'yyyy-MM-dd hh:mm:ss').split(' ')[0] + ' 00:00:00',
  endTime: formatDate(new Date(), 'yyyy-MM-dd hh:mm:ss').split(' ')[0] + ' 23:59:59',
  refundType: 2,
  username: getCookie("username"),
};
const defaultRefund = {
  id: null,
  refundType: 2,
};
export default {
  name: "refundList",
  data() {
    return {
      listQuery: Object.assign({}, defaultListQuery),
      loading: false,
      listLoading: false,
      list: null,
      total: null,
      multipleSelection: [],
      downloadLoading: false,
      filename: '',
      refund: Object.assign({}, defaultRefund),
      dateRange: '',
      refundDetail: [],
    }
  },
  created() {
    this.getList();
  },
  filters: {
    formatRefundTime(time) {
      if (time == null || time === '') {
        return 'N/A';
      }
      let date = new Date(time);
      return formatDate(date, 'yyyy-MM-dd hh:mm:ss');
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
    //自定义统计
    getSummaries(param) {
      const {columns, data} = param;
      const sums = [];
      columns.forEach((column, index) => {
        if (index === 1) {
          sums[index] = '合计';
          return;
        }
        const values = data.map(item => Number(item[column.property]));
        if (index > 1) {
          if (!values.every(value => isNaN(value))) {
            sums[index] = values.reduce((prev, curr) => {
              const value = Number(curr);
              if (!isNaN(value)) {
                return prev + curr;
              } else {
                return prev;
              }
            }, 0);
            sums[index] += '';
          } else {
            sums[index] = '--';
          }
        }

      });

      return sums;
    },
    back() {
      if (window.history.length <= 1) {
        this.$router.push({path: '/'})
        return false
      } else {
        this.$router.go(-1)
      }
    },
    handleSelectionChange(val) {
      this.multipleSelection = val;
    },
    //根据起始结束日期查找，以进行导出表格
    searchByDate() {
      if (this.dateRange) {
        this.listQuery.startTime = formatDate(this.dateRange[0], 'yyyy-MM-dd hh:mm:ss');
        this.listQuery.endTime = formatDate(this.dateRange[1], 'yyyy-MM-dd hh:mm:ss');
        this.listLoading = true;
        searchByDate(this.listQuery).then(response => {
          this.listLoading = false;
          this.list = response.data.list;
          this.total = response.data.total;
        });
      } else {
        this.listQuery.startTime = formatDate(new Date(), 'yyyy-MM-dd hh:mm:ss').split(' ')[0] + ' 00:00:00';
        this.listQuery.endTime = formatDate(new Date(), 'yyyy-MM-dd hh:mm:ss').split(' ')[0] + ' 23:59:59';
        this.getList();
      }
    },
    //导出Excel表格
    handleDownload() {
      if (this.multipleSelection.length) {
        this.downloadLoading = true;
        import('@/vendor/Export2Excel').then(excel => {
          //对应表格输出的title
          const multiHeader = [[' ', ' ', '时段退货统计表', ' ', ' ', ' '],
            ['中心库', '     年    月    日 至     年    月    日 ', ' ', ' ', '制表人: ', ' ']];
          const header = ['序号', '耗材名称', '供货商名', '生产厂家', '数量', '金额'];
          const filterVal = ['id', 'reagentName', 'supplierShortName', 'factory', 'quantity', 'total'];

          //进行所有表头的单元格合并,按行合并
          const merges = [
            "A1:B1",
            "D1:G1",

            "C2:D2",
            "E2:F2",
          ];

          const list = this.multipleSelection;
          const data = this.formatJson(filterVal, list);
          excel.export_json_to_excel({
            multiHeader,
            header,
            data,
            filename: this.filename,
            merges,
          });

          //清除复选框
          this.$nextTick(() => {
            this.$refs.refundTable.clearSelection();
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
      this.listQuery.refundType = this.refund.refundType;
      countRefund(this.listQuery).then(response => {
        this.listLoading = false;
        this.list = response.data.list;
        this.total = response.data.total;
      });
    },
  }
}
</script>


