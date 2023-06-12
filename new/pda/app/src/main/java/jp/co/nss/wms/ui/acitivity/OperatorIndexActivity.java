package jp.co.nss.wms.ui.acitivity;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.util.Log;
import android.view.KeyEvent;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AutoCompleteTextView;
import android.widget.Button;
import android.widget.ListView;
import android.widget.TextView;

import com.nhaarman.listviewanimations.itemmanipulation.swipedismiss.OnDismissCallback;
import com.nhaarman.listviewanimations.itemmanipulation.swipedismiss.SwipeDismissAdapter;

import org.greenrobot.eventbus.EventBus;
import org.greenrobot.eventbus.Subscribe;
import org.greenrobot.eventbus.ThreadMode;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;
import jp.co.nss.wms.LoginActivity;
import jp.co.nss.wms.R;
import jp.co.nss.wms.api.LoginService;
import jp.co.nss.wms.api.StockService;
import jp.co.nss.wms.base.BaseActivity;
import jp.co.nss.wms.bean.bean.MessageEvent;
import jp.co.nss.wms.bean.bean.ReagentStock;
import jp.co.nss.wms.bean.vm.ReagentDetailVm;
import jp.co.nss.wms.constance.Constance;
import jp.co.nss.wms.model.CommonResult;
import jp.co.nss.wms.model.ResultCode;
import jp.co.nss.wms.ui.adapter.OperatorIndexAdapter;
import jp.co.nss.wms.util.CommonUtil;
import jp.co.nss.wms.util.LoadingUtil;
import jp.co.nss.wms.util.RestClient;
import jp.co.nss.wms.util.SharedPreferencesUtil;
import jp.co.nss.wms.util.StringUtil;
import jp.co.nss.wms.util.ToastUtil;
import jp.co.nss.wms.util.listviewanimations.swinginadapters.prepared.SwingBottomInAnimationAdapter;
import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class OperatorIndexActivity extends BaseActivity implements OnDismissCallback {

    private static String TAG = "OperatorIndexActivity";

    OperatorIndexAdapter mAdapter;

    @BindView(R.id.et_search)
    AutoCompleteTextView etSearch;
    @BindView(R.id.tv_user)
    TextView tvUser;
    @BindView(R.id.btn_titlebar_right)
    Button btnLogout;
    @BindView(R.id.btn_refresh)
    Button btnRefresh;
    @BindView(R.id.activity_googlecards_listview)
    ListView mListView;

    private boolean isLoadingData = false;
    List<ReagentStock> dataList;

    @Override
    protected int getContentResId() {
        return R.layout.activity_operator_index;
    }

    @Override
    protected void onResume() {
        super.onResume();
        getDataAllReagent();
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        // TODO: add setContentView(...) invocation
        setContentView(R.layout.activity_operator_index);
        init();
    }

    public static void show(Context context) {
        Intent intent = new Intent(context, OperatorIndexActivity.class);
        context.startActivity(intent);
    }

    private void init() {
        super.initView();
        ButterKnife.bind(this);

        // 退出登录按钮
        btnLogout.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                logout();
            }
        });
        tvUser.setText(SharedPreferencesUtil.getInstance(this).getKeyValue(Constance.SHAREP.NICKNAME));

        addAdapter();

        etSearch.setOnKeyListener(new View.OnKeyListener() {
            @Override
            public boolean onKey(View v, int i, KeyEvent keyEvent) {
                if (i == KeyEvent.KEYCODE_ENTER) {
                    String value = etSearch.getText().toString();
                    if (!StringUtil.isEmpty(value)) {
                        etSearch.setText("");
                        getDataItem(value);
                    }
                    return true;
                }
                return false;
            }
        });

        getDataAllReagent();

    }

    private void addAdapter() {
        mAdapter = new OperatorIndexAdapter(this);
        SwingBottomInAnimationAdapter swingBottomInAnimationAdapter = new SwingBottomInAnimationAdapter(new SwipeDismissAdapter(mAdapter, this));
        swingBottomInAnimationAdapter.setInitialDelayMillis(300);
        swingBottomInAnimationAdapter.setAbsListView(mListView);
        mListView.setAdapter(swingBottomInAnimationAdapter);
    }

    @OnClick(R.id.btn_refresh)
    public void onClickRefresh() {
        isLoadingData = false;
        getDataAllReagent();
    }

    @Override
    public void onDismiss(@NonNull ViewGroup listView, @NonNull int[] reverseSortedPositions) {
        for (int position : reverseSortedPositions) {
            mAdapter.remove(position);
        }
    }

    @Override
    protected void onDestroy() {
        EventBus.getDefault().unregister(this);
        super.onDestroy();
    }

    @Subscribe(threadMode = ThreadMode.MAIN)
    public void MessageEventBus(MessageEvent msg) {}

    /**
     * 获取名下的所有试剂
     */
    private void getDataAllReagent() {
        dataList = new ArrayList<>();
        mAdapter.setData(dataList);
        mAdapter.notifyDataSetChanged();

        if (isLoadingData) return;
        isLoadingData = true;
        LoadingUtil.showLoading(this);

        String stockType = SharedPreferencesUtil.getInstance(this).getKeyValue(Constance.SHAREP.STOCK_TYPE);
        String username = SharedPreferencesUtil.getInstance(this).getKeyValue(Constance.SHAREP.LOGINNAME);

        StockService apiInterface = RestClient.getClient(this).create(StockService.class);

        Call<CommonResult<List<ReagentStock>>> call1 = apiInterface.getOperatorStockList(username, stockType);
        call1.enqueue(new Callback<CommonResult<List<ReagentStock>>>() {
            @Override
            public void onResponse(Call<CommonResult<List<ReagentStock>>> call, Response<CommonResult<List<ReagentStock>>> response) {
                CommonResult<List<ReagentStock>> result = response.body();
                if ((result!=null) && (result.getCode()==ResultCode.SUCCESS.getCode())) {
                    List<ReagentStock> list = result.getData();
                    mAdapter.setData(list);
                    mAdapter.notifyDataSetChanged();

                } else {
                    ToastUtil.show(OperatorIndexActivity.this, "获取库存数据失败");

                }
                LoadingUtil.hideLoading();
                isLoadingData = false;
            }

            @Override
            public void onFailure(Call<CommonResult<List<ReagentStock>>> call, Throwable t) {
                call.cancel();
                t.printStackTrace();
                ToastUtil.show(OperatorIndexActivity.this, Constance.DICT.NET_ON_FAILURE);
                LoadingUtil.hideLoading();
                isLoadingData = false;
            }
        });

    }

    /**
     * 扫码获取试剂
     * @param qrcode qr
     */
    private void getDataItem(String qrcode) {
        LoadingUtil.showLoading(this);

        String username = SharedPreferencesUtil.getInstance(this).getKeyValue(Constance.SHAREP.LOGINNAME);
        String _qrcode = CommonUtil.qrcode2param(qrcode);

        StockService apiInterface = RestClient.getClient(this).create(StockService.class);
        Call<CommonResult<ReagentDetailVm>> call2 = apiInterface.findItemByQrcode(_qrcode, username, "1", null, "1");
        call2.enqueue(new Callback<CommonResult<ReagentDetailVm>>() {
            @Override
            public void onResponse(Call<CommonResult<ReagentDetailVm>> call, Response<CommonResult<ReagentDetailVm>> response) {
                CommonResult result = response.body();

                if (result == null) {
                    ToastUtil.show(OperatorIndexActivity.this, Constance.DICT.RES_FAILURE);
                    LoadingUtil.hideLoading();
                    return;
                }

                if (result.getCode() == ResultCode.SUCCESS.getCode()) {
                    ReagentDetailVm item = (ReagentDetailVm) result.getData();
                    if (item == null) {
                        ToastUtil.show(OperatorIndexActivity.this, Constance.DICT.DATA_NOT_FOUND);
                    } else {
                        // 已出库
                        if (item.getReagentStatus().equals("1999")) {
                            OperatorReagentDetailActivity.show(OperatorIndexActivity.this, item);
                        } else {    // 未出库
                            OperatorUnReagentDetailActivity.show(OperatorIndexActivity.this, item);
                        }

                    }

                } else {
                    ToastUtil.show(OperatorIndexActivity.this, result.getMessage());
                }
                LoadingUtil.hideLoading();
            }

            @Override
            public void onFailure(Call<CommonResult<ReagentDetailVm>> call, Throwable t) {
                call.cancel();
                t.printStackTrace();
                ToastUtil.show(OperatorIndexActivity.this, Constance.DICT.NET_ON_FAILURE);
                LoadingUtil.hideLoading();
            }
        });

    }

    /**
     * 退出登录
     */
    private void logout() {
        LoginService apiInterface = RestClient.getClient(OperatorIndexActivity.this).create(LoginService.class);
        Call<CommonResult> call1 = apiInterface.logout();
        call1.enqueue(new Callback<CommonResult>() {
            @Override
            public void onResponse(Call<CommonResult> call, Response<CommonResult> response) {
                CommonResult result = response.body();

                if (result == null || result.getCode() != ResultCode.SUCCESS.getCode()) {
                    Log.e(TAG, "退出登录失败");
                }

                ToastUtil.show(OperatorIndexActivity.this, "登出成功");

                SharedPreferencesUtil.getInstance(OperatorIndexActivity.this).setKeyValue(Constance.SHAREP.USERINFO, "");
                SharedPreferencesUtil.getInstance(OperatorIndexActivity.this).setKeyValue(Constance.SHAREP.TOKEN, "");
                SharedPreferencesUtil.getInstance(OperatorIndexActivity.this).setKeyValue(Constance.SHAREP.USER_ROLE_ID, "");
                SharedPreferencesUtil.getInstance(OperatorIndexActivity.this).setKeyValue(Constance.SHAREP.PASSWORD,"");
                LoginActivity.show(OperatorIndexActivity.this);
                curContext = null;
                finish();
            }

            @Override
            public void onFailure(Call<CommonResult> call, Throwable t) {
                call.cancel();
                ToastUtil.show(OperatorIndexActivity.this, Constance.DICT.NET_ON_FAILURE);
                finish();
            }
        });

    }

}
