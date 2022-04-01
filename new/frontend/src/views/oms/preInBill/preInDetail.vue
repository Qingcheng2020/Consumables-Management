<template> 
  <div class="app-container">
    <!--    <el-button size="small" @click="back()">返回</el-button>-->
    <el-card class="filter-container" shadow="never">
      <i class="el-icon-tickets"></i>
      <span>随货单详情
        <el-input v-model="filename" placeholder="Enter File Name"
                  style="width:200px;
                      float:right;
                      margin-right:5px"
                  size="small"
                  prefix-icon="el-icon-document"/>
        <el-button :loading="downloadLoading"
                   style="margin-bottom:20px;
                       float:right;
                       margin-right:10px"
                   type="primary"
                   icon="el-icon-download"
                   size="small"
                   @click="handleDownload">导出
        </el-button>
        <el-button
          type="primary"
          icon="el-icon-printer"
          style="margin-bottom:20px;
                    float:right;
                    margin-right:10px"
          :loading="downloadLoading"
          size="small"
          @click="handlePrint">打印随货单
        </el-button>
      </span>
    </el-card>
    <div class="table-container">
      <el-table ref="preInDetailTable"
                :data="preInDetail"
                :row-class-name="rowClassName"
                @selection-change="handleSelectionChange"
                style="width: 100%;"
                max-height="550"
                v-loading="listLoading" border>
        <el-table-column type="selection" width="40" align="center"></el-table-column>

        <el-table-column prop="newId" align="center" label="序号" width="60"></el-table-column>
        <el-table-column label="耗材名称" width="160%" align="center">
          <template slot-scope="scope">{{ scope.row.reagentName }}</template>
        </el-table-column>
        <el-table-column label="规格型号" align="center">
          <template slot-scope="scope">{{ scope.row.reagentSpecification }}</template>
        </el-table-column>
        <el-table-column label="单位" align="center">
          <template slot-scope="scope">{{ scope.row.reagentUnit }}</template>
        </el-table-column>
        <el-table-column label="数量" align="center">
          <template slot-scope="scope">{{ scope.row.reagentCount }}</template>
        </el-table-column>
        <el-table-column label="单价" align="center">
          <template slot-scope="scope">¥ {{ scope.row.reagentPrice }}</template>
        </el-table-column>
        <el-table-column label="金额" align="center">
          <template slot-scope="scope">¥ {{ scope.row.total }}</template>
        </el-table-column>
        <el-table-column label="批号" width="100%" align="center">
          <template slot-scope="scope">{{ scope.row.batchNo }}</template>
        </el-table-column>
        <el-table-column label="有效期" width="100%" align="center">
          <template slot-scope="scope">{{ scope.row.expireDate | formatDateTime }}</template>
        </el-table-column>
        <el-table-column label="生产厂家" align="center">
          <template slot-scope="scope">{{ scope.row.manufacturerName }}</template>
        </el-table-column>
        <el-table-column label="注册证号" align="center">
          <template slot-scope="scope">{{ scope.row.registrationNo }}</template>
        </el-table-column>
        <el-table-column label="质检报告" width="190%" align="center">
          <template slot-scope="scope">
            <div v-if="roleId===5" style="display: inline-block">
              <el-upload
                ref="uploadFile"
                :show-file-list="false"
                :before-upload="beforeUpload"
                :on-success="onSuccess"
                :on-error="onError"
                :disabled="importDisabled"
                :data={inDetailId:scope.row.detailId,cell:0}
                :action="uploadUrl"
                style="display: inline-block">
                <el-button size="mini" :disabled="importDisabled" type="text">导入
                </el-button>
              </el-upload>
            </div>
            <el-button size="mini"
                       type="text"
                       @click="handleViewReport(scope.$index, scope.row,0)">查看
            </el-button>
          </template>
        </el-table-column>
        <el-table-column label="耗材状态" align="center">
          <template slot-scope="scope">
            {{ statusData[(scope.row.billStatus)] }}
          </template>
        </el-table-column>
        <el-table-column label="备注" align="center">
          <template slot-scope="scope">{{ scope.row.remark }}</template>
        </el-table-column>
        <el-table-column label="操作" width=auto align="center">
          <template slot-scope="scope">
            <el-button
              size="mini"
              type="primary"
              @click="handleViewOrder(scope.$index, scope.row)">查看
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
import {Message} from 'element-ui';
import {fetchBill} from '@/api/preInBill';
import {getReportPath, searchByBillCode} from '@/api/preInDetail';
import {formatDate} from '@/utils/date';
import {PrintForm} from '@/utils/printForm';
import {getRole} from '@/api/order';
import {getCookie} from "../../../utils/support";
import {preUploadUrl} from '@/settings';

const printFormColumn = [
  {
    field: 'reagentName',
    name: '耗材名称',

  },
  {
    field: 'reagentSpecification',
    name: '规格型号',
  },
  {
    field: 'reagentUnit',
    name: '单位',
    columnSize: '50%'
  },
  {
    field: 'reagentCount',
    name: '数量',
    columnSize: '50%'
  },
  {
    field: 'reagentPrice',
    name: '单价',
    columnSize: '50%'
  },
  {
    field: 'total',
    name: '金额',
    columnSize: '50%'
  },
  {
    field: 'batchNo',
    name: '批号',
  },
  {
    field: 'expireDate',
    name: '有效期',
  },
  {
    field: 'manufacturerName',
    name: '生产厂家',
  },
  {
    field: 'registrationNo',
    name: '注册证号',
  },
];

const defaultListQuery = {
  pageNum: 1,
  pageSize: 50,
  keyword: null,
  column: null,
  username: getCookie("username")
};
export default {
  name: "preInDetailList",
  data() {
    return {
      pdfUrl: null,
      dataPreInBill: null,
      listQuery: Object.assign({}, defaultListQuery),
      loading: false,
      listLoading: false,
      list: null,
      total: null,
      preInDetail: null,
      multipleSelection: [],
      supplierName: this.$route.query.supplierName,
      downloadLoading: false,
      filename: '',
      importDataIcon: 'el-icon-upload2',
      importDisabled: null,
      roleId: 0,
      dialogReportVisible: false,
      uploadUrl: preUploadUrl,
      //试剂状态
      statusData: {
        '0': '未入库',
        '1': '已入库',
      },
    }
  },
  created() {
    this.getList();
    this.getDataPreInBill();
    this.getRole();
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
    getRole() {
      getRole(this.listQuery.username).then(response => {
        this.roleId = response.data;
      });
    },
    // pdf加载时
    handleViewReport(index, row, column) {
      this.listQuery.keyword = row.detailId;
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
    handleSelectionChange(val) {
      this.multipleSelection = val;
    },
    /**
     * 获取当前时间
     * 格式YYYY-MM-DD
     */
    getNowFormatDate() {
      const date = new Date();
      const seperator = "-";
      const year = date.getFullYear();
      let month = date.getMonth() + 1;
      let strDate = date.getDate();
      if (month >= 1 && month <= 9) {
        month = "0" + month;
      }
      if (strDate >= 0 && strDate <= 9) {
        strDate = "0" + strDate;
      }
      return year + seperator + month + seperator + strDate;
    },
    handlePrint() {
      if (this.dataPreInBill === null) {
        Message.error('随货同行单数据获取失败');
        return;
      }
      let printList = [];
      let isAllIn = false;

      for (let i = 0; i < this.preInDetail.length; i++) {
        if (this.preInDetail[i].billStatus == 1) {
          isAllIn = true;
        } else {
          isAllIn = false;
        }
      }
      //如果isAllIn依然为true，说明此单据中全部都是已入库的，则打印全部
      //否则就只打印未入库的
      if (isAllIn) {
        printList = this.preInDetail;
      } else {
        for (let i = 0; i < this.preInDetail.length; i++) {
          if (this.preInDetail[i].billStatus == 0) {
            printList.push(this.preInDetail[i]);
          }
        }
      }

      const _data = printList;

      const _createTime = formatDate(new Date(this.dataPreInBill.createTime), 'yyyy-MM-dd hh:mm:ss');

      const pf = new PrintForm({
        header: `${this.dataPreInBill.supplierName}`,
        orderNumber: this.dataPreInBill.billCode,
        fromWho: `单位名称：临沂市河东区妇幼保健院`,
        footer: `
          <div
            style="
              margin-top: 1rem;
              display: flex;
              justify-content: space-between;"
          >
            <div>制表：${this.dataPreInBill.billCreator}</div>
            <div>送货人：${this.dataPreInBill.supplierContacts}</div>
            <div>收货人：&emsp;&emsp;&emsp;</div>
          </div>
        `,
        createTime: _createTime,
        title: '随货同行单',
        properties: printFormColumn,
        data: _data,
        showIds: true,
        qrcode: this.dataPreInBill.billCode,
        total: {
          field: 'total',
          showChinese: true,
        },
      });

      pf.toPrint();
    },
    formatJson(filterVal, jsonData) {
      return jsonData.map(v => filterVal.map(j => v[j]))
    },
    //导出Excel表格
    handleDownload() {
      if (this.multipleSelection.length) {
        this.downloadLoading = true
        import('@/vendor/Export2Excel').then(excel => {
          //对应表格输出的title
          const multiHeader = [[' ', ' ', ' ', ' ', ' ', '检验耗材随货同行单 ', ' ', ' ', ' ', ' ', ' ', ' '],
            ['供货单位:', this.supplierName, ' ', ' ', ' ', ' ', '单号:', this.multipleSelection[0].billCode, ' ', ' ', '时间:', this.getNowFormatDate()]];
          const header = ['序号', '耗材名称', '规格型号', '单位', '数量', '单价', '金额', '批号', '保质期', '生产厂家', '注册证号', '备注'];
          const filterVal = ['newId', 'reagentName', 'reagentSpecification', 'reagentUnit', 'reagentCount', 'reagentPrice', 'total', 'batchNo', 'expireDate', 'manufacturerName', 'registrationNo', 'remark'];

          //进行所有表头的单元格合并,按行合并
          const merges = [
            "A1:E1",
            "G1:L1",
          ];
          const list = this.multipleSelection;
          const data = this.formatJson(filterVal, list);
          excel.export_json_to_excel({
            multiHeader,
            header,
            data,
            filename: this.filename,
            merges,
          });

          //清除复选框
          this.$nextTick(() => {
            this.$refs.preInDetailTable.clearSelection();
          });
          this.downloadLoading = false;
        })
      } else {
        this.$message({
          message: '请至少选择其中一项！',
          type: 'warning'
        })
      }
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

    handleViewOrder(index, row) {
      this.$router.push({path: '/oms/preInItem', query: {inDetailId: row.detailId}})
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
      this.listQuery.keyword = this.$route.query.billCode;
      searchByBillCode(this.listQuery).then(response => {
        this.listLoading = false;
        this.preInDetail = response.data.list;
        this.total = response.data.total;

        for (let i = 0; i < this.preInDetail.length; i++) {
          this.preInDetail[i].expireDate = formatDate(new Date(this.preInDetail[i].expireDate), 'yyyy-MM-dd');
        }
      });
    },

    /**
     * 获取随货同行单基本信息
     * 随货同行单第一层数据
     */
    getDataPreInBill() {
      const billCode = this.$route.query.billCode;
      fetchBill({
        pageNum: 1,
        pageSize: 50,
        keyword: billCode,
        printType: 1
      }).then(res => {
        if (res.data && res.data.list.length !== 0) {
          this.dataPreInBill = res.data.list[0];
        } else {
          Message.error('获取随货同行单基本信息失败');
        }
      });
    },

  }
}
</script>

