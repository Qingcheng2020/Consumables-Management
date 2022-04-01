<template> 
  <div class="app-container">
    <!--    <el-button size="small" @click="back()">返回</el-button>-->
    <el-card class="filter-container" shadow="never">
      <i class="el-icon-tickets"></i>
      <span>入库单详情
        <el-input v-model="filename" placeholder="Enter File Name"
                  style="width:200px;
                      float:right;
                      margin-right:5px"
                  size="small"
                  prefix-icon="el-icon-document"
                  v-show="this.billStatus==1"/>
        <el-button :loading="downloadLoading"
                   style="margin-bottom:20px;
                       float:right;
                       margin-right:10px"
                   type="primary"
                   size="small"
                   icon="el-icon-download"
                   @click="handleDownload"
                   v-show="this.billStatus==1">导出
        </el-button>
        <el-button :loading="downloadLoading"
                   style="margin-bottom:20px;
                       float:right;
                       margin-right:10px"
                   type="primary"
                   size="small"
                   icon="el-icon-printer"
                   @click="handlePrint"
                   v-show="this.billStatus==1">打印
        </el-button>
        <!--        <el-button type="primary"
                           @click=" handleEditConfirm"
                           style="float: right;"
                           size="small"
                           v-show="billStatus==0">
                            {{ handleEditButton ? '编辑' : "保存" }}
                </el-button>
                <el-button type="primary"
                           @click=" handleSubConfirm"
                           style="float: right;
                           margin-right:10px"
                           size="small"
                           v-show="billStatus==0">提交
               </el-button>-->
      </span>
    </el-card>
    <!--    <el-card class="operate-container" shadow="never">-->
    <!--      <i class="el-icon-tickets"></i>-->
    <!--      <span>数据列表-->

    <!--  </span>-->
    <!--</el-card>-->
    <div class="table-container">
      <el-table ref="InBillDetailTable"
                :data="inBillDetail"
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
        <el-table-column label="单位" align="center">
          <template slot-scope="scope">{{ scope.row.reagentUnit }}</template>
        </el-table-column>
        <el-table-column label="规格型号" align="center">
          <template slot-scope="scope">{{ scope.row.reagentSpecification }}</template>
        </el-table-column>
        <el-table-column label="生产厂家" align="center">
          <template slot-scope="scope">{{ scope.row.factory }}</template>
        </el-table-column>
        <el-table-column label="单价" min-width="60%" align="center">
          <template slot-scope="scope">¥ {{ scope.row.price }}</template>
        </el-table-column>
        <el-table-column label="数量" min-width="60%" align="center">
          <template slot-scope="scope">
            <span v-if="scope.row.show">
               <el-input size="mini" placeholder="数量" v-model="scope.row.quantity"></el-input>
            </span>
            <span v-else>{{ scope.row.quantity }}</span>
          </template>
        </el-table-column>

        <el-table-column label="批号" min-width="90%" align="center">
          <template slot-scope="scope">
            <span v-if="scope.row.show">
              <el-input size="mini" placeholder="请输入产品批号" v-model="scope.row.batchNo"></el-input>
            </span>
            <span v-else>{{ scope.row.batchNo }}</span>
          </template>
        </el-table-column>

        <el-table-column label="有效期" align="center">
          <template slot-scope="scope">
             <span v-if="scope.row.show">
                <el-date-picker
                  placeholder="请选择保质期"
                  v-model="scope.row.expireDate"
                  type="date"
                  :picker-options="pickerOptions">
                </el-date-picker>
            </span>
            <span v-else>{{ scope.row.expireDate | formatDateTime }}</span>
          </template>
        </el-table-column>
        <el-table-column label="金额" align="center">
          <template slot-scope="scope">¥ {{ scope.row.total }}元</template>
        </el-table-column>
        <el-table-column label="备注" align="center">
          <template slot-scope="scope">{{ scope.row.remark }}</template>
        </el-table-column>

        <el-table-column label="操作" width="180" align="center">
          <template slot-scope="scope">
            <el-button size="mini"
                       type="primary"
                       v-show="handleEditButton"
                       @click="handleViewOrder(scope.$index, scope.row)">查看
            </el-button>
            <el-button size="mini"
                       type="danger"
                       v-show="billStatus==0 && !handleEditButton"
                       @click="handleDelete(scope.$index, scope.row)">删除
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
import {fetchBill} from '@/api/preInBill';
import {
  deleteInDetail,
  editInBillItem,
  fetchList,
  getInBillDetail,
  subInBillItem,
  updateInDetail
} from '@/api/inBillDetail'
import {Message} from 'element-ui';
import {formatDate} from '@/utils/date';
import {deleteBillByBC, updateInBillByBC} from '@/api/inBill';
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
    columnSize: '100%'
  },
  {
    field: 'reagentUnit',
    name: '单位',
    columnSize: '60%'
  },
  {
    field: 'quantity',
    name: '数量',
    columnSize: '60%'
  },
  {
    field: 'price',
    name: '单价',
    columnSize: '60%'
  },
  {
    field: 'total',
    name: '金额',
    columnSize: '50%'
  },
  {
    field: 'batchNo',
    name: '批号',
  },
  {
    field: 'expireDate',
    name: '有效期',
  },
  {
    field: 'factory',
    name: '生产厂家',
  },
  {
    field: 'reception',
    name: '验收情况',
    columnSize: '65%'
  },
];

const defaultListQuery = {
  pageNum: 1,
  pageSize: 50,
  keyword: null,
  price: null,
  quantity: 1,
  batchNo: null,
  expireDate: null,
};

const defaultBillQuery = {
  pageNum: 1,
  pageSize: 50,
  billStatus: null,
};
export default {
  name: "InBillDetailList",
  data() {
    return {
      dataInBill: null, // 入库单基本信息
      listQuery: Object.assign({}, defaultListQuery),
      inBill: Object.assign({}, defaultBillQuery),
      loading: false,
      listLoading: false,
      list: null,
      total: null,
      sub: false,
      billStatus: null,
      inBillDetail: null,
      multipleSelection: [],
      downloadLoading: false,
      filename: '',
      supplierName: this.$route.query.supplierName,
      handleEditButton: true,
      pickerOptions: {
        disabledDate(time) {
          return time.getTime() <= Date.now();
        },
      }
    }
  },
  created() {
    this.getList();
    this.getDataInBill();
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
      this.$router.push({path: '/wms/inBillItem', query: {inDetailId: row.inDetailId}})
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
      if (this.dataInBill === null) {
        Message.error('入库单数据获取失败');
        return;
      }

      const _data = this.inBillDetail;

      const _createTime = formatDate(new Date(this.dataInBill.createTime), 'yyyy-MM-dd hh:mm:ss');

      const pf = new PrintForm({
        orderNumber: this.dataInBill.billCode,
        fromWho: `供货单位：${this.dataInBill.supplierName}`,
        creator: `${this.dataInBill.trueName}`,
        createTime: _createTime,
        title: '入库单',
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
          const multiHeader = [[' ', ' ', ' ', ' ', ' ', '检验耗材入库单 ', ' ', ' ', ' ', ' ', ' '],
            ['供货单位:', this.supplierName, ' ', ' ', ' ', '单号:', this.multipleSelection[0].billCode, ' ', ' ', '时间:', this.getNowFormatDate()]];
          const header = ['序号', '耗材名称', '规格型号', '单位', '数量', '单价', '金额', '批号', '保质期', '生产厂家', '备注'];
          const filterVal = ['newId', 'reagentName', 'reagentSpecification', 'reagentUnit', 'quantity', 'price', 'total', 'batchNo', 'expireDate', 'factory', 'remark'];

          //进行所有表头的单元格合并,按行合并
          const merges = [
            "A1:E1",
            "G1:K1",
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
            this.$refs.InBillDetailTable.clearSelection();
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

    //编辑操作
    handleEditConfirm() {
      //对表格中的每一项数据使用set更新
      this.inBillDetail.map((i, index) => {
        i.show = true;
        this.$set(this.inBillDetail, index, i);
        //保存操作，隐藏编辑框，更新详细数据，获取新的列表
        if (!this.handleEditButton) {
          updateInDetail(index, i).then(response => {
            i.show = false;
            //保存之后更新订单汇总表价格,但不更新状态
            const billCode = this.inBillDetail[0].billCode;
            this.inBill.billStatus = 0;
            getInBillDetail(billCode).then(response => {
              this.billStatus = this.$route.query.billStatus;
              this.handleEditButton = true;
              this.inBillDetail = response.data;
              this.listLoading = false;
            });
            this.$message({
              message: '保存成功！',
              type: 'success'
            });
          });
        }
      });
      //编辑之后按钮变为保存按钮
      this.handleEditButton = false;
      //更新第三层的详细信息
      this.updateItem();
    },
    async handleSubConfirm() {
      //对表格中的每一项数据使用set更新
      this.inBill.billStatus = 1;
      this.inBillDetail.map((i, index) => {
        this.$set(this.inBillDetail, index, i);
        //保存操作，隐藏编辑框，更新详细数据，获取新的列表
        updateInDetail(index, i);
      });
      //更新第三层的详细信息
      await this.updateItem();
      this.submitItem();
    },
    async updateItem() {
      //更新第三层的详细信息
      const arr = [];
      this.inBillDetail.forEach(item => {
        const obj = {
          inDetailId: item.inDetailId,
          reagentName: item.reagentName,
          factory: item.factory,
          batchNo: item.batchNo,
          expireDate: item.expireDate,
          quantity: item.quantity,
        }
        arr.push(obj);
      })
      let sendData = {
        status: this.inBill.billStatus,
        billCode: this.inBillDetail[0].billCode,
        editBillMessList: arr,
      }
      await editInBillItem(sendData);
    },
    //提交信息
    submitItem() {
      const arr = [];
      this.inBillDetail.forEach(item => {
        const obj = {
          inDetailId: item.inDetailId
        }
        arr.push(obj);
      })
      let sendData = {
        status: this.inBill.billStatus,
        billCode: this.inBillDetail[0].billCode,
        subBillMessList: arr,
      }
      subInBillItem(sendData).then(result => {
        updateInBillByBC(sendData.billCode, this.inBill).then(response => {
          this.$router.go(-1);
          this.$message({
            message: '提交成功！',
            type: 'success'
          });
        });
      });
    },

    handleDelete(index, row) {
      // 获取删除订单详情的订单号
      const billCode = this.inBillDetail[0].billCode;
      this.$confirm('是否要删除该耗材信息?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        deleteInDetail(row.id).then(response => {
          this.$message({
            type: 'success',
            message: '删除成功!'
          });
          getInBillDetail(billCode).then(response => {
            this.inBillDetail = response.data;
            this.listLoading = false
            // 级联删除订单详情为空的订单
            if (this.inBillDetail.length < 0 || this.inBillDetail.length == 0) {
              deleteBillByBC(billCode).then(response => {
                if (response.data == 1) {
                  this.$message({
                    type: 'success',
                    message: '入库单删除成功!'
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
      this.listQuery.keyword = this.$route.query.billCode;
      this.billStatus = this.$route.query.billStatus;
      fetchList(this.listQuery).then(response => {
        this.listLoading = false;
        this.inBillDetail = response.data.list;
        this.total = response.data.total;

        for (let i = 0; i < this.inBillDetail.length; i++) {
          this.inBillDetail[i].expireDate = formatDate(new Date(this.inBillDetail[i].expireDate), 'yyyy-MM-dd');

          let key = "reception";
          this.inBillDetail[i][key] = "合格";
        }
      });
    },

    /**
     * 获取入库单基本信息
     * 入库第一层数据
     */
    getDataInBill() {
      const billCode = this.$route.query.billCode;
      //billType为了区分出打印的时候打印的中心库还是科室库，中心入库有供货商信息，科室没有
      const billType = this.$route.query.billType;

      fetchBill({
        pageNum: 1,
        pageSize: 50,
        keyword: billCode,
        printType: 3,
        billType: billType
      }).then(res => {
        if (res.data && res.data.list.length !== 0) {
          this.dataInBill = res.data.list[0];
        } else {
          Message.error('获取入库单基本信息失败');
        }
      });
    },

  }
}

</script>
