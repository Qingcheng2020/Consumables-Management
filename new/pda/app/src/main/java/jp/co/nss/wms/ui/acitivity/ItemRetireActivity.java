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
import java.util.Date;
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
import jp.co.nss.wms.model.ReagentRefundReq;
import jp.co.nss.wms.model.ResultCode;
import jp.co.nss.wms.ui.adapter.ItemRetireAdapter;
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
 * 退货
 */

public class ItemRetireActivity extends BaseActivity implements OnDismissCallback {

    private static String TAG = "退货";

    ItemRetireAdapter mAdapter;
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
        Intent intent = new Intent(context, ItemRetireActivity.class);
        context.startActivity(intent);
    }

    @Override
    protected void initView() {
        super.initView();
        ButterKnife.bind(this);
        EventBus.getDefault().register(this);
        mBtnLeft.setVisibility(View.VISIBLE);
        setTitle("退货");
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
        mAdapter = new ItemRetireAdapter(this);
        SwingBottomInAnimationAdapter swingBottomInAnimationAdapter = new SwingBottomInAnimationAdapter(new SwipeDismissAdapter(mAdapter, this));
        swingBottomInAnimationAdapter.setInitialDelayMillis(300);
        swingBottomInAnimationAdapter.setAbsListView(mListView);
        mListView.setAdapter(swingBottomInAnimationAdapter);

    }

    @Override
    protected int getContentResId() {
        return R.layout.activity_itemretire;
    }

    private void getDate(String searchKey) {
        LoadingUtil.showLoading(this);

        String username = SharedPreferencesUtil.getInstance(this).getKeyValue(Constance.SHAREP.LOGINNAME);
        String _searchKey = CommonUtil.qrcode2param(searchKey);

        StockService apiInterface = RestClient.getClient(this).create(StockService.class);
        Call<CommonResult<ReagentDetailVm>> call1 = apiInterface.findItemByQrcode(_searchKey, username);
        call1.enqueue(new Callback<CommonResult<ReagentDetailVm>>() {
            @Override
            public void onResponse(Call<CommonResult<ReagentDetailVm>> call, Response<CommonResult<ReagentDetailVm>> response) {
                CommonResult<ReagentDetailVm> result = response.body();

                if (result == null) {
                    ToastUtil.show(ItemRetireActivity.this, Constance.DICT.RES_FAILURE);
                    LoadingUtil.hideLoading();
                    return;
                }

                if (result.getCode() == ResultCode.SUCCESS.getCode()) {
                    ReagentDetailVm item = result.getData();
                    if (item == null) {
                        ToastUtil.show(ItemRetireActivity.this, Constance.DICT.DATA_NOT_FOUND);
                    } else {
                        addItem(item);
                        mAdapter.setItemsList(itemList);
                        mAdapter.notifyDataSetChanged();
                    }
                } else {
                    ToastUtil.show(ItemRetireActivity.this, result.getMessage());
                }
                LoadingUtil.hideLoading();
            }

            @Override
            public void onFailure(Call<CommonResult<ReagentDetailVm>> call, Throwable t) {
                call.cancel();
                t.printStackTrace();
                ToastUtil.show(ItemRetireActivity.this, Constance.DICT.NET_ON_FAILURE);
                LoadingUtil.hideLoading();
            }
        });

    }

    private void  addItem(ReagentDetailVm item ) {
        if (item == null) return;

        long timeNow = new Date().getTime();
        long timeItem = item.getExpireDate().getTime();

        // 已过期试剂，禁止退货
        if (item.getReagentStatus().equals("2") || timeItem-timeNow<=0) {
            ToastUtil.show(this, "试剂已过期");
            return;
        }

        ReagentDetailVm obj = null;
        for (ReagentDetailVm vm: itemList) {
            if (item.getBillId().equals(vm.getBillId())) obj = vm;
        }
        if (obj == null) {
            item.setQuantity(1);
            item.getQrList().add(item.getQrCode());
            item.getQrIdList().add(item.getQrId());
            itemList.add(item);
        } else {
            if (obj.getQrList().contains(item.getQrCode())) {
                // 重复扫码
                ToastUtil.show(this, Constance.DICT.QR_CODE_REPEAT);
            } else {
                obj.getQrList().add(item.getQrCode());
                obj.getQrIdList().add(item.getQrId());
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

    @OnClick(R.id.btn_save)
    public void onSaveViewClicked() {
        if (itemList.size() == 0) {
            ToastUtil.show(ItemRetireActivity.this, Constance.DICT.DATA_DRAFT_IS_NULL);
            return;
        }
        saveData();
    }

    private void saveData() {
//        ReagentRetireReq req = new ReagentRetireReq();
//        String userRoleID = SharedPreferencesUtil.getInstance(this).getKeyValue(Constance.SHAREP.USER_ROLE_ID);
//        int billType = 0, refundType = 0;
//        if (userRoleID.equals("1")) {    // 一级中心库管
//            billType = 1;   // 1-中心库领用/移库/退货出库单（中心出给科室或人）
//            refundType = 1; // 1-一级中心退货
//        } else if (userRoleID.equals("3")) { // 二级科室管理
//            billType = 2;   // 2-科室库领用/退货出库；
//            refundType = 3; // 2-二级中心退货
//        } else if (userRoleID.equals("6")) { // 二级中心库
//            billType = 3;   // 3-二级中心库出库（移库/退货）
//            refundType = 2; // 3-二级科室退货
//        } else {
//            ToastUtil.show(this, "未知的userRoleID");
//            return;
//        }
//        req.setBillType(billType);
//        req.setRefundType(refundType);
//        req.setCreateBy(SharedPreferencesUtil.getInstance(this).getKeyValue(Constance.SHAREP.LOGINNAME));
//        req.setStockType(SharedPreferencesUtil.getInstance(this).getKeyValue(Constance.SHAREP.STOCK_TYPE));
//        req.setRefundStatus(1);
//        for (ReagentDetailVm vm: itemList) {
//            ReagentRetireDetailReq detail = new ReagentRetireDetailReq();
//            detail.setReagentId(vm.getReagentId());
//            detail.setStockNo(vm.getBillId());
//            detail.setQuantity(vm.getQuantity());
//            detail.setSupplierShortName(vm.getSupplierShortName());
//            detail.setReagentPrice(vm.getPrice());
//            req.getRefundMessList().add(detail);
//        }

        LoadingUtil.showLoading(this);

        ReagentRefundReq req = new ReagentRefundReq();
        req.setCreateBy(SharedPreferencesUtil.getInstance(this).getKeyValue(Constance.SHAREP.LOGINNAME));
        for (ReagentDetailVm vm: itemList) {
            req.getQrList().addAll(vm.getQrList());
        }

        StockService apiInterface = RestClient.getClient(this).create(StockService.class);
        Call<CommonResult<Integer>> call1 = apiInterface.refundReagent(req);
        call1.enqueue(new Callback<CommonResult<Integer>>() {
            @Override
            public void onResponse(Call<CommonResult<Integer>> call, Response<CommonResult<Integer>> response) {
                CommonResult<Integer> result = response.body();

                if (result == null) {
                    ToastUtil.show(ItemRetireActivity.this, Constance.DICT.RES_FAILURE);
                    LoadingUtil.hideLoading();
                    return;
                }

                if (result.getCode() == ResultCode.SUCCESS.getCode()) {
                    if (result.getData() == 1) {
                        clearData();
                    } else {
                        ToastUtil.show(ItemRetireActivity.this, Constance.DICT.RES_FAILURE);
                    }
                } else {
                    ToastUtil.show(ItemRetireActivity.this, result.getMessage());
                }
                LoadingUtil.hideLoading();
            }

            @Override
            public void onFailure(Call<CommonResult<Integer>> call, Throwable t) {
                call.cancel();
                t.printStackTrace();
                ToastUtil.show(ItemRetireActivity.this, Constance.DICT.NET_ON_FAILURE);
                LoadingUtil.hideLoading();
            }
        });

    }

    private  void clearData(){
        ToastUtil.show(this, "退货成功");

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
