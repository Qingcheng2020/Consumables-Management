<template> 
  <div class="app-container">
    <el-card class="filter-container" shadow="never">
      <i class="el-icon-tickets"></i>
      <span>库存详情</span>
      <el-button
        circle
        type="primary"
        icon="el-icon-printer"
        style="margin-bottom:20px;
                    float:right;"
        :loading="downloadLoading"
        size="small"
        @click="handlePrint">
      </el-button>
      <el-button
        circle
        size="small"
        icon="el-icon-search"
        type="primary"
        style="float:right;
               margin-right:10px"
        @click="isShow = !isShow"></el-button>

      <div v-if="isShow">
        <div style="float:left;margin-top: 8px">
          <el-form :inline="true" :model="listQuery" size="small">
            <el-form-item>
              <el-input v-model="listQuery.reagentCode" style="width: 130px" placeholder="耗材编号" clearable
                        @keyup.enter.native="handleSearchList"></el-input>
            </el-form-item>
            <el-form-item>
              <el-input v-model="listQuery.batchNo" style="width: 130px" placeholder="产品批号" clearable
                        @keyup.enter.native="handleSearchList"></el-input>
            </el-form-item>
            <el-form-item>
              <el-date-picker
                style="width: 130px"
                placeholder="保质期"
                v-model="listQuery.expireDate"
                type="date"
                value-format="yyyy-MM-dd"
                format="yyyy-MM-dd"
                :picker-options="pickerOptions"
                @keyup.enter.native="handleSearchList">
              </el-date-picker>
            </el-form-item>
            <el-form-item>
              <el-input v-model="listQuery.enterMan" style="width: 130px" placeholder="入库人员" clearable
                        @keyup.enter.native="handleSearchList"></el-input>
            </el-form-item>
            <el-form-item>
              <el-date-picker
                style="width: 130px"
                placeholder="入库时间"
                v-model="listQuery.enterTime"
                type="date"
                value-format="yyyy-MM-dd"
                format="yyyy-MM-dd"
                @keyup.enter.native="handleSearchList">
              </el-date-picker>
            </el-form-item>
            <el-form-item>
              <el-input v-model="listQuery.enterNo" style="width: 130px" placeholder="入库单号" clearable
                        @keyup.enter.native="handleSearchList"></el-input>
            </el-form-item>
            <el-form-item>
              <el-input v-model="listQuery.outMan" style="width: 130px" placeholder="出库人员" clearable
                        @keyup.enter.native="handleSearchList"></el-input>
            </el-form-item>
            <el-form-item>
              <el-date-picker
                style="width: 130px"
                placeholder="出库时间"
                v-model="listQuery.outTime"
                type="date"
                value-format="yyyy-MM-dd"
                format="yyyy-MM-dd"
                @keyup.enter.native="handleSearchList">
              </el-date-picker>
            </el-form-item>
            <el-form-item>
              <el-input v-model="listQuery.outNo" style="width: 130px" placeholder="出库单号" clearable
                        @keyup.enter.native="handleSearchList"></el-input>
            </el-form-item>
            <el-form-item>
              <el-input v-model="listQuery.applyMan" style="width: 130px" placeholder="申领人员" clearable
                        @keyup.enter.native="handleSearchList"></el-input>
            </el-form-item>
            <el-button size="small" style="width: 130px;float:right;margin-right: 35px"
                       type="primary" :loading="loading"
                       @click.native.prevent="handleSearchList">查询搜索
            </el-button>
            <el-button
              style="width: 130px;float:right;margin-right: 15px"
              @click="handleResetSearch()"
              size="small">重置
            </el-button>
          </el-form>
        </div>
      </div>
    </el-card>
    <div class="table-container">
      <el-table ref="stockCentreTable"
                :data="stockCentre"
                style="width: 120%;"
                v-loading="listLoading" border>
        <el-table-column label="耗材名称" min-width="160%" align="center">
          <template slot-scope="scope">{{ scope.row.reagentName }}</template>
        </el-table-column>
        <el-table-column label="型号规格" align="center">
          <template slot-scope="scope">{{ scope.row.specification }}</template>
        </el-table-column>
        <el-table-column label="生产厂家" min-width="100%" align="center">
          <template slot-scope="scope">{{ scope.row.manufacturerName }}</template>
        </el-table-column>
        <el-table-column label="注册证号" min-width="100%" align="center">
          <template slot-scope="scope">{{ scope.row.registrationNo }}</template>
        </el-table-column>
        <el-table-column label="供货商" align="center">
          <template slot-scope="scope">{{ scope.row.supplierShortName }}</template>
        </el-table-column>
        <el-table-column label="单位" align="center">
          <template slot-scope="scope">{{ scope.row.unit }}</template>
        </el-table-column>
        <el-table-column label="状态" align="center">
          <template slot-scope="scope">
            {{ statusData1[(scope.row.status)] }}
          </template>
        </el-table-column>
        <el-table-column label="存储温度" align="center">
          <template slot-scope="scope">{{ scope.row.stockType }}</template>
        </el-table-column>
      </el-table>
    </div>

    <div class="table-container">
      <el-table ref="stockCentreTable"
                :data="stockCentreDetail"
                max-height="750"
                :cell-style="overdue"
                :row-class-name="rowClassName"
                style="width: 120%;"
                v-loading="listLoading" border>
        <el-table-column prop="newId" align="center" label="序号" width="50" fixed="left"></el-table-column>
        <el-table-column label="耗材编号" min-width="110%" align="center">
          <template slot-scope="scope">{{ scope.row.reagentCode }}</template>
        </el-table-column>
        <el-table-column label="产品批号" min-width="90%" align="center">
          <template slot-scope="scope">{{ scope.row.batchNo }}</template>
        </el-table-column>
        <el-table-column label="库存有效期" min-width="100%" align="center">
          <template slot-scope="scope">{{ scope.row.expireDate | formatDateTime }}</template>
        </el-table-column>
        <el-table-column label="开启有效期(天)" min-width="100%" align="center">
          <template slot-scope="scope">{{ scope.row.openPeriod }}</template>
        </el-table-column>
        <el-table-column label="单价(元)" align="center">
          <template slot-scope="scope">¥ {{ scope.row.reagentPrice }}</template>
        </el-table-column>
        <el-table-column prop="overdueDay" align="center" label="过期预警(天)"></el-table-column>
        <el-table-column label="入库时间" min-width="100%" align="center">
          <template slot-scope="scope">{{ scope.row.enterTime | formatDateTime }}</template>
        </el-table-column>
        <el-table-column label="入库单号" min-width="90%" align="center">
          <template slot-scope="scope">{{ scope.row.enterNo }}</template>
        </el-table-column>
        <el-table-column label="入库人员" align="center">
          <template slot-scope="scope">{{ scope.row.enterMan }}</template>
        </el-table-column>
        <el-table-column label="出库时间" min-width="100%" align="center">
          <template slot-scope="scope">{{ scope.row.outTime }}</template>
        </el-table-column>
        <el-table-column label="出库单号" min-width="90%" align="center">
          <template slot-scope="scope">{{ scope.row.outNo }}</template>
        </el-table-column>
        <el-table-column label="出库人员" align="center">
          <template slot-scope="scope">{{ scope.row.outMan }}</template>
        </el-table-column>
        <el-table-column label="申领人" align="center">
          <template slot-scope="scope">{{ scope.row.applyMan }}</template>
        </el-table-column>
        <el-table-column label="二维码" width="300%" align="center">
          <template slot-scope="scope">
            <div>
              <div class="qrcode-pic" ref="codeItem">
                <vue-qr :text="scope.row.qrCode" :size="110" :margin="0"></vue-qr>
              </div>
              <div v-html="scope.row.codeValue" class="right" align="left"></div>
            </div>
          </template>
        </el-table-column>
        <el-table-column label="操作" width="100" align="center" fixed="right">
          <template slot-scope="scope">
            <el-row>
              <el-button size="mini"
                         type="primary"
                         @click="handleSelectLoss(scope.$index, scope.row)">库损登记
              </el-button>
            </el-row>
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

    <el-dialog
      title="库损类型"
      :visible.sync="allocDialogVisible"
      width="30%">
      <el-select v-model="allocLossId" placeholder="请选择" size="small" style="width: 80%">
        <el-option
          v-for="item in allLossList"
          :key="item.id"
          :label="item.name"
          :value="item.id">
        </el-option>
      </el-select>
      <span slot="footer" class="dialog-footer">
            <el-button @click="allocDialogVisible = false" size="small">取 消</el-button>
            <el-button type="primary" @click="handleAllocDialogConfirm()" size="small">确 定</el-button>
          </span>
    </el-dialog>
  </div>
</template>
<script>
import {fetchList, getStockList, updateStatus} from '@/api/stockDetail'
import {formatDate} from '@/utils/date';
import {getCookie} from '@/utils/support';
import VueQr from "vue-qr";
import {Message} from "element-ui";
import {PrintForm} from '@/utils/printForm';

const printFormColumn = [
  {
    field: 'reagentName',
    name: '耗材名称',
  },
  {
    field: 'specification',
    name: '型号规格',
    columnSize: '40%'
  },
  {
    field: 'unit',
    name: '单位',
    columnSize: '30%'
  },
  {
    field: 'reagentCode',
    name: '耗材编号',
    columnSize: '50%'
  },
  {
    field: 'batchNo',
    name: '批号',
    columnSize: '50%'
  },
  {
    field: 'expireDate',
    name: '有效期至',
    columnSize: '50%'
  },
  {
    field: 'overdueDay',
    name: '剩余天数',
    columnSize: '40%'
  },

];

const defaultListQuery = {
  pageNum: 1,
  pageSize: 50,
  keyword: null,
  reagentCode: null,
  enterMan: null,
  applyMan: null,
  batchNo: null,
  expireDate: null,
  outNo: null,
  outMan: null,
  enterNo: null,
  outTime: null,
  enterTime: null,
  username: getCookie("username"),
};
export default {
  name: "stockCentreDetailList",
  data() {
    return {
      pickerOptions: {
        disabledDate(time) {
          return time.getTime() <= Date.now();
        },
      },
      downloadLoading: false,
      dataStock: null,
      isShow: false,
      listQuery: Object.assign({}, defaultListQuery),
      loading: false,
      listLoading: false,
      list: null,
      total: null,
      stockCentreDetail: [],
      stockCentre: [],
      multipleSelection: [],

      allocDialogVisible: false,
      allocLossId: null,
      allocQrcode: null,

      allLossList: [{
        id: '0',
        name: '丢失'
      }, {
        id: '1',
        name: '破损'
      }, {
        id: '2',
        name: '过期'
      }, {
        id: '3',
        name: '用尽'
      }, {
        id: '4',
        name: '其他原因'
      }],

      //试剂状态
      statusData: {
        '0': '丢失',
        '1': '破损',
        '2': '过期',
        '3': '用尽',
        '4': '其他原因库损',
        '5': '已退货',
        '1997': '中心已出库',
        '1998': '在库',
        '1999': '科室已出库',
      },
      //试剂在库状态
      statusData1: {
        '1': '已入库',
      },
      allocReagentId: null,
    }
  },
  components: {
    VueQr
  },
  created() {

    this.getList();
    this.getStock();
  },
  filters: {
    formatDateTime(time) {
      if (time == null || time === '') {
        return 'N/A';
      }
      let date = new Date(time);
      return formatDate(date, 'yyyy-MM-dd')
    }
  },
  methods: {
    overdue({row, columnIndex}) {
      //date1结束时间
      let date1 = new Date(row.expireDate);
      //date2当前时间
      let date2 = new Date();
      date1 = new Date(date1.getFullYear(), date1.getMonth(), date1.getDate());
      date2 = new Date(date2.getFullYear(), date2.getMonth(), date2.getDate());
      const diff = date1.getTime() - date2.getTime(); //目标时间减去当前时间
      const diffDate = diff / (24 * 60 * 60 * 1000);  //计算当前时间与结束时间之间相差天数

      if (diffDate <= 0 && columnIndex == 6) {
        return {
          background: 'red'
        }
      }
      if (diffDate > 0 && diffDate <= row.overdue && columnIndex == 6) {
        return {
          background: 'orange'
        }
      }
    },
    rowClassName({row, rowIndex}) {
      //date1结束时间
      let date1 = new Date(row.expireDate);
      //date2当前时间
      let date2 = new Date();
      date1 = new Date(date1.getFullYear(), date1.getMonth(), date1.getDate());
      date2 = new Date(date2.getFullYear(), date2.getMonth(), date2.getDate());
      const diff = date1.getTime() - date2.getTime(); //目标时间减去当前时间
      const diffDate = diff / (24 * 60 * 60 * 1000);  //计算当前时间与结束时间之间相差天数
      if (diffDate < 0) {
        row.overdueDay = "已过期";
      } else {
        row.overdueDay = diffDate;
      }

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
    handlePrint() {
      if (this.stockCentreDetail === null) {
        Message.error('库存详细数据获取失败');
        return;
      }
      this.stockCentreDetail.forEach(item => {
        this.stockCentre.forEach(first => {
          item.reagentNumber = first.reagentNumber;
          item.specification = first.specification;
          item.unit = first.unit;
          item.expireDate = formatDate(new Date(item.expireDate), 'yyyy-MM-dd');
        })
      })
      const _data = this.stockCentreDetail;

      const _createTime = formatDate(new Date(), 'yyyy-MM-dd hh:mm:ss');

      const pf = new PrintForm({
        orderNumber: this.dataStock.stockNo,
        fromWho: `科室名称：${this.dataStock.branch}`,
        createTime: _createTime,
        title: '库存详细表',
        properties: printFormColumn,
        data: _data,
        showIds: true,

      });

      pf.toPrint();
    },
    printCode() {
      setTimeout(() => {
        const that = this;
        this.$nextTick(() => {
          let arrDom = document.querySelectorAll(".qrcode-pic");

          let iframe = document.createElement('IFRAME');
          iframe.setAttribute('style', 'position: absolute: width:0px; height: 0px; left: -500px; top:-500px;');
          document.body.appendChild(iframe);
          let doc = iframe.contentWindow.document;

          for (let i = 0; i < that.stockCentreDetail.length; i++) {
            doc.write(`

                <div class="long">
                         <div class="qrcode">${arrDom[i].innerHTML}</div>
                         <div class="codeValue">${that.stockCentreDetail[i].codeValue}</div>
                </div>
                <div style="page-break-after: always"><br /></div>
            `);
          }
          doc.write(`
            <style>
              .long {
                width: 300px;
                height: 100px;
                padding: 2rem;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                margin: auto;
              }
              .qrcode{
                width: 110px;
                height: 110px;
                float: left;
              }
              .codeValue{
                width: 180px;
                height: 100px;
                float: right;
                font-size:8px;
                word-break:break-all;

              }
            </style>

          `);
          iframe.contentWindow.print();
          iframe.parentNode.removeChild(iframe)
        })

      }, 100)
    },

    handleAllocDialogConfirm() {
      this.$confirm('是否要确认?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        let params = new URLSearchParams();
        params.append("qrcode", this.allocQrcode);
        params.append("lossId", this.allocLossId);
        params.append("username", this.listQuery.username);
        updateStatus(params).then(response => {
          this.$message({
            message: '登记成功！',
            type: 'success'
          });
          this.allocDialogVisible = false;
          this.getStock();
          this.getList();
        })
      })
    },
    handleSelectLoss(index, row) {
      this.allocQrcode = row.qrCode;
      this.allocDialogVisible = true;
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
    getStock() {
      this.listLoading = true;
      this.listQuery.keyword = this.$route.query.stockNo;
      getStockList(this.listQuery).then(response => {
        this.listLoading = false;
        this.stockCentre = response.data;
      });
    },
    getList() {
      this.listLoading = true;
      this.listQuery.keyword = this.$route.query.stockNo;
      let sendData = {
        keyword: this.$route.query.stockNo,
        reagentCode: this.listQuery.reagentCode,
        batchNo: this.listQuery.batchNo,
        expireDate: this.listQuery.expireDate,
        enterTime: this.listQuery.enterTime,
        enterNo: this.listQuery.enterNo,
        enterMan: this.listQuery.enterMan,
        outTime: this.listQuery.outTime,
        outNo: this.listQuery.outNo,
        outMan: this.listQuery.outMan,
        applyMan: this.listQuery.applyMan,
        username: this.listQuery.username,
        pageNum: this.listQuery.pageNum,
        pageSize: this.listQuery.pageSize,
      }
      fetchList(sendData).then(response => {
        this.listLoading = false;
        this.stockCentreDetail = response.data.list;
        this.total = response.data.total;
        this.dataStock = response.data.list[0];
      });
    },
  }
}
</script>
<style type="text/css">
.qrcode-pic {
  float: left;
  margin-left: 20px;
  margin-top: 20px;
}

.right {
  position: center;
  float: left;
  font-size: 12px;
  width: 45%;
  margin-left: 10px;
}

.stock-width {
  width: 110px;
}

</style>
