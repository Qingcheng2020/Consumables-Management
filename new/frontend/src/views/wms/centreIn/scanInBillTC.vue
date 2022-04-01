<template> 
  <div class="app-container">
    <!--    <el-button size="small" @click="back()">返回</el-button>-->
    <el-card class="filter-container" shadow="never">
      <i class="el-icon-tickets"></i>
      <span>扫码入库</span>
    </el-card>
    <el-card class="operate-container" shadow="never">
      <div class="table-container">
        <el-form :inline="false" :model="createInBill" size="medium " label-width="100px">
          <el-form-item label="制单人员：">
            <el-col :span="4">
              <el-input :disabled="true" v-model="listQuery.billCreator" class="input-width"></el-input>
            </el-col>
          </el-form-item>
          <!--          <el-form-item label="备注：">
                      <el-col :span="24">
                        <el-input type="textarea"
                                  :rows="2"
                                  v-model="listQuery.remark"
                                  class="input-width">
                        </el-input>
                      </el-col>
                    </el-form-item>-->
        </el-form>
      </div>
    </el-card>
    <!-- <el-card class="operate-container" shadow="never">
         <el-button icon="el-icon-circle-plus"
                      type="primary"
                      size="mini"
                      class="btn-add"
                      @click="handleAdd()"
                      style="float: left;
                      margin-bottom:15px">选择耗材
           </el-button>
   </el-card>-->
    <div class="table-container">
      <el-table ref="InBillTable"
                :data="createInBill"
                :row-class-name="rowClassName"
                style="width: 100%;"
                v-loading="listLoading"
                border>
        <el-table-column type="selection" width="60" align="center"></el-table-column>
        <el-table-column prop="newId" align="center" label="序号" width="60"></el-table-column>

        <el-table-column label="耗材名称" align="center">
          <template slot-scope="scope">{{ scope.row.reagentName }}</template>
        </el-table-column>
        <el-table-column label="单位" width="120" align="center">
          <template slot-scope="scope">{{ scope.row.reagentUnit }}</template>
        </el-table-column>
        <el-table-column label="规格型号" width="120" align="center">
          <template slot-scope="scope">{{ scope.row.reagentSpecification }}</template>
        </el-table-column>
        <el-table-column label="供货商" width="120" align="center">
          <template slot-scope="scope">{{ scope.row.supplierShortName }}</template>
        </el-table-column>
        <el-table-column label="生产厂家" align="center">
          <template slot-scope="scope">{{ scope.row.factory }}</template>
        </el-table-column>
        <el-table-column label="产品批号" width="100" align="center">
          <template slot-scope="scope">{{ scope.row.batchNo }}</template>
        </el-table-column>
        <el-table-column label="库存有效期" width="120" align="center">
          <template slot-scope="scope">{{ scope.row.expireDate | formatDateTime }}</template>
        </el-table-column>
        <el-table-column label="单价(元)" width="100" align="center">
          <template slot-scope="scope">¥ {{ scope.row.price }}</template>
        </el-table-column>
        <el-table-column label="下单数量" width="180" align="center">
          <template slot-scope="scope">
            <el-input-number
              size="small"
              v-model="scope.row.quantity"
              :min=scope.row.minNumber :max="scope.row.maxNumber">
            </el-input-number>
          </template>
        </el-table-column>
      </el-table>

      <el-card shadow="never">
        <el-button
          type="primary"
          size="mini"
          @click="submitInBill(0)"
          style="float: left;
                 margin-bottom:15px">复核完成
        </el-button>
        <el-button
          type="primary"
          size="mini"
          @click="submitInBill(1)"
          style="float: left;
                 margin-bottom:15px">重新生成二维码并入库
        </el-button>
        <el-button
          type="primary"
          size="mini"
          @click="submitInBill(2)"
          style="float: left;
                 margin-bottom:15px">复核完成并入库
        </el-button>
      </el-card>

      <el-dialog title="耗材基础信息" :visible.sync="dialogAddTableVisible" width="84%">
        <el-card shadow="hover" :body-style="{ padding: '10px'}">
          <div>
            <el-button size="small" style="float:right;margin-right: 15px"
                       type="primary" :loading="loading"
                       @click.native.prevent="handleSearchList">
              查询搜索
            </el-button>
            <el-button
              style="float:right;margin-right: 15px"
              @click="handleResetSearch()"
              size="small">
              重置
            </el-button>
          </div>
          <div style="float:right">
            <el-form :inline="true" :model="listQuery" size="small" label-width="140px">
              <el-form-item>
                <el-input v-model="listQuery.keyword" class="input-width" placeholder="耗材名称/供货商名称"
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
          <el-table ref="createInBillAddTable"
                    :data="list"
                    :row-class-name="rowClassName"
                    height="500"
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

import {formatDate} from '@/utils/date';
import {getCookie} from '@/utils/support';
import {createInBillItem, createInBillPDA} from '@/api/inBill';
import {fetchListInBill} from '@/api/inBillDetail';
import {getPreInDetail} from '@/api/preInDetail';
import {fetchEnSupList} from '@/api/baseInfo';

const defaultListQuery = {
  pageNum: 1,
  pageSize: 50,
  keyword: null,
  billType: 2,
  createType: 4,
  stockType: 3,
  remark: null,
  billCreator: getCookie("username"),
  reagentNumber: 1,
  batchNo: null,
  expireDate: null,
  price: null,
  billCode: null,
  preBillCode: null,
  createBy: getCookie("username"),
};

export default {
  name: "createInBillList",
  data() {
    return {
      listQuery: Object.assign({}, defaultListQuery),
      loading: false,
      listLoading: false,
      list: [],
      total: null,
      isRepeat: false,
      createInBill: [],
      multipleSelection: [],
      inBillInfo: [],
      preBillInfo: [],
      dialogAddTableVisible: false,
      pickerOptions: {
        disabledDate(time) {
          return time.getTime() <= Date.now();
        },
      },
    }
  },
  created() {
    this.listQuery.keyword = this.$route.query.billCode;
    this.listQuery.preBillCode = this.$route.query.preBillCode;
    if (this.listQuery.keyword != null) {
      this.getInBill();
    }
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
      row.newId = rowIndex + 1;
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
    indexDelete(index) {
      this.createInBill.splice(index, 1);
    },
    handleAdd() {
      this.dialogAddTableVisible = true;
      this.getList();
    },
    getInBill() {
      let _this = this;
      this.listLoading = true;

      getPreInDetail(this.listQuery.preBillCode).then(response => {
        this.listLoading = false;
        this.preBillInfo = response.data;
        this.total = response.data.total;

        fetchListInBill(this.listQuery).then(response => {
          this.listLoading = false;
          this.inBillInfo = response.data.list;
          this.total = response.data.total;

          this.inBillInfo.forEach(item => {
            this.preBillInfo.forEach(preItem => {
              if (item.name == preItem.reagentName && item.batchNo == preItem.batchNo) {
                const obj = {
                  billCode: item.billCode,
                  code: item.reagentId,
                  reagentName: item.name,
                  reagentUnit: item.unit,
                  reagentSpecification: item.specification,
                  factory: item.manufacturerName,
                  batchNo: item.batchNo,
                  expireDate: item.expireDate,
                  quantity: item.quantity,
                  price: item.price,
                  supplierShortName: item.supplierShortName,
                  supplierId: item.supplierId.toString(),
                  maxNumber: preItem.quantity,
                  minNumber: item.quantity,
                  qrList: null,
                }
                _this.createInBill.push(obj);
              }
            })
          })
        });
      });
      return _this.createInBill;
    },
    submitInBill(subStatus) {
      const arr = [];
      this.createInBill.forEach(item => {
        const obj = {
          billCode: item.billCode,
          code: item.code,
          reagentName: item.reagentName,
          reagentUnit: item.reagentUnit,
          supplierShortName: item.supplierShortName,
          supplierId: item.supplierId,
          reagentSpecification: item.reagentSpecification,
          factory: item.factory,
          quantity: item.quantity,
          price: item.price,
          batchNo: item.batchNo,
          expireDate: item.expireDate,
          inBillNumber: item.minNumber,
          preBillNumber: item.maxNumber,
          qrList: null,
        }
        arr.push(obj);
      })

      if (this.inBillInfo != null) {
        this.listQuery.billCode = this.inBillInfo[0].billCode;
      } else {
        this.listQuery.billCode = null;
      }

      let sendData = {
        billStatus: subStatus,
        billType: this.listQuery.billType,
        stockType: this.listQuery.stockType,
        createType: this.listQuery.createType,
        inBillMessList: arr,
        remark: this.listQuery.remark,
        billCreator: this.listQuery.billCreator,
        preInBillCode: this.listQuery.preBillCode,
        tempInBillCode: this.listQuery.billCode,
        qrIndexFlag: 1
      }
      this.isRepeat = false;
      this.isRepeat = this.isRepeatJug(arr);

      if (!this.isRepeat) {
        if (subStatus == 0) {
          createInBillPDA(sendData);
          this.$message({
            message: '复核完成成功',
            type: 'success',
            duration: 1000
          });
          const that = this;
          setTimeout(function () {
            that.$router.push("/wms/inBillTC");
          }, 1000);
        } else if (subStatus == 1) {
          let inStockFlag = true;
          //草稿中现有耗材数量小于随货单中数量
          arr.forEach(item => {
            if (item.quantity < item.preBillNumber) {
              inStockFlag = false;
            }
          });
          //草稿中现有耗材种类数小于随货单中耗材种类数
          if (arr.length < this.preBillInfo.length) inStockFlag = false;

          if (!inStockFlag) {
            this.$message({
              message: '入库数量小于随货单中数量或种类不匹配，不允许入库！',
              type: 'warning',
              duration: 1500
            });
          } else {
            createInBillItem(sendData);
            this.$message({
              message: '重新生成二维码并入库成功',
              type: 'success',
              duration: 1000
            });
            const that = this;
            setTimeout(function () {
              that.$router.push("/wms/inBillTC");
            }, 1000);
          }
        } else if (subStatus == 2) {
          let inStockFlag = true;
          //草稿中现有耗材数量小于随货单中数量
          arr.forEach(item => {
            if (item.quantity < item.preBillNumber) {
              inStockFlag = false;
            }
          });
          //草稿中现有耗材种类数小于随货单中耗材种类数
          if (arr.length < this.preBillInfo.length) inStockFlag = false;

          if (!inStockFlag) {
            this.$message({
              message: '入库数量小于随货单中数量或种类不匹配，不允许入库！',
              type: 'warning',
              duration: 1500
            });
          } else {
            createInBillPDA(sendData);
            this.$message({
              message: '复核完成并入库成功',
              type: 'success',
              duration: 1000
            });
            const that = this;
            setTimeout(function () {
              that.$router.push("/wms/inBillTC");
            }, 1000);
          }
        }
      } else {
        this.$message({
          message: '所选耗材非同一供货商！',
          type: 'warning',
          duration: 1000
        });
      }
    },
    isRepeatJug(arr) {
      let hash = [];
      for (let i = 0; i < arr.length; i++) {
        hash.push(arr[i].supplierId)
      }
      console.log(hash);
      // ES6 提供了一个新的数据结构Set，Set 中成员的值都是唯一的，没有重复的元素。
      // 重复元素在Set中自动被过滤,即下面大小是否为1，如果不为1，说明不是同一供货商，返回true，否则返回false
      if (new Set(hash).size !== 1) {
        return true;
      } else {
        return false;
      }
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
        for (let i = 0; i < this.multipleSelection.length; i++) {
          _this.createInBill.push(this.covertInBill(this.multipleSelection[i]));
        }
        this.dialogAddTableVisible = false;
        this.listLoading = false;
        _this.createInBill.forEach(element => {
          element["show"] = true;
        });
        return _this.createInBill;
      }
    },

    covertInBill(inBill) {
      return {
        id: inBill.id,
        code: inBill.reagentId,
        reagentName: inBill.reagentName,
        reagentUnit: inBill.unit,
        reagentSpecification: inBill.specification,
        factory: inBill.manufacturerName,
        registrationNo: inBill.registrationNo,
        supplierShortName: inBill.supplierShortName,
        supplierId: inBill.supplierId,
        stockType: this.listQuery.stockType,
        quantity: this.listQuery.reagentNumber,
        batchNo: this.listQuery.batchNo,
        expireDate: this.listQuery.expireDate,
        price: inBill.price,
      };
    },
    handleDelete(index, row) {
      this.createInBill.splice(row.id, 1).then(response => {
        this.$message({
          message: '删除成功',
          type: 'warning',
          duration: 1000
        });
      });
    },
    getList() {
      this.listLoading = true;
      this.listQuery.keyword = null;
      fetchEnSupList(this.listQuery).then(response => {
        this.listLoading = false;
        this.list = response.data.list;
        this.total = response.data.total;
      });
    },
  }
}
</script>


