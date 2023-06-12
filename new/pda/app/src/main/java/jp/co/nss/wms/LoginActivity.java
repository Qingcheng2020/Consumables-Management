package jp.co.nss.wms;

import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.os.Bundle;
import android.text.Editable;
import android.text.InputType;
import android.text.TextWatcher;
import android.view.Gravity;
import android.view.KeyEvent;
import android.view.View;
import android.view.WindowManager;
import android.widget.Button;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.RadioButton;
import android.widget.TextView;

import com.loveplusplus.update.UpdateChecker;

import java.lang.reflect.Field;
import java.util.HashMap;
import java.util.Map;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;
import jp.co.nss.wms.api.LoginService;
import jp.co.nss.wms.base.BaseActivity;
import jp.co.nss.wms.constance.Constance;
import jp.co.nss.wms.model.CommonResult;
import jp.co.nss.wms.model.ResultCode;
import jp.co.nss.wms.model.UserInfoReq;
import jp.co.nss.wms.ui.acitivity.OperatorIndexActivity;
import jp.co.nss.wms.util.LoadingUtil;
import jp.co.nss.wms.util.RestClient;
import jp.co.nss.wms.util.SharedPreferencesUtil;
import jp.co.nss.wms.util.StringUtil;
import jp.co.nss.wms.util.ToastUtil;
import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

/**
 * Created by NSS.
 */

public class LoginActivity extends BaseActivity {

    @BindView(R.id.tv_userName)
    EditText tvUserName;
    @BindView(R.id.tv_password)
    EditText tvPassword;
    @BindView(R.id.forgetPassword)
    TextView forgetPassword;
    @BindView(R.id.btn_login)
    Button btnLogin;
    @BindView(R.id.btn_regist)
    Button btnRegist;
    @BindView(R.id.tv_address)
    EditText tvAddress;
    @BindView(R.id.radio1)
    RadioButton radio1;
    @BindView(R.id.radio2)
    RadioButton radio2;
    @BindView(R.id.btn_version)
    TextView btnVersion;
    @BindView(R.id.btn_server_set)
    TextView btnServerSet;

//    String addressTemp;
    String addressPer;
    private long exitTime = 0;

    public static void show(Context context) {
        Intent intent = new Intent(context, LoginActivity.class);
        context.startActivity(intent);
    }


    @Override
    protected int getContentResId() {
        return R.layout.activity_login;
    }

    @Override
    protected int getTitleBarResId() {
        return -1;
    }

    @Override
    protected void initView() {
        super.initView();
        // UpdateChecker.checkForDialog(LoginActivity.this);
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        // 自动登录
        if (!StringUtil.isEmpty(SharedPreferencesUtil.getInstance(this).getKeyValue(Constance.SHAREP.PASSWORD))) {
            doLogin(SharedPreferencesUtil.getInstance(this).getKeyValue(Constance.SHAREP.LOGINNAME), SharedPreferencesUtil.getInstance(this).getKeyValue(Constance.SHAREP.PASSWORD));
        }
        super.onCreate(savedInstanceState);
        // TODO: add setContentView(...) invocation
        ButterKnife.bind(this);
//        setAddress();
        if (!StringUtil.isEmpty(SharedPreferencesUtil.getInstance(this).getKeyValue(Constance.SHAREP.LOGINNAME)) && tvUserName != null) {
            tvUserName.setText(SharedPreferencesUtil.getInstance(this).getKeyValue(Constance.SHAREP.LOGINNAME));
            tvPassword.setFocusable(true);
            tvPassword.setFocusableInTouchMode(true);
            tvPassword.requestFocus();
            this.getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_STATE_ALWAYS_VISIBLE);

        }
//        tvAddress.addTextChangedListener(new TextWatcher() {
//            @Override
//            public void beforeTextChanged(CharSequence charSequence, int i, int i1, int i2) {
//            }
//
//            @Override
//            public void onTextChanged(CharSequence charSequence, int i, int i1, int i2) {
//                addressPer = charSequence + "";
//            }
//
//            @Override
//            public void afterTextChanged(Editable editable) {
//                radio2.setText(addressTemp);
//                radio2.setVisibility(View.VISIBLE);
//                radio1.setText(addressPer);
//            }
//        });
    }

    @Override
    protected void onResume() {
        super.onResume();
        stopTimer();
    }

    @OnClick({R.id.forgetPassword, R.id.btn_login, R.id.btn_regist})
    public void onViewClicked(View view) {
        switch (view.getId()) {
            case R.id.forgetPassword:
                ToastUtil.show(this, "忘记密码");
                break;
            case R.id.btn_login:
                check();
                break;
            case R.id.btn_regist:
                ToastUtil.show(this, "注册");
                break;
        }
    }

    @OnClick(R.id.btn_version)
    public void onVersionClicked() {
        String versionName = null;
        int versionCode = 0;

        try {
            versionName = this.getPackageManager().getPackageInfo(this.getPackageName(), 0).versionName;
            versionCode = this.getPackageManager().getPackageInfo(this.getPackageName(), 0).versionCode;
        } catch (PackageManager.NameNotFoundException ignored) {

        }

        ToastUtil.show(this, "v" + versionName + " - " + versionCode);

    }

    /**
     * 设置代理
     */
    @OnClick(R.id.btn_server_set)
    public void onServerSetClicked() {
        // 服务器地址
        String serverAddress = SharedPreferencesUtil.getInstance(this).getKeyValue(Constance.SHAREP.SERVER_ADDRESS);

        LinearLayout linearLayout = new LinearLayout(this);
        LinearLayout.LayoutParams layoutParams = new LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.MATCH_PARENT);
        linearLayout.setLayoutParams(layoutParams);

        final EditText et = new EditText(this);
        LinearLayout.LayoutParams etParams = new LinearLayout.LayoutParams(LinearLayout.LayoutParams.WRAP_CONTENT, LinearLayout.LayoutParams.WRAP_CONTENT, 1);
        etParams.gravity = Gravity.CENTER_VERTICAL;
        etParams.setMargins(30, 30, 30, 20);
        et.setLayoutParams(etParams);
        et.setSingleLine();
        et.setHint("请输入完整的服务器地址");
        et.setInputType(InputType.TYPE_TEXT_FLAG_NO_SUGGESTIONS);

        // 已存储服务器地址，回填
        if (serverAddress!=null && !serverAddress.equals("")) {
            et.setText(serverAddress);
        }

        linearLayout.addView(et);

        new AlertDialog.Builder(this).setTitle("设置服务器地址")
                .setView(linearLayout)
                .setPositiveButton("确定", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        // 阻止点击确认后关闭 dialog
                        keepDialog(dialog);

                        String _address = et.getText().toString();

                        if (_address.equals("")) {
                            ToastUtil.show(LoginActivity.this, "请输入正确的服务器地址");
                        } else {
                            SharedPreferencesUtil.getInstance(LoginActivity.this).setKeyValue(Constance.SHAREP.SERVER_ADDRESS, _address);
                            closeDialog(dialog);
                        }
                    }
                })
                .setNegativeButton("取消", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        closeDialog(dialog);
                    }
                })
                .show();
    }

    private void check() {
        if (StringUtil.isEmpty(tvUserName.getText().toString())) {
            ToastUtil.show(this, "请输入用户名");
            return;
        }
        if (StringUtil.isEmpty(tvPassword.getText().toString())) {
            ToastUtil.show(this, "请输入密码");
            return;
        }
        doLogin(tvUserName.getText().toString(), tvPassword.getText().toString());
    }

    public void doLogin(String username, String password) {
        String serverAddress = SharedPreferencesUtil.getInstance(this).getKeyValue(Constance.SHAREP.SERVER_ADDRESS);
        // 检查服务器地址设置
        if (StringUtil.isEmpty(serverAddress)) {
            ToastUtil.show(this, "请先设置服务器地址");
            return;
        }

        LoadingUtil.showLoading(this);

        Map<String, String> params = new HashMap<>();
        params.put("username", username);
        params.put("password", password);
//        if (radio1 != null) {
//            if (radio1.isChecked()) {
//                Constance.setBaseUrl(radio1.getText().toString());
//            } else {
//                Constance.setBaseUrl(radio2.getText().toString());
//            }
//        } else {
//            Constance.setBaseUrl(SharedPreferencesUtil.getInstance(this).getKeyValue(Constance.SHAREP.HTTPADDRESS));
//        }

//        Constance.setBaseUrl(Constance.COMMON_URL);
        Constance.setBaseUrl(serverAddress);
        LoginService apiInterface = RestClient.getClient(this).create(LoginService.class);

        /**
         Login
         **/
        Call<CommonResult> call1 = apiInterface.login(params);
        call1.enqueue(new Callback<CommonResult>() {
            @Override
            public void onResponse(Call<CommonResult> call, Response<CommonResult> response) {
                CommonResult result = response.body();

                if (result == null) {
                    ToastUtil.show(LoginActivity.this, Constance.DICT.RES_FAILURE);
                    return;
                }

                if (result.getCode() == ResultCode.SUCCESS.getCode()) {
                    Map data = (Map) result.getData();
                    String token = data.get("tokenHead") + (String) data.get("token");
                    saveToken(token);
                    savePassword(data.get("tokenHead") + (String) data.get("token"));
//                    saveAddress();
                    getUserInfo();
                } else {
                    LoadingUtil.hideLoading();
                    ToastUtil.show(LoginActivity.this, result.getMessage());
                }
            }

            @Override
            public void onFailure(Call<CommonResult> call, Throwable t) {
                LoadingUtil.hideLoading();
                call.cancel();
                ToastUtil.show(LoginActivity.this, "网络连接失败");
            }
        });
//        LoadingUtil.hideLoading();
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

                if (result == null) {
                    ToastUtil.show(LoginActivity.this, Constance.DICT.RES_FAILURE);
                    return;
                }

                if (result.getCode() == ResultCode.SUCCESS.getCode()) {
                    ToastUtil.show(LoginActivity.this, "登录成功");

                    UserInfoReq data = (UserInfoReq) result.getData();
                    String nickname = data.getNickname();
                    Integer userRoleID = Double.valueOf((Double) data.getRoleID()).intValue();

                    SharedPreferencesUtil.getInstance(LoginActivity.this).setKeyValue(Constance.SHAREP.NICKNAME, nickname);
                    SharedPreferencesUtil.getInstance(LoginActivity.this).setKeyValue(Constance.SHAREP.USER_ROLE_ID, userRoleID.toString());

                    saveStockType(userRoleID);

                    // 试剂操作员首页特殊
                    // 4-一级库模式试剂操作员；9-二级库模式试剂操作员
                    if (userRoleID == 4 || userRoleID == 9) {
                        if (curContext == null ||
                                curContext.getClass() == OperatorIndexActivity.class ||
                                curContext.getClass() == HomeActivity.class) {
                            OperatorIndexActivity.show(LoginActivity.this);
                        }
                    } else {
                        if (curContext == null ||
                                curContext.getClass() == HomeActivity.class ||
                                curContext.getClass() == OperatorIndexActivity.class) {
                            HomeActivity.show(LoginActivity.this);
                        }
                    }

                    startTimer();
                    finish();

                } else {
                    LoadingUtil.hideLoading();
                    ToastUtil.show(LoginActivity.this, "获取用户信息失败");
                }
            }

            @Override
            public void onFailure(Call<CommonResult<UserInfoReq>> call, Throwable t) {
                call.cancel();
                LoadingUtil.hideLoading();
                ToastUtil.show(LoginActivity.this, Constance.DICT.NET_ON_FAILURE);
            }
        });

//        LoadingUtil.hideLoading();
    }

    private void savePassword(String token) {
        if (!StringUtil.isEmpty(tvPassword.getText().toString())) {
            SharedPreferencesUtil.getInstance(this).setKeyValue(Constance.SHAREP.LOGINNAME, tvUserName.getText().toString());
//            if (!radio1.getText().toString().equals(radio2.getText().toString()))
//                SharedPreferencesUtil.getInstance(this).setKeyValue(Constance.SHAREP.PASSWORD, tvPassword.getText().toString());
            SharedPreferencesUtil.getInstance(this).setKeyValue(Constance.SHAREP.PASSWORD, tvPassword.getText().toString());
        }
    }

    // 初始化地址
    private void setAddress() {
        //如果为保存地址，则使用最初地址
        if (StringUtil.isEmpty(SharedPreferencesUtil.getInstance(this).getKeyValue(Constance.SHAREP.HTTPADDRESS))) {
            SharedPreferencesUtil.getInstance(this).setKeyValue(Constance.SHAREP.HTTPADDRESS, Constance.COMMON_URL);
            radio1.setText(Constance.COMMON_URL);
        } else {
            radio1.setText(SharedPreferencesUtil.getInstance(this).getKeyValue(Constance.SHAREP.HTTPADDRESS));
        }
        // radio1.setText(Constance.COMMON_URL);
        SharedPreferencesUtil.getInstance(this).setKeyValue(Constance.SHAREP.HTTPADDRESS1, Constance.COMMON_URL2);
        if (!StringUtil.isEmpty(SharedPreferencesUtil.getInstance(this).getKeyValue(Constance.SHAREP.HTTPADDRESS1))) {
            radio2.setText(SharedPreferencesUtil.getInstance(this).getKeyValue(Constance.SHAREP.HTTPADDRESS1));
            radio2.setVisibility(View.VISIBLE);
        }
//        addressTemp = radio1.getText().toString();
    }

    // 保存输入地址
    private void saveAddress() {
        if (radio1.isChecked()) {
            SharedPreferencesUtil.getInstance(this).setKeyValue(Constance.SHAREP.HTTPADDRESS, radio1.getText().toString());
            SharedPreferencesUtil.getInstance(this).setKeyValue(Constance.SHAREP.HTTPADDRESS1, radio2.getText().toString());
        }
    }

    /**
     * 存储 stockType
     *
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
        SharedPreferencesUtil.getInstance(LoginActivity.this).setKeyValue(Constance.SHAREP.STOCK_TYPE, stockType);
    }

    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event) {
        if (keyCode == KeyEvent.KEYCODE_BACK
                && event.getAction() == KeyEvent.ACTION_DOWN) {
            if ((System.currentTimeMillis() - exitTime) > 2000) {
                ToastUtil.show(this, "再按一次退出程序");
                exitTime = System.currentTimeMillis();
            } else {
                finish();
                System.exit(0);
            }
            return true;
        }
        return super.onKeyDown(keyCode, event);
    }

    private void saveToken(String token) {
        SharedPreferencesUtil.getInstance(this).setKeyValue(Constance.SHAREP.TOKEN, token);
    }

    /**
     * 假设对话框已经关闭，欺骗系统，以保持输入窗口
     * @param mDialogLongInterface	点击对话框按钮事件传进来的mDialogInterface参数
     */
    public static void keepDialog(DialogInterface mDialogLongInterface) {
        try {
            Field field = mDialogLongInterface.getClass().getSuperclass().getDeclaredField("mShowing");
            field.setAccessible(true);//将mShowing设置为false表示对话框已关闭
            field.set(mDialogLongInterface, false);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 销毁对话框
     * @param mDialogInterface DialogInterface
     */
    public static void closeDialog(DialogInterface mDialogInterface){
        try {
            Field field=mDialogInterface.getClass().getSuperclass().getDeclaredField("mShowing");
            field.setAccessible(true);
            field.set(mDialogInterface, true);
            mDialogInterface.dismiss();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
