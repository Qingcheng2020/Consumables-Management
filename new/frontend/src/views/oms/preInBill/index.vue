<template> 
  <div class="app-container">
    <el-card class="filter-container" shadow="never">
      <div>
        <i class="el-icon-tickets"></i>
        <span>随货同行单列表</span>
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
            <el-input v-model="listQuery.keyword" class="input-width" placeholder="随货同行单编号/供货商"
                      @keyup.enter.native="handleSearchList" clearable></el-input>
          </el-form-item>
        </el-form>
      </div>
    </el-card>

    <div class="table-container">
      <el-table ref="PreInBillTable"
                :data="list"
                :row-class-name="rowClassName"
                max-height="600"
                style="width: 100%;"
                v-loading="listLoading" border>
        <el-table-column prop="newId" align="center" label="序号" width="60"></el-table-column>
        <el-table-column label="随货同行单编号" width="160" align="center">
          <template slot-scope="scope">{{ scope.row.billCode }}</template>
        </el-table-column>
        <el-table-column label="供货商" align="center">
          <template slot-scope="scope">{{ scope.row.supplierShortName }}</template>
        </el-table-column>
        <el-table-column label="创建时间" align="center">
          <template slot-scope="scope">{{ scope.row.createTime | formatDateTime }}</template>
        </el-table-column>
        <el-table-column label="单据状态" align="center">
          <template slot-scope="scope">
            {{ statusData[(scope.row.billStatus)] }}
          </template>
        </el-table-column>
        <el-table-column label="制单人员" align="center">
          <template slot-scope="scope">{{ scope.row.billCreator }}</template>
        </el-table-column>
        <el-table-column label="电子发票" width="190%" align="center">
          <template slot-scope="scope">
            <div v-if="roleId===5" style="display: inline-block">
              <el-upload
                ref="uploadFile"
                :show-file-list="false"
                :before-upload="beforeUpload"
                :on-success="onSuccess"
                :on-error="onError"
                :disabled="importDisabled"
                :data={inDetailId:scope.row.id,cell:1}
                :action="uploadUrl"
                style="display: inline-block">
                <el-button size="mini" :disabled="importDisabled" type="text">导入
                </el-button>
              </el-upload>
            </div>
            <el-button size="mini"
                       type="text"
                       @click="handleViewReport(scope.$index, scope.row,1)">查看
            </el-button>
          </template>
        </el-table-column>

        <el-table-column label="备注" align="center">
          <template slot-scope="scope">{{ scope.row.remark }}</template>
        </el-table-column>

        <el-table-column label="操作" width="220" align="center">
          <template slot-scope="scope">
            <el-button
              size="mini"
              type="primary"
              @click="handleViewOrder(scope.$index, scope.row)"
            >查看
            </el-button>
<!--            <el-button-->
<!--              size="mini"-->
<!--              type="primary"-->
<!--              @click="handlePrint(scope.$index, scope.row)">打印二维码-->
<!--            </el-button>-->
          </template>
        </el-table-column>

      </el-table>
    </div>
    <div style="display: none">
      <el-table ref="inBillItemTable"
                :data="codePicList"
                max-height="550"
                style="width: 100%;"
                v-loading="listLoading" border>
        <el-table-column label="二维码" width="350%" align="center">
          <template slot-scope="scope">
            <div>
              <div class="qrcode-pic">
                <vue-qr :text="scope.row.qrCode" :size="110" :margin="0"></vue-qr>
              </div>
              <div v-html="scope.row.qrCodeValue" class="right" align="left"></div>
            </div>
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
import {deletePreInBill, fetchList, searchCodeList} from '@/api/preInBill';
import {deletePreInBillDetail, getReportPath} from '@/api/preInDetail';
import {deletePreInBillItem} from '@/api/preInItem';
import {formatDate} from '@/utils/date';
import {getCookie} from '@/utils/support';
import {getRole} from '@/api/order'
import VueQr from "vue-qr";
import {preUploadUrl} from '@/settings';

const defaultListQuery = {
  pageNum: 1,
  pageSize: 50,
  keyword: null,
  column: null,
  username: getCookie("username"),
};
const defaultPreInBill = {
  id: null,
  billCode: null,
  name: null,
  unit: null,
  specification: null,
  manufacturerName: null,
  registrationNo: null,
  supplierId: null,
  supplierShortName: null,
  preInBillType: null,
};
export default {
  name: 'PreInBillList',
  data() {
    return {
      listQuery: Object.assign({}, defaultListQuery),
      list: null,
      total: null,
      loading: false,
      listLoading: false,
      dialogVisible: false,
      codePicList: null,
      preInBill: Object.assign({}, defaultPreInBill),
      roleId: 0,
      pdfUrl: null,
      importDisabled: null,
      uploadUrl: preUploadUrl,

      //预入库单状态
      statusData: {
        '0': '已撤销',
        '1': '已入库',
        '2': '未入库',
        '3': '未入库-与订单部分相符',
        '4': '未入库-与订单不符',
        '5': '已关闭',
      },
    }
  },
  components: {
    VueQr
  },
  created() {
    this.getList();
    this.getRole();
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
    getRole() {
      getRole(this.listQuery.username).then(response => {
        this.roleId = response.data;
      })
    },
    // pdf加载时
    handleViewReport(index, row, column) {
      this.listQuery.keyword = row.id;
      this.listQuery.column = column;
      getReportPath(this.listQuery).then(res => {
        this.pdfUrl = res.data;
        if (this.pdfUrl != null && this.pdfUrl !== '') {
          window.open('static/pdf/web/viewer.html?file=' + this.pdfUrl);
        } else {
          this.$message({
            message: '未找到文件!',
            type: 'warning'
          });
        }
      });
    },
    onError(response, file, fileList) {
      alert("文件上传失败！");
    },
    beforeUpload(file) {
      // 限制上传格式为图片或者PDF
      //const isIMG = (file.type === 'image/jpeg' || file.type === 'image/png' || file.type === 'image/jpg')
      const extension = file.name.split(".")[1].toLowerCase() === "pdf"

      // 上传前对文件的大小的判断
      const isLt2M = file.size / 1024 / 1024 < 10     //这里做文件大小限制
      if (!extension) {
        this.$message({
          message: '上传文件只能是pdf格式!',
          type: 'warning'
        });
      }
      if (!isLt2M) {
        this.$message({
          message: '上传文件大小不能超过 10MB!',
          type: 'warning'
        });
      }
      return (extension) && isLt2M;
    },
    onSuccess(res) {
      // 将上传组件改为允许使用
      this.importDisabled = false;
      if (res.code === 200) {
        this.$message({
          message: '导入成功！',
          type: 'success',
          duration: 1000
        });
      } else {
        this.$message({
          message: '导入失败！',
          type: 'warning',
          duration: 1000
        });
      }
    },
    handlePrint(index, row) {
      this.listQuery.billCode = row.billCode;
      searchCodeList(this.listQuery).then(response => {
        this.listLoading = false;
        this.codePicList = response.data;

        if (this.codePicList.length > 0) {
          setTimeout(() => {
            const that = this;
            this.$nextTick(() => {
              let arrDom = document.querySelectorAll(".qrcode-pic");
              let iframe = document.createElement('IFRAME');
              iframe.setAttribute('style', 'position: absolute: width:0px; height: 0px; left: -500px; top:-500px;');
              document.body.appendChild(iframe);
              let doc = iframe.contentWindow.document;

              for (let i = 0; i < that.codePicList.length; i++) {
                doc.write(`
                <div class="long">
                         <div class="qrcode">${arrDom[i].innerHTML}</div>
                         <div class="qrCodeValue">${that.codePicList[i].qrCodeValue}</div>
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
              .qrCodeValue{
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
          }, 100);
        } else {
          this.$message({
            message: '此单中未有需要打印二维码！',
            type: 'warning',
            duration: 1500
          });
        }
      });
    },
    back() {
      if (window.history.length <= 1) {
        this.$router.push({path: '/'})
        return false
      } else {
        this.$router.go(-1)
      }
    },
    handleViewOrder(index, row) {
      this.$router.push({
        path: '/oms/preInDetail',
        query: {billCode: row.billCode, billStatus: row.billStatus, supplierName: row.supplierShortName}
      })
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
    handleAdd() {
      this.dialogVisible = true;
      this.preInBill = Object.assign({}, defaultPreInBill);
    },
    handleDeletePreInBill(index, row) {
      let ids = [];
      let billCodes = [];
      ids.push(row.id);
      billCodes.push(row.billCode);
      this.deletePreInBill(ids, billCodes);
    },
    deletePreInBill(ids, billCodes) {
      this.$confirm('是否要进行该删除操作?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        let params_id = new URLSearchParams();
        params_id.append("ids", ids);
        let params_code = new URLSearchParams();
        params_code.append("billCodes", billCodes);

        deletePreInBill(params_id).then(response => {
          this.$message({
            message: '删除成功！',
            type: 'success',
            duration: 1000
          });
          this.getList();
        });
        deletePreInBillDetail(params_code);
        deletePreInBillItem(params_code);
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


