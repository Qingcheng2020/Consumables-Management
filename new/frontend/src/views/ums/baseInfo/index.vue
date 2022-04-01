<template xmlns="http://www.w3.org/1999/html"> 
  <div class="app-container">
    <el-card class="filter-container" shadow="never">
      <div>
        <i class="el-icon-tickets"></i>
        <span>耗材基础信息列表</span>
      </div>
      <el-button size="small" style="float:left;margin-top: 8px"
                 type="primary" icon="el-icon-circle-plus"
                 @click="handleAdd()">添加耗材
      </el-button>

      <el-upload
        :show-file-list="false"
        :before-upload="beforeUpload"
        :on-success="onSuccess"
        :on-error="onError"
        accept=".xlsx,.xls"
        :disabled="importDisabled"
        style="display: inline-flex;float:left;margin-top: 8px;margin-left:10px"
        :action="uploadUrl">
        <el-button size="small" :disabled="importDisabled" type="primary" :icon="importDataIcon">
          批量导入
        </el-button>
      </el-upload>

      <div style="float:left;margin-top: 8px">
        <el-form :inline="true" :model="listQuery" size="small" label-width="100px">
          <el-form-item label="耗材名称：">
            <el-input v-model="listQuery.name" class="input-width" placeholder="耗材名称" clearable
                      @keyup.enter.native="handleSearchList"></el-input>
          </el-form-item>
          <el-form-item label="生产厂家：">
            <el-input v-model="listQuery.manufacturerName" class="input-width" placeholder="生产厂家" clearable
                      @keyup.enter.native="handleSearchList"></el-input>
          </el-form-item>
          <el-form-item label="供货商：">
            <el-input v-model="listQuery.supplierShortName" class="input-width" placeholder="供货商" clearable
                      @keyup.enter.native="handleSearchList"></el-input>
          </el-form-item>
        </el-form>
      </div>
      <el-button size="small" style="float:right;margin-right: 15px;margin-top: 8px"
                 type="primary" :loading="loading"
                 @click.native.prevent="handleSearchList">查询搜索
      </el-button>
      <el-button
        style="float:right;margin-right: 10px;margin-top: 8px"
        @click="handleResetSearch()"
        size="small">重置
      </el-button>
    </el-card>

    <div class="table-container">
      <el-table ref="BaseInfoTable"
                :data="list"
                :row-class-name="rowClassName"
                style="width: 100%;"
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
        <el-table-column label="供货商名" align="center">
          <template slot-scope="scope">{{ scope.row.supplierShortName }}</template>
        </el-table-column>
        <el-table-column label="储存温度" align="center">
          <template slot-scope="scope">{{ scope.row.stockType }}</template>
        </el-table-column>
        <el-table-column label="单价（元）" align="center">
          <template slot-scope="scope">¥ {{ scope.row.price }}</template>
        </el-table-column>
        <el-table-column label="过期预警时间阈值（天）" align="center">
          <template slot-scope="scope">{{ scope.row.expirationLimit }}</template>
        </el-table-column>
        <el-table-column label="低库存预警阈值" align="center">
          <template slot-scope="scope">{{ scope.row.stockLimit }}</template>
        </el-table-column>
        <el-table-column label="开启有效期限（天）" align="center">
          <template slot-scope="scope">{{ scope.row.useDayLimit }}</template>
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

    <el-dialog title="导入失败耗材" :visible.sync="errorTableVisible" width="84%">
      <div class="table-container">
        <el-table ref="errorTable"
                  :data="errorList"
                  :row-class-name="rowClassName"
                  :cell-style="nullBase"
                  max-height="450"
                  style="width: 100%;"
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
          <el-table-column label="供货商名" align="center">
            <template slot-scope="scope">{{ scope.row.supplierShortName }}</template>
          </el-table-column>
          <el-table-column label="储存温度" align="center">
            <template slot-scope="scope">{{ scope.row.stockType }}</template>
          </el-table-column>
          <el-table-column label="单价（元）" align="center">
            <template slot-scope="scope">¥ {{ scope.row.price }}</template>
          </el-table-column>
          <el-table-column label="过期预警时间阈值（天）" align="center">
            <template slot-scope="scope">{{ scope.row.expirationLimit }}</template>
          </el-table-column>
          <el-table-column label="低库存预警阈值" align="center">
            <template slot-scope="scope">{{ scope.row.stockLimit }}</template>
          </el-table-column>
          <el-table-column label="开启有效期限（天）" align="center">
            <template slot-scope="scope">{{ scope.row.useDayLimit }}</template>
          </el-table-column>
        </el-table>
      </div>

    </el-dialog>
    <el-dialog
      :title="'添加耗材信息'"
      :visible.sync="dialogVisible"
      width="40%">
      <el-form :model="BaseInfoForm"
               :rules="BaseInfoRules"
               ref="BaseInfoForm"
               label-width="150px" size="small">
        <el-form-item label="耗材名称" prop="name">
          <el-input v-model="BaseInfoForm.name" style="width: 250px"></el-input>
        </el-form-item>
        <el-form-item label="单位" prop="unit">
          <el-input v-model="BaseInfoForm.unit" style="width: 250px"></el-input>
        </el-form-item>
        <el-form-item label="规格型号" prop="specification">
          <el-input v-model="BaseInfoForm.specification" style="width: 250px"></el-input>
        </el-form-item>
        <el-form-item label="生产厂家" prop="manufacturerName">
          <el-input v-model="BaseInfoForm.manufacturerName" style="width: 250px"></el-input>
        </el-form-item>
        <el-form-item label="注册证号" prop="registrationNo">
          <el-input v-model="BaseInfoForm.registrationNo" style="width: 250px"></el-input>
        </el-form-item>
        <el-form-item label="供货商名" prop="supplierShortName">
          <el-select v-model="BaseInfoForm.supplierShortName" placeholder="请选择" size="small" style="width: 250px">
            <el-option
              v-for="item in allSupplierList"
              :key="item.id"
              :label="item.supplierShortName"
              :value="item.supplierShortName">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="单价" prop="price">
          <el-input v-model="BaseInfoForm.price" style="width: 250px"></el-input>
        </el-form-item>
        <el-form-item label="储存温度" prop="stockType">
          <el-select v-model="BaseInfoForm.stockType" placeholder="请选择" size="small" style="width: 250px">
            <el-option
              v-for="item in tempList"
              :key="item.value"
              :label="item.value"
              :value="item.value">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="过期预警时间阈值" prop="expirationLimit">
          <el-input v-model="BaseInfoForm.expirationLimit" style="width: 250px"></el-input>
        </el-form-item>
        <el-form-item label="低库存预警阈值" prop="stockLimit">
          <el-input v-model="BaseInfoForm.stockLimit" style="width: 250px"></el-input>
        </el-form-item>
        <el-form-item label="开启有效期限" prop="useDayLimit">
          <el-input v-model="BaseInfoForm.useDayLimit" style="width: 250px"></el-input>
        </el-form-item>
      </el-form>

      <span slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible = false" size="small">取 消</el-button>
        <el-button type="primary" @click="handleDialogConfirm()" size="small">确 定</el-button>
      </span>
    </el-dialog>
    <el-dialog
      :title="'编辑耗材信息'"
      :visible.sync="editDialogVisible"
      width="40%">
      <el-form :model="BaseInfoForm"
               :rules="BaseInfoRules"
               ref="BaseInfoForm"
               :disabled="supplierStatus"
               label-width="150px" size="small">
        <el-form-item label="耗材名称" prop="name">
          <el-input v-model="BaseInfoForm.name" style="width: 250px"></el-input>
        </el-form-item>
        <el-form-item label="单位" prop="unit">
          <el-input v-model="BaseInfoForm.unit" style="width: 250px"></el-input>
        </el-form-item>
        <el-form-item label="规格型号" prop="specification">
          <el-input v-model="BaseInfoForm.specification" style="width: 250px"></el-input>
        </el-form-item>
        <el-form-item label="生产厂家" prop="manufacturerName">
          <el-input v-model="BaseInfoForm.manufacturerName" style="width: 250px"></el-input>
        </el-form-item>
        <el-form-item label="注册证号" prop="registrationNo">
          <el-input v-model="BaseInfoForm.registrationNo" style="width: 250px"></el-input>
        </el-form-item>
        <el-form-item label="供货商" prop="supplierShortName">
          <el-select v-model="BaseInfoForm.supplierShortName" placeholder="请选择" size="small" style="width: 250px">
            <el-option
              v-for="item in allSupplierList"
              :key="item.id"
              :label="item.supplierShortName"
              :value="item.supplierShortName">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="单价" prop="price">
          <el-input v-model="BaseInfoForm.price" style="width: 250px"></el-input>
        </el-form-item>
        <el-form-item label="储存温度" prop="stockType">
          <el-select v-model="BaseInfoForm.stockType" placeholder="请选择" size="small" style="width: 250px">
            <el-option
              v-for="item in tempList"
              :key="item.value"
              :label="item.value"
              :value="item.value">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="过期预警时间阈值" prop="expirationLimit">
          <el-input v-model="BaseInfoForm.expirationLimit" style="width: 250px"></el-input>
        </el-form-item>
        <el-form-item label="低库存预警阈值" prop="stockLimit">
          <el-input v-model="BaseInfoForm.stockLimit" style="width: 250px"></el-input>
        </el-form-item>
        <el-form-item label="开启有效期限" prop="useDayLimit">
          <el-input v-model="BaseInfoForm.useDayLimit" style="width: 250px"></el-input>
        </el-form-item>
      </el-form>

      <span slot="footer" class="dialog-footer">
        <el-button @click="editDialogVisible = false" size="small">取 消</el-button>
        <el-button type="primary" @click="handleEditDialogConfirm()" v-if="!supplierStatus"
                   size="small">确 定</el-button>
      </span>
    </el-dialog>
  </div>
</template>
<script>
import {
  createBaseInfo,
  deleteBaseInfo,
  fetchAllBaseInfoList,
  fetchList,
  searchList,
  updateBaseInfo,
} from '@/api/baseInfo';
import {fetchAllSupplierList} from '@/api/supplier';
import {isvalidUsername} from '@/utils/validate';
import {formatDate} from '@/utils/date';
import {isInStock} from '@/api/stockDetail';
import {baseInfoUploadUrl} from '@/settings';

const defaultListQuery = {
  pageNum: 1,
  pageSize: 50,
  keyword: null,
  code: null,
  name: null,
  manufacturerName: null,
  supplierShortName: null,
};
const defaultBaseInfoForm = {
  name: '',
  unit: '',
  specification: '',
  manufacturerName: '',
  registrationNo: '',
  price: '',
  supplierShortName: '',
  stockType: '',
  expirationLimit: '',
  stockLimit: '',
  useDayLimit: '',
};
export default {
  name: 'BaseInfoList',
  data() {
    const validateTest = (rule, value, callback) => {
      if (/^[0-9]+$/.test(value)) {
        callback();
      } else {
        return callback(new Error("请填写整数"));
      }
    };
    const validateUsername = (rule, value, callback) => {
      if (!isvalidUsername(value)) {
        callback(new Error('该选项不能为空'))
      } else {
        callback()
      }
    };
    return {
      importDataIcon: 'el-icon-upload2',
      importDisabled: null,
      result: null,
      tempList: [{
        value: '常温'
      }, {
        value: '冷藏'
      }, {
        value: '冷冻'
      }],
      BaseInfoRules: {
        name: [
          {required: true, message: '请输入耗材名称', trigger: 'blur'},
          {validator: validateUsername, trigger: 'blur'}
        ],
        unit: [
          {required: true, message: '请输入单位', trigger: 'blur'},
          {validator: validateUsername, trigger: 'blur'}
        ],
        specification: [
          {required: true, message: '请输入规格型号', trigger: 'blur'},
          {validator: validateUsername, trigger: 'blur'}
        ],
        manufacturerName: [
          {required: true, message: '请输入生产厂家', trigger: 'blur'},
          {validator: validateUsername, trigger: 'blur'}
        ],
        price: [
          {required: true, message: '请输入单价', trigger: 'blur'},
          {
            type: "number", transform(value) {
              return Number(value);
            }, message: '请输入数字', trigger: 'blur'
          }
        ],
        registrationNo: [
          {required: true, message: '请输入注册证号', trigger: 'blur'},
          {validator: validateUsername, trigger: 'blur'}
        ],
        supplierShortName: [
          {required: true, message: '请输入供货商', trigger: 'blur'},
        ],
        stockType: [
          {required: true, message: '请输入存储温度', trigger: 'blur'},
          {validator: validateUsername, trigger: 'blur'}
        ],
        expirationLimit: [
          {required: true, message: '请输入过期预警时间阈值', trigger: 'blur'},
          {validator: validateTest, trigger: 'blur'}
        ],
        stockLimit: [
          {required: true, message: '请输入低库存预警阈值', trigger: 'blur'},
          {validator: validateTest, trigger: 'blur'}
        ],
        useDayLimit: [
          {required: true, message: '请输入开启有效期限', trigger: 'blur'},
          {validator: validateTest, trigger: 'blur'}
        ],
      },
      listQuery: Object.assign({}, defaultListQuery),
      list: null,
      total: null,
      loading: false,
      listLoading: false,
      dialogVisible: false,
      errorTableVisible: false,
      BaseInfoForm: Object.assign({}, defaultBaseInfoForm),
      editDialogVisible: false,
      allBaseInfoList: [],
      errorList: [],
      inStockFlag: null,
      allSupplierList: [],
      supplierStatus: false,
      uploadUrl: baseInfoUploadUrl,
    }
  },
  created() {
    this.getList();
    this.fetchSupplierList();
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
    //row,  每一行上的数据
    //column, 每一列上的数据
    //rowIndex,  行数的下标从0开始
    //columnIndex   列数下标从0开始
    nullBase({row, columnIndex}) {
      if (row.name == '' && columnIndex == 1) {
        return {
          background: 'red'
        }
      }
      if (row.unit == '' && columnIndex == 2) {
        return {
          background: 'red'
        }
      }
      if (row.specification == '' && columnIndex == 3) {
        return {
          background: 'red'
        }
      }
      if (row.manufacturerName == '' && columnIndex == 4) {
        return {
          background: 'red'
        }
      }
      if (row.registrationNo == '' && columnIndex == 5) {
        return {
          background: 'red'
        }
      }
      if (row.supplierShortName == '' && columnIndex == 6) {
        return {
          background: 'red'
        }
      }
      if (row.stockType == '' && columnIndex == 7) {
        return {
          background: 'red'
        }
      }
      if (row.price == null && columnIndex == 8) {
        return {
          background: 'red'
        }
      }
      if (row.expirationLimit == null && columnIndex == 9) {
        return {
          background: 'red'
        }
      }
      if (row.stockLimit == null && columnIndex == 10) {
        return {
          background: 'red'
        }
      }
      if (row.useDayLimit == null && columnIndex == 11) {
        return {
          background: 'red'
        }
      }

    },
    onError(response, file, fileList) {
      alert("文件上传失败！");
    },
    // 上传前对文件的大小的判断
    beforeUpload(file) {
      const extension2 = file.name.split(".")[1] === "xlsx";
      if (!extension2) {
        alert("上传文件只能是xlsx格式!");
      }
      return extension2;
    },
    onSuccess(res) {
      // 将上传组件改为允许使用
      this.importDisabled = false;

      this.errorList = res.data.list;
      if (this.errorList.length > 0) {
        this.errorTableVisible = true;
        this.$message.warning("耗材信息部分导入成功，存在导入失败耗材！");
      } else {
        this.$message.success("耗材信息全部导入成功！");
      }

      //把接收到的res存入data的result
      this.result = res;
      this.getList();
    },

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
    fetchSupplierList() {
      fetchAllSupplierList().then(response => {
        this.allSupplierList = response.data;
      });
    },
    handleResetSearch() {
      this.listQuery = Object.assign({}, defaultListQuery);
      this.listQuery.pageNum = 1;
      this.getList();
    },
    handleSearchList() {
      this.listQuery.pageNum = 1;
      this.getSearchList();
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
      this.BaseInfoForm = Object.assign({}, defaultBaseInfoForm);
    },
    handleDelete(index, row) {
      this.$confirm('是否要删除该耗材信息?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        isInStock(row.code).then(response => {
          this.inStockFlag = response.data;

          if (this.inStockFlag > 0) {
            this.$message({
              type: 'warning',
              message: '耗材在库!'
            });
          } else if (this.inStockFlag == 0) {
            deleteBaseInfo(row.id).then(response => {
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
      const supplierList = [];
      this.editDialogVisible = true;
      this.BaseInfoForm = Object.assign({}, row);

      this.allSupplierList.forEach(item => {
        supplierList.push(item.supplierShortName);
      });
      //true-在列表中，可以编辑；false-不在列表中，不可以编辑
      let flag = supplierList.includes(row.supplierShortName);
      if (!flag) this.supplierStatus = true;
      if (flag) this.supplierStatus = false;
    },
    handleDialogConfirm() {
      this.$refs.BaseInfoForm.validate(valid => {
        if (valid) {
          createBaseInfo(this.BaseInfoForm).then(response => {
            this.$message({
              message: '添加成功！',
              type: 'success'
            });
            this.dialogVisible = false;
            this.getList();
          })
        } else {
          console.log('参数验证不合法！');
          this.$message({
            message: '添加失败！',
            type: 'warning'
          });
          return false
        }
      })
    },
    handleEditDialogConfirm() {
      this.$refs.BaseInfoForm.validate(valid => {
        if (valid) {
          updateBaseInfo(this.BaseInfoForm.id, this.BaseInfoForm).then(response => {
            this.$message({
              message: '修改成功！',
              type: 'success'
            });
            this.editDialogVisible = false;
            this.getList();
          })
        } else {
          console.log('参数验证不合法！');
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
    getSearchList() {
      this.listLoading = true;
      searchList(this.listQuery).then(response => {
        this.listLoading = false;
        this.list = response.data.list;
        this.total = response.data.total;
      });
    },
    getAllBaseInfoList() {
      fetchAllBaseInfoList().then(response => {
        this.allBaseInfoList = response.data;
      });
    },
  }
}
</script>
<style>
.input-width {
  width: 140px;
}
</style>

