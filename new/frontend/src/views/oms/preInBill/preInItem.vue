<template> 
  <div class="app-container">
    <!--    <el-button size="small" @click="back()">返回</el-button>-->
    <el-card class="filter-container" shadow="never">
      <i class="el-icon-tickets"></i>
      <span>随货同行单详情
        <el-button
          size="small"
          type="primary"
          icon="el-icon-printer"
          style="margin-bottom:20px;
                 float:right;
                 margin-right:10px"
          @click="printCode">打印二维码
        </el-button>
      </span>
    </el-card>
    <div class="table-container">
      <el-table ref="preInItemTable"
                :data="preInItem"
                :row-class-name="rowClassName"
                style="width: 100%;"
                max-height="650"
                @selection-change="handleSelectionChange"
                v-loading="listLoading" border>
        <el-table-column type="selection" width="40" align="center"></el-table-column>

        <el-table-column prop="newId" align="center" label="序号" width="60"></el-table-column>
        <el-table-column label="随货同行单编号" min-width="160%" align="center">
          <template slot-scope="scope">{{ scope.row.billCode }}</template>
        </el-table-column>
        <el-table-column label="耗材编号" min-width="160%" align="center">
          <template slot-scope="scope">{{ scope.row.reagentCode }}</template>
        </el-table-column>
        <el-table-column label="二维码" width="350%" align="center">
          <template slot-scope="scope">
            <div>
              <div class="qrcode-pic" :class="'qrcode' + scope.row.newId" ref="codeItem">
                <vue-qr :text="scope.row.qrCode" :size="110" :margin="0"></vue-qr>
              </div>
              <div v-html="scope.row.codeValue" class="right" align="left"></div>
            </div>
          </template>
        </el-table-column>
        <el-table-column label="状态" align="center">
          <template slot-scope="scope">
            {{ scope.row.status ? statusData[(scope.row.status)].label : '未入库' }}
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
import {fetchList} from '@/api/preInItem'
import {formatDate} from '@/utils/date';
import VueQr from "vue-qr";

const defaultListQuery = {
  pageNum: 1,
  pageSize: 50,
  keyword: null,
};
export default {
  name: "preInItemList",
  data() {
    return {
      listQuery: Object.assign({}, defaultListQuery),
      loading: false,
      listLoading: false,
      list: null,
      total: null,
      preInItem: null,
      multipleSelection: [],
      //预入库单状态
      statusData: [
        {
          label: '未入库',
          value: 0
        },
        {
          label: '已入库',
          value: 1
        }
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
    formatOutItemTime(time) {
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
    handleSelectionChange(val) {
      this.multipleSelection = val;
    },
    printCode() {
      if (this.multipleSelection.length <= 0) {
        this.$message({
          message: '未选择要打印的二维码！',
          type: 'warning',
          duration: 1500
        });
      } else {
        setTimeout(() => {
          const that = this;
          this.$nextTick(() => {
            let iframe = document.createElement('IFRAME');
            iframe.setAttribute('style', 'position: absolute: width:0px; height: 0px; left: -500px; top:-500px;');
            document.body.appendChild(iframe);
            let doc = iframe.contentWindow.document;

            for (let i = 0; i < that.multipleSelection.length; i++) {
              const item = that.multipleSelection[i];
              const domItem = document.querySelector(`.qrcode${item.newId}`);

              doc.write(`
                <div class="long">
                  <div class="qrcode">${domItem.innerHTML}</div>
                  <div class="codeValue">${item.codeValue}</div>
                </div>
                ${i < that.multipleSelection.length - 1 ? '<div style="page-break-after: always"></div>' : ''}
            `);
            }

            doc.write(`
            <style>
            @media print {
                @page {
                    margin: 1mm;
                }
              }
              .long {
                width: 300px;
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
                width: 170px;
                height: 100px;
                float: right;
                font-size:8px;
                word-break:break-all;

            </style>
          `);

            iframe.contentWindow.print();
            iframe.parentNode.removeChild(iframe)
          })
        }, 100)
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
      this.listQuery.keyword = this.$route.query.inDetailId;
      fetchList(this.listQuery).then(response => {
        this.listLoading = false;
        this.preInItem = response.data.list;
        this.total = response.data.total;
      })
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
