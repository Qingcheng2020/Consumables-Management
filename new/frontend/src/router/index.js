import Vue from 'vue'
import Router from 'vue-router'
/* Layout */
import Layout from '../views/layout/Layout'

/* AppMain */
import AppMain from '../views/layout/components/AppMain'

Vue.use(Router)

/**
 * hidden: true                   if `hidden:true` will not show in the sidebar(default is false)
 * alwaysShow: true               if set true, will always show the root menu, whatever its child routes length
 *                                if not set alwaysShow, only more than one route under the children
 *                                it will becomes nested mode, otherwise not show the root menu
 * redirect: noredirect           if `redirect:noredirect` will no redirct in the breadcrumb
 * name:'router-name'             the name is used by <keep-alive> (must set!!!)
 * meta : {
    title: 'title'               the name show in submenu and breadcrumb (recommend set)
    icon: 'svg-name'             the icon show in the sidebar,
  }
 **/
export const constantRouterMap = [
  {path: '/login', component: () => import('@/views/login/index'), hidden: true},
  {path: '/404', component: () => import('@/views/404'), hidden: true},
  {
    path: '',
    component: Layout,
    redirect: '/home',
    children: [{
      path: 'home',
      name: 'home',
      component: () => import('@/views/home/index'),
      meta: {title: '首页', icon: 'home'}
    }]
  }
]

export const asyncRouterMap = [
  {
    path: '/oms',
    component: Layout,
    redirect: 'noredirect',
    name: 'oms',
    alwaysShow: true,
    meta: {title: '订单管理', icon: 'order'},
    children: [
      {
        path: 'order',
        name: 'order',
        component: () => import('@/views/oms/order/index'),
        meta: {title: '订单列表', icon: 'product-list'}
      },
      {
        path: 'orderDetail',
        name: 'orderDetail',
        component: () => import('@/views/oms/order/orderDetail'),
        meta: {title: '订单详情'},
        hidden: true
      },
      {
        path: 'placeOrder',
        name: 'placeOrder',
        component: () => import('@/views/oms/order/placeOrder'),
        meta: {title: '耗材下单', icon: 'place-order'}
      },
      {
        path: 'preInBill',
        name: 'preInBill',
        component: () => import('@/views/oms/preInBill/index'),
        meta: {title: '随货同行单列表', icon: 'oms-preInBill'}
      },
      /*      {
              path: 'qrcode',
              name: 'qrcode',
              component: () => import('@/views/oms/preInBill/qrcode'),
              meta: {title: '二维码', icon: 'oms-qrcode'}
            },*/
      {
        path: 'preInDetail',
        name: 'preInDetail',
        component: () => import('@/views/oms/preInBill/preInDetail'),
        meta: {title: '随货同行单详情'},
        hidden: true
      },
      {
        path: 'preInItem',
        name: 'preInItem',
        component: () => import('@/views/oms/preInBill/preInItem'),
        meta: {title: '随货同行单明细'},
        hidden: true
      },
      {
        path: 'preInBillAdd',
        name: 'preInBillAdd',
        component: () => import('@/views/oms/preInBill/preInBillAdd'),
        meta: {title: '随货同行单新增', icon: 'oms-preInBillAdd'},
        hidden: true
      },
    ]
  },
  {
    path: '/tms',
    component: Layout,
    redirect: 'noredirect',
    name: 'tms',
    alwaysShow: true,
    meta: {title: '库存管理', icon: 'tms'},
    children: [
      {
        path: 'stockCentre',
        name: 'stockCentre',
        component: () => import('@/views/tms/stockCentre/index'),
        meta: {title: '中心库存列表', icon: 'tms-stockCentre'}
      },
      {
        path: 'stockCT',
        name: 'stockCT',
        component: () => import('@/views/tms/stockCentre/stockCT'),
        meta: {title: '二级中心库存列表', icon: 'tms-stockCT'}
      },
      {
        path: 'stockBranch',
        name: 'stockBranch',
        component: () => import('@/views/tms/stockBranch/index'),
        meta: {title: '科室库存列表', icon: 'tms-stockBranch'}
      },
      {
        path: 'stockDetail',
        name: 'stockDetail',
        component: () => import('@/views/tms/stockCentre/stockDetail'),
        meta: {title: '库存详情'},
        hidden: true
      },
      {
        path: 'lowStock',
        name: 'lowStock',
        component: () => import('@/views/tms/stockCentre/lowStock'),
        meta: {title: '低库存预警详情'},
        hidden: true
      },
      {
        path: 'overdueStock',
        name: 'overdueStock',
        component: () => import('@/views/tms/stockCentre/overdueStock'),
        meta: {title: '过期库存预警详情'},
        hidden: true
      },

      {
        path: 'lossSummary',
        name: 'lossSummary',
        component: () => import('@/views/tms/stockLoss/lossSummary'),
        meta: {title: '库损汇总', icon: 'tms-lossSummary'}
      },
      {
        path: 'stockLoss',
        name: 'stockLoss',
        component: () => import('@/views/tms/stockLoss/index'),
        meta: {title: '库损列表'},
        hidden: true
      },
      {
        path: 'search',
        name: 'search',
        component: () => import('@/views/tms/search/index'),
        meta: {title: '检索', icon: 'tms-search'}
      },
    ]
  },
  {
    path: '/wms',
    component: Layout,
    redirect: 'noredirect',
    name: 'wms',
    alwaysShow: true,
    meta: {title: '入库管理', icon: 'wms'},
    children: [
      {
        path: 'inBillOC',
        name: 'inBillOC',
        component: () => import('@/views/wms/centreIn/inBillOC'),
        meta: {title: '科室库-单级入库', icon: 'wms-centreOIn'}
      },
      {
        path: 'inSummary',
        name: 'inSummary',
        component: () => import('@/views/wms/centreIn/inSummary'),
        meta: {title: '时段耗材入库汇总', icon: 'wms-inSummary'}
      },
      {
        path: 'inBillTC',
        name: 'inBillTC',
        component: () => import('@/views/wms/centreIn/inBillTC'),
        meta: {title: '中心库入库', icon: 'wms-centreTIn'}
      },
      {
        path: 'branchIn',
        name: 'branchIn',
        component: () => import('@/views/wms/branchIn/index'),
        meta: {title: '科室库入库', icon: 'wms-branchIn'}
      },
      {
        path: 'createInBillOC',
        name: 'createInBillOC',
        component: () => import('@/views/wms/centreIn/createInBillOC'),
        meta: {title: '建码入库-单级库', icon: 'wms-createInBillOC'}
      },
      {
        path: 'createInBillTC',
        name: 'createInBillTC',
        component: () => import('@/views/wms/centreIn/createInBillTC'),
        meta: {title: '建码入库-两级库', icon: 'wms-createInBillTC'}
      },
      {
        path: 'scanInBillOC',
        name: 'scanInBillOC',
        component: () => import('@/views/wms/centreIn/scanInBillOC'),
        meta: {title: '扫码入库-单级库', icon: 'wms-scanInBillOC'},
        hidden: true
      },
      {
        path: 'scanInBillTC',
        name: 'scanInBillTC',
        component: () => import('@/views/wms/centreIn/scanInBillTC'),
        meta: {title: '扫码入库-两级库', icon: 'wms-scanInBillTC'},
        hidden: true
      },
      {
        path: 'inBillDetail',
        name: 'inBillDetail',
        component: () => import('@/views/wms/centreIn/inBillDetail'),
        meta: {title: '入库详情'},
        hidden: true
      },
      {
        path: 'inBillItem',
        name: 'inBillItem',
        component: () => import('@/views/wms/centreIn/inBillItem'),
        meta: {title: '入库明细'},
        hidden: true
      },
    ]
  },
  {
    path: '/dms',
    component: Layout,
    redirect: 'noredirect',
    name: 'dms',
    alwaysShow: true,
    meta: {title: '出库管理', icon: 'dms'},
    children: [{
      path: 'centreOut',
      name: 'centreOut',
      component: () => import('@/views/dms/centreOut/index'),
      meta: {title: '一级中心库出库', icon: 'dms-centreOut'}
    },
      {
        path: 'branchOut',
        name: 'branchOut',
        component: () => import('@/views/dms/branchOut/index'),
        meta: {title: '科室库出库', icon: 'dms-branchOut'}
      },
      {
        path: 'outSummary',
        name: 'outSummary',
        component: () => import('@/views/dms/centreOut/outSummary'),
        meta: {title: '时段耗材出库汇总', icon: 'dms-outSummary'}
      },
      {
        path: 'centreOutT',
        name: 'centreOutT',
        component: () => import('@/views/dms/centreOut/outBillT'),
        meta: {title: '二级中心库出库', icon: 'dms-centreOutT'}
      },

      {
        path: 'outDetail',
        name: 'outDetail',
        component: () => import('@/views/dms/centreOut/outDetail'),
        meta: {title: '出库详情'},
        hidden: true
      },
      {
        path: 'outItem',
        name: 'outItem',
        component: () => import('@/views/dms/centreOut/outItem'),
        meta: {title: '出库明细'},
        hidden: true
      },
    ]
  },
  {
    path: '/rms',
    component: Layout,
    redirect: 'noredirect',
    name: 'rms',
    alwaysShow: true,
    meta: {title: '退货管理', icon: 'rms'},
    children: [
      {
        path: 'refundOC',
        name: 'refundOC',
        component: () => import('@/views/rms/refund/refundOC'),
        meta: {title: '一级中心库退货', icon: 'rms-refundOC'}
      },
      {
        path: 'refundOCAdd',
        name: 'refundOCAdd',
        component: () => import('@/views/rms/refund/refundOCAdd'),
        meta: {title: '一级中心库退货申请', icon: 'rms-refundOCAdd'}
      },
      {
        path: 'refundTC',
        name: 'refundTC',
        component: () => import('@/views/rms/refund/refundTC'),
        meta: {title: '二级中心库退货', icon: 'rms-refundTC'}
      },
      {
        path: 'refundTCAdd',
        name: 'refundTCAdd',
        component: () => import('@/views/rms/refund/refundTCAdd'),
        meta: {title: '二级中心库退货申请', icon: 'rms-refundTCAdd'}
      },
      {
        path: 'refundTB',
        name: 'refundTB',
        component: () => import('@/views/rms/refund/refundTB'),
        meta: {title: '二级科室库退货', icon: 'rms-refundTB'}
      },
      /*{
        path: 'refundTBAdd',
        name: 'refundTBAdd',
        component: () => import('@/views/rms/refund/refundTBAdd'),
        meta: {title: '二级科室库退货申请', icon: 'rms-refundTBAdd'}
      },*/
      {
        path: 'refundDetail',
        name: 'refundDetail',
        component: () => import('@/views/rms/refund/refundDetail'),
        meta: {title: '退货详情'},
        hidden: true
      },
      {
        path: 'refundItem',
        name: 'refundItem',
        component: () => import('@/views/rms/refund/refundItem'),
        meta: {title: '退货明细'},
        hidden: true
      },
    ]
  },
  {
    path: '/cms',
    component: Layout,
    redirect: 'noredirect',
    name: 'cms',
    alwaysShow: true,
    meta: {title: '移库管理', icon: 'cms'},
    children: [
      {
        path: 'collectLT',
        name: 'collectLT',
        component: () => import('@/views/cms/collect/collectLT'),
        meta: {title: '领用列表', icon: 'collectLT-list'}
      },
      {
        path: 'collectLTAdd',
        name: 'collectLTAdd',
        component: () => import('@/views/cms/collect/collectLTAdd'),
        meta: {title: '领用申请', icon: 'collectLT-add'}
      },
      {
        path: 'collectLO',
        name: 'collectLO',
        component: () => import('@/views/cms/collect/collectLO'),
        meta: {title: '领用列表', icon: 'collectLO-list'}
      },
      {
        path: 'collectDetail',
        name: 'collectDetail',
        component: () => import('@/views/cms/collect/collectDetail'),
        meta: {title: '领用详情'},
        hidden: true
      },
      {
        path: 'collectLOAdd',
        name: 'collectLOAdd',
        component: () => import('@/views/cms/collect/collectLOAdd'),
        meta: {title: '领用申请', icon: 'collectLO-add'}
      },
      {
        path: 'relocation',
        name: 'relocation',
        component: () => import('@/views/cms/relocation/index'),
        meta: {title: '移库列表', icon: 'relocation-list'}
      },
      {
        path: 'relocationDetail',
        name: 'relocationDetail',
        component: () => import('@/views/cms/relocation/relocationDetail'),
        meta: {title: '移库详情'},
        hidden: true
      },
      {
        path: 'relocationAdd',
        name: 'relocationAdd',
        component: () => import('@/views/cms/relocation/relocationAdd'),
        meta: {title: '移库申请', icon: 'relocation-add'}
      },
      // {
      //   path: 'centreOut',
      //   name: 'centreOut',
      //   component: () => import('@/views/dms/centreOut/index'),
      //   meta: {title: '一级中心库出库', icon: 'dms-centreOut'}
      // },
      // {
      //   path: 'branchOut',
      //   name: 'branchOut',
      //   component: () => import('@/views/dms/branchOut/index'),
      //   meta: {title: '科室库出库', icon: 'dms-branchOut'}
      // },
      // {
      //   path: 'centreOutT',
      //   name: 'centreOutT',
      //   component: () => import('@/views/dms/centreOut/outBillT'),
      //   meta: {title: '二级中心库出库', icon: 'dms-centreOutT'}
      // },
      //
      // {
      //   path: 'outDetail',
      //   name: 'outDetail',
      //   component: () => import('@/views/dms/centreOut/outDetail'),
      //   meta: {title: '出库详情'},
      //   hidden: true
      // },
      // {
      //   path: 'outItem',
      //   name: 'outItem',
      //   component: () => import('@/views/dms/centreOut/outItem'),
      //   meta: {title: '出库明细'},
      //   hidden: true
      // },
    ]
  },
  {
    path: '/bms',
    component: Layout,
    redirect: 'noredirect',
    name: 'bms',
    alwaysShow: true,
    meta: {title: '报表管理', icon: 'bms'},
    children: [
      {
        path: 'refundOCR',
        name: 'refundOCR',
        component: () => import('@/views/bms/refund/refundOCR'),
        meta: {title: '一级中心库退货', icon: 'bms-refundOCR'}
      },
      {
        path: 'refundTCR',
        name: 'refundTCR',
        component: () => import('@/views/bms/refund/refundTCR'),
        meta: {title: '二级中心库退货', icon: 'bms-refundTCR'}
      },
      {
        path: 'refundTBR',
        name: 'refundTBR',
        component: () => import('@/views/bms/refund/refundTBR'),
        meta: {title: '二级科室库退货', icon: 'bms-refundTBR'}
      },
      {
        path: 'countLoss',
        name: 'countLoss',
        component: () => import('@/views/bms/countLoss'),
        meta: {title: '库损报表', icon: 'bms-countLoss'}
      },
      {
        path: 'countOutIn',
        name: 'countOutIn',
        component: () => import('@/views/bms/countOutIn'),
        meta: {title: '出入库报表', icon: 'bms-countOutIn'}
      },
      {
        path: 'reagentOutIn',
        name: 'reagentOutIn',
        component: () => import('@/views/bms/reagentOutIn'),
        meta: {title: '时段耗材出入库报表', icon: 'bms-reagentOutIn'}
      },
      {
        path: 'reagentOverall',
        name: 'reagentOverall',
        component: () => import('@/views/bms/reagentOverall'),
        meta: {title: '耗材总库存', icon: 'bms-reagentOverall'}
      },
      {
        path: 'reagentUseLog',
        name: 'reagentUseLog',
        component: () => import('@/views/bms/reagentUseLog'),
        meta: {title: '耗材使用记录报表', icon: 'bms-reagentUseLog'}
      },
      {
        path: 'countCollect',
        name: 'countCollect',
        component: () => import('@/views/bms/countCollect'),
        meta: {title: '组别领用报表', icon: 'bms-countCollect'}
      },
    ]

  },
  {
    path: '/qms',
    component: Layout,
    redirect: 'noredirect',
    name: 'qms',
    alwaysShow: true,
    meta: {title: '资质管理', icon: 'qms'},
    children: [
      {
        path: 'copQualification',
        name: 'copQualification',
        component: () => import('@/views/qms/copQualification'),
        meta: {title: '公司资质', icon: 'qms-copQualification'}
      },
      {
        path: 'prodQualification',
        name: 'prodQualification',
        component: () => import('@/views/qms/prodQualification'),
        meta: {title: '产品资质', icon: 'qms-prodQualification'}
      },
    ]
  },
  {
    path: '/ums',
    component: Layout,
    redirect: 'noredirect',
    name: 'ums',
    alwaysShow: true,
    meta: {title: '系统管理', icon: 'ums'},
    children: [
      {
        path: 'admin',
        name: 'admin',
        component: () => import('@/views/ums/admin/index'),
        meta: {title: '用户管理', icon: 'ums-admin'}
      },
      {
        path: 'role',
        name: 'role',
        component: () => import('@/views/ums/role/index'),
        meta: {title: '角色管理', icon: 'ums-role'}
      },
      {
        path: 'branch',
        name: 'branch',
        component: () => import('@/views/ums/branch/index'),
        meta: {title: '科室管理', icon: 'ums-branch'}
      },
      {
        path: 'supplier',
        name: 'supplier',
        component: () => import('@/views/ums/supplier/index'),
        meta: {title: '供货商管理', icon: 'ums-supplier'}
      },
      {
        path: 'baseInfo',
        name: 'baseInfo',
        component: () => import('@/views/ums/baseInfo/index'),
        meta: {title: '耗材基础管理', icon: 'ums-baseInfo'}
      },
      {
        path: 'device',
        name: 'device',
        component: () => import('@/views/ums/device/index'),
        meta: {title: '设备管理', icon: 'ums-device'}
      },
      {
        path: '/log',
        redirect: '/ums/log/loginLog',
        name: 'log',
        meta: {title: '日志管理', icon: 'ums-log'},
        component: AppMain,
        children: [
          {
            path: 'operationLog',
            name: 'operationLog',
            component: () => import('@/views/ums/log/operationLog'),
            meta: {title: '操作日志', icon: 'log-operationLog'}
          },
          {
            path: 'loginLog',
            name: 'loginLog',
            component: () => import('@/views/ums/log/loginLog'),
            meta: {title: '登录日志', icon: 'log-loginLog'}
          },
        ]
      },

      {
        path: 'allocMenu',
        name: 'allocMenu',
        component: () => import('@/views/ums/role/allocMenu'),
        meta: {title: '分配菜单'},
        hidden: true
      },
      {
        path: 'allocResource',
        name: 'allocResource',
        component: () => import('@/views/ums/role/allocResource'),
        meta: {title: '分配资源'},
        hidden: true
      },
      /*      {
              path: 'menu',
              name: 'menu',
              component: () => import('@/views/ums/menu/index'),
              meta: {title: '菜单列表', icon: 'ums-menu'}
            },*/
      {
        path: 'addMenu',
        name: 'addMenu',
        component: () => import('@/views/ums/menu/add'),
        meta: {title: '添加菜单'},
        hidden: true
      },
      {
        path: 'updateMenu',
        name: 'updateMenu',
        component: () => import('@/views/ums/menu/update'),
        meta: {title: '修改菜单'},
        hidden: true
      },
      {
        path: 'resource',
        name: 'resource',
        component: () => import('@/views/ums/resource/index'),
        meta: {title: '资源列表', icon: 'ums-resource'}
      },
      {
        path: 'resourceCategory',
        name: 'resourceCategory',
        component: () => import('@/views/ums/resource/categoryList'),
        meta: {title: '资源分类'},
        hidden: true
      }
    ]
  },

  {path: '*', redirect: '/404', hidden: true}
]

export default new Router({
  // mode: 'history', //后端支持可开
  scrollBehavior: () => ({y: 0}),
  routes: constantRouterMap
})

