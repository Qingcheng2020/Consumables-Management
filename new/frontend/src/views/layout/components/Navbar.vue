<template>
  <div>

    <el-menu class="navbar" mode="horizontal">
      <hamburger class="hamburger-container" :toggleClick="toggleSideBar" :isActive="sidebar.opened"></hamburger>
      <div>耗材精细化管理平台 (临沂市河东区妇幼保健院)

        <div class="username">
          <span>{{ trueName }}({{ roleName }})</span>
        </div>
        <el-dropdown class="avatar-container" trigger="click">

          <div class="avatar-wrapper">
            <img class="user-avatar" :src="imgUrl">
            <i class="el-icon-caret-bottom"></i>
          </div>

          <el-dropdown-menu class="user-dropdown" slot="dropdown">
            <router-link class="inlineBlock" to="/">
              <el-dropdown-item>
                首页
              </el-dropdown-item>
            </router-link>
            <el-dropdown-item divided>
              <span @click="logout" style="display:block;">退出</span>
            </el-dropdown-item>
            <el-dropdown-item divided>
              <span @click="update" style="display:block;">修改密码</span>
            </el-dropdown-item>
          </el-dropdown-menu>

        </el-dropdown>
      </div>
    </el-menu>

    <breadcrumb></breadcrumb>
    <div style="border-bottom: 1px solid #e6e6e6"></div>

    <el-dialog
      :title="'修改用户密码'"
      :visible.sync="dialogVisible"
      width="40%">
      <el-form :model="adminForm"
               :rules="adminRules"
               ref="adminForm"
               label-width="150px" size="small">
        <el-form-item label="用户名：" prop="username">
          <el-input v-model="trueName" style="width: 250px" :disabled="true"></el-input>
        </el-form-item>

        <el-form-item label="原密码：" prop="password">
          <el-input v-model="adminForm.password" type="password" style="width: 250px"></el-input>
        </el-form-item>
        <el-form-item label="新密码：" prop="newPassword">
          <el-input v-model="adminForm.newPassword" type="password" style="width: 250px"></el-input>
        </el-form-item>
        <el-form-item label="新密码确认：" prop="confirmPwd">
          <el-input v-model="adminForm.confirmPwd" type="password" style="width: 250px"></el-input>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible = false" size="small">取 消</el-button>
        <el-button type="primary" @click="handleDialogConfirm()" size="small">确 定</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
import {mapGetters} from 'vuex'
import Breadcrumb from '@/components/Breadcrumb'
import Hamburger from '@/components/Hamburger'
import imgSrc from '../../../icons/svg/ums-admin.svg'
import {getCookie} from '@/utils/support';
import {getTrueName, updatePassword} from '@/api/login';
import {getRole} from '@/api/order';

const defaultAdminForm = {
  username: getCookie("username"),
  password: '',
  newPassword: '',
  confirmPwd: "",
  trueName: '',
};
export default {
  data() {
    const validatePass = (rule, value, callback) => {
      const pwdReg = /^(?=.*\d)(?=.*[a-zA-Z]).{6,}$/;
      if (!value) {
        return callback(new Error("请输入密码"));
      } else if (pwdReg.test(value)) {
        callback();
      } else {
        callback(new Error("请输入包含数字字母的不低于6位数的密码"));
      }
    };
    const validatePass2 = (rule, value, callback) => {
      if (!value) {
        callback(new Error("请再次输入密码"));
      } else if (value !== this.adminForm.newPassword) {
        callback(new Error("两次输入密码不一致!"));
      } else {
        callback();
      }
    };
    return {
      adminRules: {
        password: [
          {required: true, validator: validatePass, trigger: "blur"},
        ],
        newPassword: [
          {required: true, validator: validatePass, trigger: "blur"},
        ],
        confirmPwd: [
          {required: true, validator: validatePass2, trigger: "blur"},
        ],
      },
      adminForm: Object.assign({}, defaultAdminForm),
      dialogVisible: false,
      imgUrl: imgSrc,
      trueName: null,
      roleId: 0,
      roleName: "默认"
    }
  },
  components: {
    Breadcrumb,
    Hamburger
  },
  computed: {
    ...mapGetters([
      'sidebar',
      'avatar'
    ])
  },
  created() {
    this.getTrueName();
    this.getRole();
  },
  methods: {
    getRole() {
      getRole(getCookie("username")).then(response => {
        this.roleId = response.data;
        switch (this.roleId) {
          case 1:
            this.roleName = "超管";
            break;
          case 2:
            this.roleName = "科室库管";
            break;
          case 3:
            this.roleName = "科室库管";
            break;
          case 4:
            this.roleName = "操作员";
            break;
          case 5:
            this.roleName = "供货商";
            break;
          case 6:
            this.roleName = "中心库管";
            break;
          case 7:
            this.roleName = "管理员";
            break;
          case 8:
            this.roleName = "管理员";
            break;
          case 9:
            this.roleName = "操作员";
            break;
          default:
            this.roleName = "默认";
        }
      })
    },
    handleDialogConfirm() {
      this.$refs.adminForm.validate(valid => {
        if (valid) {
          let uname = getCookie("username");
          let sendData = {
            username: uname,
            oldPassword: this.adminForm.password,
            newPassword: this.adminForm.newPassword,
          }
          updatePassword(sendData).then(response => {
            this.$message({
              message: '修改成功！',
              type: 'success'
            });
            this.dialogVisible = false;

            setTimeout(() => {
              if (this.$store.getters.token) {
                this.$store.dispatch('FedLogOut').then(() => {
                  this.$alert('密码已修改，请重新登录。', '提示', {
                    confirmButtonText: '确定'
                  }).then(() => {
                    location.reload()
                  })
                })
              }
            }, 1000);
          })
        } else {
          console.log('参数验证不合法！');
          this.$message({
            message: '操作失败！',
            type: 'warning'
          });
          return false
        }
      })
    },
    toggleSideBar() {
      this.$store.dispatch('ToggleSideBar')
    },
    logout() {
      //clearCookie("username");
      this.$store.dispatch('LogOut').then(() => {
        location.reload() // 为了重新实例化vue-router对象 避免bug
      })
    },
    update() {
      this.dialogVisible = true;
    },
    getTrueName() {
      const user = getCookie("username");
      getTrueName(user).then(res => {
        this.trueName = res.data[0].trueName;
      })
    }

  }
}
</script>

<style rel="stylesheet/scss" lang="scss" scoped>
.username {
  width: 180px;
  height: 50px;
  font-size: 20px;
  margin-right: 80px;
  text-align: right;
  padding-right: 10px;
  float: right;

}

.navbar {
  height: 50px;
  line-height: 50px;
  border-radius: 0px !important;
  background: #ebeef5;

  .hamburger-container {
    line-height: 58px;
    height: 50px;
    float: left;
    padding: 0 10px;
  }

  .screenfull {
    position: absolute;
    right: 90px;
    top: 16px;
    color: #ff0000;
  }

  .avatar-container {
    height: 50px;
    display: inline-block;
    position: absolute;
    right: 35px;

    .avatar-wrapper {
      cursor: pointer;
      margin-top: 5px;
      position: relative;

      .user-avatar {
        width: 40px;
        height: 40px;
        border-radius: 10px;
      }

      .el-icon-caret-bottom {
        position: absolute;
        right: -20px;
        top: 25px;
        font-size: 12px;
      }
    }
  }
}
</style>

