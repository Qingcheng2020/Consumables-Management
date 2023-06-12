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

import java.util.ArrayList;
import java.util.List;

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
import jp.co.nss.wms.model.ReagentCloseReq;
import jp.co.nss.wms.model.ResultCode;
import jp.co.nss.wms.ui.adapter.ItemCloseAdapter;
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

/**
 * Created by nss.
 * 终了
 */

public class ItemCloseActivity extends BaseActivity implements OnDismissCallback {

    ItemCloseAdapter mAdapter;
    @BindView(R.id.activity_googlecards_listview)
    ListView mListView;

    @BindView(R.id.et_search)
    AutoCompleteTextView etSearch;

    @BindView(R.id.btn_search)
    Button btnSearch;

    @BindView(R.id.btn_save)
    Button btnSave;

    List<ReagentDetailVm> itemList = new ArrayList<>();


    public static void show(Context context) {
        Intent intent = new Intent(context, ItemCloseActivity.class);
        context.startActivity(intent);
    }

    @Override
    protected void initView() {
        super.initView();
        ButterKnife.bind(this);
        EventBus.getDefault().register(this);
        mBtnLeft.setVisibility(View.VISIBLE);
        setTitle("终了");
        addAdapter();

        etSearch.setOnKeyListener(new View.OnKeyListener() {
            @Override
            public boolean onKey(View v, int i, KeyEvent keyEvent) {
                if (i == KeyEvent.KEYCODE_ENTER) {
                    String value = etSearch.getText().toString();
                    if (!StringUtil.isEmpty(value)) {
                        etSearch.setText("");
                        getDate(value);
                    }
                    return true;
                }
                return false;
            }
        });

    }

    @Override
    protected void onDestroy() {
        EventBus.getDefault().unregister(this);
        super.onDestroy();
    }

    @Subscribe(threadMode = ThreadMode.MAIN)
    public void MessageEventBus(MessageEvent msg) {
    }

    private void addAdapter() {
        mAdapter = new ItemCloseAdapter(this);
        SwingBottomInAnimationAdapter swingBottomInAnimationAdapter = new SwingBottomInAnimationAdapter(new SwipeDismissAdapter(mAdapter, this));
        swingBottomInAnimationAdapter.setInitialDelayMillis(300);
        swingBottomInAnimationAdapter.setAbsListView(mListView);
        mListView.setAdapter(swingBottomInAnimationAdapter);

    }

    @Override
    protected int getContentResId() {
        return R.layout.activity_itemclose;
    }

    private void getDate(String searchKey) {
        LoadingUtil.showLoading(this);

        String username = SharedPreferencesUtil.getInstance(this).getKeyValue(Constance.SHAREP.LOGINNAME);
        String _searchKey = CommonUtil.qrcode2param(searchKey);

        StockService apiInterface = RestClient.getClient(this).create(StockService.class);
        Call<CommonResult<ReagentDetailVm>> call1 = apiInterface.findItemByQrcode(_searchKey, username, "1");
        call1.enqueue(new Callback<CommonResult<ReagentDetailVm>>() {
            @Override
            public void onResponse(Call<CommonResult<ReagentDetailVm>> call, Response<CommonResult<ReagentDetailVm>> response) {
                CommonResult<ReagentDetailVm> result = response.body();

                if (result == null) {
                    ToastUtil.show(ItemCloseActivity.this, Constance.DICT.RES_FAILURE);
                    LoadingUtil.hideLoading();
                    return;
                }

                if (result.getCode() == ResultCode.SUCCESS.getCode()) {
                    ReagentDetailVm item = result.getData();
                    if (item == null) {
                        ToastUtil.show(ItemCloseActivity.this, Constance.DICT.DATA_NOT_FOUND);
                    } else {
                        // 检查出库顺序
                        // earlierNum 为 0 则数据库中不存在更早过期的试剂
                        if (item.getEarlierNum() == 0) {
                            addItem(item);
                            mAdapter.setItemsList(itemList);
                            mAdapter.notifyDataSetChanged();
                        } else {
                            // earlierNum 不为 0
                            // 需要检查是否和草稿中的试剂数量对应
                            // 若数量相等，则可以将当前的试剂存入草稿
                            if (!checkDraft(item.getEarlierNum())) {
                                // 不存在于草稿中，提示存在更早过期的试剂，禁入草稿
                                ToastUtil.show(ItemCloseActivity.this, Constance.DICT.DATA_IS_NOT_EARLIER);
                            } else {
                                // 数据库中更早过期的试剂数组 已全部存在于草稿中
                                // 这时扫码查询的单个数据可插入到草稿中
                                addItem(item);
                                mAdapter.setItemsList(itemList);
                                mAdapter.notifyDataSetChanged();
                            }
                        }

                    }
                } else {
                    ToastUtil.show(ItemCloseActivity.this, result.getMessage());
                }
                LoadingUtil.hideLoading();
            }

            @Override
            public void onFailure(Call<CommonResult<ReagentDetailVm>> call, Throwable t) {
                call.cancel();
                t.printStackTrace();
                ToastUtil.show(ItemCloseActivity.this, Constance.DICT.NET_ON_FAILURE);
                LoadingUtil.hideLoading();
            }
        });
    }

    private void  addItem(ReagentDetailVm item ) {
        if (item == null) return;
        ReagentDetailVm obj = null;
        for (ReagentDetailVm vm: itemList) {
            if (item.getBatchNo().equals(vm.getBatchNo())) obj = vm;
        }
        if (obj == null) {
            item.setQuantity(1);
            item.getQrList().add(item.getQrCode());
            itemList.add(item);
        } else {
            if (obj.getQrList().contains(item.getQrCode())) {
                // 重复扫码
                ToastUtil.show(this, Constance.DICT.QR_CODE_REPEAT);
            } else {
                obj.getQrList().add(item.getQrCode());
                obj.setQuantity(obj.getQuantity() + 1);
            }
        }

    }

    /**
     * 检查草稿中是否包含 数据库中更早过期的试剂
     * @param earlierNum 数据库中更早过期的试剂数量
     * @return false-数据库中仍存在更早过期的试剂；true-数据库中不存在更早过期的试剂
     */
    private boolean checkDraft(Integer earlierNum) {
        int countDraft = 0;
        for (ReagentDetailVm draft: itemList) {
            countDraft += draft.getQrList().size();
        }
        return earlierNum <= countDraft;
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


    @OnClick(R.id.btn_search)
    public void onSearchViewClicked() {
        System.out.println("XXXXX");
    }

    @OnClick(R.id.btn_save)
    public void onSaveViewClicked() {
        saveData();
    }

    private void saveData() {
        LoadingUtil.showLoading(this);

        //Req做成
        ReagentCloseReq req = new ReagentCloseReq();
        req.setReagentStatus("3");  // 3-用尽
        req.setCreateBy(SharedPreferencesUtil.getInstance(this).getKeyValue(Constance.SHAREP.LOGINNAME));
        for (ReagentDetailVm vm: itemList) {
            req.getQrList().addAll(vm.getQrList());
        }

        StockService apiInterface = RestClient.getClient(this).create(StockService.class);
        Call<CommonResult<Integer>> call1 = apiInterface.closeReagent(req);

        call1.enqueue(new Callback<CommonResult<Integer>>() {
            @Override
            public void onResponse(Call<CommonResult<Integer>> call, Response<CommonResult<Integer>> response) {
                CommonResult<Integer> result = response.body();
                if (result.getCode() == ResultCode.SUCCESS.getCode()) {
                    if (result.getData() == 1) {
                        clearData();
                    } else {
                        ToastUtil.show(ItemCloseActivity.this, Constance.DICT.RES_FAILURE);
                    }

                } else {
                    ToastUtil.show(ItemCloseActivity.this, result.getMessage());
                }
                LoadingUtil.hideLoading();
            }

            @Override
            public void onFailure(Call<CommonResult<Integer>> call, Throwable t) {
                t.printStackTrace();
                LoadingUtil.hideLoading();
            }
        });

    }

    private  void clearData(){
        ToastUtil.show(this, "终了成功");

        itemList = new ArrayList<>();
        mAdapter.setItemsList(itemList);
        mAdapter.notifyDataSetChanged();

        LoadingUtil.hideLoading();
    }

}
