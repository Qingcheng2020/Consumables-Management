package jp.co.nss.wms.ui.acitivity;

import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
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
import jp.co.nss.wms.model.ReagentCheckReq;
import jp.co.nss.wms.model.ResultCode;
import jp.co.nss.wms.ui.adapter.StockCheckAdapter;
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
 * 库损管理
 */

public class StockCheckActivity extends BaseActivity implements OnDismissCallback {

    StockCheckAdapter mAdapter;
    @BindView(R.id.activity_googlecards_listview)
    ListView mListView;

    @BindView(R.id.et_search)
    AutoCompleteTextView etSearch;

    @BindView(R.id.btn_search)
    Button btnSearch;

    @BindView(R.id.btn_save)
    Button btnSave;

    List<ReagentDetailVm> itemList = new ArrayList<>();

    // 库损类型
    // 0-丢失；1-破损；2-过期；3-用尽；4-其它原因库损
    CharSequence items[] = new CharSequence[] {"破损", "过期", "其它原因"};
    int typeTmp = 1;    // 库损类型，单选，默认为破损

    public static void show(Context context) {
        Intent intent = new Intent(context, StockCheckActivity.class);
        context.startActivity(intent);
    }

    @Override
    protected void initView() {
        super.initView();
        ButterKnife.bind(this);
        EventBus.getDefault().register(this);
        mBtnLeft.setVisibility(View.VISIBLE);
        setTitle("库损管理");
        addAdapter();

        etSearch.setOnKeyListener(new View.OnKeyListener() {
            @Override
            public boolean onKey(View v, int i, KeyEvent keyEvent) {
                if (i == KeyEvent.KEYCODE_ENTER) {
                    String  value = etSearch.getText().toString();
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
        mAdapter = new StockCheckAdapter(this);
        SwingBottomInAnimationAdapter swingBottomInAnimationAdapter = new SwingBottomInAnimationAdapter(new SwipeDismissAdapter(mAdapter, this));
        swingBottomInAnimationAdapter.setInitialDelayMillis(300);
        swingBottomInAnimationAdapter.setAbsListView(mListView);
        mListView.setAdapter(swingBottomInAnimationAdapter);

    }

    @Override
    protected int getContentResId() {
        return R.layout.activity_stockcheck;
    }

    private void getDate(String searchKey) {
        LoadingUtil.showLoading(this);

        String username = SharedPreferencesUtil.getInstance(this).getKeyValue(Constance.SHAREP.LOGINNAME);
        String _searchKey = CommonUtil.qrcode2param(searchKey);

        StockService apiInterface = RestClient.getClient(this).create(StockService.class);
        Call<CommonResult<ReagentDetailVm>> callC = apiInterface.findItemByQrcode(_searchKey, username);

        callC.enqueue(new Callback<CommonResult<ReagentDetailVm>>() {
            @Override
            public void onResponse(Call<CommonResult<ReagentDetailVm>> call, Response<CommonResult<ReagentDetailVm>> response) {
                CommonResult<ReagentDetailVm> result = response.body();

                if (result == null) {
                    ToastUtil.show(StockCheckActivity.this, Constance.DICT.RES_FAILURE);
                    LoadingUtil.hideLoading();
                    return;
                }

                if (result.getCode() == ResultCode.SUCCESS.getCode()) {
                    ReagentDetailVm item = result.getData();
                    if (item == null) {
                        ToastUtil.show(StockCheckActivity.this, Constance.DICT.DATA_NOT_FOUND);
                    } else {
                        addItem(item);
                        mAdapter.setItemsList(itemList);
                        mAdapter.notifyDataSetChanged();
                        LoadingUtil.hideLoading();
                    }
                } else {
                    ToastUtil.show(StockCheckActivity.this, result.getMessage());
                }
                LoadingUtil.hideLoading();
            }

            @Override
            public void onFailure(Call<CommonResult<ReagentDetailVm>> call, Throwable t) {
                call.cancel();
                ToastUtil.show(StockCheckActivity.this, Constance.DICT.NET_ON_FAILURE);
                t.printStackTrace();
                LoadingUtil.hideLoading();
            }
        });

    }

    private void  addItem(ReagentDetailVm item) {
        if (item == null) return;
        ReagentDetailVm obj = null;

        for (ReagentDetailVm vm: itemList) {
            if (item.getBillId().equals(vm.getBillId())) obj = vm;
        }
        if (obj == null) {  // 未扫过码的试剂
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

    // 保存更新试剂库损数据
    @OnClick(R.id.btn_save)
    public void onSaveViewClicked() {
        if (itemList.size() == 0) {
            ToastUtil.show(StockCheckActivity.this, Constance.DICT.DATA_DRAFT_IS_NULL);
            return;
        }

        AlertDialog.Builder adb = new AlertDialog.Builder(this);
        adb.setSingleChoiceItems(items, 0, new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface d, int n) {
                // 点击 radio 事件
                typeTmp = n + 1;
            }
        });
        adb.setNegativeButton("取消", null);
        adb.setPositiveButton("确认", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                saveData();
            }
        });
        adb.setTitle("选择库损类型");
        adb.show();
    }

    private void saveData() {
        LoadingUtil.showLoading(this);

        StockService apiInterface = RestClient.getClient(this).create(StockService.class);

        ReagentCheckReq req = new ReagentCheckReq();
        req.setCreateBy(SharedPreferencesUtil.getInstance(this).getKeyValue(Constance.SHAREP.LOGINNAME));

        if (typeTmp == 3) typeTmp = 4;
        req.setReagentStatus(typeTmp+"");

        for (ReagentDetailVm item: itemList) {
            req.getQrList().addAll(item.getQrList());
        }

        Call<CommonResult<Integer>> call1 = apiInterface.checkStock(req);

        call1.enqueue(new Callback<CommonResult<Integer>>() {
            @Override
            public void onResponse(Call<CommonResult<Integer>> call, Response<CommonResult<Integer>> response) {
                CommonResult<Integer> result = response.body();
                if (result.getCode() == ResultCode.SUCCESS.getCode()) {
                    if (result.getData() == 1) {    // 处理成功
                        clearData();
                    } else { // 处理失败
                        ToastUtil.show(StockCheckActivity.this, Constance.DICT.RES_FAILURE);
                    }
                } else {
                    ToastUtil.show(StockCheckActivity.this, Constance.DICT.RES_FAILURE);
                }
                LoadingUtil.hideLoading();
            }

            @Override
            public void onFailure(Call<CommonResult<Integer>> call, Throwable t) {
                call.cancel();
                t.printStackTrace();
                ToastUtil.show(StockCheckActivity.this, Constance.DICT.NET_ON_FAILURE);
                LoadingUtil.hideLoading();
            }
        });

    }

    private  void clearData(){
        ToastUtil.show(this, "库损成功");

        itemList = new ArrayList<>();
        mAdapter.setItemsList(itemList);
        mAdapter.notifyDataSetChanged();

        LoadingUtil.hideLoading();
    }

    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event) {
        if (keyCode == KeyEvent.KEYCODE_BACK
                && event.getAction() == KeyEvent.ACTION_DOWN) {
            AlertDialog.Builder builder = new AlertDialog.Builder(this);
            builder.setMessage("确认返回？")
                    .setPositiveButton("确认", new DialogInterface.OnClickListener() {
                        @Override
                        public void onClick(DialogInterface dialog, int which) {
                            finish();
                        }
                    })
                    .setNegativeButton("取消", new DialogInterface.OnClickListener() {
                        @Override
                        public void onClick(DialogInterface dialogInterface, int i) {
                            dialogInterface.dismiss();
                        }
                    }).create().show();
        }
        return super.onKeyDown(keyCode, event);
    }

}
