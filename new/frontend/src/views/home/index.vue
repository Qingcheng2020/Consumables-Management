<template>
  <div class="app-container">
    <div class="address-layout">
      <el-row :gutter="20">
      </el-row>
    </div>
    <div class="total-layout">
      <el-row :gutter="20">
        <el-col :span="6">
          <div v-show="isOrder" class="total-frame1" @click="order()" style="cursor:pointer; " v-loading="loading">
            <img :src="img_home_order" class="total-icon">
            <div class="total-title">订单总数</div>
            <div class="total-value">{{ listQuery.orderCount }}</div>
            <div class="order-title">已配货:{{ listQuery.placeOrder }}</div>
            <div class="order-title">已完成:{{ listQuery.completed }}</div>
            <div class="order-title">待处理:{{ listQuery.pending }}</div>
          </div>
        </el-col>
        <el-col :span="6">
          <div v-show="isTrue" class="total-frame2" @click="stock()" style="cursor:pointer;" v-loading="loading">
            <img :src="img_home_stock_count" class="total-icon">
            <div class="total-title">库存总数</div>
            <div class="total-value">{{ listQuery.stockCount }}</div>
            <div class="money-title">金额</div>
            <div class="money-value">{{ listQuery.moneyCount }}万元</div>
          </div>
        </el-col>
        <el-col :span="6">
          <div v-show="isTrue" class="total-frame3" @click="lowStock()" style="cursor:pointer;" v-loading="loading">
            <img :src="img_home_low_stock" class="total-icon">
            <div class="total-title">低库存预警</div>
            <div class="total-value">{{ listQuery.lowStockCount }}</div>
          </div>
        </el-col>
        <el-col :span="6">
          <div v-show="isTrue" class="total-frame4" @click="overdueStock()" style="cursor:pointer;" v-loading="loading">
            <img :src="img_home_overdue_count" class="total-icon">
            <div class="total-title">过期预警</div>
            <div class="total-value">{{ listQuery.overdueCount }}</div>
          </div>
        </el-col>
      </el-row>
    </div>

    <div v-show="isTrue" class="overview-layout">
      <el-row :gutter="20">
        <el-col :span="12">
          <div class="out-border">
            <!--   耗材供货商分布总览饼图-->
            <div class="layout-title">耗材供货商分布总览</div>
            <div id="chartPie" style="width: auto;height: 300px" class="myChart" v-loading="loading">
            </div>
          </div>
        </el-col>
        <el-col :span="12">
          <div class="out-border">
            <!--   出库排行榜柱状图-->
            <div class="layout-title">耗材出库排行榜</div>
            <div id="chartBarTop" style="width: auto;height: 300px" class="myChart" v-loading="loading">
            </div>
          </div>
        </el-col>
      </el-row>
    </div>
    <div v-show="isTrue" class="overview-layout">
      <el-row :gutter="20">
        <el-col>
          <div class="out-border">
            <!--   耗材总览柱状图-->
            <div class="layout-title">耗材总览</div>
            <div id="chartBar" style="width: auto;height: 400px;" class="myChart" v-loading="loading">
            </div>
          </div>
        </el-col>
      </el-row>
    </div>
    <div v-show="isOrder" class="overview-layout">
      <el-row :gutter="20">
        <el-col>
          <div class="out-border">
            <!--   订单总览折线图-->
            <div class="layout-title">订单总览</div>
            <div id="lineChart" style="width: auto;height: 400px;" class="myChart" v-loading="loading">
            </div>
          </div>
        </el-col>
      </el-row>
    </div>
    <div class="tableTitle"></div>
    <div class='footer'>
      <span class="copyright"></span>
      <p class='smallFont'>
        <a href="https://beian.miit.gov.cn" target=”_blank”>
          鲁ICP备2021036636号</a>&nbsp;
        <a>服务电话4000539079</a>
      </p>
    </div>
  </div>

</template>
<style scoped>
.myChart {
  margin-top: 15px;
}
</style>

<script>
import img_home_order from '@/assets/images/home_order.png';
import img_home_low_stock from '@/assets/images/home_low_stock.png';
import img_home_overdue_count from '@/assets/images/home_overdue_count.png';
import img_home_stock_count from '@/assets/images/home_stock_count.png';
import {getChartBar, getChartBarTop, getChartLine, getChartPie, getCount, getHomeCount} from '@/api/count';
import {getCookie} from '@/utils/support';
import {getRole} from '@/api/order'
import * as echarts from "echarts";

const defaultListQuery = {
  orderCount: null,
  stockCount: null,
  moneyCount: null,
  placeOrder: null,
  completed: null,
  pending: null,
  lowStockCount: null,
  overdueCount: null,
  username: getCookie("username"),
};
export default {
  name: 'home',
  data() {
    return {
      isOrder: false,
      isTrue: false,
      roleId: 0,
      chartPie: '',
      typeName: [],//类型名称
      typeNum: [], //类型数量

      list: null,
      WarningList: null,
      listQuery: Object.assign({}, defaultListQuery),

      orderCountDate: '',
      chartSettings: {
        xAxisType: 'time',
        area: true,
        axisSite: {right: ['orderAmount']},
        labelMap: {'orderCount': '订单数量', 'orderAmount': '订单金额'}
      },
      chartData: {
        columns: [],
        rows: []
      },
      loading: true,
      dataEmpty: false,
      img_home_order,
      img_home_stock_count,
      img_home_low_stock,
      img_home_overdue_count

    }
  },

  created() {
    this.getRole();
  },
  methods: {
    getRole() {
      const that = this;
      getRole(this.listQuery.username).then(response => {
        this.roleId = response.data;
        if (this.roleId !== 3 && this.roleId !== 4 && this.roleId !== 9) {
          this.isOrder = true;
        }
        if (this.roleId !== 5) {
          this.isTrue = true;
        }

        getCount(this.listQuery).then(response => {
          this.list = response.data;
          this.listQuery.orderCount = this.list.orderCount;
          this.listQuery.stockCount = this.list.stockCount;
          this.listQuery.moneyCount = this.list.moneyCount;

          this.listQuery.placeOrder = this.list.placeOrder;
          this.listQuery.completed = this.list.completed;
          this.listQuery.pending = this.list.pending;

          that.drawCharts();
        });

        getHomeCount(this.listQuery).then(response => {
          this.WarningList = response.data;
          this.listQuery.lowStockCount = this.WarningList.lowStockCount;
          this.listQuery.overdueCount = this.WarningList.overdueCount;
          if (this.listQuery.lowStockCount != null && this.listQuery.overdueCount != null) {
            this.loading = false;
          }

          if (this.isTrue && this.listQuery.overdueCount * 1 > 0) {
            this.timer = window.setTimeout(() => {
              this.$notify({
                title: '提示',
                message: '存在达到过期预警耗材，请及时查看！',
                type: 'warning',
                position: 'bottom-right',
                // duration: 0
              });
            }, 0)
          }
          if (this.isTrue && this.listQuery.lowStockCount * 1 > 0) {
            this.timer = window.setTimeout(() => {
              this.$notify({
                title: '提示',
                message: '存在达到低库存预警耗材，请及时查看！',
                type: 'warning',
                position: 'bottom-right',
                // duration: 0
              });
            }, 0)
          }

        }).catch((e) => {
          this.$message({
            type: 'info',
            message: '请刷新重试!'
          });
        });

      })
    },
    lowStock() {
      if (this.roleId === 7 || this.roleId === 8 || this.roleId === 9) {
        //由于管理员7、8、9没有库存展示的权限，所以跳转页面会出现丢失
        this.$message({
          type: 'info',
          message: '没有查看权限!'
        });
      } else {
        this.$router.push({path: '/tms/lowStock'})
      }

    },
    overdueStock() {
      if (this.roleId === 7 || this.roleId === 8 || this.roleId === 9) {
        //由于管理员7、8、9没有库存展示的权限，所以跳转页面会出现丢失
        this.$message({
          type: 'info',
          message: '没有查看权限!'
        });
      } else {
        this.$router.push({path: '/tms/overdueStock'})
      }
    },
    order() {
      if (this.roleId === 7 || this.roleId === 8 || this.roleId === 9) {
        //由于管理员7、8、9没有库存展示的权限，所以跳转页面会出现丢失
        this.$message({
          type: 'info',
          message: '没有查看权限!'
        });
      } else {
        this.$router.push({path: '/oms/order'})
      }
    },
    stock() {
      if (this.roleId === 2 || this.roleId === 4) {
        this.$router.push({path: '/tms/stockCentre'})
      } else if (this.roleId === 3) {
        this.$router.push({path: '/tms/stockBranch'})
      } else if (this.roleId === 1 || this.roleId === 6) {
        this.$router.push({path: '/tms/stockCT'})
      } else if (this.roleId === 7 || this.roleId === 8 || this.roleId === 9) {
        //由于管理员7、8、9没有库存展示的权限，所以跳转页面会出现丢失
        this.$message({
          type: 'info',
          message: '没有查看权限!'
        });
      }
    },
    drawCharts() {
      this.drawBarChartTop();
      this.drawBarChart();
      this.drawPieChart();
      this.drawLineChart();
    },
    drawLineChart() {
      getChartLine(this.listQuery).then(response => {
        const getName = [];
        const getValue = [];
        //先进行赋值，数据获取
        for (let i = 0; i < response.data.length; i++) {
          getName[i] = response.data[i].name;
          getValue[i] = response.data[i].value;
        }
        this.lineChart = this.$echarts.init(document.getElementById("lineChart"));
        this.lineChart.setOption({
          //设置标题,副标题,以及标题位置居中
          title: {
            text: '最近一月订单统计图',
            //subtext: '纯属虚构',
            x: 'center'
          },
          //具体点击某一项触发的样式内容
          tooltip: {
            trigger: 'axis',
            formatter: "{a} <br/>{b} : {c} "
          },

          legend: {
            // data: ['测试1', '测试2', '测试3', '测试4'],
            data: [],
            left: 'right',
          },
          grid: {
            left: '3%',
            right: '4%',
            bottom: '3%',
            containLabel: true
          },
          xAxis: [
            {
              type: 'category',
              boundaryGap: false,
              data: getName
            }
          ],
          yAxis: [
            {
              type: 'value',
              axisLabel: {
                formatter: '{value} '
              },
              splitNumber: 10
            }
          ],

          series: [
            {
              name: '订单数量',
              type: 'line',
              data: getValue
            },
          ],
        });
      }).catch((e) => {
        //alert(e.name + ": " + e.message);
      });
    },
    drawPieChart() {
      getChartPie(this.listQuery).then(response => {
        const getData = [];
        //先进行赋值，数据获取
        for (let i = 0; i < response.data.length; i++) {
          const obj = {};
          obj.name = response.data[i].name;
          obj.value = response.data[i].value;
          getData[i] = obj;
        }
        //画
        this.chartPie = this.$echarts.init(document.getElementById("chartPie"));
        this.chartPie.setOption({
          //设置标题,副标题,以及标题位置居中
          title: {
            text: '耗材供货商统计图',
            //subtext: '纯属虚构',
            x: 'center'
          },
          //具体点击某一项触发的样式内容
          tooltip: {
            trigger: 'item',
            formatter: "{a} <br/>{b} : {c} ({d}%)"
          },
          //左上侧分类条形符
          legend: {
            orient: 'vertical',
            left: 'left',
            data: []
          },
          //饼状图类型以及数据源
          // color: ['#32dadd', '#b6a2de', '#5ab1ef'],
          series: [
            {
              name: '统计数量',
              type: 'pie',
              radius: '55%',
              center: ['50%', '60%'],
              data: getData,
              //设置饼状图扇形区域的样式
              emphasis: {
                itemStyle: {
                  shadowBlur: 10,
                  shadowOffsetX: 0,
                  //shadowColor: 'rgba(0,0,0,0.5)'
                  shadowColor: 'black'
                }
              }
            }
          ],

        });
      }).catch((e) => {
        //alert(e.name + ": " + e.message);
      });

    },
    drawBarChart() {
      getChartBar(this.listQuery).then(response => {
        const getName = [];
        const getValue = [];
        //先进行赋值，数据获取
        for (let i = 0; i < response.data.length; i++) {
          getName[i] = response.data[i].name;
          getValue[i] = response.data[i].value;
        }
        this.chartBar = this.$echarts.init(document.getElementById("chartBar"));
        this.chartBar.setOption({
          //设置标题,副标题,以及标题位置居中
          title: {
            text: '耗材统计图',
            //subtext: '纯属虚构',
            x: 'center'
          },
          //具体点击某一项触发的样式内容
          tooltip: {
            trigger: 'item',
            formatter: "{a} <br/>{b} : {c}"
          },
          //左上侧分类条形符
          legend: {
            orient: 'vertical',
            left: 'left',
            data: []
          },
          xAxis: [
            {
              type: 'category',
              data: getName,
              axisLabel: {
                //加入这段代码隐藏过长的文字,长度可以自己定义
                formatter: function (value) {
                  var res = value;
                  if (res.length > 5) {
                    res = res.substring(0, 3) + "..";
                  }
                  return res;
                }
              }
            }

          ],
          yAxis: [
            {
              type: 'value',
              axisLabel: {
                formatter: '{value} '
              },
              splitNumber: 10
            }
          ],
          //住状图类型以及数据源
          series: [
            {
              name: '库存数量',
              type: 'bar',
              data: getValue,
              //radius: '70%',
              //center: ['50%', '60%'],
              //设置饼状图扇形区域的样式
              itemStyle: {
                emphasis: {
                  shadowBlur: 10,
                  shadowOffsetX: 0,
                  shadowColor: 'rgba(0, 0, 0, 0.5)'
                },
                normal: {
                  color: new echarts.graphic.LinearGradient(0, 0, 1, 0, [
                    {offset: 0, color: "#3977E6"},
                    {offset: 1, color: "#37BBF8"},
                  ]),
                },
              },
            }
          ],

        });
      }).catch((e) => {
        //alert(e.name + ": " + e.message);
      });
    },
    drawBarChartTop() {
      getChartBarTop(this.listQuery).then(response => {
        const getName = [];
        const getValue = [];
        //先进行赋值，数据获取
        for (let i = 0; i < response.data.length; i++) {
          getName[i] = response.data[i].name;
          getValue[i] = response.data[i].value;
        }

        this.chartBar = this.$echarts.init(document.getElementById("chartBarTop"));
        this.chartBar.setOption({
          title: {
            text: '耗材出库排行榜Top5',
            x: 'center'
          },
          tooltip: {
            trigger: "item",
            // axisPointer: {
            //   type: "shadow",
            // },
          },
          grid: {
            left: "5%",
            containLabel: true,
          },
          xAxis: {
            type: "value",
            axisLine: {
              show: false,
            },
            axisTick: {
              show: false,
            },
            splitLine: {show: false},
            axisLabel: {show: false},
          },
          yAxis: {
            type: "category",
            data: getName,
            inverse: true,
            axisLabel: {
              //加入这段代码隐藏过长的文字,长度可以自己定义
              formatter: function (value) {
                let res = value;
                if (res.length > 5) {
                  res = res.substring(0, 5) + "..";
                }
                return res;
              }
            },
            splitLine: {show: false},
            axisLine: {
              show: false,
            },
            axisTick: {
              show: false,
            },
            offset: 10,
            nameTextStyle: {
              fontSize: 10,
            },
          },
          series: [
            {
              name: "出库数量",
              type: "bar",
              data: getValue,
              barWidth: 15,
              barGap: 5,
              smooth: true,
              label: {
                normal: {
                  show: true,
                  position: "right",
                  offset: [5, -2],
                  textStyle: {
                    color: "#333",
                    fontSize: 13,
                  },
                },
              },

              itemStyle: {
                emphasis: {
                  shadowBlur: 10,
                  shadowOffsetX: 0,
                  shadowColor: 'rgba(0, 0, 0, 0.5)'
                },
                normal: {
                  barBorderRadius: 7,
                  color: new echarts.graphic.LinearGradient(0, 0, 1, 0, [
                    {offset: 0, color: "#3977E6"},
                    {offset: 1, color: "#37BBF8"},
                  ]),
                },
              },
            },
          ],
        });
      }).catch((e) => {
        //alert(e.name + ": " + e.message);
      });
    },

    /*    numberCount() {
          getCount(this.listQuery).then(response => {
            this.list = response.data;
            this.listQuery.orderCount = this.list.orderCount;
            this.listQuery.stockCount = this.list.stockCount;
            this.listQuery.lowStockCount = this.list.lowStockCount;
            this.listQuery.overdueCount = this.list.overdueCount;
            if (this.listQuery.lowStockCount != null && this.listQuery.overdueCount != null) {
              this.loading = false;
            }
          }).catch((e) => {
            this.$message({
              type: 'info',
              message: '请刷新重试!'
            });
          });
          return new Promise(resolve => {
            setTimeout(() => resolve(this.listQuery), 1000);
          });
        },*/
    /*    initOrderCountDate() {
          let start = new Date();
          start.setFullYear(2018);
          start.setMonth(10);
          start.setDate(1);
          const end = new Date();
          end.setTime(start.getTime() + 1000 * 60 * 60 * 24 * 7);
          this.orderCountDate = [start, end];
        },*/
    /*    async warningOverdue() {
          const isTrue = await this.getRole();
          await this.numberCount();
          if (isTrue && this.listQuery.overdueCount * 1 > 0) {
            this.timer = window.setTimeout(() => {
              this.$notify({
                title: '提示',
                message: '存在达到过期预警耗材，请及时查看！',
                type: 'warning',
                position: 'bottom-right',
                // duration: 0
              });
            }, 0)
          }
          if (isTrue && this.listQuery.lowStockCount * 1 > 0) {
            this.timer = window.setTimeout(() => {
              this.$notify({
                title: '提示',
                message: '存在达到低库存预警耗材，请及时查看！',
                type: 'warning',
                position: 'bottom-right',
                // duration: 0
              });
            }, 0)
          }
        },*/
  }
}
</script>

<style scoped>
.tableTitle {
  position: relative;
  margin-top: 30px;
  width: auto;
  height: 1px;
  background-color: #d4d4d4;
  text-align: center;
  font-size: 16px;
  color: rgba(101, 101, 101, 1);
}

.footer {
  height: 80px;

  font-size: 16px;
  padding: 20px 10px;
  position: relative;
}

.copyright {
  font-size: 16px;
}

.smallFont {
  font-size: 14px;
  color: #72767b;
  line-height: 25px;
}

body {
  margin: 0;
}

.chart-container {
  width: 100%;
  float: left;
}

.app-container {
  margin-top: 40px;
  margin-left: 120px;
  margin-right: 120px;
}

.address-layout {
}

.total-layout {
  margin-top: 20px;
}

.total-frame1 {
  border: 1px solid #DCDFE6;
  padding: 20px;
  height: 100px;
  background-color: #4e72b8;
  border-radius: 5px;
}

.total-frame2 {
  border: 1px solid #DCDFE6;
  padding: 20px;
  height: 100px;
  background-color: #19CAAD;
  border-radius: 5px;
}

.total-frame3 {
  border: 1px solid #DCDFE6;
  padding: 20px;
  height: 100px;
  background-color: #FF9900;
  border-radius: 5px;
}

.total-frame4 {
  border: 1px solid #DCDFE6;
  padding: 20px;
  height: 100px;
  background-color: #eb6101;
  border-radius: 5px;
}

.total-icon {
  color: #FFFFFF;
  width: 60px;
  height: 60px;
}

.total-title {
  position: relative;
  font-size: 16px;
  color: #FFFFFF;
  left: 70px;
  top: -50px;
}

.total-value {
  position: relative;
  font-size: 18px;
  color: #FFFFFF;
  left: 70px;
  top: -40px;
}

.order-title {
  position: relative;
  font-size: 16px;
  color: #FFFFFF;
  left: 170px;
  top: -90px;
}

.money-title {
  position: relative;
  font-size: 16px;
  color: #FFFFFF;
  left: 170px;
  top: -87px;
}

.money-value {
  position: relative;
  font-size: 18px;
  color: #FFFFFF;
  left: 170px;
  top: -77px;
}

.un-handle-layout {
  margin-top: 20px;
  border: 1px solid #DCDFE6;
}

.layout-title {
  color: #606266;
  padding: 15px 20px;
  background: #F2F6FC;
  font-weight: bold;
}

.un-handle-content {
  padding: 20px 40px;
}

.un-handle-item {
  border-bottom: 1px solid #EBEEF5;
  padding: 10px;
}

.overview-layout {
  margin-top: 20px;
}

.overview-item-value {
  font-size: 24px;
  text-align: center;
}

.overview-item-title {
  margin-top: 10px;
  text-align: center;
}

.out-border {
  border: 1px solid #DCDFE6;
}

.statistics-layout {
  margin-top: 20px;
  border: 1px solid #DCDFE6;
}

.mine-layout {
  position: absolute;
  right: 140px;
  top: 107px;
  width: 250px;
  height: 235px;
}

.address-content {
  padding: 20px;
  font-size: 18px
}
</style>
