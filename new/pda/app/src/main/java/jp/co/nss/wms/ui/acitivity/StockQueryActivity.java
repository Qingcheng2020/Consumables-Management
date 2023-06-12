package jp.co.nss.wms.ui.acitivity;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.view.KeyEvent;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AutoCompleteTextView;
import android.widget.Button;
import android.widget.ListView;

import com.nhaarman.listviewanimations.itemmanipulation.swipedismiss.OnDismissCallback;
import com.nhaarman.listviewanimations.itemmanipulation.swipedismiss.SwipeDismissAdapter;

import org.greenrobot.eventbus.EventBus;
import org.greenrobot.eventbus.Subscribe;
import org.greenrobot.eventbus.ThreadMode;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;
import jp.co.nss.wms.R;
import jp.co.nss.wms.api.StockService;
import jp.co.nss.wms.base.BaseActivity;
import jp.co.nss.wms.bean.bean.MessageEvent;
import jp.co.nss.wms.bean.bean.ReagentStock;
import jp.co.nss.wms.bean.vm.ReagentDetailVm;
import jp.co.nss.wms.constance.Constance;
import jp.co.nss.wms.model.CommonResult;
import jp.co.nss.wms.model.ReagentLowListRes;
import jp.co.nss.wms.model.ReagentStockReq;
import jp.co.nss.wms.model.ResultCode;
import jp.co.nss.wms.ui.adapter.StockQueryAdapter;
import jp.co.nss.wms.util.CommonUtil;
import jp.co.nss.wms.util.DateUtil;
import jp.co.nss.wms.util.LoadingUtil;
import jp.co.nss.wms.util.RestClient;
import jp.co.nss.wms.util.SharedPreferencesUtil;
import jp.co.nss.wms.util.StringUtil;
import jp.co.nss.wms.util.ToastUtil;
import jp.co.nss.wms.util.listviewanimations.swinginadapters.prepared.SwingBottomInAnimationAdapter;
import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

/**
 * Created by nss.
 * 库存查询
 */

public class StockQueryActivity extends BaseActivity implements OnDismissCallback {

    StockQueryAdapter mAdapter;
    @BindView(R.id.activity_googlecards_listview)
    ListView mListView;
    @BindView(R.id.et_search)
    AutoCompleteTextView etSearch;
    @BindView(R.id.btn_search)
    Button btnSearch;
    @BindView(R.id.btn_reset)
    Button btnReset;
    @BindView(R.id.et_search2)
    AutoCompleteTextView etSearch2;

    // activity 类型
    // 默认为在库查询，正常的查询
    // 1-低库存查询；2-过期预警
    private static int flagPageType = 0;

    public static void show(Context context, int pageType) {
        Intent intent = new Intent(context, StockQueryActivity.class);
        context.startActivity(intent);
        flagPageType = pageType;
    }

    @Override
    protected void initView() {
        super.initView();
        ButterKnife.bind(this);
        EventBus.getDefault().register(this);
        mBtnLeft.setVisibility(View.VISIBLE);

        String tempTitle;
        if (flagPageType == 1) {
            tempTitle = Constance.warningNameList[0];
        } else if (flagPageType == 2) {
            tempTitle = Constance.warningNameList[1];
        } else {
            tempTitle = "在库";
        }
        tempTitle += "查询";
        setTitle(tempTitle);

        addAdapter();

        etSearch.setOnKeyListener(new View.OnKeyListener() {
            @Override
            public boolean onKey(View v, int i, KeyEvent keyEvent) {
                if (i == KeyEvent.KEYCODE_ENTER) {
                    String value = etSearch.getText().toString();
                    if (!StringUtil.isEmpty(value)) {
                        etSearch.setText("");
                        getDataPre(value, "", "");
                    }
                    return true;
                }
                return false;
            }
        });

        getDataPre("","", "");

    }

    @Override
    protected void onDestroy() {
        EventBus.getDefault().unregister(this);
        super.onDestroy();
    }
    @Subscribe(threadMode = ThreadMode.MAIN)
    public void MessageEventBus(MessageEvent msg) {
        getDataPre(etSearch.getText().toString(), etSearch2.getText().toString(), "");
    }

    private void addAdapter() {
        mAdapter = new StockQueryAdapter(this);
        SwingBottomInAnimationAdapter swingBottomInAnimationAdapter = new SwingBottomInAnimationAdapter(new SwipeDismissAdapter(mAdapter, this));
        swingBottomInAnimationAdapter.setInitialDelayMillis(300);
        swingBottomInAnimationAdapter.setAbsListView(mListView);

        mListView.setAdapter(swingBottomInAnimationAdapter);

    }

    @Override
    protected int getContentResId() {
        return R.layout.activity_picking;
    }

    /**
     * 按类型获取相应的数据
     */
    private void getDataPre(String qrcode, String reagentName, String supplierName) {
        if (flagPageType == 1) {
            // 低库存预警
            getLowData("1", reagentName, supplierName);
        } else if (flagPageType == 2) {
            // 过期预警
            getLowData("2", reagentName, supplierName);
        } else {
            // 普通在库查询
            getData(qrcode, reagentName);
        }
    }

    /**
     * 根据试剂名称查询或扫码查询单个试剂信息
     * @param stockQrcode String 二维码
     * @param reagentName String 试剂名称
     */
    private void getData(String stockQrcode,String reagentName) {
        LoadingUtil.showLoading(this);
        mAdapter.clearData();

        String stockType = SharedPreferencesUtil.getInstance(this).getKeyValue(Constance.SHAREP.STOCK_TYPE);
        String username = SharedPreferencesUtil.getInstance(this).getKeyValue(Constance.SHAREP.LOGINNAME);

        StockService apiInterface = RestClient.getClient(this).create(StockService.class);
        // 试剂名称查询
        if (stockQrcode.equals("")) {
            Call<CommonResult<ReagentStockReq>> call1 = apiInterface.searchList(stockType, username, reagentName);
            call1.enqueue(new Callback<CommonResult<ReagentStockReq>>() {
                @Override
                public void onResponse(Call<CommonResult<ReagentStockReq>> call, Response<CommonResult<ReagentStockReq>> response) {
                    CommonResult result = response.body();
                    if (result == null) {
                        ToastUtil.show(StockQueryActivity.this, Constance.DICT.RES_FAILURE);
                        LoadingUtil.hideLoading();
                        return;
                    }

                    if (result.getCode() == ResultCode.SUCCESS.getCode()) {
                        ReagentStockReq data = (ReagentStockReq) result.getData();
                        List<ReagentStock> list = data.getList();
                        mAdapter.setStockQueryList(list);
                        mAdapter.notifyDataSetChanged();
                    }
                    LoadingUtil.hideLoading();
                }

                @Override
                public void onFailure(Call<CommonResult<ReagentStockReq>> call, Throwable t) {
                    call.cancel();
                    t.printStackTrace();
                    ToastUtil.show(StockQueryActivity.this, Constance.DICT.NET_ON_FAILURE);
                    LoadingUtil.hideLoading();
                }
            });
        } else {
            // 二维码查询
            String _stockQrcode = CommonUtil.qrcode2param(stockQrcode);

            Call<CommonResult<ReagentDetailVm>> call2 = apiInterface.findItemByQrcode(_stockQrcode, username, null, "1");
            call2.enqueue(new Callback<CommonResult<ReagentDetailVm>>() {
                @Override
                public void onResponse(Call<CommonResult<ReagentDetailVm>> call, Response<CommonResult<ReagentDetailVm>> response) {
                    CommonResult result = response.body();

                    if (result == null) {
                        ToastUtil.show(StockQueryActivity.this, Constance.DICT.RES_FAILURE);
                        LoadingUtil.hideLoading();
                        return;
                    }

                    if (result.getCode() == ResultCode.SUCCESS.getCode()) {
                        ReagentDetailVm item = (ReagentDetailVm) result.getData();
                        if (item == null) {
                            ToastUtil.show(StockQueryActivity.this, Constance.DICT.DATA_NOT_FOUND);
                        } else {
                            ReagentStock detail = new ReagentStock();
                            detail.setReagentName(item.getReagentName());
                            detail.setBatchNo(item.getBatchNo());
                            detail.setExpireDate(DateUtil.getDate_ymd(item.getExpireDate()));
                            detail.setFactory(item.getManufacturerName());
                            detail.setSupplierName(item.getSupplierShortName());
                            detail.setQuantity(item.getReagentCount());
                            detail.setReagentStatus(item.getReagentStatus());
                            detail.setStockNo(item.getBillId());

                            mAdapter.setStock(detail);
                            mAdapter.notifyDataSetChanged();
                        }

                    } else {
                        ToastUtil.show(StockQueryActivity.this, result.getMessage());
                    }
                    LoadingUtil.hideLoading();
                }

                @Override
                public void onFailure(Call<CommonResult<ReagentDetailVm>> call, Throwable t) {
                    call.cancel();
                    t.printStackTrace();
                    ToastUtil.show(StockQueryActivity.this, Constance.DICT.NET_ON_FAILURE);
                    LoadingUtil.hideLoading();
                }
            });
        }

    }

    /**
     * 低库存和过期预警
     */
    private void getLowData(String type, String reagentName, String supplierName) {
        LoadingUtil.showLoading(this);

        String stockType = SharedPreferencesUtil.getInstance(this).getKeyValue(Constance.SHAREP.STOCK_TYPE);
        String username = SharedPreferencesUtil.getInstance(this).getKeyValue(Constance.SHAREP.LOGINNAME);

        StockService apiInterface = RestClient.getClient(this).create(StockService.class);
        Call<CommonResult<ReagentLowListRes>> call1 = apiInterface.getLowList(stockType, username, type, reagentName, supplierName);

        call1.enqueue(new Callback<CommonResult<ReagentLowListRes>>() {
            @Override
            public void onResponse(Call<CommonResult<ReagentLowListRes>> call, Response<CommonResult<ReagentLowListRes>> response) {
                CommonResult result = response.body();

                if (result == null) {
                    ToastUtil.show(StockQueryActivity.this, Constance.DICT.RES_FAILURE);
                    LoadingUtil.hideLoading();
                    return;
                }

                if (result.getCode() == ResultCode.SUCCESS.getCode()) {
                    ReagentLowListRes data = (ReagentLowListRes) result.getData();
                    if (data == null) {
                        ToastUtil.show(StockQueryActivity.this, Constance.DICT.DATA_NOT_FOUND);
                    } else {
                        List<ReagentStock> list = data.getList();
                        mAdapter.setStockQueryList(list);
                        mAdapter.notifyDataSetChanged();
                    }

                }
                LoadingUtil.hideLoading();
            }

            @Override
            public void onFailure(Call<CommonResult<ReagentLowListRes>> call, Throwable t) {
                call.cancel();
                t.printStackTrace();
                ToastUtil.show(StockQueryActivity.this, Constance.DICT.NET_ON_FAILURE);
                LoadingUtil.hideLoading();
            }
        });

    }

    @Override
    public void onDismiss(@NonNull ViewGroup listView, @NonNull int[] reverseSortedPositions) {
        for (int position : reverseSortedPositions) {
            mAdapter.remove(position);
        }
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        // TODO: add setContentView(...) invocation
        ButterKnife.bind(this);
    }

    // 重置按钮
    @OnClick(R.id.btn_reset)
    public void onResetClicked() {
        etSearch.setText("");
        etSearch2.setText("");
        getDataPre("", "", "");
    }

    @OnClick(R.id.btn_search)
    public void onViewClicked() {
        getDataPre("", etSearch2.getText().toString(), "");
    }

    /**
     * 点击「查看同类试剂」按钮，跳转到新页面
     * @param item 扫码获取的试剂数据
     */
    public void onLoadSimilar(ReagentStock item) {
        StockQueryDetailActivity.show(this, item);
    }
}
