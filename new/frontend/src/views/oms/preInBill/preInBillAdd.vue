<template> 
  <div class="app-container">
    <!--    <el-button size="small" @click="back()">返回</el-button>-->
    <el-card class="filter-container" shadow="never">
      <i class="el-icon-tickets"></i>
      <span>随货同行单新增</span>
    </el-card>
    <div class="table-container">
      <el-form :inline="false" :model="preInBillAdd" size="medium " label-width="100px">
        <el-form-item label="制单人员：">
          <el-col :span="4">
            <el-input :disabled="true" v-model="listQuery.billCreator" class="input-width"></el-input>
          </el-col>
        </el-form-item>
        <el-form-item label="备注：">
          <el-col :span="24">
            <el-input type="textarea"
                      :rows="2"
                      v-model="listQuery.remark"
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
      <el-form :rules="model.rules" :model="model" ref="form">
        <el-table ref="preInTable"
                  :data="model.tableData"
                  :row-class-name="rowClassName"
                  max-height="550"
                  style="width: 100%;"
                  v-loading="listLoading"
                  :default-sort="{prop: 'date', order: 'descending'}"
                  border>
          <el-table-column type="selection" width=auto align="center"></el-table-column>
          <el-table-column prop="newId" align="center" label="序号" width="60"></el-table-column>
          <el-table-column label="耗材名称" width=auto align="center">
            <template slot-scope="scope">{{ scope.row.reagentName }}</template>
          </el-table-column>
          <el-table-column label="单位" width=auto align="center">
            <template slot-scope="scope">{{ scope.row.reagentUnit }}</template>
          </el-table-column>
          <el-table-column label="规格型号" width=auto align="center">
            <template slot-scope="scope">{{ scope.row.reagentSpecification }}</template>
          </el-table-column>
          <el-table-column label="生产厂家" align="center">
            <template slot-scope="scope">{{ scope.row.factory }}</template>
          </el-table-column>
          <el-table-column prop="batchNo" label="产品批号" width="150%" align="center">
            <template slot-scope="scope">
              <el-form-item>
                <el-input placeholder="请输入产品批号" v-model="scope.row.batchNo"></el-input>
              </el-form-item>
            </template>
          </el-table-column>
          <el-table-column prop="expireDate" label="库存有效期" width="250%" align="center">
            <template slot-scope="scope">
              <el-form-item :prop="'tableData.' + scope.$index + '.expireDate'" :rules='model.rules.name'>
                <el-date-picker
                  placeholder="请选择保质期"
                  v-model="scope.row.expireDate"
                  type="date"
                  value-format="yyyy-MM-dd"
                  format="yyyy-MM-dd"
                  :picker-options="pickerOptions">
                </el-date-picker>
              </el-form-item>
            </template>
          </el-table-column>
          <el-table-column label="单价" width=auto align="center">
            <template slot-scope="scope">¥ {{ scope.row.price }}</template>
          </el-table-column>
          <el-table-column label="配货数量" width="150" align="center">
            <template slot-scope="scope">
              <el-form-item :prop="'tableData.' + scope.$index + '.quantity'" :rules='model.rules.name'>
                <el-input-number
                  size="small"
                  v-model="scope.row.quantity"
                  :min="1" :max="scope.row.unsendNum">
                </el-input-number>
              </el-form-item>
            </template>
          </el-table-column>
          <el-table-column label="操作" width=auto align="center">
            <template slot-scope="scope">
              <el-button size="mini"
                         icon="el-icon-delete"
                         type="danger"
                         @click="handleDelete(scope.$index)">删除
              </el-button>
            </template>
          </el-table-column>
        </el-table>
      </el-form>
      <el-card shadow="never">
        <el-button
          type="primary"
          size="mini"
          @click="submitConfirm(1)"
          :loading="loadingbut"
          style="float: left;margin-bottom:15px">提交
        </el-button>
      </el-card>
      <el-dialog title="耗材基础信息" :visible.sync="dialogAddTableVisible" width="84%">
        <el-card shadow="hover" :body-style="{ padding: '10px'}">
          <el-button icon="el-icon-circle-plus"
                     type="primary"
                     size="mini"
                     class="btn-add"
                     @click="toggleSelection()"
                     style="float: left; margin-bottom:11px">添加
          </el-button>
        </el-card>
        <div class="table-container">
          <el-table ref="preInBillAddTable"
                    :data="list"
                    :row-class-name="rowBaseInfoId"
                    max-height="500"
                    style="width: 100%;"
                    @selection-change="handleSelectionChange"
                    v-loading="listLoading" border>
            <el-table-column type="selection" width="50" fixed align="center"></el-table-column>

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
            :total="baseInfoTotal">
          </el-pagination>
        </div>
      </el-dialog>

      <el-dialog :visible.sync="dialogConfirmTableVisible" width="84%">
        <el-card shadow="hover" :body-style="{ padding: '10px'}" align="middle">
          <span style="color: red">提示：请仔细核对产品批号及有效期，提交后将无法修改！</span>
        </el-card>
        <div class="table-container">
          <el-table ref="preInTable"
                    :data="model.tableData"
                    :row-class-name="rowClassName"
                    max-height="550"
                    style="width: 100%;"
                    v-loading="listLoading"
                    :default-sort="{prop: 'date', order: 'descending'}"
                    border>
            <el-table-column prop="newId" align="center" label="序号" width="60"></el-table-column>
            <el-table-column label="耗材名称" width=auto align="center">
              <template slot-scope="scope">{{ scope.row.reagentName }}</template>
            </el-table-column>
            <el-table-column label="单位" width=auto align="center">
              <template slot-scope="scope">{{ scope.row.reagentUnit }}</template>
            </el-table-column>
            <el-table-column label="规格型号" width=auto align="center">
              <template slot-scope="scope">{{ scope.row.reagentSpecification }}</template>
            </el-table-column>
            <el-table-column label="生产厂家" align="center">
              <template slot-scope="scope">{{ scope.row.factory }}</template>
            </el-table-column>
            <el-table-column label="产品批号" align="center">
              <template slot-scope="scope">{{ scope.row.batchNo }}</template>
            </el-table-column>
            <el-table-column label="库存有效期" align="center">
              <template slot-scope="scope">{{ scope.row.expireDate | formatDateTime }}</template>
            </el-table-column>
            <el-table-column label="单价" width=auto align="center">
              <template slot-scope="scope">¥ {{ scope.row.price }}</template>
            </el-table-column>
            <el-table-column label="配货数量" width=auto align="center">
              <template slot-scope="scope">{{ scope.row.quantity }}</template>
            </el-table-column>
          </el-table>
        </div>
        <el-card shadow="hover" :body-style="{ padding: '10px'}" align="middle">
          <el-button @click="dialogConfirmTableVisible = false" size="small">取 消</el-button>
          <el-button type="primary"
                     size="small"
                     class="btn-add"
                     @click="submitOrder()">确认提交
          </el-button>
        </el-card>
      </el-dialog>
    </div>
    <el-button style="margin-top: 20px" size="small" @click="back()">返回</el-button>
  </div>
</template>
<script>
import {fetchListByOrder} from '@/api/baseInfo';
import {fetchListPre} from '@/api/orderDetail';
import {formatDate} from '@/utils/date';
import {getCookie} from '@/utils/support';
import {createPreInBillItem} from '@/api/preInBill';

const defaultListQuery = {
  remark: null,
  billCreator: null,
  supplierShortName: getCookie("username"),
  billStatus: 0,
  billType: 1,
  reagentNumber: 1,
  batchNo: null,
  expireDate: null,
  price: null,
  keyword: null
};
const defaultBaseInfoListQuery = {
  pageNum: 1,
  pageSize: 50,
  keyword: null
};
export default {
  name: "preInBillAddList",
  data() {
    return {
      form: {
        supplier2: "",
        type: "",
        desc: "",
        batchNo: ""
      },
      model: {
        rules: {
          name: {required: true, message: '必填字段', trigger: 'blur'},
          batchNo: [{required: true, message: '必填字段', trigger: 'blur'},
            {min: 8, max: 8, message: '批号只能为8位数字', trigger: 'blur'},
            {
              type: "number", transform(value) {
                return Number(value);
              }, message: '批号只能为8位数字', trigger: 'blur'
            }],
        },
        tableData: []
      },
      listQuery: Object.assign({}, defaultListQuery),
      listBaseInfoQuery: Object.assign({}, defaultBaseInfoListQuery),
      loading: false,
      listLoading: false,
      list: null,
      total: null,
      baseInfoTotal: null,
      preInBillAdd: [],
      orderInfo: null,
      multipleSelection: [],
      dialogAddTableVisible: false,
      dialogConfirmTableVisible: false,
      loadingbut: false,
      pickerOptions: {
        disabledDate(time) {
          return time.getTime() <= Date.now();
        },
      },
    }
  },
  created() {
    this.model.tableData = this.preInBillAdd;
    this.listQuery.billCreator = getCookie("username");
    this.listQuery.keyword = this.$route.query.orderNo;
    this.listBaseInfoQuery.keyword = this.$route.query.orderNo;
    this.getOrder();
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
    rowBaseInfoId({row, rowIndex}) {
      //把每一行的索引放进row.id
      row.newId = (this.listBaseInfoQuery.pageSize * (this.listBaseInfoQuery.pageNum - 1)) + rowIndex + 1;
    },
    back() {
      if (window.history.length <= 1) {
        this.$router.push({path: '/'})
        return false
      } else {
        this.$router.go(-1)
      }
    },
    getOrder() {
      let _this = this;
      this.listLoading = true;
      fetchListPre(this.listQuery).then(response => {
        this.listLoading = false;
        this.orderInfo = response.data.list;
        this.total = response.data.total;

        this.orderInfo.forEach(item => {
          const obj = {
            code: item.reagentId,
            reagentName: item.name,
            reagentUnit: item.unit,
            quantity: item.quantity,
            price: item.price,
            reagentSpecification: item.specification,
            factory: item.manufacturerName,
            supplierShortName: item.supplierShortName,
            sendNum: item.sendNum,
            unsendNum: item.unsendNum
          }
          _this.preInBillAdd.push(obj);
        })
      });
      return _this.preInBillAdd;
    },
    handleSizeChange(val) {
      this.listBaseInfoQuery.pageNum = 1;
      this.listBaseInfoQuery.pageSize = val;
      this.getList();
    },
    handleCurrentChange(val) {
      this.listBaseInfoQuery.pageNum = val;
      this.getList();
    },
    handleSelectionChange(val) {
      this.multipleSelection = val;
    },
    handleAdd() {
      this.dialogAddTableVisible = true;
      this.getList();
    },
    submitConfirm(submitType) {
      this.dialogConfirmTableVisible = true;
    },
    submitOrder(submitType) {
      this.$refs.form.validate(valid => {
        if (valid) {
          this.loadingbut = true;
          const arr = [];
          this.model.tableData.forEach(item => {
            const obj = {
              code: item.code,
              quantity: item.quantity,
              price: item.price,
              batchNo: item.batchNo,
              expireDate: item.expireDate,
              supplierId: item.supplierId,
              factory: item.factory,
              supplierShortName: item.supplierShortName
            }
            arr.push(obj);
          })
          const isRepeat = this.getNewList(arr);
          let flag = true;
          this.orderInfo.forEach(item => {
            isRepeat.forEach(item1 => {
              if (item.reagentId === parseInt(item1.code, 10) && item1.quantity > item.unsendNum) {
                flag = false;
              }
            })
          })
          //只有配货数量小于等于未发货数量时，才可以配货
          if (flag) {
            console.log('配货数量没问题！');
            let sendData = {
              billType: this.listQuery.billType,
              billStatus: this.listQuery.billStatus,
              preInBillMessList: arr,
              remark: this.listQuery.remark,
              billCreator: this.listQuery.billCreator,
              orderNo: this.$route.query.orderNo
            }
            createPreInBillItem(sendData).then(response => {
              if (response.data > 0) {
                this.loadingbut = false;
                this.$message({
                  message: '提交成功',
                  type: 'success',
                  duration: 1000
                });
                this.$router.push("/oms/preInBill");
              }
            }).catch(error => {
              this.loadingbut = false;
            })
          } else {
            console.log('配货数量超出！');
            this.loadingbut = false;
            this.$message({
              message: '配货数量与订单不符！',
              type: 'warning'
            });
          }
        } else {
          console.log('参数验证不合法！');
          this.loadingbut = false;
          this.$message({
            message: '提交失败！',
            type: 'warning'
          });
          return false
        }
      })
    },
    getNewList(params) {
      const temp = {};
      for (const i in params) {
        const key = params[i].code; //判断依据
        if (temp[key]) {
          temp[key].code = params[i].code;
          temp[key].quantity += params[i].quantity;//相加值
        } else {
          temp[key] = {};
          temp[key].code = params[i].code;
          temp[key].quantity = params[i].quantity;
        }
      }
      const newArray = [];
      for (const k in temp) {
        newArray.push(temp[k]);
      }
      return newArray;
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
          _this.preInBillAdd.push(this.covertOrder(this.multipleSelection[i]));
        }
        this.dialogAddTableVisible = false;
        this.listLoading = false;
        _this.preInBillAdd.forEach(element => {
          element["show"] = true;
        });
        return _this.preInBillAdd;
      }
    },
    covertOrder(baseInfo) {
      return {
        id: baseInfo.id,
        code: baseInfo.code,
        reagentName: baseInfo.name,
        reagentUnit: baseInfo.unit,
        reagentSpecification: baseInfo.specification,
        factory: baseInfo.manufacturerName,
        supplierId: baseInfo.supplierId,
        supplierShortName: baseInfo.supplierShortName,
        billCreator: this.listQuery.billCreator,
        quantity: this.listQuery.reagentNumber,
        remark: this.listQuery.remark,
        batchNo: this.listQuery.batchNo,
        expireDate: this.listQuery.expireDate,
        price: baseInfo.price
      };
    },
    handleDelete(index) {
      this.preInBillAdd.splice(index, 1);
    },
    getList() {
      this.listLoading = true;
      fetchListByOrder(this.listBaseInfoQuery).then(response => {
        this.listLoading = false;
        this.list = response.data.list;
        this.baseInfoTotal = response.data.total;
      });
    },
  }
}
</script>

