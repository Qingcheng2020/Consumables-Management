<template> 
  <div class="app-container">
    <!--    <el-button size="small" @click="back()">返回</el-button>-->
    <el-card class="filter-container" shadow="never">
      <i class="el-icon-tickets"></i>
      <span>退货单详情</span>
      <el-input v-model="filename" placeholder="Enter File Name"
                style="width:200px;
                      float:right;
                      margin-right:5px"
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
      <el-button
        type="primary"
        icon="el-icon-printer"
        style="margin-bottom:20px;
                    float:right;
                    margin-right:10px"
        :loading="downloadLoading"
        size="small"
        @click="handlePrint">打印
      </el-button>
    </el-card>
    <div class="table-container">
      <el-table ref="refundTable"
                :data="refundDetail"
                :row-class-name="rowClassName"
                @selection-change="handleSelectionChange"
                max-height="550"
                stripe
                :default-sort="{scope: 'scope.row.orderDay', order: 'descending'}"
                style="width: 100%;"
                v-loading="listLoading" border>
        <el-table-column type="selection" width="40" align="center"></el-table-column>
        <el-table-column prop="newId" align="center" label="序号" width="60"></el-table-column>
        <el-table-column label="耗材名称" min-width="160%" align="center">
          <template slot-scope="scope">{{ scope.row.reagentName }}</template>
        </el-table-column>
        <el-table-column label="型号规格" align="center">
          <template slot-scope="scope">{{ scope.row.reagentSpecification }}</template>
        </el-table-column>
        <el-table-column label="批号" align="center">
          <template slot-scope="scope">{{ scope.row.batchNo }}</template>
        </el-table-column>
        <el-table-column label="生产厂家" min-width="110%" align="center">
          <template slot-scope="scope">{{ scope.row.factory }}</template>
        </el-table-column>
        <el-table-column label="注册证号" min-width="110%" align="center">
          <template slot-scope="scope">{{ scope.row.registrationNo }}</template>
        </el-table-column>
        <el-table-column label="供货商" align="center">
          <template slot-scope="scope">{{ scope.row.supplierShortName }}</template>
        </el-table-column>
        <el-table-column label="单位" min-width="60%" align="center">
          <template slot-scope="scope">{{ scope.row.reagentUnit }}</template>
        </el-table-column>
        <el-table-column label="单价" align="center">
          <template slot-scope="scope">¥ {{ scope.row.reagentPrice }}</template>
        </el-table-column>
        <el-table-column label="退货数量" align="center">
          <template slot-scope="scope">{{ scope.row.quantity }}</template>
        </el-table-column>
        <el-table-column label="合计金额" align="center">
          <template slot-scope="scope">¥ {{ scope.row.total }}</template>
        </el-table-column>
        <el-table-column label="退货时间" min-width="160%" align="center">
          <template slot-scope="scope">{{ scope.row.createTime | formatRefundTime }}</template>
        </el-table-column>
        <el-table-column label="退货人" align="center">
          <template slot-scope="scope">{{ scope.row.createBy }}</template>
        </el-table-column>

        <el-table-column label="操作" width="110" align="center">
          <template slot-scope="scope">
            <el-button
              size="mini"
              type="primary"
              @click="handleViewRefund(scope.$index, scope.row)">查看
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
import {deleteRefundDetailItem, fetchList, getRefundDetail} from '@/api/refundDetail'
import {formatDate} from '@/utils/date';
import {fetchBill} from '@/api/preInBill';
import {deleteRefundByReCo} from '@/api/refund';
import {Message} from "element-ui";
import {PrintForm} from '@/utils/printForm';

const printFormColumn = [
  {
    field: 'reagentName',
    name: '耗材名称',
    columnSize: '200%'
  },
  {
    field: 'reagentSpecification',
    name: '规格型号',
  },
  {
    field: 'batchNo',
    name: '批号',
  },
  {
    field: 'factory',
    name: '生产厂家',
  },
  {
    field: 'registrationNo',
    name: '注册证号',
  },
  {
    field: 'supplierShortName',
    name: '供货商',
  },
  {
    field: 'reagentUnit',
    name: '单位',
  },
  {
    field: 'reagentPrice',
    name: '单价',
  },
  {
    field: 'quantity',
    name: '退货数量',
  },
  {
    field: 'total',
    name: '合计金额',
  },
];
const defaultListQuery = {
  pageNum: 1,
  pageSize: 50,
  keyword: null,
  refundCode: null,
  startTime: null,
  endTime: null,
};
const defaultRefundEditDetail = {
  id: null,
  reagentNumber: null,
  refundCode: null
};
export default {
  name: "refundDetailList",
  data() {
    return {
      listQuery: Object.assign({}, defaultListQuery),
      loading: false,
      listLoading: false,
      list: null,
      total: null,
      filename: '',
      downloadLoading: false,
      refundDetail: null,
      dataRefundBill: null,
      multipleSelection: [],
      refundStatus: this.$route.query.refundStatus,
      RefundEditDetail: Object.assign({}, defaultRefundEditDetail),
    }
  },
  created() {
    this.getList();
    this.getDataRefundBill();
  },
  filters: {
    formatRefundTime(time) {
      if (time == null || time === '') {
        return 'N/A';
      }
      let date = new Date(time);
      return formatDate(date, 'yyyy-MM-dd hh:mm:ss');
    }
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
    handleViewRefund(index, row) {
      this.$router.push({
        path: '/rms/refundItem',
        query: {refundDetailId: row.refundDetailId}
      })
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

    //导出Excel表格
    handleSelectionChange(val) {
      this.multipleSelection = val;
    },

    handlePrint() {
      if (this.dataRefundBill === null) {
        Message.error('退货单数据获取失败');
        return;
      }

      const _data = this.refundDetail;

      const _createTime = formatDate(new Date(this.dataRefundBill.createTime), 'yyyy-MM-dd hh:mm:ss');

      const pf = new PrintForm({
        orderNumber: this.dataRefundBill.billCode,
        fromBranch: `${this.dataRefundBill.applicationBranch}`,
        billBranch: `${this.dataRefundBill.billBranch}`,
        fromWho: `申请人：${this.dataRefundBill.applicationUser}`,
        creator: `${this.dataRefundBill.billCreator}`,
        createTime: _createTime,
        title: '退货单',
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

    async handleDownload() {
      if (this.multipleSelection.length) {
        this.downloadLoading = true;
        import('@/vendor/Export2Excel').then(excel => {
          //对应表格输出的title
          const multiHeader = [[' ', ' ', ' ', '检验耗材退货单', '', ' ', ' ', ' ', ' '],
            ['供货单位: ', this.multipleSelection[0].supplierShortName, ' ', '单号: ', this.multipleSelection[0].refundCode, '时间: ', this.getNowFormatDate(), '制表人: ', this.multipleSelection[0].createBy]];
          const header = ['序号', '耗材名称', '规格型号', '单位', '数量', '单价', '合计金额', '批号', '备注'];
          const filterVal = ['newId', 'reagentName', 'reagentSpecification', 'reagentUnit', 'quantity', 'reagentPrice', 'total', 'batchNo', ' '];
          const merges = [];
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
    handleUpdate(index, row) {
      this.RefundEditDetail = Object.assign({}, row);
    },

    handleDelete(index, row) {
      // 获取删除订单详情的订单号
      const refundCode = this.refundDetail[0].refundCode;
      this.$confirm('是否要删除该耗材信息?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        deleteRefundDetailItem(row.id).then(response => {
          this.$message({
            type: 'success',
            message: '删除成功!'
          });
          getRefundDetail(this.refundCode).then(response => {
            this.refundDetail = response.data;
            this.listLoading = false;
            // 级联删除订单详情为空的订单
            if (this.refundDetail.length < 0 || this.refundDetail.length == 0) {
              deleteRefundByReCo(refundCode).then(response => {
                if (response.data == 1) {
                  this.$message({
                    type: 'success',
                    message: '已全部删除!'
                  });
                }
              });
            }
          });
        });
      });
    },
    getList() {
      this.listLoading = true;
      this.listQuery.keyword = this.$route.query.refundCode;
      fetchList(this.listQuery).then(response => {
        this.listLoading = false;
        this.refundDetail = response.data.list;
        this.total = response.data.total;
      });
    },

    /**
     * 获取退货单基本信息
     * 退货第一层数据
     */
    getDataRefundBill() {
      const billCode = this.$route.query.refundCode;
      fetchBill({
        pageNum: 1,
        pageSize: 50,
        keyword: billCode,
        printType: 6
      }).then(res => {
        if (res.data && res.data.list.length !== 0) {
          this.dataRefundBill = res.data.list[0];
        } else {
          Message.error('获取退货单基本信息失败');
        }
      });
    },
  }
}
</script>


