<template> 
  <div class="app-container">
    <el-card class="filter-container" shadow="never">

      <div>
        <i class="el-icon-tickets"></i>
        <span>库损列表</span>
      </div>

      <el-button
        style="margin-bottom:20px;
                   float:right;
                   margin-right:10px"
        type="primary"
        size="small"
        icon="el-icon-download"
        @click="printCode">打印
      </el-button>

<!--      <div style="float:right">-->
<!--        <el-form :inline="true" :model="listQuery" size="small" label-width="140px">-->
<!--          <el-form-item>-->
<!--            <el-select clearable v-model="listQuery.reagentStatus" placeholder="状态" size="small" style="width: 130px">-->
<!--              <el-option-->
<!--                v-for="item in statusDataList"-->
<!--                :key="item.id"-->
<!--                :label="item.name"-->
<!--                :value="item.id">-->
<!--              </el-option>-->
<!--            </el-select>-->
<!--          </el-form-item>-->
<!--          <el-form-item>-->
<!--            <el-input v-model="listQuery.keyword" class="input-width" placeholder="库存编号/试剂名称"></el-input>-->
<!--          </el-form-item>-->
<!--        </el-form>-->
<!--      </div>-->

    </el-card>


    <div class="table-container">
      <el-table ref="StockLossTable"
                :data="list"
                :row-class-name="rowClassName"
                style="width: 100%;"
                v-loading="listLoading" border>
        <el-table-column prop="newId" align="center" label="序号" width="60"></el-table-column>

        <el-table-column label="库存编号" min-width="160%" align="center">
          <template slot-scope="scope">{{ scope.row.stockNo }}</template>
        </el-table-column>
        <el-table-column label="耗材名称" min-width="160%" align="center">
          <template slot-scope="scope">{{ scope.row.reagentName }}</template>
        </el-table-column>
        <el-table-column label="科室库名" align="center">
          <template slot-scope="scope">{{ scope.row.branch }}</template>
        </el-table-column>
        <el-table-column label="库损时间" min-width="100%" align="center">
          <template slot-scope="scope">{{ scope.row.updateTime | formatDateTime }}</template>
        </el-table-column>
        <el-table-column label="二维码" width="350%" align="center">
          <template slot-scope="scope">
            <div>
              <div class="qrcode-pic" ref="codeItem">
                <vue-qr :text="scope.row.qrCode" :size="110" :margin="0"></vue-qr>
              </div>
              <div v-html="scope.row.codeValue" class="right" align="left"></div>
            </div>
          </template>
        </el-table-column>
        <el-table-column label="耗材状态" align="center">
          <template slot-scope="scope">
            {{ statusData[(scope.row.reagentStatus)].label }}
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
import {fetchLossList} from '@/api/stockDetail';
import {formatDate} from '@/utils/date';
import {getCookie} from '@/utils/support';
import VueQr from "vue-qr";

const defaultListQuery = {
  pageNum: 1,
  pageSize: 50,
  keyword: null,
  username: getCookie("username"),
  reagentStatus: null,
  reagentId:null,
};
const defaultStockLoss = {
  id: null,
  code: null,
  name: null,
  unit: null,
  specification: null,
  manufacturerName: null,
  registrationNo: null,
  supplierId: null,
  supplierShortName: null,
  stockLossType: null,
};
export default {
  name: 'StockLossList',
  data() {
    return {
      statusDataList: [{
        id: '0',
        name: '丢失'
      }, {
        id: '1',
        name: '破损'
      }, {
        id: '2',
        name: '过期'
      }, {
        id: '4',
        name: '其他原因库损'
      }],
      listQuery: Object.assign({}, defaultListQuery),
      list: null,
      total: null,
      loading: false,
      listLoading: false,
      dialogVisible: false,
      StockLoss: Object.assign({}, defaultStockLoss),
      editDialogVisible: false,
      allStockLossList: [],
      //试剂状态
      statusData: [
        {
          value: '0',
          label: '丢失'
        }, {
          value: '1',
          label: '破损'
        }, {
          value: '2',
          label: '过期'
        }, {
          value: '4',
          label: '其他原因库损'
        },
      ],
    }
  },
  components: {
    VueQr
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
    printCode() {
      setTimeout(() => {
        const that = this;
        this.$nextTick(() => {
          let arrDom = document.querySelectorAll(".qrcode-pic");

          let iframe = document.createElement('IFRAME');
          iframe.setAttribute('style', 'position: absolute: width:0px; height: 0px; left: -500px; top:-500px;');
          document.body.appendChild(iframe);
          let doc = iframe.contentWindow.document;

          for (let i = 0; i < that.list.length; i++) {
            doc.write(`

                <div class="long">
                         <div class="qrcode">${arrDom[i].innerHTML}</div>
                         <div class="codeValue">${that.list[i].codeValue}</div>
                </div>
                <div style="page-break-after: always"><br /></div>
            `);
          }
          doc.write(`
            <style>
              .long {
                width: 250px;
                height: 100px;
                padding: 2rem;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                margin: auto;
              }
              .qrcode{
                width: 110px;
                height: 110px;
                float: left;
              }
              .codeValue{
                width: 123px;
                height: 100px;
                float: right;
                font-size:8px;
                word-break:break-all;

              }
            </style>

          `);
          iframe.contentWindow.print();
          iframe.parentNode.removeChild(iframe)
        })

      }, 100)
    },
    handleResetSearch() {
      this.listQuery = Object.assign({}, defaultListQuery);
      this.listQuery.pageNum = 1;
      this.listQuery.username = getCookie("username");
      this.getList();
    },
    handleSearchList() {
      this.listQuery.pageNum = 1;
      this.listQuery.username = getCookie("username");
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
      this.StockLoss = Object.assign({}, defaultStockLoss);
    },
    handleUpdate(index, row) {
      this.editdialogVisible = true;
      this.StockLoss = Object.assign({}, row);
    },
    getList() {
      this.listLoading = true;
      this.listQuery.reagentId = this.$route.query.reagentId;
      this.listQuery.reagentStatus = this.$route.query.reagentStatus;
      fetchLossList(this.listQuery).then(response => {
        this.listLoading = false;
        this.list = response.data.list;
        this.total = response.data.total;
      });
    },
  }
}
</script>
<style></style>
<style type="text/css">
.qrcode-pic {
  float: left;
  margin-left: 20px;
  margin-top: 20px;
}

.right {
  position: center;
  float: left;
  font-size: 12px;
  width: 45%;
  margin-left: 20px;
}


</style>


