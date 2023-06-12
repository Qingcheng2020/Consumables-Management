package jp.co.nss.wms;

import android.os.Bundle;
import android.os.Handler;
import android.widget.LinearLayout;

import java.util.HashMap;
import java.util.Map;

import butterknife.BindView;
import butterknife.ButterKnife;
import jp.co.nss.wms.api.LoginService;
import jp.co.nss.wms.base.BaseActivity;
import jp.co.nss.wms.constance.Constance;
import jp.co.nss.wms.model.CommonResult;
import jp.co.nss.wms.model.ResultCode;
import jp.co.nss.wms.model.UserInfoReq;
import jp.co.nss.wms.ui.acitivity.OperatorIndexActivity;
import jp.co.nss.wms.util.RestClient;
import jp.co.nss.wms.util.SharedPreferencesUtil;
import jp.co.nss.wms.util.StringUtil;
import jp.co.nss.wms.util.ToastUtil;
import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

/**
 * Created by nss.
 */

public class WelComeActivity extends BaseActivity {


    @BindView(R.id.ll_root)
    LinearLayout llRoot;
    private int status;

    @Override
    protected int getTitleBarResId() {
        return -1;
    }

    @Override
    protected int getContentResId() {
        return R.layout.activity_linear;
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        // TODO: add setContentView(...) invocation
        ButterKnife.bind(this);
        llRoot.setBackgroundResource(R.drawable.welcome);

        String username = SharedPreferencesUtil.getInstance(this).getKeyValue(Constance.SHAREP.LOGINNAME);
        String password = SharedPreferencesUtil.getInstance(this).getKeyValue(Constance.SHAREP.PASSWORD);
        String serverAddress = SharedPreferencesUtil.getInstance(this).getKeyValue(Constance.SHAREP.SERVER_ADDRESS);

        if (!StringUtil.isEmpty(password) && !StringUtil.isEmpty(serverAddress)) {
            doLogin(username, password, serverAddress);
        } else {
            LoginActivity.show(this);
            finish();
        }

        Handler handler = new Handler();
        handler.postDelayed(new Runnable() {
            @Override
            public void run() {
                if (status == 0) {
                    status++;
                } else {
                    getUserInfo();
                }
            }
        }, 3000);

    }

    public void doLogin(String username, String password, String serverAddress) {
        Map<String, String> params = new HashMap<>();
        params.put("username", username);
        params.put("password", password);

//        Constance.setBaseUrl(Constance.COMMON_URL);
        Constance.setBaseUrl(serverAddress);
        //Constance.setBaseUrl(SharedPreferencesUtil.getInstance(this).getKeyValue(Constance.SHAREP.HTTPADDRESS));
        LoginService apiInterface = RestClient.getClient(this).create(LoginService.class);
        Call<CommonResult> call1 = apiInterface.login(params);
        call1.enqueue(new Callback<CommonResult>() {
            @Override
            public void onResponse(Call<CommonResult> call, Response<CommonResult> response) {
                CommonResult result = response.body();

                if ((result!=null) && (result.getCode()==ResultCode.SUCCESS.getCode())) {
                    Map data = (Map) result.getData();
                    String token = (String) data.get("tokenHead") +  (String) data.get("token");
                    saveToken(token);

                    if (status == 0) {
                        status++;
                    } else {
                        getUserInfo();
                    }
                } else {
                    LoginActivity.show(getActivity());
                    finish();
                }
            }

            @Override
            public void onFailure(Call<CommonResult> call, Throwable t) {
                LoginActivity.show(getActivity());
                finish();
            }
        });

    }

    /**
     * 获取用户信息（主要是拿到用户roleID）
     */
    private void getUserInfo() {
        LoginService apiInterface = RestClient.getClient(this).create(LoginService.class);
        Call<CommonResult<UserInfoReq>> call1 = apiInterface.userInfo();
        call1.enqueue(new Callback<CommonResult<UserInfoReq>>() {
            @Override
            public void onResponse(Call<CommonResult<UserInfoReq>> call, Response<CommonResult<UserInfoReq>> response) {
                CommonResult result = response.body();
                if ((result!=null) && (result.getCode() == ResultCode.SUCCESS.getCode())) {

                    UserInfoReq data = (UserInfoReq) result.getData();
                    String nickname = data.getNickname();
                    Integer userRoleID = Double.valueOf((Double) data.getRoleID()).intValue();

                    SharedPreferencesUtil.getInstance(WelComeActivity.this).setKeyValue(Constance.SHAREP.NICKNAME, nickname);
                    SharedPreferencesUtil.getInstance(WelComeActivity.this).setKeyValue(Constance.SHAREP.USER_ROLE_ID, userRoleID.toString());

                    saveStockType(userRoleID);

                    // 试剂操作员首页特殊
                    // 4-一级库模式试剂操作员；9-二级库模式试剂操作员
                    if (userRoleID==4 || userRoleID==9) {
                        if (curContext==null ||
                                curContext.getClass()==OperatorIndexActivity.class ||
                                curContext.getClass()==HomeActivity.class) {
                            OperatorIndexActivity.show(WelComeActivity.this);
                        }
                    } else {
                        if (curContext==null ||
                                curContext.getClass()==HomeActivity.class ||
                                curContext.getClass()==OperatorIndexActivity.class) {
                            HomeActivity.show(WelComeActivity.this);
                        }
                    }

                    startTimer();
                    finish();

                } else {
                    ToastUtil.show(WelComeActivity.this, result.getMessage());
                    SharedPreferencesUtil.getInstance(WelComeActivity.this).setKeyValue(Constance.SHAREP.PASSWORD, "");
                    LoginActivity.show(WelComeActivity.this);
                }
            }

            @Override
            public void onFailure(Call<CommonResult<UserInfoReq>> call, Throwable t) {
                call.cancel();
                ToastUtil.show(WelComeActivity.this, Constance.DICT.NET_ON_FAILURE);
            }
        });
    }

    private void  saveToken(String token){
        SharedPreferencesUtil.getInstance(this).setKeyValue(Constance.SHAREP.TOKEN, token);
    }

    /**
     * 存储 stockType
     * @param userRoleId int
     */
    private void saveStockType(int userRoleId) {
        String stockType;
        switch (userRoleId) {
            case 1:   // ! 超管（待定）
            case 2:   // 一级架构中心库管理
                stockType = "1";    // 一级中心库汇总
                break;
            case 3: // 二级架构科室库管理
            case 9: // 二级架构试剂操作员
            case 6:   // 二级架构中心库管理
                stockType = "3";
                break;
            default:
                stockType = null;
        }
        SharedPreferencesUtil.getInstance(WelComeActivity.this).setKeyValue(Constance.SHAREP.STOCK_TYPE, stockType);
    }

}
