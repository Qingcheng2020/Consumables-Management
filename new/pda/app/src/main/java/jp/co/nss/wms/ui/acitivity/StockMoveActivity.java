package jp.co.nss.wms.ui.acitivity;

import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.Typeface;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.view.KeyEvent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AutoCompleteTextView;
import android.widget.Button;
import android.widget.LinearLayout;
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
import jp.co.nss.wms.R;
import jp.co.nss.wms.api.StockService;
import jp.co.nss.wms.base.BaseActivity;
import jp.co.nss.wms.bean.bean.MessageEvent;
import jp.co.nss.wms.bean.vm.ReagentDetailVm;
import jp.co.nss.wms.bean.vm.ReagentMoveDetailVm;
import jp.co.nss.wms.bean.vm.ReagentMoveVm;
import jp.co.nss.wms.constance.Constance;
import jp.co.nss.wms.model.CommonResult;
import jp.co.nss.wms.model.ReagentMoveDetailRes;
import jp.co.nss.wms.model.ReagentMoveItemReq;
import jp.co.nss.wms.model.ReagentMoveReq;
import jp.co.nss.wms.model.ResultCode;
import jp.co.nss.wms.ui.adapter.StockMoveAdapter;
import jp.co.nss.wms.ui.adapter.StockMoveDetailAdapter;
import jp.co.nss.wms.ui.view.dialog.SyCustomDialog;
import jp.co.nss.wms.util.AlertDialogUtil;
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
 * 移库
 */

public class StockMoveActivity extends BaseActivity implements OnDismissCallback {

    StockMoveAdapter mAdapter;
    StockMoveDetailAdapter detailAdapter;
    ListView lvDialogDetail;

    @BindView(R.id.activity_googlecards_listview)
    ListView mListView;
    @BindView(R.id.et_search)
    AutoCompleteTextView etSearch;
    @BindView(R.id.tv_branch)
    TextView tvBranch;
    @BindView(R.id.tv_applicant)
    TextView tvApplicant;
    @BindView(R.id.tv_date)
    TextView tvDate;
    @BindView(R.id.btn_browser)
    Button btnBrowser;
    @BindView(R.id.btn_save)
    Button btnSave;

    // 从移库汇总传过来的单据数据
    private static ReagentMoveVm dataMove;
    List<ReagentMoveDetailVm> dataMoveDetailList = new ArrayList<>();
    // 移库申请单详情（排除草稿中已添加的试剂）
    List<ReagentMoveDetailVm> dataMoveDetailToShowList = new ArrayList<>();
    List<ReagentDetailVm> itemList = new ArrayList<>();

    public static void show(Context context, ReagentMoveVm vm) {
        Intent intent = new Intent(context, StockMoveActivity.class);
        context.startActivity(intent);
        dataMove = vm;
    }

    @Override
    protected void initView() {
        super.initView();
        ButterKnife.bind(this);
        EventBus.getDefault().register(this);
        mBtnLeft.setVisibility(View.VISIBLE);
        setTitle("移库");
        addAdapter();

        getMoveDetailData();

        tvApplicant.setText(dataMove.getCreateName());
        tvBranch.setText(dataMove.getBranch());
        tvDate.setText(DateUtil.getDate_ymd(dataMove.getCreateTime()));

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
        mAdapter = new StockMoveAdapter(this);
        SwingBottomInAnimationAdapter swingBottomInAnimationAdapter = new SwingBottomInAnimationAdapter(new SwipeDismissAdapter(mAdapter, this));
        swingBottomInAnimationAdapter.setInitialDelayMillis(300);
        swingBottomInAnimationAdapter.setAbsListView(mListView);
        mListView.setAdapter(swingBottomInAnimationAdapter);

    }

    @Override
    protected int getContentResId() {
        return R.layout.activity_stockmove;
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
                    ToastUtil.show(StockMoveActivity.this, Constance.DICT.RES_FAILURE);
                    LoadingUtil.hideLoading();
                    return;
                }

                if (result.getCode() == ResultCode.SUCCESS.getCode()) {
                    ReagentDetailVm item = result.getData();
                    if (item == null) {
                        ToastUtil.show(StockMoveActivity.this, Constance.DICT.DATA_NOT_FOUND);
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
                                ToastUtil.show(StockMoveActivity.this, Constance.DICT.DATA_IS_NOT_EARLIER);
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
                    ToastUtil.show(StockMoveActivity.this, result.getMessage());
                }
                LoadingUtil.hideLoading();
            }

            @Override
            public void onFailure(Call<CommonResult<ReagentDetailVm>> call, Throwable t) {
                call.cancel();
                ToastUtil.show(StockMoveActivity.this, Constance.DICT.NET_ON_FAILURE);
                t.printStackTrace();
                LoadingUtil.hideLoading();

            }
        });

    }

    private void getMoveDetailData() {
        LoadingUtil.showLoading(this);

        String moveNo = dataMove.getCollectNo();

        StockService apiInterface = RestClient.getClient(this).create(StockService.class);
        Call<CommonResult<ReagentMoveDetailRes>> call1 = apiInterface.getCollectDetail(moveNo);
        call1.enqueue(new Callback<CommonResult<ReagentMoveDetailRes>>() {
            @Override
            public void onResponse(Call<CommonResult<ReagentMoveDetailRes>> call, Response<CommonResult<ReagentMoveDetailRes>> response) {
                CommonResult<ReagentMoveDetailRes> result = response.body();
                if (result!=null && result.getCode()==ResultCode.SUCCESS.getCode()) {
                    ReagentMoveDetailRes data = result.getData();
                    if (data == null) {
                        ToastUtil.show(StockMoveActivity.this, Constance.DICT.DATA_NOT_FOUND);
                    } else {
                        dataMoveDetailList = data.getList();
                        for (int i=0; i<dataMoveDetailList.size(); i++) {
                            dataMoveDetailToShowList.add((ReagentMoveDetailVm) dataMoveDetailList.get(i).clone());
                        }

                        if (detailAdapter != null) {
                            detailAdapter.setItemsList(dataMoveDetailToShowList);
                            detailAdapter.notifyDataSetChanged();
                        }
                    }
                } else {
                    ToastUtil.show(StockMoveActivity.this, "获取移库详情失败");
                }
                LoadingUtil.hideLoading();
            }

            @Override
            public void onFailure(Call<CommonResult<ReagentMoveDetailRes>> call, Throwable t) {
                call.cancel();
                ToastUtil.show(StockMoveActivity.this, Constance.DICT.NET_ON_FAILURE);
                t.printStackTrace();
                LoadingUtil.hideLoading();
            }
        });
    }

    private void  addItem(ReagentDetailVm item) {
        if (item == null) return;

        ReagentDetailVm obj = null;
        for (ReagentDetailVm vm: itemList) {
            if (item.getReagentId().equals(vm.getReagentId())) {
                obj = vm;
                break;
            }
        }

        // 将扫码试剂与所需试剂列表匹配
        ReagentMoveDetailVm tempDetailItem = null;
        for (ReagentMoveDetailVm detailItem: dataMoveDetailList) {
            if (item.getReagentId().equals(detailItem.getReagentCode())) tempDetailItem = detailItem;
        }

        if (obj == null) { // 未扫过码的试剂
            if (tempDetailItem == null) {   // 不在申请单中
                ToastUtil.show(this, "该试剂不包含在申请单中，禁止移库");
            } else { // 草稿中新建该类试剂
                item.setQuantity(1);
                item.getQrList().add(item.getQrCode());
                item.getQrIdList().add(item.getQrId());
                item.getQrCodeValueList().add(item.getQrCodeValue());
                item.getReagentCodeList().add(item.getReagentCode());
                itemList.add(item);
                ToastUtil.show(this, "新增试剂：" + item.getReagentName());
                updateDataMoveDetailToShowList(tempDetailItem);
            }

        } else {
            if (obj.getQrList().contains(item.getQrCode())) { // 重复扫码
                ToastUtil.show(this, Constance.DICT.QR_CODE_REPEAT);
            } else if (obj.getQuantity() == tempDetailItem.getReagentNumber()) { // 已完成该类试剂的移库
                ToastUtil.show(this, "已完成对 "+obj.getReagentName()+" 的移库");
            } else { // 数量+1
                obj.getQrList().add(item.getQrCode());
                obj.getQrIdList().add(item.getQrId());
                obj.getQrCodeValueList().add(item.getQrCodeValue());
                obj.getReagentCodeList().add(item.getReagentCode());
                obj.setQuantity(obj.getQuantity() + 1);
                // 满足所需数量则提醒
                if (obj.getQuantity() == tempDetailItem.getReagentNumber()) {
                    ToastUtil.show(this, "已完成对 "+obj.getReagentName()+" 的移库");
                } else {
                    ToastUtil.show(this, item.getReagentName() + "数量+1");
                }
                updateDataMoveDetailToShowList(tempDetailItem);
            }
        }

    }

    /**
     * 更新用户可看到的移库申请单详情
     * 只给用户展示未扫码的试剂信息
     */
    private void updateDataMoveDetailToShowList(ReagentMoveDetailVm detailItem) {

        for (ReagentMoveDetailVm item: dataMoveDetailToShowList) {
            if (item.getReagentCode().equals(detailItem.getReagentCode())) {
                // 数量减1
                if (item.getReagentNumber() > 1) {
                    item.setReagentNumber(item.getReagentNumber() - 1);
                } else {
                    // 数量为0，移除
                    dataMoveDetailToShowList.remove(item);
                    break;
                }
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

    @OnClick(R.id.btn_browser)
    public void onBrowserClicked() {
        LinearLayout parent = (LinearLayout) LayoutInflater.from(this).inflate(R.layout.activity_dialog_stock_move_list, null);
        lvDialogDetail = (ListView) parent.findViewById(R.id.activity_googlecards_listview);
        TextView tvIconFont = (TextView) parent.findViewById(R.id.dialog_close);

        // load icon
        Typeface iconfont = Typeface.createFromAsset(getAssets(), "iconfont.ttf");
        tvIconFont.setTypeface(iconfont);

        detailAdapter = new StockMoveDetailAdapter(this);
        lvDialogDetail.setAdapter(detailAdapter);
        detailAdapter.setItemsList(dataMoveDetailToShowList);

        if (dataMoveDetailList == null) {
            // 取详情数据
            getMoveDetailData();
            LoadingUtil.showLoading(parent.getContext());
        }

        // 弹 dialog
        final SyCustomDialog dia = new SyCustomDialog(this);
        dia.setWidthRatio(0.9f);
        dia.setHeightRatio(0.8f);
        dia.setContentView(parent);

        dia.show();

        // dialog 关闭按钮
        tvIconFont.setClickable(true);
        tvIconFont.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                dia.cancel();
            }
        });

    }

    @OnClick(R.id.btn_save)
    public void onSaveClicked() {
        if (itemList.size() == 0) {
            ToastUtil.show(StockMoveActivity.this, Constance.DICT.DATA_DRAFT_IS_NULL);
            return;
        }

        // 种类必须相符
        if (itemList.size() != dataMoveDetailList.size()) {
            AlertDialogUtil.show(this, "与移库申请单试剂种类不符，禁止移库", null);
            return;
        }

        // 检查数量
        for (ReagentDetailVm item: itemList) {
            for (ReagentMoveDetailVm detailItem: dataMoveDetailList) {
                if (item.getReagentId().equals(detailItem.getReagentCode()) &&
                    item.getReagentName().equals(detailItem.getReagentName())) {
                    // 数量需一致
                    if (item.getQuantity() != detailItem.getReagentNumber()) {
                        String txtError = item.getReagentName() + "数量与移库申请单中数量不符，禁止移库";
                        AlertDialogUtil.show(this, txtError, null);
                        return;
                    }
                }
            }
        }

        saveData();
    }

    /**
     * 注册保存事件，输入科室名
     */
//    @OnClick(R.id.btn_save)
//    public void onSaveViewClicked() {
//        if (itemList.size() == 0) {
//            ToastUtil.show(this, Constance.DICT.DATA_DRAFT_IS_NULL);
//            return;
//        }
//        final EditText et = new EditText(this);
//        new AlertDialog.Builder(this).setTitle("请输入科室名")
//                .setView(et)
//                .setPositiveButton("确定", new DialogInterface.OnClickListener() {
//                    @Override
//                    public void onClick(DialogInterface dialog, int which) {
//                        String branchName = et.getText().toString();
//                        if (branchName.equals("")) {
//                            ToastUtil.show(StockMoveActivity.this, "科室名不能为空");
//                        } else {
//                            saveData(branchName);
//                        }
//                    }
//                })
//                .setNegativeButton("取消", null)
//                .show();
//    }

    /**
     * 保存
     */
    private void saveData() {
        LoadingUtil.showLoading(this);

        String username = SharedPreferencesUtil.getInstance(this).getKeyValue(Constance.SHAREP.LOGINNAME);

        ReagentMoveReq req = new ReagentMoveReq();

        req.setCreateBy(username);
        req.setOutType("3");    // 二级中心库出库
        req.setApplyMan(dataMove.getCreateName());  // 申请人
        req.setApplyInType("0");    // 中心库确认移库，等待科室库确认申领
        req.setCollectNo(dataMove.getCollectNo());

        for (ReagentDetailVm item: itemList) {
            ReagentMoveItemReq itemReq = new ReagentMoveItemReq();
            itemReq.setReagentId(item.getReagentId());
            itemReq.setReagentName(item.getReagentName());
            itemReq.setReagentSpecification(item.getReagentSpecification());
            itemReq.setReagentUnit(item.getReagentUnit());
            itemReq.setBatchNo(item.getBatchNo());
            itemReq.setManufacturerName(item.getManufacturerName());
            itemReq.setRegistrationNo(item.getRegistrationNo());
            itemReq.setSupplierShortName(item.getSupplierShortName());
            itemReq.setQuantity(item.getQuantity());
            itemReq.setReagentPrice(item.getReagentPrice());
            itemReq.setExpireDate(DateUtil.getDate_ymd(item.getExpireDate()));
            itemReq.setQrList(item.getQrList());
            itemReq.setQrCodeValueList(item.getQrCodeValueList());
            itemReq.setReagentCodeList(item.getReagentCodeList());

            req.getCollectMessList().add(itemReq);
            req.getQrList().addAll(itemReq.getQrList());
        }

        StockService apiInterface = RestClient.getClient(this).create(StockService.class);
        Call<CommonResult<Integer>> call1 = apiInterface.stockRelocation(req);
        call1.enqueue(new Callback<CommonResult<Integer>>() {
            @Override
            public void onResponse(Call<CommonResult<Integer>> call, Response<CommonResult<Integer>> response) {
                CommonResult<Integer> result = response.body();
                if (result.getCode() == ResultCode.SUCCESS.getCode()) {
                    if (result.getData() == 1) {
                        clearData();
                    } else {    // 后端更新库失败
                        ToastUtil.show(StockMoveActivity.this, Constance.DICT.RES_FAILURE);
                    }
                } else {
                    ToastUtil.show(StockMoveActivity.this, result.getMessage());
                }
                LoadingUtil.hideLoading();
            }

            @Override
            public void onFailure(Call<CommonResult<Integer>> call, Throwable t) {
                call.cancel();
                t.printStackTrace();
                ToastUtil.show(StockMoveActivity.this, Constance.DICT.NET_ON_FAILURE);
                LoadingUtil.hideLoading();
            }
        });

    }

    private  void clearData() {
        AlertDialog.Builder builder = new AlertDialog.Builder(this);
        builder.setMessage("移库成功")
                .setPositiveButton("确认", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        finish();
                    }
                }).create().show();

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
