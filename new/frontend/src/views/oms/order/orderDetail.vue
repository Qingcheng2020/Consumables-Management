<template> 
  <div class="app-container">
    <el-card class="filter-container" shadow="never">
      <i class="el-icon-tickets"></i>

      <span>订单详情

         <el-button type="primary"
                    @click=" handleEditConfirm"
                    style="float: right;"
                    size="small"
                    v-show="orderStatus==0">
                    {{ handleEditButton ? '编辑' : "保存" }}
         </el-button>
         <el-button type="primary"
                    @click=" handleSubConfirm"
                    style="float: right;margin-right:10px"
                    size="small"
                    v-show="orderStatus==0">提交
         </el-button>
        <el-button
          type="primary"
          icon="el-icon-printer"
          style="margin-bottom:20px;
                      float:right;
                      margin-right:10px"
          @click="handlePrint">打印
        </el-button>

      </span>
    </el-card>
    <div class="table-container">
      <el-table ref="orderDetailTable"
                :data="orderDetail"
                :row-class-name="rowClassName"
                style="width: 100%;"
                max-height="550"
                v-loading="listLoading" border>
        <el-table-column prop="newId" align="center" label="序号" width="60"></el-table-column>

        <el-table-column label="订单编号" align="center">
          <template slot-scope="scope">{{ scope.row.orderNo }}</template>
        </el-table-column>
        <el-table-column label="耗材名称" align="center">
          <template slot-scope="scope">{{ scope.row.reagentName }}</template>
        </el-table-column>
        <el-table-column label="订货单位" align="center">
          <template slot-scope="scope">{{ scope.row.unit }}</template>
        </el-table-column>
        <el-table-column label="规格型号" align="center">
          <template slot-scope="scope">{{ scope.row.specification }}</template>
        </el-table-column>
        <el-table-column label="生产厂家" align="center">
          <template slot-scope="scope">{{ scope.row.manufacturerName }}</template>
        </el-table-column>
        <el-table-column label="单价(元)" align="center">
          <template slot-scope="scope">¥ {{ scope.row.price }}</template>
        </el-table-column>

        <el-table-column label="下单数量" width="200" align="center">
          <template slot-scope="scope">
            <span v-if="scope.row.show">
              <el-input-number
                v-model="scope.row.reagentNumber"
                :min="1" :max="100000">
              </el-input-number>
            </span>
            <span v-else>{{ scope.row.reagentNumber }}</span>
          </template>
        </el-table-column>
        <el-table-column label="已发货数量" align="center">
          <template slot-scope="scope">{{ scope.row.sendNum }}</template>
        </el-table-column>
        <el-table-column label="未发货数量" align="center">
          <template slot-scope="scope">{{ scope.row.unsendNum }}</template>
        </el-table-column>

        <el-table-column label="操作" width="180" align="center" v-if="orderStatus==0 ">
          <template slot-scope="scope">
            <el-button size="mini"
                       type="danger"
                       @click="handleDelete(scope.$index, scope.row)"
                       v-show="!handleEditButton"
            >删除
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
import {deleteOrderByNo, updateOrderByON} from '@/api/order';
import {fetchBill} from '@/api/preInBill';
import {deleteOrderDetailItem, fetchList, getOrderDetail, updateOrderDetail} from '@/api/orderDetail'
import {formatDate} from '@/utils/date';
import {PrintForm} from '@/utils/printForm';

const printFormColumn = [
  {
    field: 'reagentName',
    name: '耗材名称',
    columnSize: '200%'
  },
  {
    field: 'specification',
    name: '规格型号',
  },
  {
    field: 'unit',
    name: '单位',
  },
  {
    field: 'reagentNumber',
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
const defaultOrderQuery = {
  pageNum: 1,
  pageSize: 50,
  orderStatus: null,
  reagentPrice: null,
};
export default {
  name: "orderDetailList",
  data() {
    return {
      dataOrder: null,
      listQuery: Object.assign({}, defaultListQuery),
      order: Object.assign({}, defaultOrderQuery),
      listLoading: false,
      list: null,
      total: null,
      orderDetail: null,
      multipleSelection: [],
      orderStatus: null,
      handleEditButton: true,
      componentKey: 0,
      opShow: false,
    }
  },
  created() {
    this.getList();
    this.getDataOrder();
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
    handleSizeChange(val) {
      this.listQuery.pageNum = 1;
      this.listQuery.pageSize = val;
      this.getList();
    },
    handleCurrentChange(val) {
      this.listQuery.pageNum = val;
      this.getList();
    },

    //编辑操作
    handleEditConfirm() {
      //对表格中的每一项数据使用set更新
      this.orderDetail.map((i, index) => {
        i.show = true;
        this.$set(this.orderDetail, index, i);

        //保存操作，隐藏编辑框，更新详细数据，获取新的列表
        if (!this.handleEditButton) {
          updateOrderDetail(index, i).then(response => {
            i.show = false;

            //保存之后更新订单汇总表价格,但不更新状态
            const orderNo = this.orderDetail[0].orderNo;
            this.order.orderStatus = 0;
            updateOrderByON(orderNo, this.order);

            getOrderDetail(orderNo).then(response => {
              this.orderStatus = this.$route.query.orderStatus;
              this.handleEditButton = true;
              this.orderDetail = response.data;
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
    },

    handleSubConfirm() {
      //提交
      this.orderDetail.map((i, index) => {
        //i.show = true;
        this.$set(this.orderDetail, index, i);

        //保存操作，隐藏编辑框，更新详细数据，获取新的列表
        updateOrderDetail(index, i).then(response => {
          //i.show = false;

          //提交之后更新状态
          const orderNo = this.orderDetail[0].orderNo;
          this.order.orderStatus = 1;
          updateOrderByON(orderNo, this.order);
          this.$router.push("/oms/order")
          this.$message({
            message: '提交成功！',
            type: 'success'
          });
        });
      });
      /*if (this.handleEditButton) {
        this.order.orderStatus = 1;
        const orderNo = this.orderDetail[0].orderNo;
        updateOrderByON(orderNo, this.order).then(response => {
          this.$router.push("/oms/order")
          this.$message({
            message: '提交成功！',
            type: 'success'
          });
        });
        } else {
             this.$message({
               message: '请先保存入库单！',
               type: 'warning'
             });
           }*/
    },
    handleDelete(index, row) {
      // 获取删除订单详情的订单号
      const orderNo = this.orderDetail[0].orderNo;
      this.$confirm('是否要删除该耗材信息?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        deleteOrderDetailItem(row.id).then(response => {
          this.$message({
            type: 'success',
            message: '删除成功!'
          });
          getOrderDetail(orderNo).then(response => {
            this.orderDetail = response.data;
            this.listLoading = false;
            // 级联删除订单详情为空的订单
            if (this.orderDetail.length < 0 || this.orderDetail.length == 0) {
              deleteOrderByNo(orderNo).then(response => {
                if (response.data == 1) {
                  this.$router.push("/oms/order")
                }
              });
            }
          });
        });
      });

    },

    handlePrint() {
      if (this.dataOrder === null) {
        Message.error('订单数据获取失败');
        return;
      }

      const _data = this.orderDetail;

      // 每类的金额
      for (let item of _data) {
        item.total = item.price * item.reagentNumber;
      }

      const _createTime = formatDate(new Date(this.dataOrder.createTime), 'yyyy-MM-dd hh:mm:ss');

      const pf = new PrintForm({
        orderNumber: this.dataOrder.billCode,
        fromWho: `供货单位：${this.dataOrder.supplierName}`,
        creator: `${this.dataOrder.billCreator}`,
        createTime: _createTime,
        title: '订单',
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

    getList() {
      this.listLoading = true;
      this.listQuery.keyword = this.$route.query.orderNo;
      this.orderStatus = this.$route.query.orderStatus;
      fetchList(this.listQuery).then(response => {
        this.listLoading = false;
        this.orderDetail = response.data.list;
        this.total = response.data.total;
      });
    },

    /**
     * 获取订单基本信息
     * 订单第一层数据
     */
    getDataOrder() {
      const orderNo = this.$route.query.orderNo;

      fetchBill({
        pageNum: 1,
        pageSize: 50,
        keyword: orderNo,
        printType: 2
      }).then(res => {
        if (res.data && res.data.list.length != 0) {
          this.dataOrder = res.data.list[0];
        } else {
          Message.error('获取订单基本信息失败');
        }
      });
    },

  }
}
</script>
