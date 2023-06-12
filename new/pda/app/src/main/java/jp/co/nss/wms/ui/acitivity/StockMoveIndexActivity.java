package jp.co.nss.wms.ui.acitivity;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ListView;

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
import jp.co.nss.wms.R;
import jp.co.nss.wms.api.StockService;
import jp.co.nss.wms.base.BaseActivity;
import jp.co.nss.wms.bean.bean.MessageEvent;
import jp.co.nss.wms.bean.vm.ReagentMoveDetailVm;
import jp.co.nss.wms.bean.vm.ReagentMoveVm;
import jp.co.nss.wms.constance.Constance;
import jp.co.nss.wms.model.CommonResult;
import jp.co.nss.wms.model.ReagentMoveRes;
import jp.co.nss.wms.model.ResultCode;
import jp.co.nss.wms.ui.adapter.StockMoveIndexAdapter;
import jp.co.nss.wms.util.LoadingUtil;
import jp.co.nss.wms.util.RestClient;
import jp.co.nss.wms.util.SharedPreferencesUtil;
import jp.co.nss.wms.util.ToastUtil;
import jp.co.nss.wms.util.listviewanimations.swinginadapters.prepared.SwingBottomInAnimationAdapter;
import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class StockMoveIndexActivity extends BaseActivity implements OnDismissCallback {

    StockMoveIndexAdapter mAdapter;
    Boolean isFirstIn = true;

    @BindView(R.id.activity_googlecards_listview)
    ListView mListView;
    @BindView(R.id.et_search)
    EditText etSearch;
    @BindView(R.id.btn_reset)
    Button btnReset;
    @BindView(R.id.btn_search)
    Button btnSearch;

    @Override
    protected int getContentResId() {
        return R.layout.activity_stockmove_index;
    }

    public static void show(Context context) {
        Intent intent = new Intent(context, StockMoveIndexActivity.class);
        context.startActivity(intent);
    }

    @Override
    protected void initView() {
        super.initView();
        ButterKnife.bind(this);
        EventBus.getDefault().register(this);
        mBtnLeft.setVisibility(View.VISIBLE);
        setTitle("移库");
        addAdapter();
        getData("");

    }

    @Override
    protected void onResume() {
        super.onResume();

        List<ReagentMoveVm> list = new ArrayList<>();
        mAdapter.setItemsList(list);
        mAdapter.notifyDataSetChanged();

        // initView 之后会调用 onResume
        if (!isFirstIn) {
            getData("");
        } else {
            isFirstIn = false;
        }

    }

    private void addAdapter() {
        mAdapter = new StockMoveIndexAdapter(this);
        SwingBottomInAnimationAdapter swingBottomInAnimationAdapter = new SwingBottomInAnimationAdapter(new SwipeDismissAdapter(mAdapter, this));
        swingBottomInAnimationAdapter.setInitialDelayMillis(300);
        swingBottomInAnimationAdapter.setAbsListView(mListView);
        mListView.setAdapter(swingBottomInAnimationAdapter);
    }

    /**
     * 搜索
     */
    @OnClick(R.id.btn_search)
    public void onSearchClicked() {
        List<ReagentMoveVm> list = new ArrayList<>();
        mAdapter.setItemsList(list);
        getData(etSearch.getText().toString());
    }

    /**
     * 重置
     */
    @OnClick(R.id.btn_reset)
    public void onResetClicked() {
        etSearch.setText("");
        List<ReagentMoveVm> list = new ArrayList<>();
        mAdapter.setItemsList(list);
        getData("");
    }

    /**
     * 获取移库汇总
     * @param searchKey 关键字-申请单号/申请人
     */
    private void getData(String searchKey) {
        LoadingUtil.showLoading(this);

        String username = SharedPreferencesUtil.getInstance(this).getKeyValue(Constance.SHAREP.LOGINNAME);

        StockService apiInterface = RestClient.getClient(this).create(StockService.class);
        Call<CommonResult<ReagentMoveRes>> callC = apiInterface.getCollectList(username, searchKey);
        callC.enqueue(new Callback<CommonResult<ReagentMoveRes>>() {
            @Override
            public void onResponse(Call<CommonResult<ReagentMoveRes>> call, Response<CommonResult<ReagentMoveRes>> response) {
                CommonResult<ReagentMoveRes> result = response.body();
                if (result!=null && result.getCode()== ResultCode.SUCCESS.getCode()) {
                    ReagentMoveRes data = result.getData();
                    if (data == null) {
                        ToastUtil.show(StockMoveIndexActivity.this, Constance.DICT.DATA_NOT_FOUND);
                    } else {
                        List<ReagentMoveVm> list  = new ArrayList<>();

                        // 只显示已提交状态的试剂
                        for (ReagentMoveVm item: data.getList()) {
                            if (item.getCollectStatus().equals("1")) list.add(item);
                        }
                        mAdapter.setItemsList(list);
                        mAdapter.notifyDataSetChanged();
                    }
                } else {
                    ToastUtil.show(StockMoveIndexActivity.this, "获取移库列表失败");
                }
                LoadingUtil.hideLoading();
            }

            @Override
            public void onFailure(Call<CommonResult<ReagentMoveRes>> call, Throwable t) {
                call.cancel();
                ToastUtil.show(StockMoveIndexActivity.this, Constance.DICT.NET_ON_FAILURE);
                t.printStackTrace();
                LoadingUtil.hideLoading();
            }
        });
    }

    @Subscribe(threadMode = ThreadMode.MAIN)
    public void MessageEventBus(MessageEvent msg) {}

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

}
