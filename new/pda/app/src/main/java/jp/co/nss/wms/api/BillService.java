package jp.co.nss.wms.api;

import jp.co.nss.wms.bean.bean.ReagentItemBean;
import jp.co.nss.wms.model.CommonResult;
import jp.co.nss.wms.model.ReagentInBillReq;
import jp.co.nss.wms.model.ReagentMoveReq;
import retrofit2.Call;
import retrofit2.http.Body;
import retrofit2.http.GET;
import retrofit2.http.POST;
import retrofit2.http.Path;
import retrofit2.http.Query;

public interface BillService {
    // 二维码查找试剂的详细信息
    @GET("/preInItem/getByQrCode")
    Call<CommonResult<ReagentItemBean>> findPreItem(@Query("qrCode") String qrcode);

    // 扫码入库
    @POST("/inBill/pda")
    Call<CommonResult<String>> save(@Body ReagentInBillReq req);

    // 一键入库
    @POST("/inBill/pda/oneKey")
    Call<CommonResult<Integer>> oneKeyToIn(@Body ReagentInBillReq req);

    // 一键移库
    @POST("/inBill/pda/oneKeyCollect/")
    Call<CommonResult<Integer>> onKeyToMove(@Body ReagentMoveReq req);

    @GET("/api/inbills/{qrCode}")
    Call<CommonResult<ReagentItemBean>> findItem(@Path("qrCode") String qrCode);

//    @POST("/api/inbills/")
//    Call<CommonResult<Integer>> save(@Body ReagentInBillReq req);
}
