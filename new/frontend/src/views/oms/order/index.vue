<template> 
  <div class="app-container">
    <el-card class="filter-container" shadow="never">
      <div>
        <i class="el-icon-tickets"></i>
        <span>订单列表</span>
      </div>
      <el-button size="small" style="float:right;margin-right: 15px"
                 type="primary" :loading="loading"
                 @click.native.prevent="handleSearchList">
        查询搜索
      </el-button>

      <el-button
        style="float:right;margin-right: 10px"
        @click="handleResetSearch()"
        size="small">
        重置
      </el-button>
      <div style="float:right">
        <el-form :inline="true" :model="listQuery" size="small" label-width="140px">
          <el-form-item>
            <el-input v-model="listQuery.keyword" clearable
                      class="input-width" placeholder="订单编号/供货商"
                      @keyup.enter.native="handleSearchList"></el-input>
          </el-form-item>
        </el-form>
      </div>
    </el-card>
    <div class="table-container">
      <el-table ref="orderTable"
                :data="list"
                :row-class-name="rowClassName"
                max-height="760"
                stripe
                :default-sort="{scope: 'scope.row.orderDay', order: 'descending'}"
                style="width: 100%;"
                @selection-change="handleSelectionChange"
                @expand-change="handleDetail"
                v-loading="listLoading" border>

        <el-table-column type="expand">
          <template slot-scope="scope">
            <el-table :data="scope.row.tableData"
                      border
                      style="width: 100%;float:right">
              <el-table-column label="订单编号" align="center">
                <template slot-scope="props">{{ props.row.orderNo }}</template>
              </el-table-column>
              <el-table-column label="耗材名称" align="center">
                <template slot-scope="props">{{ props.row.reagentName }}</template>
              </el-table-column>
              <el-table-column label="订货单位" align="center">
                <template slot-scope="props">{{ props.row.unit }}</template>
              </el-table-column>
              <el-table-column label="规格型号" align="center">
                <template slot-scope="props">{{ props.row.specification }}</template>
              </el-table-column>
              <el-table-column label="生产厂家" align="center">
                <template slot-scope="props">{{ props.row.manufacturerName }}</template>
              </el-table-column>
              <el-table-column label="单价(元)" align="center">
                <template slot-scope="props">¥ {{ props.row.price }}</template>
              </el-table-column>

              <el-table-column label="下单数量" width="200" align="center">
                <template slot-scope="props">
            <span v-if="props.row.show">
              <el-input-number
                v-model="props.row.reagentNumber"
                :min="1" :max="100000">
              </el-input-number>
            </span>
                  <span v-else>{{ props.row.reagentNumber }}</span>
                </template>
              </el-table-column>
              <el-table-column label="已发货数量" align="center">
                <template slot-scope="props">{{ props.row.sendNum }}</template>
              </el-table-column>
              <el-table-column label="未发货数量" align="center">
                <template slot-scope="props">{{ props.row.unsendNum }}</template>
              </el-table-column>

            </el-table>
          </template>
        </el-table-column>

        <el-table-column prop="newId" align="center" label="序号" width="60"></el-table-column>
        <el-table-column label="订单编号" width="180" align="center">
          <template slot-scope="scope">{{ scope.row.orderNo }}</template>
        </el-table-column>
        <el-table-column label="下单日期" align="center">
          <template slot-scope="scope">{{ scope.row.orderDay }}</template>
        </el-table-column>
        <el-table-column label="供货商" align="center">
          <template slot-scope="scope">{{ scope.row.supplierShortName }}</template>
        </el-table-column>
        <el-table-column label="下单人员" align="center">
          <template slot-scope="scope">{{ scope.row.createBy }}</template>
        </el-table-column>
        <el-table-column label="总价(元)" align="center">
          <template slot-scope="scope">¥ {{ scope.row.orderPrice }}</template>
        </el-table-column>
        <el-table-column label="状态" align="center">
          <template slot-scope="scope">
            {{ statusData[(scope.row.orderStatus)] }}
          </template>
        </el-table-column>
        <el-table-column label="备注" align="center">
          <template slot-scope="scope">{{ scope.row.orderDescribe }}</template>
        </el-table-column>
        <el-table-column label="创建时间" width="100" align="center">
          <template slot-scope="scope">{{ scope.row.createTime | formatDateTime }}</template>
        </el-table-column>
        <el-table-column label="操作" width="220" align="center">
          <template slot-scope="scope">
            <el-button
              size="mini"
              type="primary"
              @click="handleViewOrder(scope.$index, scope.row)"
              v-show="scope.row.orderStatus!=0"
            >查看
            </el-button>
            <el-button
              size="mini"
              type="primary"
              @click="handlePlaceOrder(scope.$index, scope.row)"
              v-show="(scope.row.orderStatus==1 || scope.row.orderStatus==2) && (roleId == 1 || roleId == 5)"
            >配货
            </el-button>
            <el-button
              size="mini"
              type="primary"
              icon="el-icon-edit"
              @click="handleViewOrder(scope.$index, scope.row)"
              v-show="scope.row.orderStatus==0">编辑
            </el-button>
            <el-button
              size="mini"
              type="danger"
              v-show="scope.row.orderStatus==0"
              @click="handleDeleteOrder(scope.$index, scope.row)">删除
            </el-button>
            <el-button
              size="mini"
              type="danger"
              v-show="(roleId == 2 || roleId == 6 || roleId == 1) && (scope.row.orderStatus==1)"
              @click="handleRevoke(scope.$index, scope.row)">撤销
            </el-button>
            <el-button
              size="mini"
              type="danger"
              v-show="(roleId == 2 || roleId == 6 || roleId == 1) && (scope.row.orderStatus==1 || scope.row.orderStatus==2|| scope.row.orderStatus==5)"
              @click="handleClose(scope.$index, scope.row)">关闭
            </el-button>
          </template>
        </el-table-column>
      </el-table>
    </div>
    <!--    <div class="batch-operate-container">
          <el-select
            size="small"
            v-model="operateType" placeholder="批量操作">
            <el-option
              v-for="item in operateOptions"
              :key="item.value"
              :label="item.label"
              :value="item.value">
            </el-option>
          </el-select>
          <el-button
            style="margin-left: 20px"
            class="search-button"
            @click="handleBatchOperate()"
            type="primary"
            size="small">确定
          </el-button>
        </div>-->
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
import {closeOrder, deleteOrder, fetchDetailList, fetchList, getRole, revokeOrder} from '@/api/order'
import {formatDate} from '@/utils/date';
import {deleteOrderDetail} from "@/api/orderDetail";
import {getCookie} from '@/utils/support';

const defaultListQuery = {
  pageNum: 1,
  pageSize: 50,
  keyword: null,
  orderStatus: null,
  createBy: null,
  username: getCookie("username"),
};
export default {
  name: "orderList",
  data() {
    return {
      tableData: null,
      orderStatus: null,
      listQuery: Object.assign({}, defaultListQuery),
      loading: false,
      listLoading: false,
      responseData: null,
      list: null,
      total: null,
      operateType: null,
      multipleSelection: [],
      downloadLoading: false,
      filename: '',
      roleId: 0,

      //订单状态
      statusData: {
        '0': '草稿',
        '1': '已提交',
        '2': '已配货',
        '3': '已撤销',
        '4': '已完成',
        '5': '已全部配货',
      },
      //订单操作
      operateOptions: [
        {
          label: "删除订单",
          value: 2
        }
      ],
    }
  },
  created() {
    this.getList();
    this.getRole();
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
      row.newId = (this.listQuery.pageSize * (this.listQuery.pageNum - 1)) + rowIndex + 1;
    },
    getRole() {
      getRole(this.listQuery.username).then(response => {
        this.roleId = response.data;
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
      this.listQuery.username = getCookie("username");
      this.getList();
    },
    handleSelectionChange(val) {
      this.multipleSelection = val;
    },
    //导出Excel表格
    handleDownload() {
      if (this.multipleSelection.length) {
        this.downloadLoading = true
        import('@/vendor/Export2Excel').then(excel => {
          const tHeader = ['编号', '订单号', '下单日', '供货商ID', '供货商名', '下单人', '总价', '状态', '描述'];
          const filterVal = ['id', 'orderNo', 'orderDay', 'supplierId', 'supplierShortName', 'creatBy', 'orderPrice', 'orderStatus', 'orderDescribe'];
          const list = this.multipleSelection;
          const data = this.formatJson(filterVal, list);
          excel.export_json_to_excel({
            header: tHeader,
            data,
            filename: this.filename
          })
          this.$nextTick(() => {
            this.$refs.orderTable.clearSelection();
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

    handleViewOrder(index, row) {
      this.$router.push({path: '/oms/orderDetail', query: {orderNo: row.orderNo, orderStatus: row.orderStatus}})
    },
    handlePlaceOrder(index, row) {
      this.$router.push({
        path: '/oms/preInBillAdd',
        query: {orderNo: row.orderNo, supplierShortName: row.supplierShortName, createBy: row.createBy}
      })
    },
    handleDeleteOrder(index, row) {
      let ids = [];
      let orderNos = [];
      ids.push(row.id);
      orderNos.push(row.orderNo);
      this.deleteOrder(ids, orderNos);
    },
    handleRevoke(index, row) {
      revokeOrder(row.id).then(response => {
        this.$message({
          message: '撤销成功！',
          type: 'success',
          duration: 1000
        });
        this.getList();
      });
    },
    handleClose(index, row) {
      closeOrder(row.id).then(response => {
        this.$message({
          message: '关闭成功！',
          type: 'success',
          duration: 1000
        });
        this.getList();
      });
    },

    handleBatchOperate() {
      if (this.multipleSelection == null || this.multipleSelection.length < 1) {
        this.$message({
          message: '请选择要操作的订单',
          type: 'warning',
          duration: 1000
        });
        return;
      }
      if (this.operateType === 2) {
        //删除订单
        let ids = [];
        let orderNos = [];
        for (let i = 0; i < this.multipleSelection.length; i++) {
          ids.push(this.multipleSelection[i].id);
          orderNos.push(this.multipleSelection[i].orderNo);
        }
        this.deleteOrder(ids, orderNos);
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
    deleteOrder(ids, orderNos) {
      this.$confirm('是否要进行该删除操作?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        let params_id = new URLSearchParams();
        params_id.append("ids", ids);
        let params_orderNo = new URLSearchParams();
        params_orderNo.append("orderNos", orderNos);

        deleteOrder(params_id).then(response => {
          this.$message({
            message: '删除成功！',
            type: 'success',
            duration: 1000
          });
          this.getList();
        });
        deleteOrderDetail(params_orderNo);
      })
    },
    handleDetail(row, expandedRows) {
      if (expandedRows.length > 0) {
        this.listLoading = true;
        this.listQuery.keyword = row.orderNo;
        fetchDetailList(this.listQuery).then(response => {
          this.listLoading = false;
          row.tableData = response.data.list;
        })
      }
    },
    getList() {
      this.listLoading = true;
      fetchList(this.listQuery).then(response => {
        this.listLoading = false;
        this.list = response.data.list;
        this.total = response.data.total;
      });
    },

  }
}
</script>
<style scoped>
.input-width {
  width: 203px;
}
</style>


