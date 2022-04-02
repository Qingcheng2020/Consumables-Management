<template> 
  <div class="app-container">
    <el-card class="filter-container" shadow="never">
      <i class="el-icon-tickets"></i>
      <span>新增出库单</span>
    </el-card>
    <div class="table-container">
      <el-form :inline="false" :model="outBillAdd" size="medium " label-width="100px">
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
      <i class="el-icon-tickets"></i>
      <span>出库单详细</span>
    </el-card>
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
      <el-table ref="outTable"
                :data="outBillAdd"
                :row-class-name="rowClassName"
                style="width: 100%;"
                v-loading="listLoading"
                border>
        <el-table-column type="selection" width="60" align="center"></el-table-column>
        <el-table-column prop="newId" align="center" label="序号" width="60"></el-table-column>
        <el-table-column label="出库单编号" width="150" align="center">
          <template slot-scope="scope">{{ scope.row.billCode }}</template>
        </el-table-column>
        <el-table-column label="出库单种类" align="center">
          <template slot-scope="scope">{{ scope.row.billType }}</template>
        </el-table-column>
        <el-table-column label="单据日期" align="center">
          <template slot-scope="scope">{{ scope.row.billDate  | formatDateTime }}</template>
        </el-table-column>
        <el-table-column label="单据状态" align="center">
          <template slot-scope="scope">{{ scope.row.billStatus }}</template>
        </el-table-column>
        <el-table-column label="制单人员" align="center">
          <template slot-scope="scope">{{ scope.row.billCreator }}</template>
        </el-table-column>
        <el-table-column label="备注" align="center">
          <template slot-scope="scope">{{ scope.row.remark }}</template>
        </el-table-column>
        <el-table-column label="申请科室名" align="center">
          <template slot-scope="scope">{{ scope.row.branchName }}</template>
        </el-table-column>
        <el-table-column label="申请日" align="center">
          <template slot-scope="scope">{{ scope.row.applicationDate  | formatDateTime }}</template>
        </el-table-column>
        <el-table-column label="申请人" align="center">
          <template slot-scope="scope">{{ scope.row.applicationUser }}</template>
        </el-table-column>

        <el-table-column label="操作" width="220" align="center">
          <template slot-scope="scope">
            <el-button size="mini"
                       icon="el-icon-delete"
                       type="danger"
                       @click="handleDelete(scope.$index, scope.row)">删除
            </el-button>
          </template>
        </el-table-column>
      </el-table>
      <el-card shadow="never">
        <el-button
          type="primary"
          size="mini"
          @click="submitOut(0)"
          style="float: left;
                 margin-bottom:15px">保存
        </el-button>
        <el-button
          type="primary"
          size="mini"
          @click="submitOut(1)"
          style="float: left;
                 margin-bottom:15px">提交
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
          <el-table ref="outBillAddTable"
                    :data="list"
                    :row-class-name="rowClassName"
                    height="500"
                    style="width: 100%;"
                    @selection-change="handleSelectionChange"
                    v-loading="listLoading" border>
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
            <el-table-column label="过期预警时间阈值" align="center">
              <template slot-scope="scope">{{ scope.row.expirationLimit }}</template>
            </el-table-column>
            <el-table-column label="低库存预警阈值" align="center">
              <template slot-scope="scope">{{ scope.row.stockLimit }}</template>
            </el-table-column>
            <el-table-column label="开启有效期限" align="center">
              <template slot-scope="scope">{{ scope.row.useDayLimit }}</template>
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
import {fetchList} from '@/api/baseInfo';
import {formatDate} from '@/utils/date';
import {getCookie} from '@/utils/support';
import {createOutItem} from '@/api/outBillAdd';

const defaultListQuery = {
  pageNum: 1,
  pageSize: 50,
  remark: null,
  billCreator: null,
  username: getCookie("username"),
};
export default {
  name: "outBillAddList",
  data() {
    return {
      listQuery: Object.assign({}, defaultListQuery),
      loading: false,
      listLoading: false,
      list: null,
      total: null,
      outBillAdd: [],
      multipleSelection: [],
      reagentNumber: 1,
      dialogAddTableVisible: false
    }
  },
  created() {
    this.listQuery.billCreator = getCookie("username");
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
      row.newId = (this.listQuery.pageSize * (this.listQuery.pageNum - 1) ) + rowIndex + 1;
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
    handleSelectionChange(val) {
      this.multipleSelection = val;
    },
    numberChange(value) {
      this.reagentNumber = value;
    },
    handleAdd() {
      this.dialogAddTableVisible = true;
      this.getList();
    },
    submitOut(outStatus) {
      const arr = [];
      this.outBillAdd.forEach(item => {
        const obj = {
          reagentCode: item.code,
          number: item.reagentNumber,
          supplierId: item.supplierId,
          supplierName: item.supplierShortName,
        }
        arr.push(obj);
      })
      let sendData = {
        outState: outStatus,
        outMessList: arr,
        remark: this.listQuery.remark,
        billCreator: this.listQuery.billCreator
      }
      createOutItem(sendData);

      if (outStatus) {
        this.$message({
          message: '提交成功',
          type: 'success',
          duration: 1000
        });
      } else if (!outStatus) {
        this.$message({
          message: '保存成功',
          type: 'success',
          duration: 1000
        });
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
          _this.outBillAdd.push(this.covertOut(this.multipleSelection[i]));
        }
        this.dialogAddTableVisible = false;
        this.listLoading = false;
        return _this.outBillAdd;
      }
    },

    covertOut(out) {
      let outBillAddDetail = {
        id: out.id,
        code: out.code,
        name: out.name,
        unit: out.unit,
        price: out.price,
        specification: out.specification,
        supplierId: out.supplierId,
        reagentNumber: this.reagentNumber,
        supplierShortName: out.supplierShortName,
        billCreator: this.listQuery.billCreator,
        remark: this.listQuery.remark,
      };
      return outBillAddDetail;
    },
    handleDelete(index, row) {
      this.outBillAdd.splice(row.id, 1).then(response => {
        this.$message({
          message: '删除成功',
          type: 'warning',
          duration: 1000
        });
      });
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


