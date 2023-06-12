package jp.co.nss.wms.ui.acitivity;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ListView;

import com.nhaarman.listviewanimations.itemmanipulation.swipedismiss.OnDismissCallback;
import com.nhaarman.listviewanimations.itemmanipulation.swipedismiss.SwipeDismissAdapter;

import org.greenrobot.eventbus.EventBus;
import org.greenrobot.eventbus.Subscribe;
import org.greenrobot.eventbus.ThreadMode;
import org.jetbrains.annotations.NotNull;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;
import jp.co.nss.wms.R;
import jp.co.nss.wms.api.StockService;
import jp.co.nss.wms.base.BaseActivity;
import jp.co.nss.wms.bean.bean.MessageEvent;
import jp.co.nss.wms.bean.vm.ReagentDetailVm;
import jp.co.nss.wms.constance.Constance;
import jp.co.nss.wms.model.CommonResult;
import jp.co.nss.wms.model.ReagentOutDetailReq;
import jp.co.nss.wms.model.ReagentOutReq;
import jp.co.nss.wms.model.ResultCode;
import jp.co.nss.wms.ui.adapter.OperatorUnReagentDetailAdapter;
import jp.co.nss.wms.util.DateUtil;
import jp.co.nss.wms.util.LoadingUtil;
import jp.co.nss.wms.util.RestClient;
import jp.co.nss.wms.util.SharedPreferencesUtil;
import jp.co.nss.wms.util.ToastUtil;
import jp.co.nss.wms.util.listviewanimations.swinginadapters.prepared.SwingBottomInAnimationAdapter;
import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

/**
 * 试剂操作员扫描科室库中未出库的试剂
 * 试剂操作员可以出库该试剂
 */

public class OperatorUnReagentDetailActivity extends BaseActivity implements OnDismissCallback {
    OperatorUnReagentDetailAdapter mAdapter;

    @BindView(R.id.activity_googlecards_listview)
    ListView mListView;
    @BindView(R.id.btn_go_out)
    Button btnGoOut;

    private static ReagentDetailVm dataReagent;

    @Override
    protected int getContentResId() {
        return R.layout.activity_operator_un_reagent_detail;
    }

    public static void show(Context context, ReagentDetailVm vm) {
        Intent intent = new Intent(context, OperatorUnReagentDetailActivity.class);
        context.startActivity(intent);
        dataReagent = vm;
    }

    @Override
    protected void initView() {
        super.initView();
        ButterKnife.bind(this);
        EventBus.getDefault().register(this);
        mBtnLeft.setVisibility(View.VISIBLE);
        mTvUser.setVisibility(View.GONE);
        setTitle("试剂详情");

        addAdapter();

        mAdapter.setData(dataReagent);
    }

    private void addAdapter() {
        mAdapter = new OperatorUnReagentDetailAdapter(this);
        SwingBottomInAnimationAdapter swingBottomInAnimationAdapter = new SwingBottomInAnimationAdapter(new SwipeDismissAdapter(mAdapter, this));
        swingBottomInAnimationAdapter.setInitialDelayMillis(300);
        swingBottomInAnimationAdapter.setAbsListView(mListView);
        mListView.setAdapter(swingBottomInAnimationAdapter);
    }

    @OnClick(R.id.btn_go_out)
    public void onClickGoOut() {
        // 检查是否存在更早过期的试剂
        if (dataReagent.getEarlierNum() == 0) {
            reagentGoOut();
        } else {
            ToastUtil.show(OperatorUnReagentDetailActivity.this, Constance.DICT.DATA_IS_NOT_EARLIER);
        }
        System.out.println(dataReagent.getEarlierNum());
    }

    /**
     * 试剂出库 req
     */
    private void reagentGoOut() {
        LoadingUtil.showLoading(this);

        String username = SharedPreferencesUtil.getInstance(this).getKeyValue(Constance.SHAREP.LOGINNAME);

        ReagentOutReq req = new ReagentOutReq();
        req.setBillCreator(username);
        req.setApplicationUser(username);
        req.setBillDate(DateUtil.getDateStrYYYYMMDD());
        req.setRemark("");

        ReagentOutDetailReq detail = new ReagentOutDetailReq();
        detail.setId(dataReagent.getBillId());
        detail.setReagentId(dataReagent.getReagentId());
        detail.setReagentSpecification(dataReagent.getReagentSpecification());
        detail.setBatchNo(dataReagent.getBatchNo());
        detail.setFactory(dataReagent.getManufacturerName());
        detail.setRegistrationNo(dataReagent.getRegistrationNo());
        detail.setSupplierShortName(dataReagent.getSupplierShortName());
        detail.setReagentUnit(dataReagent.getReagentUnit());
        detail.setPrice(dataReagent.getReagentPrice());
        detail.setQuantity(1);
        detail.setTotal(dataReagent.getReagentPrice());
        detail.setExpireDate(DateUtil.getDate_ymd(dataReagent.getExpireDate()));
        detail.getQrList().add(dataReagent.getQrCode());
        detail.getReagentCodeList().add(dataReagent.getReagentCode());
        detail.getQrCodeValueList().add(dataReagent.getQrCodeValue());

        req.getDetails().add(detail);
        StockService apiInterface = RestClient.getClient(this).create(StockService.class);
        Call<CommonResult<Integer>> call1 = apiInterface.saveOutStock(req);

        call1.enqueue(new Callback<CommonResult<Integer>>() {
            @Override
            public void onResponse(Call<CommonResult<Integer>> call, Response<CommonResult<Integer>> response) {
                CommonResult<Integer> result = response.body();
                if ((result!=null) && (result.getCode() == ResultCode.SUCCESS.getCode())) {
                    if (result.getData() == 1) {
                        ToastUtil.show(OperatorUnReagentDetailActivity.this, "出库成功");
                        finish();
                    } else {
                        ToastUtil.show(OperatorUnReagentDetailActivity.this, Constance.DICT.RES_FAILURE);
                    }
                } else {
                    ToastUtil.show(OperatorUnReagentDetailActivity.this, "出库失败");
                }
                LoadingUtil.hideLoading();
            }

            @Override
            public void onFailure(Call<CommonResult<Integer>> call, Throwable t) {
                call.cancel();
                t.printStackTrace();
                ToastUtil.show(OperatorUnReagentDetailActivity.this, Constance.DICT.NET_ON_FAILURE);
                LoadingUtil.hideLoading();
            }
        });

    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        // TODO: add setContentView(...) invocation
        ButterKnife.bind(this);
    }

    @Override
    protected void onDestroy() {
        EventBus.getDefault().unregister(this);
        super.onDestroy();
    }

    @Subscribe(threadMode = ThreadMode.MAIN)
    public void MessageEventBus(MessageEvent msg) {}

    @Override
    public void onDismiss(@NonNull @NotNull ViewGroup listView, @NonNull @NotNull int[] reverseSortedPositions) {
        for (int position : reverseSortedPositions) {
            mAdapter.remove(position);
        }
    }

}
