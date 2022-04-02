<template> 
  <div class="app-container">
    <!--    <el-card class="operate-container" shadow="never">-->
    <!--      <i class="el-icon-tickets"></i>-->
    <!--      <span>数据详情</span>-->
    <!--    </el-card>-->
    <el-card class="filter-container" shadow="never">
      <i class="el-icon-tickets"></i>
      <span>出库详细列表
                <el-input v-model="filename" placeholder="Enter File Name"
                          style="width:200px;
                          float:right;
                          margin-right:5px"
                          size="small"
                          prefix-icon="el-icon-document"/>
                <el-button :loading="downloadLoading"
                           style="margin-bottom:20px;
                           float:right;
                           margin-right:10px"
                           type="primary"
                           icon="el-icon-download"
                           size="small"
                           @click="handleDownload">导出
                </el-button>
                <el-button
                  type="primary"
                  icon="el-icon-printer"
                  style="margin-bottom:20px;
                    float:right;
                    margin-right:10px"
                  :loading="downloadLoading"
                  size="small"
                  @click="handlePrint">打印</el-button>
      </span>
    </el-card>
    <div class="table-container">
      <el-table ref="OutDetailTable"
                :data="OutDetail"
                :row-class-name="rowClassName"
                @selection-change="handleSelectionChange"
                max-height="550"
                stripe
                :default-sort="{scope: 'scope.row.orderDay', order: 'descending'}"
                style="width: 100%;"
                v-loading="listLoading" border>

        <el-table-column type="selection" width="40" align="center"></el-table-column>
        <el-table-column prop="newId" align="center" label="序号" width="60"></el-table-column>
        <el-table-column label="出库单号" align="center">
          <template slot-scope="scope">{{ scope.row.billCode }}</template>
        </el-table-column>
        <el-table-column label="耗材名称" min-width="150%" align="center">
          <template slot-scope="scope">{{ scope.row.reagentName }}</template>
        </el-table-column>
        <el-table-column label="规格型号" align="center">
          <template slot-scope="scope">{{ scope.row.reagentSpecification }}</template>
        </el-table-column>
        <el-table-column label="生产厂家" min-width="120%" align="center">
          <template slot-scope="scope">{{ scope.row.factory }}</template>
        </el-table-column>
        <el-table-column label="注册证号" min-width="100%" align="center">
          <template slot-scope="scope">{{ scope.row.registrationNo }}</template>
        </el-table-column>
        <el-table-column label="供货商" align="center">
          <template slot-scope="scope">{{ scope.row.supplierShortName }}</template>
        </el-table-column>
        <el-table-column label="产品批号" min-width="100%" align="center">
          <template slot-scope="scope">{{ scope.row.batchNo }}</template>
        </el-table-column>
        <el-table-column label="单位" align="center">
          <template slot-scope="scope">{{ scope.row.reagentUnit }}</template>
        </el-table-column>
        <el-table-column label="数量" align="center">
          <template slot-scope="scope">{{ scope.row.quantity }}</template>
        </el-table-column>
        <!--        <el-table-column label="价格" align="center">-->
        <!--          <template slot-scope="scope">{{ scope.row.price }}</template>-->
        <!--        </el-table-column>-->
        <!--        <el-table-column label="金额" align="center">-->
        <!--          <template slot-scope="scope">{{ scope.row.total }}</template>-->
        <!--        </el-table-column>-->
        <el-table-column label="出库时间" min-width="100%" align="center">
          <template slot-scope="scope">{{ scope.row.createTime | formatDateTime }}</template>
        </el-table-column>
        <el-table-column label="出库人员" align="center">
          <template slot-scope="scope">{{ scope.row.createBy }}</template>
        </el-table-column>
        <!--        <el-table-column label="申领人员" align="center">
                  <template slot-scope="scope">{{ scope.row.applicationUser }}</template>
                </el-table-column>-->
        <el-table-column label="操作" width="120" align="center">
          <template slot-scope="scope">
            <el-button
              size="mini"
              type="primary"
              @click="handleViewOrder(scope.$index, scope.row)">查看
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
import {Message} from 'element-ui';
import {fetchBill} from '@/api/preInBill';
import {fetchList} from '@/api/outDetail'
import {formatDate} from '@/utils/date';
import {PrintForm} from '@/utils/printForm';

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
    field: 'reagentSpecification',
    name: '规格型号',
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
    field: 'price',
    name: '单价',
  },
  {
    field: 'total',
    name: '金额',
  },
  {
    field: 'remark',
    name: '备注',
  },
];

const defaultListQuery = {
  pageNum: 1,
  pageSize: 50,
  keyword: null
};
export default {
  name: "OutDetailList",
  data() {
    return {
      dataOutBill: null,
      listQuery: Object.assign({}, defaultListQuery),
      loading: false,
      listLoading: false,
      list: null,
      total: null,
      OutDetail: null,
      multipleSelection: [],
      downloadLoading: false,
      filename: '',
    }
  },
  created() {
    this.getList();
    this.getDataOutBill();
  },
  filters: {
    formatDateTime(time) {
      if (time == null || time === '') {
        return 'N/A';
      }
      let date = new Date(time);
      return formatDate(date, 'yyyy-MM-dd')
    },
  },
  methods: {
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
    handleViewOrder(index, row) {
      this.$router.push({path: '/dms/outItem', query: {outDetailId: row.outDetailId}})
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
    handleSelectionChange(val) {
      this.multipleSelection = val;
    },

    /**
     * 获取当前时间
     * 格式YYYY-MM-DD
     */
    getNowFormatDate() {
      const date = new Date();
      const seperator = "-";
      const year = date.getFullYear();
      let month = date.getMonth() + 1;
      let strDate = date.getDate();
      if (month >= 1 && month <= 9) {
        month = "0" + month;
      }
      if (strDate >= 0 && strDate <= 9) {
        strDate = "0" + strDate;
      }
      return year + seperator + month + seperator + strDate;
    },

    handlePrint() {
      if (this.dataOutBill === null) {
        Message.error('出库单数据获取失败');
        return;
      }
      const _data = this.OutDetail;

      const _createTime = formatDate(new Date(this.dataOutBill.createTime), 'yyyy-MM-dd hh:mm:ss');

      const pf = new PrintForm({
        orderNumber: this.dataOutBill.billCode,
        fromBranch: `${this.dataOutBill.applicationBranch}`,
        billBranch: `${this.dataOutBill.billBranch}`,
        fromWho: `申领人：${this.dataOutBill.applicationUser}`,
        creator: `${this.dataOutBill.billCreator}`,
        createTime: _createTime,
        title: '出库单',
        properties: printFormColumn,
        data: _data,
        showIds: true,
        total: {
          field: 'total',
          showChinese: true,
        },
      });
      pf.toPrint();
    },

    //导出Excel表格
    handleDownload() {
      if (this.multipleSelection.length) {
        this.downloadLoading = true
        import('@/vendor/Export2Excel').then(excel => {
          //对应表格输出的title
          const multiHeader = [[' ', ' ', ' ', '检验耗材出库单 ', ' ', ' ', ' ', ' ', ' '],
            ['申领人:', this.multipleSelection[0].createBy, ' ', ' ', '单号:', this.multipleSelection[0].billCode, ' ', '时间:', this.getNowFormatDate()]];
          const header = ['序号', '耗材名称', '规格型号', '单位', '数量', '单价', '合计金额', '批号', '备注'];
          const filterVal = ['newId', 'reagentName', 'reagentSpecification', 'reagentUnit', 'quantity', 'price', 'total', 'batchNo', 'remark'];

          //进行所有表头的单元格合并,按行合并
          const merges = [
            "E1:F1",
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
            this.$refs.OutDetailTable.clearSelection();
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
    getList() {
      this.listLoading = true;
      this.listQuery.keyword = this.$route.query.billCode;
      fetchList(this.listQuery).then(response => {
        this.listLoading = false;
        this.OutDetail = response.data.list;
        this.total = response.data.total;
      });

    },

    /**
     * 获取出库单基本信息
     * 出库第一层数据
     */
    getDataOutBill() {
      const billCode = this.$route.query.billCode;
      //const billType = this.$route.query.billType ? this.$route.query.billType : 3;

      fetchBill({
        pageNum: 1,
        pageSize: 50,
        keyword: billCode,
        printType: 4
      }).then(res => {
        if (res.data && res.data.list.length !== 0) {
          this.dataOutBill = res.data.list[0];
        } else {
          Message.error('获取出库单基本信息失败');
        }
      });
    },

  }
}
</script>
