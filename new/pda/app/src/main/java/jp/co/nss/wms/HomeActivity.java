package jp.co.nss.wms;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.GridView;
import android.widget.TextView;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;
import jp.co.nss.wms.api.CommonService;
import jp.co.nss.wms.api.LoginService;
import jp.co.nss.wms.base.BaseActivity;
import jp.co.nss.wms.bean.bean.HomeMenuBean;
import jp.co.nss.wms.bean.bean.HomeWarningBean;
import jp.co.nss.wms.constance.Constance;
import jp.co.nss.wms.model.CommonResult;
import jp.co.nss.wms.model.HomeCountRes;
import jp.co.nss.wms.model.ResultCode;
import jp.co.nss.wms.ui.acitivity.OperatorIndexActivity;
import jp.co.nss.wms.ui.adapter.HomeGridAdapter;
import jp.co.nss.wms.ui.adapter.HomeWarningAdapter;
import jp.co.nss.wms.util.RestClient;
import jp.co.nss.wms.util.SharedPreferencesUtil;
import jp.co.nss.wms.util.ToastUtil;
import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

/**
 * Created by nss.
 */

public class HomeActivity extends BaseActivity {

    private static String TAG = "HomeActivity";

    HomeGridAdapter adapter;
    HomeWarningAdapter warningAdapter;

    GridView gvHome;
    GridView gvWarning;
    @BindView(R.id.tv_user)
    TextView tvUser;
    @BindView(R.id.btn_titlebar_right)
    Button btnLogout;

    ArrayList<HomeMenuBean> list = new ArrayList<>();

    @Override
    protected void onResume() {
        super.onResume();

        initUserData();
    }

    public static void show(Context context) {
        Intent intent = new Intent(context, HomeActivity.class);
        context.startActivity(intent);
    }

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.fragment_home);
        init();

//        ActivityListUtil.getInstence().addActivityToList(this);
    }

    private void init() {
        ButterKnife.bind(this);

        // 退出登录按钮
        btnLogout.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                logout();
            }
        });

        adapter = new HomeGridAdapter();
        warningAdapter = new HomeWarningAdapter();

        gvHome = findViewById(R.id.gv_home);
        gvHome.setAdapter(adapter);
        gvWarning = findViewById(R.id.gv_warning);
        gvWarning.setAdapter(warningAdapter);

        initUserData();

    }

    private void initUserData() {
        tvUser.setText(SharedPreferencesUtil.getInstance(this).getKeyValue(Constance.SHAREP.NICKNAME));

        generateMenu();
        // ! 暂时屏蔽，放开时别忘 fragment_home.xml 需要去掉 gone
//        getHomeData();
    }

    /**
     * 生成菜单
     */
    private void generateMenu() {
        list.clear();

        String userRoleID = SharedPreferencesUtil.getInstance(this).getKeyValue(Constance.SHAREP.USER_ROLE_ID);

        switch (userRoleID) {
            case "1": // 超管
                for (int i = 0; i < Constance.menuNameListAdminSuper.length; i++) {
                    addBtn2List(Constance.menuNameListAdminSuper[i], Constance.menuImgListAdminSuper[i]);
                }
                break;
            case "2": // 一级架构中心库管理
                for (int i = 0; i < Constance.menuNameListAdmin1.length; i++) {
                    addBtn2List(Constance.menuNameListAdmin1[i], Constance.menuImgListAdmin1[i]);
                }
                break;
            case "3": // 二级架构科室库管理
                for (int i = 0; i < Constance.menuNameListAdmin2Branch.length; i++) {
                    addBtn2List(Constance.menuNameListAdmin2Branch[i], Constance.menuImgListAdmin2Branch[i]);
                }
                break;
            case "6": // 二级架构中心库管理
                for (int i = 0; i < Constance.menuNameListAdmin2Center.length; i++) {
                    addBtn2List(Constance.menuNameListAdmin2Center[i], Constance.menuImgListAdmin2Center[i]);
                }
                break;
            case "4": // 一级架构试剂操作员
            case "9": // 二级架构试剂操作员
                // 试剂操作员跳转到专属首页
//                for (int i=0; i<Constance.menuNameListOperator.length; i++) {
//                    addBtn2List(Constance.menuNameListOperator[i], Constance.menuImgListOperator[i]);
//                }
                OperatorIndexActivity.show(this);
                finish();
                break;
        }

        adapter.setList(list);
        adapter.notifyDataSetChanged();

    }

    /**
     * 生成菜单 item
     * @param btnName String
     * @param imgResId int
     */
    private void addBtn2List(String btnName, int imgResId) {
        HomeMenuBean btn1 = new HomeMenuBean();
        btn1.setBtnName(btnName);
        btn1.setImaResId(imgResId);
        list.add(btn1);
    }

    /**
     * 首页预警数据
     */
    private void getHomeData() {
        String username = SharedPreferencesUtil.getInstance(this).getKeyValue(Constance.SHAREP.LOGINNAME);

        CommonService apiInterface = RestClient.getClient(this).create(CommonService.class);
        Call<CommonResult<HomeCountRes>> call1 = apiInterface.getHomeCountData(username);
        call1.enqueue(new Callback<CommonResult<HomeCountRes>>() {
            @Override
            public void onResponse(Call<CommonResult<HomeCountRes>> call, Response<CommonResult<HomeCountRes>> response) {
                CommonResult result = response.body();
                if (result!=null && result.getCode() == ResultCode.SUCCESS.getCode()) {
                    initWarningItem((HomeCountRes) result.getData());
                } else {
                    HomeCountRes res = new HomeCountRes();
                    res.setLowStockCount("0");
                    res.setOrderCount("0");
                    res.setOverdueCount("0");
                    res.setStockCount("0");
                    initWarningItem(res);
                    ToastUtil.show(HomeActivity.this, "获取预警数据失败");
                }
            }

            @Override
            public void onFailure(Call<CommonResult<HomeCountRes>> call, Throwable t) {
                call.cancel();
                ToastUtil.show(HomeActivity.this, Constance.DICT.NET_ON_FAILURE);
            }
        });

    }

    /**
     * 初始化预警按钮
     * @param res HomeCountRes
     */
    private void initWarningItem(HomeCountRes res) {
        List<HomeWarningBean> warningList = new ArrayList<>();
        HomeWarningBean item1 = new HomeWarningBean();
        item1.setBtnName(Constance.warningNameList[0]);
        item1.setWarningNum(res.getLowStockCount());
        warningList.add(item1);

        HomeWarningBean item2 = new HomeWarningBean();
        item2.setBtnName(Constance.warningNameList[1]);
        item2.setWarningNum(res.getOverdueCount());
        warningList.add(item2);

        warningAdapter.setList(warningList);
        warningAdapter.notifyDataSetChanged();
    }

    /**
     * 退出登录
     */
    private void logout() {
        LoginService apiInterface = RestClient.getClient(HomeActivity.this).create(LoginService.class);
        Call<CommonResult> call1 = apiInterface.logout();
        call1.enqueue(new Callback<CommonResult>() {
            @Override
            public void onResponse(Call<CommonResult> call, Response<CommonResult> response) {
//                CommonResult result = response.body();

//                if (result == null) {
//                    ToastUtil.show(HomeActivity.this, Constance.DICT.RES_FAILURE);
//                    return;
//                }
//
//                if (result.getCode() != ResultCode.SUCCESS.getCode()) {
//                    ToastUtil.show(HomeActivity.this, "退出登录失败");
//                }

                clearData();
            }

            @Override
            public void onFailure(Call<CommonResult> call, Throwable t) {
                call.cancel();
                t.printStackTrace();
                clearData();
            }
        });

    }

    private void clearData() {
        SharedPreferencesUtil.getInstance(this).setKeyValue(Constance.SHAREP.USERINFO, "");
        SharedPreferencesUtil.getInstance(this).setKeyValue(Constance.SHAREP.TOKEN, "");
        SharedPreferencesUtil.getInstance(this).setKeyValue(Constance.SHAREP.USER_ROLE_ID, "");
        SharedPreferencesUtil.getInstance(this).setKeyValue(Constance.SHAREP.PASSWORD,"");
        LoginActivity.show(this);
        curContext = null;
    }

}
