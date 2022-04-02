<template> 
  <div class="app-container">
    <el-card class="filter-container" shadow="never">
      <i class="el-icon-tickets"></i>
      <span>领用申请详情
        <el-button type="primary"
                   @click=" handleEditConfirm"
                   style="float: right;"
                   size="small"
                   v-show="collectStatus==0">
                    {{ handleEditButton ? '编辑' : "保存" }}
         </el-button>
         <el-button type="primary"
                    @click=" handleSubConfirm"
                    style="float: right;margin-right:10px"
                    size="small"
                    v-show="collectStatus==0">提交
         </el-button>
      </span>
    </el-card>
    <div class="table-container">
      <el-table ref="relocationTable"
                :data="collectDetail"
                :row-class-name="rowClassName"
                max-height="550"
                style="width: 100%;"
                v-loading="listLoading" border>
        <el-table-column prop="newId" align="center" label="序号" width="60"></el-table-column>

        <el-table-column label="耗材名称" min-width="200%" align="center">
          <template slot-scope="scope">{{ scope.row.reagentName }}</template>
        </el-table-column>
        <el-table-column label="供货商" align="center">
          <template slot-scope="scope">{{ scope.row.supplierShortName }}</template>
        </el-table-column>
        <el-table-column label="生产厂家" min-width="150%" align="center">
          <template slot-scope="scope">{{ scope.row.factory }}</template>
        </el-table-column>
        <el-table-column label="型号规格" align="center">
          <template slot-scope="scope">{{ scope.row.reagentType }}</template>
        </el-table-column>
        <el-table-column label="申请人" align="center">
          <template slot-scope="scope">{{ scope.row.createBy }}</template>
        </el-table-column>
        <el-table-column label="单位" align="center">
          <template slot-scope="scope">{{ scope.row.unit }}</template>
        </el-table-column>
        <el-table-column label="单价" align="center">
          <template slot-scope="scope">¥ {{ scope.row.price }}</template>
        </el-table-column>
        <el-table-column label="数量" align="center">
          <template slot-scope="scope">
            <span v-if="scope.row.show">
               <el-input size="mini" placeholder="数量" v-model="scope.row.reagentNumber"></el-input>
            </span>
            <span v-else>{{ scope.row.reagentNumber }}</span>
          </template>
        </el-table-column>
        <el-table-column label="操作" width="150" align="center" v-if="collectStatus==0">
          <template slot-scope="scope">
            <el-button size="mini"
                       type="danger"
                       v-show="!handleEditButton"
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
  </div>
</template>
<script>
import {deleteCollectDetailItem, fetchList, getCollectDetail, updateCollectDetail} from '@/api/collectDetail'
import {formatDate} from '@/utils/date';
import {deleteCollectByCoNo, updateRelocationByCN} from '@/api/collect';

const defaultListQuery = {
  pageNum: 1,
  pageSize: 50,
  keyword: null,
};
const defaultRelocationQuery = {
  pageNum: 1,
  pageSize: 50,
  collectStatus: null,
};
export default {
  name: "collectDetailList",
  data() {
    return {
      listQuery: Object.assign({}, defaultListQuery),
      relocation: Object.assign({}, defaultRelocationQuery),
      loading: false,
      listLoading: false,
      list: null,
      total: null,
      collectDetail: null,
      collectStatus: null,
      handleEditButton: true,
      multipleSelection: [],
    }
  },
  created() {
    this.listLoading = true;
    this.listQuery.keyword = this.$route.query.collectNo;
    fetchList(this.listQuery).then(response => {
      this.listLoading = false;
      this.collectStatus = this.$route.query.collectStatus;
      this.collectDetail = response.data.list;
      this.total = response.data.total;
    });

    (this.collectDetail || []).map(i => {
      i.show = false;
      return i;
    });
  },
  filters: {
    formatCollectTime(time) {
      let date = new Date(time);
      return formatDate(date, 'yyyy-MM-dd')
    },
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
      this.collectDetail.map((i, index) => {
        i.show = true;
        this.$set(this.collectDetail, index, i);

        //保存操作，隐藏编辑框，更新详细数据，获取新的列表
        if (!this.handleEditButton) {
          updateCollectDetail(index, i).then(response => {
            if (response.data > 0) {
              this.option = this.$message({
                showClose: true,
                message: "申请耗材：" + i.reagentName + "超出库存" + response.data + "支，申请失败！",
                type: 'warning',
                duration: 0,
              });
            } else if (response.data == 0) {
              i.show = false;
              getCollectDetail(this.$route.query.collectNo).then(response => {
                this.collectStatus = this.$route.query.collectStatus;
                this.handleEditButton = true;
                this.collectDetail = response.data;
                this.listLoading = false;
              });
              this.$message({
                message: "申请耗材：" + i.reagentName + "保存成功！",
                type: 'success'
              });
            }
          });
        }
      });
      //编辑之后按钮变为保存按钮
      this.handleEditButton = false;
    },

    handleSubConfirm() {
      //只有不是处于编辑状态的才能提交
      if (this.handleEditButton) {
        this.relocation.collectStatus = 1;
        const collectNo = this.collectDetail[0].collectNo;
        updateRelocationByCN(collectNo, this.relocation).then(response => {
          this.$router.go(-1);
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
      }
    },
    handleDelete(index, row) {
      // 获取删除订单详情的订单号
      const collectNo = this.collectDetail[0].collectNo;
      this.$confirm('是否要删除该耗材信息?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        deleteCollectDetailItem(row.id).then(response => {
          this.$message({
            type: 'success',
            message: '删除成功!'
          });
          getCollectDetail(collectNo).then(response => {
            this.collectDetail = response.data;
            this.listLoading = false;
            // 级联删除订单详情为空的订单
            if (this.collectDetail.length < 0 || this.collectDetail.length == 0) {
              deleteCollectByCoNo(collectNo).then(response => {
                if (response.data == 1) {
                  this.$router.push("/cms/relocation")
                }
              });
            }
          });
        });
      });
    },
    getList() {
      this.listLoading = true;
      fetchList(this.listQuery).then(response => {
        this.listLoading = false;
        this.collectDetail = response.data.list;
        this.total = response.data.total;
      });
    },
  }
}
</script>


