<template> 
  <div class="app-container">
    <el-card class="filter-container" shadow="never">

      <div>
        <i class="el-icon-tickets"></i>
        <span>库存汇总列表</span>
      </div>
      <div style="float:left;margin-top: 8px">
        <el-form :inline="true" :model="listQuery" size="small">
          <el-form-item label="耗材名称:">
            <el-input v-model="listQuery.reagentName" class="stock-width" placeholder="耗材名称" clearable
                      @keyup.enter.native="handleSearchList"></el-input>
          </el-form-item>
          <el-form-item label="供货商:">
            <el-input v-model="listQuery.supplierName" class="stock-width" placeholder="供货商" clearable
                      @keyup.enter.native="handleSearchList"></el-input>
          </el-form-item>
          <el-form-item label="生产厂家:">
            <el-input v-model="listQuery.factory" class="stock-width" placeholder="生产厂家" clearable
                      @keyup.enter.native="handleSearchList"></el-input>
          </el-form-item>
          <el-form-item label="存储温度:">
            <el-input v-model="listQuery.reagentTemp" class="stock-width" placeholder="存储温度" clearable
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
        size="small">
        重置
      </el-button>
    </el-card>
    <div class="table-container">
      <el-table ref="StockCentreTable"
                :data="list"
                max-height="600"
                :cell-style="lowStock"
                :row-class-name="rowClassName"
                style="width: 100%;"
                v-loading="listLoading" border>
        <el-table-column prop="newId" align="center" label="序号" width="60"></el-table-column>
        <el-table-column label="名称" min-width="160%" align="center">
          <template slot-scope="scope">{{ scope.row.reagentName }}</template>
        </el-table-column>
        <el-table-column label="型号规格" align="center">
          <template slot-scope="scope">{{ scope.row.reagentType }}</template>
        </el-table-column>
        <el-table-column label="生产厂家" min-width="100%" align="center">
          <template slot-scope="scope">{{ scope.row.factory }}</template>
        </el-table-column>
        <el-table-column label="供货商" align="center">
          <template slot-scope="scope">{{ scope.row.supplierName }}</template>
        </el-table-column>
        <el-table-column label="单位" align="center">
          <template slot-scope="scope">{{ scope.row.reagentUnit }}</template>
        </el-table-column>
        <el-table-column label="数量" align="center">
          <template slot-scope="scope">{{ scope.row.quantity }}</template>
        </el-table-column>
        <el-table-column label="储存温度" align="center">
          <template slot-scope="scope">{{ scope.row.reagentTemp }}</template>
        </el-table-column>
        <el-table-column label="低库存预警" align="center"></el-table-column>
        <el-table-column label="过期预警" align="center">
          <template slot-scope="scope">
            <span v-if="scope.row.overdueStock < '0'">
              存在过期
            </span>
            <span v-else>
              {{ scope.row.overdueStock }}天
            </span>
          </template>
        </el-table-column>
        <el-table-column label="状态" width="100" align="center">
          <template slot-scope="scope">
            {{ statusData[(scope.row.reagentStatus)] }}
          </template>
        </el-table-column>
        <el-table-column label="操作" width="120" align="center">
          <template slot-scope="scope">
            <!--            <el-button size="mini"
                                   type="primary"
                                   icon="el-icon-edit"
                                   @click="handleUpdate(scope.$index, scope.row)">编辑
                        </el-button>-->
            <el-button size="mini"
                       type="primary"
                       @click="handleViewStock(scope.$index, scope.row)">查看
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
      :title="'编辑库存信息'"
      :visible.sync="editDialogVisible"
      width="40%">
      <el-form :model="StockCentre"
               ref="StockCentreForm"
               label-width="150px" size="small">
        <el-form-item label="耗材编号">
          <el-input v-model="StockCentre.reagentId" style="width: 250px"></el-input>
        </el-form-item>
        <el-form-item label="耗材名称">
          <el-input v-model="StockCentre.reagentName" style="width: 250px"></el-input>
        </el-form-item>
        <el-form-item label="型号规格">
          <el-input v-model="StockCentre.reagentType" style="width: 250px"></el-input>
        </el-form-item>
        <el-form-item label="单位">
          <el-input v-model="StockCentre.reagentUnit" style="width: 250px"></el-input>
        </el-form-item>
        <el-form-item label="生产厂家">
          <el-input v-model="StockCentre.factory" style="width: 250px"></el-input>
        </el-form-item>
        <el-form-item label="供货商">
          <el-input v-model="StockCentre.supplierName" style="width: 250px"></el-input>
        </el-form-item>
        <el-form-item label="状态">
          <el-input v-model="StockCentre.reagentStatus" style="width: 250px"></el-input>
        </el-form-item>
        <el-form-item label="存储温度">
          <el-input v-model="StockCentre.reagentTemp" style="width: 250px"></el-input>
        </el-form-item>
        <el-form-item label="低库存预警">
          <el-input v-model="StockCentre.lowStock" style="width: 250px"></el-input>
        </el-form-item>
        <el-form-item label="过期预警">
          <el-input v-model="StockCentre.overdueStock" style="width: 250px"></el-input>
        </el-form-item>
      </el-form>

      <span slot="footer" class="dialog-footer">
        <el-button @click="editDialogVisible = false" size="small">取 消</el-button>
        <el-button type="primary" @click="handleEditDialogConfirm()" size="small">确 定</el-button>
      </span>
    </el-dialog>

  </div>
</template>
<script>

import {createStock, updateStock, deleteStock,searchLowList} from '@/api/stock';
import {formatDate} from '@/utils/date';
import {deleteStockDetail} from '@/api/stockDetail';
import {getCookie} from '@/utils/support';


const defaultListQuery = {
  pageNum: 1,
  pageSize: 50,
  keyword: null,
  stockType: 1,
  reagentId: null,
  reagentName: null,
  supplierName: null,
  factory: null,
  reagentStatus: null,
  reagentTemp: null,
  type:2,
  username: getCookie("username")
};
const defaultStockCentre = {
  id: null,
  stockNo: null,
  stockType: 3,
  reagentId: null,
  reagentName: null,
  reagentType: null,
  reagentUnit: null,
  factory: null,
  supplierName: null,
  quantity: null,
  reagentStatus: null,
  reagentTemp: null,
  lowStock: null,
  overdue: null,
  overdueStock: null,
};
export default {
  name: 'StockCentreList',
  data() {
    return {
      listQuery: Object.assign({}, defaultListQuery),
      list: null,
      total: null,
      loading: false,
      listLoading: false,
      dialogVisible: false,
      StockCentre: Object.assign({}, defaultStockCentre),
      editDialogVisible: false,
      //耗材在库状态
      statusData: {
        '1': '已入库',
        '5': '已退货',
        '1997': '已出库',
      },
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
    //row,  每一行上的数据
    //column, 每一列上的数据
    //rowIndex,  行数的下标从0开始
    //columnIndex   列数下标从0开始
    lowStock({row, columnIndex}) {
      if (row.quantity <= row.lowStock && columnIndex == 8) {
        return {
          background: 'orange'
        }
      }
      if (row.quantity == '0' && columnIndex == 8) {
        return {
          background: '#red'
        }
      }
      if (row.overdueStock * 1 <= '0' && columnIndex == 9) {
        return {
          background: 'red'
        }
      }
      if (row.overdueStock * 1 > '0' && row.overdueStock * 1 <= row.overdue && columnIndex == 9) {
        return {
          background: 'orange'
        }
      }
    },
    handleViewStock(index, row) {
      this.$router.push({path: '/tms/stockDetail', query: {stockNo: row.stockNo}})
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
    handleDelete(index, row) {
      this.$confirm('是否要删除该库存信息?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        deleteStock(row.id).then(response => {
          this.$message({
            type: 'success',
            message: '删除成功!'
          });
          this.getList();
        });
        deleteStockDetail(row.stockNo);
      });
    },
    handleUpdate(index, row) {
      this.editDialogVisible = true;
      this.StockCentre = Object.assign({}, row);
    },
    handleDialogConfirm() {
      this.$confirm('是否要确认?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        createStock(this.StockCentre).then(response => {
          this.$message({
            message: '添加成功！',
            type: 'success'
          });
          this.dialogVisible = false;
          this.getList();
        })
      })
    },
    handleEditDialogConfirm() {
      this.$confirm('是否要确认?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        updateStock(this.StockCentre.id, this.StockCentre).then(response => {
          this.$message({
            message: '修改成功！',
            type: 'success'
          });
          this.editDialogVisible = false;
          this.getList();
        });

      })
    },
    getList() {
      this.listLoading = true;
      searchLowList(this.listQuery).then(response => {
        this.listLoading = false;
        this.list = response.data.list;
        this.total = response.data.total;
      });
    },
  }
}
</script>
<style>
.stock-width {
  width: 120px;
}
</style>



