<template> 
  <div class="app-container">
    <el-card class="filter-container" shadow="never">
      <i class="el-icon-tickets"></i>
      <span>耗材总库存</span>
      <el-button
        style="float:right;margin-bottom: 10px"
        size="small"
        type="primary"
        @click.native.prevent="searchByDate">搜索
      </el-button>
      <div style="float:right">
        <el-form :inline="true" :model="listQuery" size="small">
          <el-form-item>
            <el-input v-model="listQuery.branchName" style="width: 120px" placeholder="科室名称" clearable
                      @keyup.enter.native="searchByDate"></el-input>
          </el-form-item>
        </el-form>
      </div>
      <div style="float:right">
        <el-form :inline="true" :model="listQuery" size="small">
          <el-form-item>
            <el-input v-model="listQuery.supplier" style="width: 120px" placeholder="供货商" clearable
                      @keyup.enter.native="searchByDate"></el-input>
          </el-form-item>
        </el-form>
      </div>
      <div style="float:right">
        <el-form :inline="true" :model="listQuery" size="small">
          <el-form-item>
            <el-input v-model="listQuery.reagentName" style="width: 120px" placeholder="耗材名称" clearable
                      @keyup.enter.native="searchByDate"></el-input>
          </el-form-item>
        </el-form>
      </div>
      <div style="margin-left: 10px;margin-top: 10px">
        <span>制表人：{{ listQuery.username }},{{ branch }}</span>
      </div>
      <div style="margin-left: 10px;margin-top: 10px">
        <el-input v-model="filename" placeholder="Enter File Name"
                  style="width:200px;
                      float:right;"
                  prefix-icon="el-icon-document"
                  size="small"/>
        <el-button :loading="downloadLoading"
                   style="margin-bottom:20px;
                       float:right;
                       margin-right:10px"
                   type="primary"
                   icon="el-icon-download"
                   @click="handleDownload"
                   size="small">导出
        </el-button>
        <el-button :loading="downloadLoading"
                   style="margin-bottom:20px;
                       float:right;
                       margin-right:10px"
                   type="primary"
                   icon="el-icon-printer"
                   @click="handlePrint"
                   size="small">打印
        </el-button>
      </div>
      <!--      <el-popover placement="right" width="400" trigger="click">-->
      <!--        <el-checkbox-group v-model="colOptions">-->
      <!--          <el-checkbox v-for="item in colData" :label="item.title" :key="item.istrue" ></el-checkbox>-->
      <!--        </el-checkbox-group>-->
      <!--        <el-button slot="reference">筛选列</el-button>-->
      <!--      </el-popover>-->
    </el-card>

    <div class="table-container">

      <!--      <span style="float: right;margin-right: 40px;margin-bottom: 10px"></span>-->
      <el-table ref="reagentTable"
                :data="list"
                :row-class-name="rowClassName"
                :summary-method="getSummaries"
                show-summary
                max-height="550"
                style="width: 100%;"
                v-loading="listLoading" border>

        <el-table-column prop="newId" align="center" label="序号" width="60"></el-table-column>
        <el-table-column label="耗材名称" width="240" align="center">
          <template slot-scope="scope">{{ scope.row.reagentName }}</template>
        </el-table-column>
        <el-table-column label="型号规格" align="center">
          <template slot-scope="scope">{{ scope.row.reagentType }}</template>
        </el-table-column>
        <el-table-column label="生产厂家" min-width="100%" align="center">
          <template slot-scope="scope">{{ scope.row.factory }}</template>
        </el-table-column>
        <el-table-column label="供货商" align="center">
          <template slot-scope="scope">{{ scope.row.supplierName }}</template>
        </el-table-column>
        <el-table-column label="单位" align="center">
          <template slot-scope="scope">{{ scope.row.reagentUnit }}</template>
        </el-table-column>
        <el-table-column label="数量" prop="quantity" align="center">
          <template slot-scope="scope">{{ scope.row.quantity }}</template>
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
import {reagentOverall} from '@/api/stockDetail'
import {formatDate} from '@/utils/date';
import {getCookie} from '@/utils/support';
import {getBranch} from '@/api/count'
import {PrintForm} from "../../utils/printForm";

const printFormColumn = [
  {
    field: 'reagentName',
    name: '耗材名称',
    columnSize: '200%'
  },
  {
    field: 'reagentType',
    name: '型号规格',
  },
  {
    field: 'factory',
    name: '生产厂家',
    columnSize: '150%'
  },
  {
    field: 'supplierName',
    name: '供货商',
  },
  {
    field: 'reagentUnit',
    name: '单位',
  },
  {
    field: 'quantity',
    name: '数量',
  },
  {
    name: '备注',
    columnSize: '150%'
  },
];

const defaultListQuery = {
  supplier: null,
  reagentName: null,
  branchName: null,
  pageNum: 1,
  pageSize: 50,
  keyword: null,
  username: getCookie("username"),
  startTime: formatDate(new Date(), 'yyyy-MM-dd hh:mm:ss').split(' ')[0] + ' 00:00:00',
  endTime: formatDate(new Date(), 'yyyy-MM-dd hh:mm:ss').split(' ')[0] + ' 23:59:59',
};

export default {
  name: 'reagentOverall',
  data() {
    return {
      // colData: [
      //   {title: "入库数量",istrue: true},
      //   {title: "入库金额",istrue: true},
      //   {title: "退货数量",istrue: true},
      //   {title: "退货金额",istrue: true},
      //   {title: "出库数量",istrue: true},
      //   {title: "出库金额",istrue: true},
      //   {title: "净入库数量",istrue: true},
      //   {title: "净入库金额",istrue: true}],
      // colOptions: ["入库数量","入库金额", "退货数量","退货金额","出库数量","出库金额","净入库数量","净入库金额",],
      // colSelect: ["入库数量", "入库金额","退货数量","退货金额","出库数量","出库金额","净入库数量","净入库金额",],
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
  // watch:{
  //   colOptions(valArr) {
  //     let arr = this.colSelect.filter(i => valArr.indexOf(i) < 0); // 将colSelect中的值筛选出来  作为未选中的
  //     this.colData.filter(i => {
  //       if (arr.indexOf(i.title) !== -1) {
  //         i.istrue = false;
  //         this.$nextTick(() => {
  //           this.$refs.reagentTable.doLayout();
  //         });
  //       } else {
  //         i.istrue = true;
  //         this.$nextTick(() => {
  //           this.$refs.reagentTable.doLayout();// ref上面定义过，不懂的看一下vue官方文档
  //         });
  //       }
  //     });
  //   },
  // },
  methods: {
    //自定义统计
    getSummaries(param) {
      const that = this;
      const {columns, data} = param;
      const sums = [];
      columns.forEach((column, index) => {
        if (index === 2) {
          sums[index] = '合计';
          return;
        }
        if (index === 6) {
          sums[index] = '';
        }
        const values = data.map(item => Number(item[column.property]));
        if (index > 2) {
          if (!values.every(value => isNaN(value))) {
            let sum = values.reduce((prev, curr) => {
              const value = Number(curr);
              if (!isNaN(value)) {
                return prev + curr;
              } else {
                return prev;
              }
            }, 0);
            if (index % 2 === 0) {  //耗材数量不加人民币符号和取两位小数
              sums[index] = sum;
            } else {  //金额加人民币符号和取两位小数
              sums[index] = sums[index] + sum.toFixed(2);
            }
          } else {
            sums[index] = '--';
          }
        }
      });
      for (let i = 0; i < sums.length; i++) {
        if (i >= 3) {
          that.sums[i - 3] = sums[i];
        }
      }
      return sums;
    },
    rowClassName({row, rowIndex}) {
      //把每一行的索引放进row.id
      row.newId = (this.listQuery.pageSize * (this.listQuery.pageNum - 1)) + rowIndex + 1;
    },
    getBranch() {
      getBranch(this.listQuery.username).then(response => {
        this.branch = response.data;
      })
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
        const multiHeader = [[' ', ' ', '耗材总库存', ' ', ' ', ' ', ' '],
          [' ', ' ', ' ', ' ', ' ', ' ', ' '],
          [' ', ' ', ' ', ' ', '制表人: ', getCookie("username")]];
        const header = ['耗材名称', '型号规格', '生产厂家', '供货商', '单位', '数量', '备注'];
        const filterVal = ['reagentName', 'reagentType', 'factory', 'supplierName', 'reagentUnit', 'quantity', ' '];

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
          this.$refs.reagentTable.clearSelection();
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

      const pf = new PrintForm({
        orderNumber: formatDate(new Date(), 'yyyyMMddhhmmss'),
        createTime: _createTime,
        title: '耗材总库存',
        properties: printFormColumn,
        data: _data,
        showIds: true,
        showStuffing: true,
        mulTotal: this.sums
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
      reagentOverall(this.listQuery).then(response => {
        this.listLoading = false;
        this.list = response.data.list;
        this.total = response.data.total;

        this.list.forEach(item => {
          const obj = {
            reagentName: item.reagentName,
            reagentType: item.reagentType,
            reagentUnit: item.reagentUnit,
            factory: item.factory,
            supplierName: item.supplierName,
            quantity: item.quantity,
          }
          this.formatList.push(obj);
        });
      });
    },
  }
}
</script>


