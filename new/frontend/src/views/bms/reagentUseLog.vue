<template> 
  <div class="app-container">
    <el-card class="filter-container" shadow="never">
      <i class="el-icon-tickets"></i>
      <span>耗材使用记录列表</span>
      <el-button
        style="float:right;margin-bottom: 10px"
        size="small"
        type="primary"
        @click.native.prevent="searchByDate">搜索
      </el-button>
      <el-button
        style="float:right;margin-right: 10px"
        @click="handleResetSearch()"
        size="small">
        重置
      </el-button>
      <el-date-picker
        size="small"
        style="float:right;margin-right: 10px"
        v-model="dateRange"
        type="datetimerange"
        start-placeholder="开始日期"
        end-placeholder="结束日期"
        :default-time="['00:00:00','23:59:59']">
      </el-date-picker>

      <div style="float:right">
        <el-form :inline="true" :model="listQuery" size="small">
          <el-form-item label="耗材名称：">
            <el-input v-model="listQuery.reagentName" class="input-width" placeholder="耗材名称" clearable
                      @keyup.enter.native="searchByDate"></el-input>
          </el-form-item>
          <el-form-item label="设备名称">
            <el-select clearable v-model="listQuery.keyword" placeholder="请选择" size="small" style="width: 250px">
              <el-option
                v-for="item in allDeviceList"
                :key="item.id"
                :label="item.deviceName"
                :value="item.id">
              </el-option>
            </el-select>
          </el-form-item>
        </el-form>
      </div>
      <div style="margin-left: 10px;margin-top: 10px">
        <span>制表人：{{ listQuery.username }},{{ branch }},{{ listQuery.startTime|formatDate }}——{{ listQuery.endTime|formatDate }}</span>
      </div>
      <div style="margin-left: 10px;margin-top: 10px">
        <el-input v-model="filename" placeholder="Enter File Name"
                  style="width:200px;
                      float:right;
                      margin-right:5px"
                  prefix-icon="el-icon-document"
                  size="small"/>
        <el-button :loading="downloadLoading"
                   style="margin-bottom:20px;
                       float:right;
                       margin-right:10px"
                   type="primary"
                   icon="el-icon-download"
                   @click="handleDownload"
                   size="small">导出
        </el-button>
        <el-button :loading="downloadLoading"
                   style="margin-bottom:20px;
                       float:right;
                       margin-right:10px"
                   type="primary"
                   icon="el-icon-printer"
                   @click="handlePrint"
                   size="small">打印
        </el-button>
      </div>
    </el-card>

    <div class="table-container">

      <!--      <span style="float: right;margin-right: 40px;margin-bottom: 10px"></span>-->
      <el-table ref="lossTable"
                :data="list"
                :row-class-name="rowClassName"
                max-height="550"
                stripe
                :default-sort="{scope: 'scope.row.orderDay', order: 'descending'}"
                style="width: 100%;"
                @selection-change="handleSelectionChange"
                v-loading="listLoading" border>
        <!--<el-table-column type="selection" width="40" align="center"></el-table-column>-->
        <el-table-column prop="newId" align="center" label="序号" width="60"></el-table-column>
        <el-table-column label="日期" width="240" align="center">
          <template slot-scope="scope">{{ scope.row.useTime | formatDateTime }}</template>
        </el-table-column>
        <el-table-column label="耗材名称" width="240" align="center">
          <template slot-scope="scope">{{ scope.row.reagentName }}</template>
        </el-table-column>
        <el-table-column label="规格型号" align="center">
          <template slot-scope="scope">{{ scope.row.reagentSpecification }}</template>
        </el-table-column>
        <el-table-column label="单位" align="center">
          <template slot-scope="scope">{{ scope.row.reagentUnit }}</template>
        </el-table-column>
        <el-table-column label="批号" align="center">
          <template slot-scope="scope">{{ scope.row.batchNo }}</template>
        </el-table-column>
        <el-table-column label="耗材编号" align="center">
          <template slot-scope="scope">{{ scope.row.reagentCode }}</template>
        </el-table-column>
        <el-table-column label="有效期" align="center">
          <template slot-scope="scope">{{ scope.row.expireDate | formatDateDay }}</template>
        </el-table-column>
        <el-table-column label="设备名称" align="center">
          <template slot-scope="scope">{{ scope.row.deviceName }}</template>
        </el-table-column>
        <el-table-column label="上机人员" align="center">
          <template slot-scope="scope">{{ scope.row.updateBy }}</template>
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
<script type="text/ecmascript-6">
import {reagentUseLog} from '@/api/stockDetail'
import {formatDate} from '@/utils/date';
import {getCookie} from '@/utils/support';
import {getBranch} from '@/api/count'
import {getDeviceList} from '@/api/device';
import {PrintForm} from '@/utils/printForm';

const printFormColumn = [
  {
    field: 'useTime',
    name: '日期',
    columnSize: '200%'
  },
  {
    field: 'reagentName',
    name: '耗材名称',
    columnSize: '200%'
  },
  {
    field: 'reagentSpecification',
    name: '规格型号',
  },
  {
    field: 'reagentUnit',
    name: '单位',
  },
  {
    field: 'batchNo',
    name: '批号',
    columnSize: '100%'
  },
  {
    field: 'reagentCode',
    name: '耗材编号',
    columnSize: '80%'
  },
  {
    field: 'expireDate',
    name: '有效期',
    columnSize: '100%'
  },
  {
    field: 'deviceName',
    name: '设备名称',
    columnSize: '100%'
  },
  {
    field: 'updateBy',
    name: '更换人员',
    columnSize: '100%'
  },
];
const defaultListQuery = {
  pageNum: 1,
  pageSize: 50,
  keyword: null,
  username: getCookie("username"),
  startTime: formatDate(new Date(), 'yyyy-MM-dd hh:mm:ss').split(' ')[0] + ' 00:00:00',
  endTime: formatDate(new Date(), 'yyyy-MM-dd hh:mm:ss').split(' ')[0] + ' 23:59:59',
  deviceName: null,
  reagentName: null,
};

export default {
  name: 'reagentDeviceLog',
  data() {
    return {
      allDeviceList: [],
      branch: null,
      listQuery: Object.assign({}, defaultListQuery),
      list: null,
      formatList: [],
      total: null,
      loading: false,
      listLoading: false,
      dateRange: '',
      filename: '',
      multipleSelection: [],
      downloadLoading: false,
    }
  },
  created() {
    this.getList();
    this.getBranch();
    this.fetchDeviceList();
  },
  filters: {
    formatDateTime(time) {
      if (time == null || time === '') {
        return 'N/A';
      }
      let date = new Date(time);
      return formatDate(date, 'yyyy-MM-dd hh:mm:ss')
    },
    formatDateDay(time) {
      if (time == null || time === '') {
        return 'N/A';
      }
      let date = new Date(time);
      return formatDate(date, 'yyyy-MM-dd')
    },
    formatDate(time) {
      if (time == null || time === '') {
        return '/';
      }
      let date = new Date(time);
      return formatDate(date, 'yyyy年MM月dd日')
    }
  },
  methods: {
    fetchDeviceList() {
      getDeviceList(this.listQuery.username).then(response => {
        this.allDeviceList = response.data;
      });
    },

    rowClassName({row, rowIndex}) {
      //把每一行的索引放进row.id
      row.newId = (this.listQuery.pageSize * (this.listQuery.pageNum - 1)) + rowIndex + 1;
    },
    getBranch() {
      getBranch(this.listQuery.username).then(response => {
        this.branch = response.data;
      })
    },
    back() {
      if (window.history.length <= 1) {
        this.$router.push({path: '/'})
        return false
      } else {
        this.$router.go(-1)
      }
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
    //根据起始结束日期查找，以进行导出表格
    searchByDate() {
      if (this.dateRange) {
        this.listQuery.startTime = formatDate(this.dateRange[0], 'yyyy-MM-dd hh:mm:ss');
        this.listQuery.endTime = formatDate(this.dateRange[1], 'yyyy-MM-dd hh:mm:ss');
      } else {
        this.listQuery.startTime = formatDate(new Date(), 'yyyy-MM-dd hh:mm:ss').split(' ')[0] + ' 00:00:00';
        this.listQuery.endTime = formatDate(new Date(), 'yyyy-MM-dd hh:mm:ss').split(' ')[0] + ' 23:59:59';
      }
      this.getList();
    },
    //导出Excel表格
    handleDownload() {
      //只有选择了设备名称之后才可以导出
      this.downloadLoading = true;
      import('@/vendor/Export2Excel').then(excel => {
        //对应表格输出的title
        const multiHeader = [[' ', ' ', ' ', '耗材使用记录列表', ' ', ' ', ' ', ' ', ' '], [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
          [this.listQuery.startTime, '至', this.listQuery.endTime, ' ', ' ', '制表人: ', getCookie("username"), '科室: ', this.branch]];
        const header = ['日期', '耗材名称', '规格型号', '单位', '批号', '耗材编号', '有效期', '设备名称', '更换人员'];
        const filterVal = ['useTime', 'reagentName', 'reagentSpecification', 'reagentUnit', 'batchNo', 'reagentCode', 'expireDate', 'deviceName', 'updateBy'];

        //进行所有表头的单元格合并,按行合并
        const merges = [
          "A1:C1",
          "E1:H1",
        ];
        const list = this.formatList;
        const data = this.formatJson(filterVal, list);
        excel.export_json_to_excel({
          multiHeader,
          header,
          data,
          filename: this.filename,
          merges
        });
        //清除复选框
        this.$nextTick(() => {
          this.$refs.lossTable.clearSelection();
        });
        this.downloadLoading = false;
      })

    },
    formatJson(filterVal, jsonData) {
      return jsonData.map(v => filterVal.map(j => v[j]))
    },
    handlePrint() {
      const _data = this.formatList;
      const _createTime = formatDate(new Date(), 'yyyy-MM-dd hh:mm:ss');

      const pf = new PrintForm({
        orderNumber: formatDate(new Date(), 'yyyyMMddhhmmss'),
        createTime: _createTime,
        title: '耗材使用记录',
        properties: printFormColumn,
        data: _data,
        showIds: true,
        total: {
          field: 'total',
          showChinese: false,
        },
      });
      pf.toPrint();
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
      this.formatList = [];
      this.listQuery.deviceName = null;
      reagentUseLog(this.listQuery).then(response => {
        this.listLoading = false;
        this.list = response.data.list;
        this.total = response.data.total;

        //if (this.listQuery.keyword != null && this.listQuery.keyword !== '') {
        this.list.forEach(item => {
          let useTime;
          let expireDate;
          if (item.useTime == null || item.useTime === '') {
            useTime = 'N/A';
          } else {
            let date = new Date(item.useTime);
            useTime = formatDate(date, 'yyyy-MM-dd hh:mm:ss')
          }

          if (item.expireDate == null || item.expireDate === '') {
            expireDate = 'N/A';
          } else {
            let date = new Date(item.expireDate);
            expireDate = formatDate(date, 'yyyy-MM-dd')
          }

          const obj = {
            useTime: useTime,
            reagentName: item.reagentName,
            reagentSpecification: item.reagentSpecification,
            reagentUnit: item.reagentUnit,
            batchNo: item.batchNo,
            reagentCode: item.reagentCode,
            expireDate: expireDate,
            deviceName: item.deviceName,
            updateBy: item.updateBy,
          }
          this.formatList.push(obj);
          this.listQuery.deviceName = obj.deviceName;
        });
        //}
      });
    },
  }
}
</script>


