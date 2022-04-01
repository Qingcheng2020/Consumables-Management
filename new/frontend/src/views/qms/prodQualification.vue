<template> 
  <div class="app-container">
    <el-card class="filter-container" shadow="never">

      <div>
        <i class="el-icon-tickets"></i>
        <span>产品资质</span>
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
      <div style="float:right;margin-top: 8px">
        <el-form :inline="true" :model="listQuery" size="small" label-width="100px">
          <el-form-item label="公司简称：" v-if="roleId!==5">
            <el-input v-model="listQuery.supplierShortName" class="input-width" placeholder="公司简称" clearable
                      @keyup.enter.native="handleSearchList"></el-input>
          </el-form-item>
          <el-form-item label="耗材名称：">
            <el-input v-model="listQuery.reagentName" class="input-width" placeholder="耗材名称" clearable
                      @keyup.enter.native="handleSearchList"></el-input>
          </el-form-item>
        </el-form>
      </div>
    </el-card>
    <div class="table-container">
      <el-table ref="prodQualificationTable"
                :data="prodQualification"
                :row-class-name="rowClassName"
                style="width: 100%;"
                max-height="600"
                v-loading="listLoading" border>

        <el-table-column prop="newId" align="center" label="序号" width="60"></el-table-column>
        <el-table-column label="公司简称" width="160%" align="center">
          <template slot-scope="scope">{{ scope.row.supplierShortName }}</template>
        </el-table-column>
        <el-table-column label="耗材名称" width="160%" align="center">
          <template slot-scope="scope">{{ scope.row.reagentName }}</template>
        </el-table-column>
        <el-table-column label="生产厂家营业执照" width="190%" align="center">
          <template slot-scope="scope">
            <div v-if="roleId===5" style="display: inline-block">
              <el-upload
                ref="uploadFile"
                :show-file-list="false"
                :before-upload="beforeUpload"
                :on-success="onSuccess"
                :on-error="onError"
                :disabled="importDisabled"
                :data={id:scope.row.id,cell:0,flag:0}
                :action="uploadUrl"
                style="display: inline-block">
                <el-button size="mini" :disabled="importDisabled" type="text" class="color-import">
                  导入
                </el-button>
              </el-upload>
            </div>
            <el-button size="mini"
                       type="text"
                       @click="handleViewReport(scope.$index, scope.row,0)">查看
            </el-button>
          </template>
        </el-table-column>
        <el-table-column label="医疗器械生产许可证" width="190%" align="center">
          <template slot-scope="scope">
            <div v-if="roleId===5" style="display: inline-block">
              <el-upload
                ref="uploadFile"
                :show-file-list="false"
                :before-upload="beforeUpload"
                :on-success="onSuccess"
                :on-error="onError"
                :disabled="importDisabled"
                :data={id:scope.row.id,cell:1,flag:0}
                :action="uploadUrl"
                style="display: inline-block">
                <el-button size="mini" :disabled="importDisabled" type="text" class="color-import">
                  导入
                </el-button>
              </el-upload>
            </div>
            <el-button size="mini"
                       type="text"
                       @click="handleViewReport(scope.$index, scope.row,1)">查看
            </el-button>
          </template>
        </el-table-column>
        <el-table-column label="医疗器械注册证" width="190%" align="center">
          <template slot-scope="scope">
            <div v-if="roleId===5" style="display: inline-block">
              <el-upload
                ref="uploadFile"
                :show-file-list="false"
                :before-upload="beforeUpload"
                :on-success="onSuccess"
                :on-error="onError"
                :disabled="importDisabled"
                :data={id:scope.row.id,cell:2,flag:0}
                :action="uploadUrl"
                style="display: inline-block">
                <el-button size="mini" :disabled="importDisabled" type="text" class="color-import">
                  导入
                </el-button>
              </el-upload>
            </div>
            <el-button size="mini"
                       type="text"
                       @click="handleViewReport(scope.$index, scope.row, 2)">查看
            </el-button>
          </template>
        </el-table-column>
        <el-table-column label="说明书" width="190%" align="center">
          <template slot-scope="scope">
            <div v-if="roleId===5" style="display: inline-block">
              <el-upload
                ref="uploadFile"
                :show-file-list="false"
                :before-upload="beforeUpload"
                :on-success="onSuccess"
                :on-error="onError"
                :disabled="importDisabled"
                :data={id:scope.row.id,cell:3,flag:0}
                :action="uploadUrl"
                style="display: inline-block">
                <el-button size="mini" :disabled="importDisabled" type="text" class="color-import">
                  导入
                </el-button>
              </el-upload>
            </div>
            <el-button size="mini"
                       type="text"
                       @click="handleViewReport(scope.$index, scope.row, 3)">查看
            </el-button>
          </template>
        </el-table-column>
        <el-table-column label="彩页" width="190%" align="center">
          <template slot-scope="scope">
            <div v-if="roleId===5" style="display: inline-block">
              <el-upload
                ref="uploadFile"
                :show-file-list="false"
                :before-upload="beforeUpload"
                :on-success="onSuccess"
                :on-error="onError"
                :disabled="importDisabled"
                :data={id:scope.row.id,cell:4,flag:0}
                :action="uploadUrl"
                style="display: inline-block">
                <el-button size="mini" :disabled="importDisabled" type="text" class="color-import">
                  导入
                </el-button>
              </el-upload>
            </div>
            <el-button size="mini"
                       type="text"
                       @click="handleViewReport(scope.$index, scope.row,4)">查看
            </el-button>
          </template>
        </el-table-column>
        <el-table-column label="产品外盒" width="190%" align="center">
          <template slot-scope="scope">
            <div v-if="roleId===5" style="display: inline-block">
              <el-upload
                ref="uploadFile"
                :show-file-list="false"
                :before-upload="beforeUpload"
                :on-success="onSuccess"
                :on-error="onError"
                :disabled="importDisabled"
                :data={id:scope.row.id,cell:5,flag:0}
                :action="uploadUrl"
                style="display: inline-block">
                <el-button size="mini" :disabled="importDisabled" type="text" class="color-import">
                  导入
                </el-button>
              </el-upload>
            </div>
            <el-button size="mini"
                       type="text"
                       @click="handleViewReport(scope.$index, scope.row,5)">查看
            </el-button>
          </template>
        </el-table-column>
        <el-table-column label="其他" width="190%" align="center">
          <template slot-scope="scope">
            <div v-if="roleId===5" style="display: inline-block">
              <el-upload
                ref="uploadFile"
                :show-file-list="false"
                :before-upload="beforeUpload"
                :on-success="onSuccess"
                :on-error="onError"
                :disabled="importDisabled"
                :data={id:scope.row.id,cell:6,flag:0}
                :action="uploadUrl"
                style="display: inline-block">
                <el-button size="mini" :disabled="importDisabled" type="text" class="color-import">
                  导入
                </el-button>
              </el-upload>
            </div>
            <el-button size="mini"
                       type="text"
                       @click="handleViewReport(scope.$index, scope.row , 6 )">查看
            </el-button>
          </template>
        </el-table-column>
      </el-table>
    </div>
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
import {formatDate} from '@/utils/date';
import {getRole} from '@/api/order';
import {getReportPath, prodList} from '@/api/qualification';
import {getCookie} from '@/utils/support';
import {qualificationUploadUrl} from '@/settings';

const defaultListQuery = {
  pageNum: 1,
  pageSize: 50,
  keyword: null,
  row: null,
  column: null,
  username: getCookie("username"),
  supplierShortName: null,
  reagentName: null,
  flag: 0
};
export default {
  name: "copQualifiList",
  data() {
    return {
      pdfUrl: null,
      listQuery: Object.assign({}, defaultListQuery),
      loading: false,
      total: null,
      listLoading: false,
      dialogVisible: false,
      prodQualification: null,
      importDataIcon: 'el-icon-upload2',
      importDisabled: null,
      roleId: 0,
      uploadUrl: qualificationUploadUrl,
    }
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
      return formatDate(date, 'yyyy-MM-dd')
    }
  },
  methods: {
    handleResetSearch() {
      this.listQuery = Object.assign({}, defaultListQuery);
      this.listQuery.pageNum = 1;
      this.getList();
    },
    getRole() {
      getRole(this.listQuery.username).then(response => {
        this.roleId = response.data;
      });
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
    // pdf加载时
    handleViewReport(index, row, column) {
      this.listQuery.row = row.id;
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
    rowClassName({row, rowIndex}) {
      //把每一行的索引放进row.id
      row.newId = (this.listQuery.pageSize * (this.listQuery.pageNum - 1)) + rowIndex + 1;
    },
    handleSearchList() {
      this.listQuery.pageNum = 1;
      this.getList();
    },
    getList() {
      this.listLoading = true;
      prodList(this.listQuery).then(response => {
        this.listLoading = false;
        this.prodQualification = response.data.list;
        this.total = response.data.total;
      });
    },
  }
}
</script>
<style scoped>
.color-import {
  color: orange;
}
</style>
