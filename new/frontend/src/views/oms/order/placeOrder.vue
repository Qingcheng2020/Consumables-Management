<template> 
  <div class="app-container">
    <!--    <el-button size="small" @click="back()">返回</el-button>-->
    <el-card class="filter-container" shadow="never">
      <i class="el-icon-tickets"></i>
      <span>耗材下单</span>
    </el-card>
    <div class="table-container">
      <el-form :inline="false" :model="placeOrder" size="medium " label-width="100px">
        <el-form-item label="下单人员：">
          <el-col :span="4">
            <el-input :disabled="true" v-model="listQuery.createBy" class="input-width"></el-input>
          </el-col>
        </el-form-item>
        <el-form-item label="备注：">
          <el-col :span="24">
            <el-input type="textarea"
                      :rows="2"
                      v-model="listQuery.orderDescribe"
                      class="input-width">
            </el-input>
          </el-col>
        </el-form-item>
      </el-form>
    </div>

    <el-card class="operate-container" shadow="never">
      <el-button icon="el-icon-circle-plus"
                 type="primary"
                 size="mini"
                 class="btn-add"
                 @click="handleAdd()"
                 style="float: left;
                 margin-bottom:15px">选择耗材
      </el-button>
    </el-card>

    <div class="table-container">
      <el-table ref="orderTable"
                :data="placeOrder"
                :row-class-name="rowClassName"
                style="width: 100%;"
                max-height="550"
                v-loading="listLoading"
                border>
        <el-table-column type="selection" width="60" align="center"></el-table-column>
        <el-table-column prop="newId" align="center" label="序号" width="60"></el-table-column>

        <el-table-column label="耗材名称" align="center">
          <template slot-scope="scope">{{ scope.row.name }}</template>
        </el-table-column>
        <el-table-column label="单位" align="center">
          <template slot-scope="scope">{{ scope.row.unit }}</template>
        </el-table-column>
        <el-table-column label="规格型号" align="center">
          <template slot-scope="scope">{{ scope.row.specification }}</template>
        </el-table-column>
        <el-table-column label="生产厂家" align="center">
          <template slot-scope="scope">{{ scope.row.manufacturerName }}</template>
        </el-table-column>
        <el-table-column label="供货商" align="center">
          <template slot-scope="scope">{{ scope.row.supplierShortName }}</template>
        </el-table-column>
        <el-table-column label="单价" align="center">
          <template slot-scope="scope">¥ {{ scope.row.price }}</template>
        </el-table-column>
        <el-table-column label="下单数量" width="150" align="center">
          <template slot-scope="scope">
            <el-input-number
              size="small"
              v-model="scope.row.reagentNumber"
              :min="1" :max="100000">
            </el-input-number>
          </template>
        </el-table-column>

        <el-table-column label="操作" width="220" align="center">
          <template slot-scope="scope">
            <el-button size="mini"
                       icon="el-icon-delete"
                       type="danger"
                       @click="handleDelete(scope.$index)">删除
            </el-button>
          </template>
        </el-table-column>
      </el-table>
      <el-card shadow="never">
        <el-button
          type="primary"
          size="mini"
          @click="submitOrder(0)"
          style="float: left;
                 margin-bottom:15px">保存
        </el-button>
        <el-button
          type="primary"
          size="mini"
          @click="submitOrder(1)"
          style="float: left;
                 margin-bottom:15px">提交
        </el-button>
      </el-card>

      <el-dialog title="耗材基础信息" :visible.sync="dialogAddTableVisible" width="84%">
        <el-card shadow="hover" :body-style="{ padding: '10px'}">
          <div>
            <el-button size="small" style="float:right;margin-right: 15px"
                       type="primary" :loading="loading"
                       @click.native.prevent="handleSearchList">查询搜索
            </el-button>
            <el-button
              style="float:right;margin-right: 15px"
              @click="handleResetSearch"
              size="small">重置
            </el-button>
          </div>
          <div style="float:right">
            <el-form :inline="true" :model="listQuery" size="small" label-width="140px">
              <el-form-item>
                <el-input v-model="listQuery.keyword" class="input-width" placeholder="供货商名/耗材名称"
                          clearable @keyup.enter.native="handleSearchList"></el-input>
              </el-form-item>
            </el-form>
          </div>

          <el-button icon="el-icon-circle-plus"
                     type="primary"
                     size="mini"
                     class="btn-add"
                     @click="toggleSelection()"
                     style="float: left; margin-bottom:11px">添加
          </el-button>
        </el-card>
        <div class="table-container">
          <el-table ref="placeOrderTable"
                    :data="list"
                    :row-class-name="rowClassName"
                    height="400"
                    style="width: 100%;"
                    @selection-change="handleSelectionChange"
                    v-loading="listLoading" border>
            <el-table-column type="selection" width="50" fixed align="center"></el-table-column>
            <el-table-column prop="newId" align="center" label="序号" width="60"></el-table-column>

            <el-table-column label="耗材名称" align="center">
              <template slot-scope="scope">{{ scope.row.reagentName }}</template>
            </el-table-column>
            <el-table-column label="单位" align="center">
              <template slot-scope="scope">{{ scope.row.unit }}</template>
            </el-table-column>
            <el-table-column label="规格型号" align="center">
              <template slot-scope="scope">{{ scope.row.specification }}</template>
            </el-table-column>
            <el-table-column label="生产厂家" align="center">
              <template slot-scope="scope">{{ scope.row.manufacturerName }}</template>
            </el-table-column>
            <el-table-column label="注册证号" align="center">
              <template slot-scope="scope">{{ scope.row.registrationNo }}</template>
            </el-table-column>
            <el-table-column label="供货商" align="center">
              <template slot-scope="scope">{{ scope.row.supplierShortName }}</template>
            </el-table-column>
            <el-table-column label="单价" align="center">
              <template slot-scope="scope">¥ {{ scope.row.price }}</template>
            </el-table-column>
            <el-table-column label="储存温度" align="center">
              <template slot-scope="scope">{{ scope.row.stockType }}</template>
            </el-table-column>
            <el-table-column label="库存数量" align="center">
              <template slot-scope="scope">{{ scope.row.stockNumber }}</template>
            </el-table-column>
            <!--            <el-table-column label="过期预警时间阈值" align="center">
                          <template slot-scope="scope">{{ scope.row.expirationLimit }}</template>
                        </el-table-column>
                        <el-table-column label="低库存预警阈值" align="center">
                          <template slot-scope="scope">{{ scope.row.stockLimit }}</template>
                        </el-table-column>
                        <el-table-column label="开启有效期限" align="center">
                          <template slot-scope="scope">{{ scope.row.useDayLimit }}</template>
                        </el-table-column>-->
          </el-table>
        </div>
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
      </el-dialog>

    </div>
    <el-button style="margin-top: 20px" size="small" @click="back()">返回</el-button>
  </div>
</template>
<script>
import {fetchEnSupList} from '@/api/baseInfo';
import {formatDate} from '@/utils/date';
import {createOrderItem} from '@/api/order';
import {getCookie} from "../../../utils/support";

const defaultListQuery = {
  pageNum: 1,
  pageSize: 50,
  orderDescribe: null,
  createBy: getCookie("username"),
  keyword: null,
};
export default {
  name: "placeOrderList",
  data() {
    return {
      listQuery: Object.assign({}, defaultListQuery),
      loading: false,
      listLoading: false,
      list: null,
      total: null,
      placeOrder: [],
      multipleSelection: [],
      reagents: [],
      reagentNumber: 1,
      dialogAddTableVisible: false
    }
  },
  created() {
    this.listLoading = false;
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
    handleResetSearch() {
      this.listQuery = Object.assign({}, defaultListQuery);
      this.listQuery.pageNum = 1;
      this.getList();
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
    handleSelectionChange(val) {
      this.multipleSelection = val;
    },
    handleAdd() {
      this.dialogAddTableVisible = true;
      this.getList();
    },
    submitOrder(orderStatus) {
      const arr = [];
      this.placeOrder.forEach(item => {
        const obj = {
          reagentCode: item.code,
          number: item.reagentNumber,
          supplierId: item.supplierId,
          supplierName: item.supplierShortName,
          specification: item.specification,
          manufacturerName: item.manufacturerName,
        }
        arr.push(obj);
      })
      let sendData = {
        orderState: orderStatus,
        orderMessList: arr,
        orderDescribe: this.listQuery.orderDescribe,
        createBy: this.listQuery.createBy
      }
      createOrderItem(sendData);

      if (orderStatus) {
        this.$message({
          message: '提交成功',
          type: 'success',
          duration: 1000
        });
      } else if (!orderStatus) {
        this.$message({
          message: '保存成功',
          type: 'success',
          duration: 1000
        });
      }
      this.$router.push("/oms/order");
    },

    toggleSelection() {
      if (this.multipleSelection == null || this.multipleSelection.length < 1) {
        this.$message({
          message: '请选择要添加的耗材',
          type: 'warning',
          duration: 1000
        });

      } else {
        let _this = this;
        this.listLoading = true;

        for (let j = 0; j < this.placeOrder.length; j++) {
          this.reagents[j] = this.placeOrder[j].code;
        }
        if (this.reagents.length > 0) {
          for (let i in this.reagents) {
            for (let k in this.multipleSelection) {
              if (this.reagents[i] == this.multipleSelection[k].reagentId) {
                this.multipleSelection.splice(k, 1)
              }
            }
          }
          for (let i = 0; i < this.multipleSelection.length; i++) {
            this.placeOrder.push(this.covertOrder(this.multipleSelection[i]));
          }
        } else {
          for (let i = 0; i < this.multipleSelection.length; i++) {
            this.placeOrder.push(this.covertOrder(this.multipleSelection[i]));
          }
        }


        this.dialogAddTableVisible = false;
        this.listLoading = false;
        return _this.placeOrder;
      }
    },
    covertOrder(order) {
      return {
        id: order.id,
        code: order.reagentId,
        name: order.reagentName,
        unit: order.unit,
        price: order.price,
        specification: order.specification,
        manufacturerName: order.manufacturerName,
        supplierId: order.supplierId,
        reagentNumber: this.reagentNumber,
        supplierShortName: order.supplierShortName,
        createBy: this.listQuery.createBy,
        orderDescribe: this.listQuery.orderDescribe,
      };
    },
    handleDelete(index) {
      this.placeOrder.splice(index, 1);
    },
    getList() {
      this.listLoading = true;
      fetchEnSupList(this.listQuery).then(response => {
        this.listLoading = false;
        this.list = response.data.list;
        this.total = response.data.total;
      });
    },
  }
}
</script>


