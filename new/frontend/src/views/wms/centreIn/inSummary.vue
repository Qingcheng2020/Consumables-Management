<template> 
  <div class="app-container">
    <el-card class="filter-container" shadow="never">
      <i class="el-icon-tickets"></i>
      <span>时段耗材入库汇总列表</span>
      <div style="float: right">
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
              <el-input v-model="listQuery.reagentName" class="input-width" placeholder="耗材名称" clearable
                        @keyup.enter.native="searchByDate"></el-input>
            </el-form-item>
          </el-form>
        </div>
      </div>
      <div style="margin-left: 10px;margin-top: 10px">
        <span>{{ listQuery.startTime|formatDate }}——{{ listQuery.endTime|formatDate }}</span>
      </div>
      <div style="margin-left: 10px;margin-top: 10px">
        <el-input v-model="filename" placeholder="Enter File Name"
                  style="width:200px;
                      float:right;"
                  prefix-icon="el-icon-document"
                  size="small"/>
        <el-button :loading="downloadLoading"
                   style="margin-bottom:10px;
                       float:right;
                       margin-right:10px"
                   type="primary"
                   icon="el-icon-download"
                   @click="handleDownload"
                   size="small">导出
        </el-button>
        <el-button :loading="downloadLoading"
                   style="margin-bottom:10px;
                       float:right;
                       margin-right:10px"
                   type="primary"
                   icon="el-icon-printer"
                   @click="handlePrint"
                   size="small">打印
        </el-button>
      </div>
    </el-card>

    <div class="table-container">
      <el-table ref="lossTable"
                :data="list"
                :row-class-name="rowClassName"
                max-height="550"
                stripe
                :default-sort="{scope: 'scope.row.orderDay', order: 'descending'}"
                style="width: 100%;"
                @selection-change="handleSelectionChange"
                v-loading="listLoading" border>

        <el-table-column prop="newId" align="center" label="序号" width="60"></el-table-column>
        <el-table-column label="耗材名称" width="240" align="center">
          <template slot-scope="scope">{{ scope.row.reagentName }}</template>
        </el-table-column>
        <el-table-column label="耗材编号" align="center">
          <template slot-scope="scope">{{ scope.row.updateBy }}</template>
        </el-table-column>
        <el-table-column label="批号" align="center">
          <template slot-scope="scope">{{ scope.row.batchNo }}</template>
        </el-table-column>
        <el-table-column label="供货商" align="center">
          <template slot-scope="scope">{{ scope.row.factory }}</template>
        </el-table-column>
        <el-table-column label="单位" align="center">
          <template slot-scope="scope">{{ scope.row.reagentUnit }}</template>
        </el-table-column>
        <el-table-column label="入库时间" width="200" align="center">
          <template slot-scope="scope">{{ scope.row.createTime | formatDateTime }}</template>
        </el-table-column>
        <el-table-column label="领用人" align="center">
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
<script type="text/ecmascript-6">
import {inSummary} from '@/api/inBillDetail';
import {formatDate} from '@/utils/date';
import {getCookie} from '@/utils/support';
import {PrintForm} from "../../../utils/printForm";

const printFormColumn = [
  {
    field: 'reagentName',
    name: '耗材名称',
    columnSize: '200%'
  },
  {
    field: 'batchNo',
    name: '批号',
  },
  {
    field: 'updateBy',
    name: '耗材编号',
    columnSize: '120%'
  },
  {
    field: 'factory',
    name: '供货商',
    columnSize: '100%'
  },
  {
    field: 'reagentUnit',
    name: '单位',
  },
  {
    field: 'createTime',
    name: '入库时间',
    columnSize: '150%'
  },
  {
    field: 'createBy',
    name: '领用人',
    columnSize: '100%'
  }
];

const defaultListQuery = {
  supplier: null,
  reagentName: null,
  pageNum: 1,
  pageSize: 50,
  keyword: null,
  username: getCookie("username"),
  startTime: formatDate(new Date(), 'yyyy-MM-dd hh:mm:ss').split(' ')[0] + ' 00:00:00',
  endTime: formatDate(new Date(), 'yyyy-MM-dd hh:mm:ss').split(' ')[0] + ' 23:59:59',
};

export default {
  name: 'inSummary',
  data() {
    return {
      startDay: new Date(),
      endDay: new Date(),
      branch: null,
      listQuery: Object.assign({}, defaultListQuery),
      list: null,
      formatList: [],
      total: null,
      loading: false,
      listLoading: false,
      dialogVisible: false,
      editDialogVisible: false,
      dateRange: '',
      filename: '',
      multipleSelection: [],
      downloadLoading: false,
      sums: [],
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
    // getSummaries(param) {
    //   const that = this;
    //   const {columns, data} = param;
    //   const sums = [];
    //   columns.forEach((column, index) => {
    //     if (index === 2) {
    //       sums[index] = '合计';
    //       return;
    //     }
    //     if (index === 6 || index === 7 ) {
    //       sums[index] = '¥ ';
    //     } else {
    //       sums[index] = '';
    //     }
    //     const values = data.map(item => Number(item[column.property]));
    //     if (index > 2) {
    //       if (!values.every(value => isNaN(value))) {
    //         let sum = values.reduce((prev, curr) => {
    //           const value = Number(curr);
    //           if (!isNaN(value)) {
    //             return prev + curr;
    //           } else {
    //             return prev;
    //           }
    //         }, 0);
    //         if (index === 5) {  //试剂数量不加人民币符号和取两位小数
    //           sums[index] = sum;
    //         } else {  //金额加人民币符号和取两位小数
    //           sums[index] = sums[index] + sum.toFixed(2);
    //         }
    //       } else {
    //         sums[index] = '--';
    //       }
    //     }
    //   });
    //   for (let i = 0; i < sums.length; i++) {
    //     if (i >= 3) {
    //       that.sums[i - 3] = sums[i];
    //     }
    //   }
    //   return sums;
    // },
    rowClassName({row, rowIndex}) {
      //把每一行的索引放进row.id
      row.newId = (this.listQuery.pageSize * (this.listQuery.pageNum - 1)) + rowIndex + 1;
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
        this.startDay = this.dateRange[0];
        this.endDay = this.dateRange[1];
      } else {
        this.listQuery.startTime = formatDate(new Date(), 'yyyy-MM-dd hh:mm:ss').split(' ')[0] + ' 00:00:00';
        this.listQuery.endTime = formatDate(new Date(), 'yyyy-MM-dd hh:mm:ss').split(' ')[0] + ' 23:59:59';
        this.startDay = new Date();
        this.endDay = new Date();
      }
      this.getList();
    },
    //导出Excel表格
    handleDownload() {
      this.downloadLoading = true;
      import('@/vendor/Export2Excel').then(excel => {
        //对应表格输出的title
        const multiHeader = [[' ', ' ', ' ', '时段耗材入库汇总表', ' ', ' ', ' ', ' '],
          [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
          [this.listQuery.startTime, '至', this.listQuery.endTime, ' ', ' ', ' ', '制表人: ', getCookie("username"), '科室: ', this.branch]];
        const header = ['耗材名称', '耗材编号', '批号', '供货商', '单位', '入库时间', '领用人'];
        const filterVal = ['reagentName', 'updateBy', 'batchNo', 'factory', 'reagentUnit', 'createTime', 'createBy'];

        const list = this.formatList;
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

    },
    formatJson(filterVal, jsonData) {
      return jsonData.map(v => filterVal.map(j => v[j]))
    },
    //打印表单
    handlePrint() {
      const _data = this.formatList;
      const _createTime = formatDate(new Date(), 'yyyy-MM-dd hh:mm:ss');
      const _startTime = formatDate(this.startDay, 'yyyy年MM月dd日');
      const _endTime = formatDate(this.endDay, 'yyyy年MM月dd日');

      const pf = new PrintForm({
        orderNumber: formatDate(new Date(), 'yyyyMMddhhmmss'),
        fromWho: `时间：${_startTime}至${_endTime}`,
        createTime: _createTime,
        title: '耗材入库汇总',
        properties: printFormColumn,
        data: _data,
        showIds: true,
        // mulTotal: this.sums
      });
      pf.toPrint();
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
      this.formatList = [];
      inSummary(this.listQuery).then(response => {
        this.listLoading = false;
        this.list = response.data.list;
        this.total = response.data.total;

        this.list.forEach(item => {
          const obj = {
            reagentName: item.reagentName,
            batchNo: item.batchNo,
            factory: item.factory,
            reagentUnit: item.reagentUnit,
            updateBy: item.updateBy,
            createTime: formatDate(new Date(item.createTime), 'yyyy-MM-dd hh:mm:ss'),
            createBy: item.createBy,
          }
          this.formatList.push(obj);
        });
      });
    },
  }
}
</script>


