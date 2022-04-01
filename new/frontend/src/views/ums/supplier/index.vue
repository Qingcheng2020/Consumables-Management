<template> 
  <div class="app-container">
    <el-card class="filter-container" shadow="never">

      <div>
        <i class="el-icon-tickets"></i>
        <span>供货商列表</span>
      </div>
      <el-button size="small" style="float:left;margin-top: 8px"
                 type="primary" icon="el-icon-circle-plus"
                 @click="handleAdd()">添加供货商
      </el-button>

      <el-button size="small" style="float:right;margin-right: 15px;margin-top: 8px"
                 type="primary"
                 @click.native.prevent="handleSearchList">
        查询搜索
      </el-button>
      <el-button
        style="float:right;margin-right: 10px;margin-top: 8px"
        @click="handleResetSearch()"
        size="small">
        重置
      </el-button>
      <div style="float:right;margin-top: 8px">
        <el-form :inline="true" :model="listQuery" size="small" label-width="140px">
          <el-form-item>
            <el-input v-model="listQuery.keyword" class="input-width" placeholder="供货商编号/供货商全称" clearable
                      @keyup.enter.native="handleSearchList"></el-input>
          </el-form-item>
        </el-form>
      </div>
    </el-card>

    <div class="table-container">
      <el-table ref="supplierTable"
                :data="list"
                :row-class-name="rowClassName"
                style="width: 100%;"
                v-loading="listLoading" border>
        <el-table-column prop="newId" align="center" label="序号" width="60"></el-table-column>
        <el-table-column label="供货商全称" align="center">
          <template slot-scope="scope">{{ scope.row.supplierName }}</template>
        </el-table-column>
        <el-table-column label="供货商简称" align="center">
          <template slot-scope="scope">{{ scope.row.supplierShortName }}</template>
        </el-table-column>
        <el-table-column label="联系人" align="center">
          <template slot-scope="scope">{{ scope.row.contacts }}</template>
        </el-table-column>
        <el-table-column label="电话" align="center">
          <template slot-scope="scope">{{ scope.row.contactsTel }}</template>
        </el-table-column>
        <el-table-column label="手机" align="center">
          <template slot-scope="scope">{{ scope.row.contactsPhone }}</template>
        </el-table-column>
        <el-table-column label="微信" align="center">
          <template slot-scope="scope">{{ scope.row.contactsWechat }}</template>
        </el-table-column>
        <el-table-column label="公司地址" width="160" align="center">
          <template slot-scope="scope">{{ scope.row.supplierAddress }}</template>
        </el-table-column>
        <!--        <el-table-column label="公司状态" align="center">-->
        <!--          <template slot-scope="scope">{{ scope.row.status }}</template>-->
        <!--        </el-table-column>-->
        <el-table-column label="添加时间" width="100" align="center">
          <template slot-scope="scope">{{ scope.row.createTime | formatDateTime }}</template>
        </el-table-column>
        <!--        <el-table-column label="更新时间" width="100" align="center">-->
        <!--          <template slot-scope="scope">{{ scope.row.updateTime | formatDateTime }}</template>-->
        <!--        </el-table-column>-->
        <el-table-column label="是否启用" width="100" align="center">
          <template slot-scope="scope">
            <el-switch
              @change="handleStatusChange(scope.$index, scope.row)"
              :active-value="1"
              :inactive-value="0"
              v-model="scope.row.status">
            </el-switch>
          </template>
        </el-table-column>
        <el-table-column label="操作" width="180" align="center">
          <template slot-scope="scope">

            <el-button size="mini"
                       type="primary"
                       icon="el-icon-edit"
                       @click="handleUpdate(scope.$index, scope.row)">编辑
            </el-button>
            <el-button size="mini"
                       type="danger"
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
    <el-dialog
      :title="'编辑供货商'"
      :visible.sync="editDialogVisible"
      width="40%">
      <el-form :model="supplierForm"
               :rules="supplierRules"
               ref="supplierForm"
               label-width="150px" size="small">
        <el-form-item label="供货商全称" prop="supplierName">
          <el-input v-model="supplierForm.supplierName" style="width: 250px"></el-input>
        </el-form-item>
        <el-form-item label="供货商简称">
          <el-input v-model="supplierForm.supplierShortName" style="width: 250px" disabled="true"></el-input>
        </el-form-item>
        <el-form-item label="联系人" prop="contacts">
          <el-input v-model="supplierForm.contacts" style="width: 250px"></el-input>
        </el-form-item>
        <el-form-item label="电话">
          <el-input v-model="supplierForm.contactsTel" style="width: 250px"></el-input>
        </el-form-item>
        <el-form-item label="手机" prop="contactsPhone">
          <el-input v-model="supplierForm.contactsPhone" style="width: 250px"></el-input>
        </el-form-item>
        <el-form-item label="微信">
          <el-input v-model="supplierForm.contactsWechat" style="width: 250px"></el-input>
        </el-form-item>
        <el-form-item label="公司地址" prop="supplierAddress">
          <el-input v-model="supplierForm.supplierAddress" style="width: 250px"></el-input>
        </el-form-item>
        <!--        <el-form-item label="公司状态">-->
        <!--          <el-input v-model="supplierForm.status" style="width: 250px"></el-input>-->
        <!--        </el-form-item>-->
        <el-form-item label="是否启用：">
          <el-radio-group v-model="supplierForm.status">
            <el-radio :label="1">是</el-radio>
            <el-radio :label="0">否</el-radio>
          </el-radio-group>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button @click="editDialogVisible = false" size="small">取 消</el-button>
        <el-button type="primary" @click="handleEditDialogConfirm()" size="small">确 定</el-button>
      </span>
    </el-dialog>
    <el-dialog
      :title="'添加供货商'"
      :visible.sync="dialogVisible"
      width="40%">
      <el-form :model="supplierForm"
               :rules="supplierRules"
               ref="supplierForm"
               label-width="150px" size="small">
        <el-form-item label="供货商全称" prop="supplierName">
          <el-input v-model="supplierForm.supplierName" style="width: 250px"></el-input>
        </el-form-item>
        <el-form-item label="供货商简称" prop="supplierShortName">
          <el-input v-model="supplierForm.supplierShortName" style="width: 250px"></el-input>
        </el-form-item>
        <el-form-item label="联系人" prop="contacts">
          <el-input v-model="supplierForm.contacts" style="width: 250px"></el-input>
        </el-form-item>
        <el-form-item label="电话">
          <el-input v-model="supplierForm.contactsTel" style="width: 250px"></el-input>
        </el-form-item>
        <el-form-item label="手机" prop="contactsPhone">
          <el-input v-model="supplierForm.contactsPhone" style="width: 250px"></el-input>
        </el-form-item>
        <el-form-item label="微信">
          <el-input v-model="supplierForm.contactsWechat" style="width: 250px"></el-input>
        </el-form-item>
        <el-form-item label="公司地址" prop="supplierAddress">
          <el-input v-model="supplierForm.supplierAddress" style="width: 250px"></el-input>
        </el-form-item>
        <!--        <el-form-item label="公司状态">-->
        <!--          <el-input v-model="supplierForm.status" style="width: 250px"></el-input>-->
        <!--        </el-form-item>-->
        <el-form-item label="是否启用：">
          <el-radio-group v-model="supplierForm.status">
            <el-radio :label="1">是</el-radio>
            <el-radio :label="0">否</el-radio>
          </el-radio-group>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible = false" size="small">取 消</el-button>
        <el-button type="primary" @click="handleDialogConfirm()" size="small">确 定</el-button>
      </span>
    </el-dialog>
  </div>
</template>
<script>
import {
  createSupplier,
  deleteSupplier,
  fetchAllSupplierList,
  fetchList,
  updateStatus,
  updateSupplier
} from '@/api/supplier';
import {formatDate} from '@/utils/date';
import {isvalidUsername} from '@/utils/validate';
import {isSupInStock} from '@/api/stockDetail';

const defaultListQuery = {
  pageNum: 1,
  pageSize: 50,
  keyword: null
};
const defaultSupplierForm = {
  supplierName: '',
  supplierShortName: '',
  contacts: '',
  contactsTel: '',
  contactsWechat: '',
  supplierAddress: '',
  contactsPhone: '',
  status: 1
};
export default {
  name: 'supplierList',
  data() {
    const validateUsername = (rule, value, callback) => {
      if (!isvalidUsername(value)) {
        callback(new Error('该选项不能为空'))
      } else {
        callback()
      }
    };
    const checkPhone = (rule, value, callback) => {
      if (!value) {
        return callback(new Error('手机号不能为空'));
      } else {
        const reg = /^1[3|4|5|7|8][0-9]\d{8}$/
        console.log(reg.test(value));
        if (reg.test(value)) {
          callback();
        } else {
          return callback(new Error('请输入正确的手机号'));
        }
      }
    };
    return {
      supplierRules: {
        supplierName: [
          {required: true, message: '请输入供货商全称', trigger: 'blur'},
          {validator: validateUsername, trigger: 'blur'}
        ],
        supplierShortName: [
          {required: true, message: '请输入供货商简称', trigger: 'blur'},
          {validator: validateUsername, trigger: 'blur'}
        ],
        contacts: [
          {required: true, message: '请输入联系人', trigger: 'blur'},
          {validator: validateUsername, trigger: 'blur'}
        ],
        contactsPhone: [
          {required: true, validator: checkPhone, trigger: 'blur'}
        ],
        supplierAddress: [
          {required: true, message: '请输入公司地址', trigger: 'blur'},
          {validator: validateUsername, trigger: 'blur'}
        ],
      },
      listQuery: Object.assign({}, defaultListQuery),
      list: null,
      total: null,
      loading: false,
      listLoading: false,
      dialogVisible: false,
      editDialogVisible: false,
      supplierForm: Object.assign({}, defaultSupplierForm),
      allSupplierList: [],
      inStockFlag: null,
    }
  },
  created() {
    this.getList();
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
    back() {
      if (window.history.length <= 1) {
        this.$router.push({path: '/'})
        return false
      } else {
        this.$router.go(-1)
      }
    },
    handleStatusChange(index, row) {
      this.$confirm('是否要修改该状态?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        updateStatus(row.id, {status: row.status}).then(response => {
          this.$message({
            type: 'success',
            message: '修改成功!'
          });
          this.getList();
        });
      }).catch(() => {
        this.$message({
          type: 'info',
          message: '取消修改'
        });
        this.getList();
      });
      //this.getList();
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
    handleAdd() {
      this.dialogVisible = true;
      this.supplierForm = Object.assign({}, defaultSupplierForm);
    },
    handleDelete(index, row) {
      this.$confirm('是否要删除该用户?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        isSupInStock(row.supplierShortName).then(response => {
          this.inStockFlag = response.data;
          if (this.inStockFlag > 0) {
            this.$message({
              type: 'warning',
              message: '关联耗材未终结!'
            });
          } else if (this.inStockFlag == 0) {
            deleteSupplier(row.id).then(response => {
              this.$message({
                type: 'success',
                message: '删除成功!'
              });
              this.getList();
            });
          }
        });
      });
    },
    handleUpdate(index, row) {
      this.editDialogVisible = true;
      this.supplierForm = Object.assign({}, row);
    },
    handleDialogConfirm() {
      this.$refs.supplierForm.validate(valid => {
        if (valid) {
          createSupplier(this.supplierForm).then(response => {
            this.$message({
              message: '添加成功！',
              type: 'success'
            });
            this.dialogVisible = false;
            this.getList();
          })
        } else {
          this.$message({
            message: '添加失败！',
            type: 'warning'
          });
          return false
        }
      })
    },
    handleEditDialogConfirm() {
      this.$refs.supplierForm.validate(valid => {
        if (valid) {
          updateSupplier(this.supplierForm.id, this.supplierForm).then(response => {
            this.$message({
              message: '修改成功！',
              type: 'success'
            });
            this.editDialogVisible = false;
            this.getList();
          })
        } else {
          this.$message({
            message: '修改失败！',
            type: 'warning'
          });
          return false
        }
      })
    },
    getList() {
      this.listLoading = true;
      fetchList(this.listQuery).then(response => {
        this.listLoading = false;
        this.list = response.data.list;
        this.total = response.data.total;
      });
    },
    getAllSupplierList() {
      fetchAllSupplierList().then(response => {
        this.allSupplierList = response.data;
      });
    },
  }
}
</script>
<style></style>


