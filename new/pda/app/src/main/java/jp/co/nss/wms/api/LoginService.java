package jp.co.nss.wms.api;

import java.util.Map;

import jp.co.nss.wms.model.CommonResult;
import jp.co.nss.wms.model.UserInfoReq;
import retrofit2.Call;
import retrofit2.http.Body;
import retrofit2.http.GET;
import retrofit2.http.POST;

public interface  LoginService {
    @POST("/admin/login")
    Call<CommonResult> login(@Body Map data);

    @GET("/admin/info")
    Call<CommonResult<UserInfoReq>> userInfo();

    @POST("/admin/logout")
    Call<CommonResult> logout();

    @GET("api/users")
    Call<CommonResult> listUsers();

}
