package jp.co.nss.wms.api;

import java.util.List;

import jp.co.nss.wms.bean.vm.BranchVm;
import jp.co.nss.wms.bean.vm.DeviceVm;
import jp.co.nss.wms.model.CommonResult;
import jp.co.nss.wms.model.HomeCountRes;
import jp.co.nss.wms.model.UserInfo;
import retrofit2.Call;
import retrofit2.http.GET;
import retrofit2.http.Query;

public interface CommonService {
    @GET("/count/home")
    Call<CommonResult<HomeCountRes>> getHomeCountData(@Query("username") String username);

    @GET("/admin/checkUserFromBranch")
    Call<CommonResult<Integer>> checkUserFromBranch(@Query("usernameCurrent") String current,
                                                    @Query("usernameTarget") String target);

    /**
     * 获取所有的科室
     */
    @GET("/branch/listAll")
    Call<CommonResult<List<BranchVm>>> getBranchSet();

    /**
     * 获取同属当前用户科室的试剂操作员列表
     */
    @GET("/admin/operator/list")
    Call<CommonResult<List<UserInfo>>> getOperators();

    /**
     * 根据设备二维码获取设备信息
     */
    @GET("/device/getByQrcode")
    Call<CommonResult<DeviceVm>> getDeviceByQrCode(@Query("qrcode") String qrcode);
}
