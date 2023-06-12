package jp.co.nss.wms.api;

import java.util.List;

import jp.co.nss.wms.bean.bean.ReagentItemBean;
import jp.co.nss.wms.bean.bean.ReagentStock;
import jp.co.nss.wms.bean.vm.ReagentDetailVm;
import jp.co.nss.wms.bean.vm.ReagentInfoVm;
import jp.co.nss.wms.constance.Constance;
import jp.co.nss.wms.model.CommonResult;
import jp.co.nss.wms.model.ReagentCheckReq;
import jp.co.nss.wms.model.ReagentCloseReq;
import jp.co.nss.wms.model.ReagentDetailListReq;
import jp.co.nss.wms.model.ReagentInBillDetailRes;
import jp.co.nss.wms.model.ReagentInBillItemRes;
import jp.co.nss.wms.model.ReagentInBillRes;
import jp.co.nss.wms.model.ReagentItemsReq;
import jp.co.nss.wms.model.ReagentLowListRes;
import jp.co.nss.wms.model.ReagentMoveDetailRes;
import jp.co.nss.wms.model.ReagentMoveReq;
import jp.co.nss.wms.model.ReagentMoveRes;
import jp.co.nss.wms.model.ReagentOrderDedetailRes;
import jp.co.nss.wms.model.ReagentOrderRes;
import jp.co.nss.wms.model.ReagentOutReq;
import jp.co.nss.wms.model.ReagentPreInDetailRes;
import jp.co.nss.wms.model.ReagentRefundReq;
import jp.co.nss.wms.model.ReagentStockPreInRes;
import jp.co.nss.wms.model.ReagentStockReq;
import retrofit2.Call;
import retrofit2.http.Body;
import retrofit2.http.Field;
import retrofit2.http.FormUrlEncoded;
import retrofit2.http.GET;
import retrofit2.http.POST;
import retrofit2.http.Path;
import retrofit2.http.Query;

public interface StockService {
    // 扫码查询
    @GET("/stockDetail/pda")
    Call<CommonResult<ReagentDetailVm>> findItemByQrcode(@Query("qrCode") String qrCode,
                                                         @Query("username") String username);

    // 扫码查询-检查日期
    // isLater: 1-检查是否存在距离过期更早的试剂
    @GET("/stockDetail/pda")
    Call<CommonResult<ReagentDetailVm>> findItemByQrcode(@Query("qrCode") String qrCode,
                                                         @Query("username") String username,
                                                         @Query("isLater") String isLater);

    // 扫码查询-检查日期和查询非正常状态试剂
    // isLater: 1-检查是否存在距离过期更早的试剂
    // isMore: 1-查询非正常状态试剂
    @GET("/stockDetail/pda")
    Call<CommonResult<ReagentDetailVm>> findItemByQrcode(@Query("qrCode") String qrCode,
                                                         @Query("username") String username,
                                                         @Query("isLater") String isLater,
                                                         @Query("isMore") String isMore);

    // 扫码查询-检查日期和查询非正常状态试剂
    // isLater: 1-检查是否存在距离过期更早的试剂
    // isMore: 1-查询非正常状态试剂
    // countSameStore: 1-获取科室库中同类型试剂的数量
    @GET("/stockDetail/pda")
    Call<CommonResult<ReagentDetailVm>> findItemByQrcode(@Query("qrCode") String qrCode,
                                                         @Query("username") String username,
                                                         @Query("isLater") String isLater,
                                                         @Query("isMore") String isMore,
                                                         @Query("countSameStore") String countSameStore);

    // 获取订单汇总
    @GET("/order/list?pageNum=1&pageSize=" + Constance.PAGE_SIZE)
    Call<CommonResult<ReagentOrderRes>> getOrderList(@Query("username") String username,
                                                     @Query("keyword") String keyword);

    @GET("/orderDetail/list?pageNum=1&pageSize=" + Constance.PAGE_SIZE)
    Call<CommonResult<ReagentOrderDedetailRes>> getOrderDetail(@Query("keyword") String keyword);

    // 获取预入库/随货同行单汇总
    @GET("/preInBill/list?pageNum=1&pageSize=" + Constance.PAGE_SIZE)
    Call<CommonResult<ReagentStockPreInRes>> getPreInBillList(@Query("keyword") String searchKey,
                                                              @Query("username") String username);

    // 获取随货同行单详情（第2层）数据
    @GET("/preInDetail/list?pageNum=1&pageSize=" + Constance.PAGE_SIZE)
    Call<CommonResult<ReagentPreInDetailRes>> getPreInDetailList(@Query("keyword") String keyword);

    // 获取入库单汇总
    @GET("/inBill/list?pageNum=1&pageSize=" + Constance.PAGE_SIZE)
    Call<CommonResult<ReagentInBillRes>> getInBillList(@Query("username") String username,
                                                       @Query("billType") String billType,
                                                       @Query("keyword") String keyword);

    // 获取入库单第2层数据
    @GET("/inBillDetail/list?pageNum=1&pageSize=" + Constance.PAGE_SIZE)
    Call<CommonResult<ReagentInBillDetailRes>> getInBillDetailList(@Query("keyword") String keyword);

    // 获取入库单 item，第3层数据
    @GET("/inBillItem/list?pageNum=1&pageSize=" + Constance.PAGE_SIZE)
    Call<CommonResult<ReagentInBillItemRes>> getInBillDetailItemList(@Query("keyword") String keyword);

    // 获取移库申请列表
    @GET("/collect/list?pageNum=1&pageSize=" + Constance.PAGE_SIZE + "&applyType=2")
    Call<CommonResult<ReagentMoveRes>> getCollectList(@Query("username") String username,
                                                      @Query("keyword") String keyword);

    @GET("/collectDetail/list?pageNum=1&pageSize=" + Constance.PAGE_SIZE)
    Call<CommonResult<ReagentMoveDetailRes>> getCollectDetail(@Query("keyword") String collectNo);

    // 移库
    @POST("/collect/pda/relocation")
    Call<CommonResult<Integer>> stockRelocation(@Body ReagentMoveReq req);

    // 出库
    @POST("/outBill/pda/outItem")
    Call<CommonResult<Integer>> saveOutStock(@Body ReagentOutReq req);

    // 库损
    @POST("/stockDetail/updateStatusList")
    Call<CommonResult<Integer>> checkStock(@Body ReagentCheckReq req);

    // 退货
    @POST("/refund/pda/create")
    Call<CommonResult<Integer>> refundReagent(@Body ReagentRefundReq req);

    /**
     * 试剂开始上机使用
     */
    @FormUrlEncoded
    @POST("/stockDetail/associateDevice")
    Call<CommonResult<Integer>> associateDevice(@Field("qrcode") String qrcode,
                                                @Field("deviceId") Long deviceId);

    // 终结
    @POST("/stockDetail/pda/endReagent")
    Call<CommonResult<Integer>> closeReagent(@Body ReagentCloseReq req);

    /**
     * 更新单个试剂的开启有效期限
     *
     * @param days   int
     * @param qrcode String
     * @return void
     */
    @FormUrlEncoded
    @POST("/stockDetail/update/effectiveOpenTime")
    Call<CommonResult<Integer>> updateEffectiveOpenTime(@Field("days") int days,
                                                        @Field("qrcode") String qrcode);

    /**
     * 获取所有同类试剂
     */
    @POST("/stockDetail/list")
    Call<CommonResult<ReagentStockReq>> getStockDetailList(@Body ReagentDetailListReq req);

    @GET("/stock/searchList?pageNum=1&pageSize=" + Constance.PAGE_SIZE)
    Call<CommonResult<ReagentStockReq>> searchList(
            @Query("stockType") String stockType,
            @Query("username") String username
    );

    @GET("/stock/searchList?pageNum=1&pageSize=" + Constance.PAGE_SIZE)
    Call<CommonResult<ReagentStockReq>> searchList(
            @Query("stockType") String stockType,
            @Query("username") String username,
            @Query("reagentName") String reagentName
    );

    /**
     * 获取试剂操作员名下的试剂
     *
     * @param username  用户名
     * @param stockType type
     * @return List<ReagentStock>
     */
    @GET("/stock/list/operator")
    Call<CommonResult<List<ReagentStock>>> getOperatorStockList(@Query("username") String username,
                                                                @Query("stockType") String stockType);

    @GET("/stock/searchLowList?pageNum=1&pageSize=" + Constance.PAGE_SIZE)
    Call<CommonResult<ReagentLowListRes>> getLowList(@Query("stockType") String stockType,
                                                     @Query("username") String username,
                                                     @Query("type") String type,
                                                     @Query("reagentName") String reagentName,
                                                     @Query("supplierName") String supplierName);

    @GET("/api/stock/search")
    Call<CommonResult<List<ReagentInfoVm>>> search(@Query("batchNo") String batchNo, @Query("qrCode") String qrCode);

    @GET("/stock/{qrCode}")
    Call<CommonResult<ReagentItemBean>> findItem(@Path("qrCode") String qrCode);

    @POST("/stockItem/close")
    Call<CommonResult<Integer>> closeItem(@Body ReagentItemsReq req);


    @POST("/stockItem/retire")
    Call<CommonResult<Integer>> retireItem(@Body ReagentItemsReq req);

}
