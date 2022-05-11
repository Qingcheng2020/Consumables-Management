<template> 
  <div class="app-container">
    <el-card class="filter-container" shadow="never">
      <div>
        <i class="el-icon-tickets"></i>
        <span>移库列表</span>
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
            <el-input v-model="listQuery.keyword" class="input-width" placeholder="申请单号/申请人员"
                      @keyup.enter.native="handleSearchList"></el-input>
          </el-form-item>
        </el-form>
      </div>
    </el-card>

    <div class="table-container">
      <el-table ref="relocationTable"
                :data="list"
                :row-class-name="rowClassName"
                max-height="550"
                stripe
                :default-sort="{scope: 'scope.row.collectDay', collect: 'descending'}"
                style="width: 100%;"
                @selection-change="handleSelectionChange"
                v-loading="listLoading" border>
        <el-table-column prop="newId" align="center" label="序号" width="60"></el-table-column>
        <el-table-column label="申请编号" min-width="150%" align="center">
          <template slot-scope="scope">{{ scope.row.collectNo }}</template>
        </el-table-column>
        <el-table-column label="申请日" align="center">
          <template slot-scope="scope">{{ scope.row.collectDay | formatCollectTime }}</template>
        </el-table-column>
        <el-table-column label="申请人" align="center">
          <template slot-scope="scope">{{ scope.row.createName }}</template>
        </el-table-column>
        <el-table-column label="申请科室库" align="center">
          <template slot-scope="scope">{{ scope.row.branch }}</template>
        </el-table-column>
        <el-table-column label="状态" align="center">
          <template slot-scope="scope">
            {{ statusData[(scope.row.collectStatus)] }}
          </template>
        </el-table-column>
        <el-table-column label="描述" align="center">
          <template slot-scope="scope">{{ scope.row.collectDescribe }}</template>
        </el-table-column>
        <el-table-column label="操作" width="250" align="center">
          <template slot-scope="scope">
            <el-button
              size="mini"
              type="primary"
              @click="handleViewCollect(scope.$index, scope.row)"
              v-show="scope.row.collectStatus==1 || scope.row.collectStatus==2 || scope.row.collectStatus==3">查看
            </el-button>
            <el-button
              size="mini"
              type="primary"
              @click="handleViewChange(scope.$index, scope.row)"
              v-show="(scope.row.collectStatus==1 || scope.row.collectStatus==2 || scope.row.collectStatus==3)
                      && (roleId==1 || roleId==6)">出库
            </el-button>
            <el-button
              size="mini"
              type="primary"
              @click="handleApplyIn(scope.$index, scope.row)"
              v-show="scope.row.collectStatus==2 && (roleId == 3 || roleId == 1)">申领入库
            </el-button>
            <el-button
              size="mini"
              type="primary"
              icon="el-icon-edit"
              @click="handleViewCollect(scope.$index, scope.row)"
              v-show="scope.row.collectStatus==0">编辑
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

<!--    <el-dialog-->
<!--      :title="'确认出库？'"-->
<!--      :visible.sync="editDialogVisible"-->
<!--      width="20%">-->

<!--      <span slot="footer" class="dialog-footer">-->
<!--        <el-button @click="editDialogVisible = false" size="small">取 消</el-button>-->
<!--        <el-button type="primary" @click="handleEditDialogConfirm()" size="small">确 定</el-button>-->
<!--      </span>-->
<!--    </el-dialog>-->

  </div>
</template>
<script>
import {outFromCentreStock} from '@/api/stock';
import {applyInStock, deleteCollect, fetchList,changeStatus} from '@/api/collect'
import {formatDate} from '@/utils/date';
import {deleteCollectDetail} from "@/api/collectDetail";
import {getCookie} from '@/utils/support';
import {getRole} from '@/api/order'

const defaultListQuery = {
  pageNum: 1,
  pageSize: 50,
  keyword: null,
  applyType: 2,
  username: getCookie("username"),
  itemId: null,
};
export default {
  name: "relocationList",
  data() {
    return {
      listQuery: Object.assign({}, defaultListQuery),
      loading: false,
      listLoading: false,
      list: null,
      total: null,
      operateType: null,
      multipleSelection: [],
      roleId: 0,
      applyInType: 0,

      //申请单状态
      statusData: {
        '0': '草稿',
        '1': '已提交',
        '2': '中心已出库',
        '3': '科室已入库',
      },
      //申请单操作
      operateOptions: [
        {
          label: "批量删除",
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
    formatCollectTime(time) {
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
    getRole() {
      getRole(this.listQuery.username).then(response => {
        this.roleId = response.data;
      })
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
    handleSelectionChange(val) {
      this.multipleSelection = val;
    },
    handleViewCollect(index, row) {
      this.$router.push({
        path: '/cms/relocationDetail',
        query: {collectNo: row.collectNo, collectStatus: row.collectStatus}
      })
    },
    // handleViewChange(index, row) {
    //   this.editDialogVisible = true;
    //   this.StockCentre = Object.assign({}, row);

      // console.log(sendData)
      // changeStatus(sendData).then(response => {
      //   this.$message({
      //     message: '出库成功！',
      //     type: 'success',
      //     duration: 1000
      //   });
      //   this.getList();
      // });
    // },
    handleViewChange(index, row) {
      let sendData = {
        OrderId : row.collectNo,
        destination : row.branch
      };
      this.$confirm('是否确认出库?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        outFromCentreStock(sendData).then(response => {
          this.$message({
            message: '出库成功！',
            type: 'success',
            duration: 1000
          });
          this.getList();
        });

      })
    },
    handleApplyIn(index, row) {
      this.applyInType = 1;
      let sendData = {
        itemId: row.id,
        branch: null,
        qrList: null,
        inType: 3,
        createType: 5,
        outType: 3,
        collectState: 1,
        applyInType: this.applyInType,
        collectNo: row.collectNo,
        username: this.listQuery.username
      };
      applyInStock(sendData).then(response => {
        this.$message({
          message: '入库成功！',
          type: 'success',
          duration: 1000
        });
        this.getList();
      });
    },
    handleDeleteCollect(index, row) {
      let ids = [];
      let collectNos = [];
      ids.push(row.id);
      collectNos.push(row.collectNo);
      this.deleteCollect(ids, collectNos);
    },
    deleteCollect(ids, collectNos) {
      this.$confirm('是否要进行该删除操作?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        let params_id = new URLSearchParams();
        params_id.append("ids", ids);
        let params_collectNo = new URLSearchParams();
        params_collectNo.append("collectNos", collectNos);

        deleteCollect(params_id).then(response => {
          this.$message({
            message: '删除成功！',
            type: 'success',
            duration: 1000
          });
          this.getList();
        });
        deleteCollectDetail(params_collectNo);
      })
    },
    handleBatchOperate() {
      if (this.multipleSelection == null || this.multipleSelection.length < 1) {
        this.$message({
          message: '请选择要操作的申请单',
          type: 'warning',
          duration: 1000
        });
        return;
      }
      if (this.operateType === 2) {
        //删除申请单
        let ids = [];
        let collectNos = [];
        for (let i = 0; i < this.multipleSelection.length; i++) {
          ids.push(this.multipleSelection[i].id);
          collectNos.push(this.multipleSelection[i].collectNo);
        }
        this.deleteCollect(ids, collectNos);
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


