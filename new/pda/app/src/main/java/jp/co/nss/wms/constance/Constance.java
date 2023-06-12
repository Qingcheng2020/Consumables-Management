package jp.co.nss.wms.constance;

import jp.co.nss.wms.R;
import jp.co.nss.wms.util.StringUtil;

/**
 * Created by NSS
 */

public class Constance {

    //测试站http://119.23.251.167/wms/
//    public static String COMMON_URL = "http://39.98.136.110/wms";
//    public static String COMMON_URL = "http://192.168.31.8:8081/jeewms";

//    public static String COMMON_URL = "http://wms.daojiadiandian.com:8086/jeewms";

//    public static String COMMON_URL = "http://192.168.10.109:8080";
//    public static String COMMON_URL2 = "http://192.168.0.8:8080";

        public static String COMMON_URL = "http://192.168.3.18:8080";    // 正式环境-临沂市妇幼保健院
    //    public static String COMMON_URL = "http://121.4.95.202:8080";    // 正式环境-旧环境
//    public static String COMMON_URL = "http://101.35.138.224:8080"; // 测试环境
//   public static String COMMON_URL = "http://10.160.168.127:8080"; // 本地

    // public static String COMMON_URL2 = "http://192.168.3.18:8080";
   public static String COMMON_URL2 = "http://121.4.95.202:8090";
    public static String COMMON_URL3 = "http://192.168.0.22:8080";

    // 无操作登出时间 单位s
    public static int TIME_LOGOUT = 1200;

    // 默认 pageSize
    public static final int PAGE_SIZE = 2000;

    // 主页预警
    public static final String[] warningNameList = {"低库存预警", "过期预警"};
//    public static final int[] warningIconList = {R.string.iconfont_warning1, R.string.iconfont_warning2};

    //主界面按钮图片
    public static final int[] btnImgList = {R.drawable.home1, R.drawable.home2, R.drawable.home3, R.drawable.home4, R.drawable.home5, R.drawable.home6, R.drawable.home7, R.drawable.home8, R.drawable.home9, R.drawable.home10, R.drawable.home11, R.drawable.home12};
    //主界面按钮名字
//    public static final String[] btnNameList = {"收货", "上架", "按单拣货", "装车复核", "储位转移", "盘点", "商品资料", "库存查询", "波次拣货", "波次下架复核", "波次分拣", "波次装车复核"};
    public static final String[] btnNameList = {"在库查询", "入库", "移库", "出库", "退货", "库损", "终结"};

    // 超管菜单
    public static final String[] menuNameListAdminSuper = {"在库查询", "入库", "出库", "退货", "库损"};
    public static final int[] menuImgListAdminSuper = {R.drawable.home1, R.drawable.home2, R.drawable.home4, R.drawable.home5, R.drawable.home6};

    // 一级中心库管 菜单
    public static final String[] menuNameListAdmin1 = {"在库查询", "入库", "出库", "退货", "库损"};
    public static final int[] menuImgListAdmin1 = {R.drawable.home1, R.drawable.home2, R.drawable.home4, R.drawable.home5, R.drawable.home6};

    // 二级中心库管 菜单
    public static final String[] menuNameListAdmin2Center = {"在库查询", "入库", "移库", "退货", "库损"};
    public static final int[] menuImgListAdmin2Center = {R.drawable.home1, R.drawable.home2, R.drawable.home3, R.drawable.home5, R.drawable.home6};

    // 二级科室库管 菜单
    public static final String[] menuNameListAdmin2Branch = {"在库查询", "出库", "退货", "库损"};
    public static final int[] menuImgListAdmin2Branch = {R.drawable.home1, R.drawable.home4, R.drawable.home5, R.drawable.home6};

    // 试剂操作员 菜单
    public static final String[] menuNameListOperator = {"在库查询", "退货", "库损", "终结"};
    public static final int[] menuImgListOperator = {R.drawable.home1, R.drawable.home5, R.drawable.home6, R.drawable.home7};

    public static void setBaseUrl(String baseUrl) {
        if (!StringUtil.isEmpty(baseUrl)) {
            COMMON_URL = baseUrl;
        }
    }

    public static String getBaseUrl() {
        return COMMON_URL;
    }

    //登录
    public static final String LOGIN = "/admin/login";
    //按货捡单
    public static final String GINOTICE = "/rest/wvGiNoticeController";
    //保存捡单
    public static final String SAVEGINOTICE = "/rest/wmToDownGoodsController";
    //获取按货捡单列表
    public static final String QUERYWV = "/xys/xys/queryWv_gi_notice_head";
    //收货                                       rest/wmInQmIController
    public static final String NoticeController = "/rest/wvNoticeController";
    public static final String InQmIController = "/rest/wmInQmIController";
    public static final String ToMoveGoodsController = "/rest/wmToMoveGoodsController";
    public static final String SttInGoodsController = "/rest/wmSttInGoodsController";
    public static final String GoodsController = "/rest/mdGoodsController";
    public static final String wvGiController = "/rest/wvGiController";
    public static final String StockController = "/rest/wvStockController";
    //保存上架
    public static final String wmToUpGoodsController = "/rest/wmToUpGoodsController";
    public static final String wmInQmIController = "/rest/wmInQmIController";

    //盘点保存
    public static final String wmSttInGoodsControllerc = "/rest/wmSttInGoodsController/change";
    //装车复核保存
    public static final String wmToDownGoodsControllerc = "/rest/wmToDownGoodsController/change";
    //商品信息保存
    public static final String mdGoodsControllerc = "/rest/mdGoodsController/change";
    //商品下单
    public static final String mdGoodsControllercorder = "/rest/mdGoodsController/order";
    //移储保存
    public static final String wmToMoveGoodsControllerc = "/rest/wmToMoveGoodsController/change";
    //镭射清单
    public static final String tSapLsqdController = "/rest/tSapLsqdController";
    //库存清单
    public static final String tSapStockController = "/rest/tSapStockController";
    //库存清单
    public static final String tSapLtttController = "/rest/tSapLtttController";
    //波次下架查询
    public static final String waveToDownList = "/rest/waveToDownController/list/todown";
    //波次下架保存
    public static final String waveToDownSave = "/rest/waveToDownController";
    //波次分拣查询
    public static final String waveToFjList = "/rest/waveToFjController/list/tofj";
    //波次分拣保存
    public static final String waveToFjSave = "/rest/waveToFjController";
    //登录
    public static String getLoginURL() {
        return COMMON_URL + LOGIN;
    } //登录

    //获取简单详情
    public static String getGiNoticeURL() {
        return COMMON_URL + GINOTICE;
    } //登录

    public static String getSaveginoticeURL() {
        return COMMON_URL + SAVEGINOTICE;
    }

    public static String getNoticeControllerURL() {
        return COMMON_URL + NoticeController;
    }

    public static String getInQmIControllerURL() {
        return COMMON_URL + InQmIController;
    }

    public static String getToMoveGoodsControllerURL() {
        return COMMON_URL + ToMoveGoodsController;
    }

    public static String getSttInGoodsControllerURL() {
        return COMMON_URL + SttInGoodsController;
    }

    public static String getGoodsControllerURL() {
        return COMMON_URL + GoodsController;
    }


    public static String getStockControllerURL() {
        return COMMON_URL + StockController;
    }

    public static String getWmToUpGoodsControllerURL() {
        return COMMON_URL + wmToUpGoodsController;
    }

    public static String getWmInQmIControllerURL() {
        return COMMON_URL + wmInQmIController;
    }

    public static String getwvGiControllerURL() {
        return COMMON_URL + wvGiController;
    }

    public static String getwmToDownGoodsControllercURL() {
        return COMMON_URL + wmToDownGoodsControllerc;
    }

    public static String getwmSttInGoodsControllercURL() {
        return COMMON_URL + wmSttInGoodsControllerc;
    }
    public static String getwaveToDownGoodsControllercURL() {
        return COMMON_URL + waveToDownList;
    }

    public static String getwavetosaveControllercURL() {
        return COMMON_URL + waveToDownSave;
    }
    public static String getwavetofjGoodsControllercURL() {
        return COMMON_URL + waveToFjList;
    }

    public static String getwavetofjsaveControllercURL() {
        return COMMON_URL + waveToFjSave;
    }
    public static String getmdGoodsControllercURL() {
        return COMMON_URL + mdGoodsControllerc;
    }
    public static String getmdGoodsControllerorderURL() {
        return COMMON_URL + mdGoodsControllercorder;
    }

    public static String getwmToMoveGoodsControllercURL() {
        return COMMON_URL + wmToMoveGoodsControllerc;
    }

    public static String gettSapLsqdControllerURL() {
        return COMMON_URL + tSapLsqdController;
    }
    public static String gettSapStockControllerURL() {
        return COMMON_URL + tSapStockController;
    }
    public static String gettSapLtttControllerURL() {
        return COMMON_URL + tSapLtttController;
    }

    public static class SHAREP {
        /**
         * SharedPreferences
         */
        public static final String SHAREDSAVE = "save";

        //登录名
        public static final String LOGINNAME = "userName";

        // 用户昵称
        public static final String NICKNAME = "nickname";

        //登录名
        public static final String LOGINID = "userId";

        //登录密码
        public static final String PASSWORD = "passWord";
        //地址
        public static final String HTTPADDRESS = "httpAddress";
        public static final String HTTPADDRESS1 = "httpAddress1";

        //token
        public static final String TOKEN = "token";

        // 用户信息
        public static final String USERINFO = "userInfo";

        // 用户角色ID
        public static final String USER_ROLE_ID = "userRoleID";

        // stockType    1一级中心库汇总    2二级架构科室汇总   3二级架构中心库汇总
        public static final String STOCK_TYPE = "stock_type";

        // 服务器地址
        public static final String SERVER_ADDRESS = "serverAddress";
    }

    /*
    * dictionary
    * */
    public static class DICT {
        // http onFailure
        public static final String NET_ON_FAILURE = "网络连接失败";

        // 后端处理数据失败，操作未成功
        public static final String RES_FAILURE = "操作失败";

        // 二维码重复
        public static final String QR_CODE_REPEAT = "重复扫码";

        // 未查找到数据或无权限
//        public static final String DATA_NOT_FOUND = "未查找到数据或当前账号无权限";
        public static final String DATA_NOT_FOUND = "试剂未入库";

        public static final String DATA_GET_ERROR = "数据查询失败";

        // 试剂草稿为空
        public static final String DATA_DRAFT_IS_NULL = "草稿为空";

        public static final String DATA_IS_NOT_EARLIER = "存在更早过期的试剂";
    }
}
