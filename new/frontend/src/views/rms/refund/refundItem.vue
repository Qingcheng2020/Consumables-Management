<template> 
  <div class="app-container">
    <!--    <el-button size="small" @click="back()">返回</el-button>-->
    <el-card class="filter-container" shadow="never">
      <i class="el-icon-tickets"></i>
      <span>退货详情</span>
      <el-button
        style="margin-bottom:20px;
                   float:right;
                   margin-right:10px"
        type="primary"
        icon="el-icon-download"
        @click="printCode">打印
      </el-button>
    </el-card>
    <div class="table-container">
      <el-table ref="refundItemTable"
                :data="refundItem"
                :row-class-name="rowClassName"
                style="width: 100%;"
                v-loading="listLoading" border>
        <el-table-column prop="newId" align="center" label="序号" width="60"></el-table-column>
        <el-table-column label="耗材编号" min-width="160%" align="center">
          <template slot-scope="scope">{{ scope.row.reagentCode }}</template>
        </el-table-column>
        <el-table-column label="二维码" width="350%" align="center">
          <template slot-scope="scope">
            <div>

              <div class="qrcode-pic" ref="codeItem">
                <vue-qr :text="scope.row.qrCode" :size="110" :margin="0"></vue-qr>
              </div>
              <div v-html="scope.row.codeValue" class="right"></div>
            </div>
          </template>
        </el-table-column>
        <el-table-column label="状态" align="center">
          <template slot-scope="scope">{{ scope.row.status }}</template>
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
    <logistics-dialog v-model="logisticsDialogVisible"></logistics-dialog>
  </div>
</template>
<script>
import {fetchList} from '@/api/refundItem'
import {formatDate} from '@/utils/date';
import VueQr from "vue-qr";

const defaultListQuery = {
  pageNum: 1,
  pageSize: 50,
  keyword: null,
};
export default {
  name: "refundItemList",
  data() {
    return {
      listQuery: Object.assign({}, defaultListQuery),
      loading: false,
      listLoading: false,
      list: null,
      total: null,
      refundItem: null,
      multipleSelection: [],
      logisticsDialogVisible: false
    }
  },
  components: {
    VueQr
  },
  created() {
    this.getList();

  },
  filters: {
    formatOutItemTime(time) {
      let date = new Date(time);
      return formatDate(date, 'yyyy-MM-dd')
    },
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
    printCode() {
      setTimeout(() => {
        const that = this;
        this.$nextTick(() => {
          let arrDom = document.querySelectorAll(".qrcode-pic");

          let iframe = document.createElement('IFRAME');
          iframe.setAttribute('style', 'position: absolute: width:0px; height: 0px; left: -500px; top:-500px;');
          document.body.appendChild(iframe);
          let doc = iframe.contentWindow.document;

          for (let i = 0; i < that.refundItem.length; i++) {
            doc.write(`

                <div class="long">
                         <div class="qrcode">${arrDom[i].innerHTML}</div>
                         <div class="codeValue">${that.refundItem[i].codeValue}</div>
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
                width: 120px;
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
      this.listQuery.keyword = this.$route.query.refundDetailId;
      fetchList(this.listQuery).then(response => {
        this.listLoading = false;
        this.refundItem = response.data.list;
        this.total = response.data.total;
      });
    },
  }
}
</script>

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

