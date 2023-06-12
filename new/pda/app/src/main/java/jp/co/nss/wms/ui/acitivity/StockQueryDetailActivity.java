package jp.co.nss.wms.ui.acitivity;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ListView;
import android.widget.TextView;

import com.nhaarman.listviewanimations.itemmanipulation.swipedismiss.OnDismissCallback;
import com.nhaarman.listviewanimations.itemmanipulation.swipedismiss.SwipeDismissAdapter;

import org.greenrobot.eventbus.EventBus;
import org.greenrobot.eventbus.Subscribe;
import org.greenrobot.eventbus.ThreadMode;
import org.jetbrains.annotations.NotNull;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;
import jp.co.nss.wms.R;
import jp.co.nss.wms.api.StockService;
import jp.co.nss.wms.base.BaseActivity;
import jp.co.nss.wms.bean.bean.MessageEvent;
import jp.co.nss.wms.bean.bean.ReagentStock;
import jp.co.nss.wms.constance.Constance;
import jp.co.nss.wms.model.CommonResult;
import jp.co.nss.wms.model.ReagentDetailListReq;
import jp.co.nss.wms.model.ReagentStockReq;
import jp.co.nss.wms.model.ResultCode;
import jp.co.nss.wms.ui.adapter.StockQueryDetailAdapter;
import jp.co.nss.wms.util.LoadingUtil;
import jp.co.nss.wms.util.RestClient;
import jp.co.nss.wms.util.SharedPreferencesUtil;
import jp.co.nss.wms.util.ToastUtil;
import jp.co.nss.wms.util.listviewanimations.swinginadapters.prepared.SwingBottomInAnimationAdapter;
import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class StockQueryDetailActivity extends BaseActivity implements OnDismissCallback {

    private static ReagentStock dataReagentItem;

    StockQueryDetailAdapter mAdapter;
    @BindView(R.id.activity_googlecards_listview)
    ListView mListView;

    public static void show(Context context, ReagentStock item) {
        Intent intent = new Intent(context, StockQueryDetailActivity.class);
        context.startActivity(intent);
        dataReagentItem = item;
    }

    @Override
    protected void initView() {
        super.initView();
        ButterKnife.bind(this);
        EventBus.getDefault().register(this);
        mBtnLeft.setVisibility(View.VISIBLE);
        setTitle("同类试剂查询");

        addAdapter();

        getData();
    }


    private void addAdapter() {
        mAdapter = new StockQueryDetailAdapter(this);
        SwingBottomInAnimationAdapter swingBottomInAnimationAdapter = new SwingBottomInAnimationAdapter(new SwipeDismissAdapter(mAdapter, this));
        swingBottomInAnimationAdapter.setInitialDelayMillis(300);
        swingBottomInAnimationAdapter.setAbsListView(mListView);

        mListView.setAdapter(swingBottomInAnimationAdapter);
    }

    private void getData() {
        LoadingUtil.showLoading(this);

        String username = SharedPreferencesUtil.getInstance(this).getKeyValue(Constance.SHAREP.LOGINNAME);

        ReagentDetailListReq req = new ReagentDetailListReq();
        req.setKeyword(dataReagentItem.getStockNo());
        req.setUsername(username);

        StockService apiInterface = RestClient.getClient(this).create(StockService.class);
        Call<CommonResult<ReagentStockReq>> call1 = apiInterface.getStockDetailList(req);
        call1.enqueue(new Callback<CommonResult<ReagentStockReq>>() {
            @Override
            public void onResponse(Call<CommonResult<ReagentStockReq>> call, Response<CommonResult<ReagentStockReq>> response) {
                CommonResult result = response.body();

                if (result == null) {
                    ToastUtil.show(StockQueryDetailActivity.this, Constance.DICT.RES_FAILURE);
                    LoadingUtil.hideLoading();
                    return;
                }

                if (result.getCode() == ResultCode.SUCCESS.getCode()) {
                    ReagentStockReq data = (ReagentStockReq) result.getData();
                    List<ReagentStock> list = data.getList();
                    mAdapter.setStockQueryDetailList(list);
                    mAdapter.notifyDataSetChanged();
                    computedTotal(data.getTotal());
                }
                LoadingUtil.hideLoading();
            }

            @Override
            public void onFailure(Call<CommonResult<ReagentStockReq>> call, Throwable t) {
                call.cancel();
                t.printStackTrace();
                ToastUtil.show(StockQueryDetailActivity.this, Constance.DICT.NET_ON_FAILURE);
                LoadingUtil.hideLoading();
            }
        });

    }

    /**
     * 计算同类试剂总数
     * @param total long
     */
    private void computedTotal (long total) {
        String totalText = total + "";
        TextView tvTotal = (TextView) findViewById(R.id.tv_reagent_total);
        tvTotal.setText(totalText);
    }

    @Override
    protected int getContentResId() {
        return R.layout.activity_stock_query_detail;
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
    public void MessageEventBus(MessageEvent msg) {

    }

    @Override
    public void onDismiss(@NonNull @NotNull ViewGroup listView, @NonNull @NotNull int[] reverseSortedPositions) {
        for (int position : reverseSortedPositions) {
            mAdapter.remove(position);
        }
    }
}
