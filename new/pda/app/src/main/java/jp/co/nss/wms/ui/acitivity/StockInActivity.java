package jp.co.nss.wms.ui.acitivity;

import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.Typeface;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.text.method.ScrollingMovementMethod;
import android.util.Log;
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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;
import jp.co.nss.wms.R;
import jp.co.nss.wms.api.BillService;
import jp.co.nss.wms.api.StockService;
import jp.co.nss.wms.base.BaseActivity;
import jp.co.nss.wms.bean.bean.MessageEvent;
import jp.co.nss.wms.bean.bean.ReagentItemBean;
import jp.co.nss.wms.bean.bean.ReagentNumberBean;
import jp.co.nss.wms.bean.vm.ReagentInBillDetailVm;
import jp.co.nss.wms.bean.vm.ReagentInBillItemVm;
import jp.co.nss.wms.bean.vm.ReagentInBillVm;
import jp.co.nss.wms.bean.vm.ReagentPreInDetail;
import jp.co.nss.wms.bean.vm.ReagentStockPreIn;
import jp.co.nss.wms.constance.Constance;
import jp.co.nss.wms.model.CommonResult;
import jp.co.nss.wms.model.ReagentInBillDetailRes;
import jp.co.nss.wms.model.ReagentInBillItemRes;
import jp.co.nss.wms.model.ReagentInBillMessReq;
import jp.co.nss.wms.model.ReagentInBillReq;
import jp.co.nss.wms.model.ReagentInBillRes;
import jp.co.nss.wms.model.ReagentPreInDetailRes;
import jp.co.nss.wms.model.ResultCode;
import jp.co.nss.wms.ui.adapter.StockInAdapter;
import jp.co.nss.wms.ui.adapter.StockInDetailAdapter;
import jp.co.nss.wms.ui.adapter.StockOrderDraftAdapter;
import jp.co.nss.wms.ui.view.dialog.SyCustomDialog;
import jp.co.nss.wms.util.AlertDialogUtil;
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
 * 入库
 */

public class StockInActivity extends BaseActivity implements OnDismissCallback {

    private String TAG = "StockInActivity";

    StockInAdapter mAdapter;
    StockInDetailAdapter detailAdapter;
    StockOrderDraftAdapter orderDraftAdapter;

    ListView lvDialogDetail;

    // 预入库单数据第1层，从汇总页面传递过来数据
    private static ReagentStockPreIn dataPreIn1;
    // 草稿单号，确保保存、加载草稿，操作的是同一个草稿单
    private static String flagInBillCode;

    // 入库单类型
    // 0-草稿；1-入库
    CharSequence opts[] = new CharSequence[] {"复核完成", "复核完成并入库"};

    List<ReagentItemBean> itemList = new ArrayList<>();
    List<ReagentPreInDetail> dataPreInDetailList = new ArrayList<>();
    // 重新计算随货通行单中各种类的数量
    // 存在同一批号类型试剂拆分的情况
    Map<String, ReagentNumberBean> mapPreInDetailNumber = new HashMap<>();
    // 统计已扫码的数量
    Map<String, ReagentNumberBean> mapInDetailDraftNumber = new HashMap<>();

    // custom dialog，用于展示未入库的草稿单
    SyCustomDialog cDialog;

    @BindView(R.id.activity_googlecards_listview)
    ListView mListView;
    @BindView(R.id.et_search)
    AutoCompleteTextView etSearch;
    // 随货同行单编号
    @BindView(R.id.tv_billInNo)
    TextView tvBillInNo;
    // 随货同行单日期
    @BindView(R.id.tv_operationDate)
    TextView tvOperationDate;
    @BindView(R.id.tv_supplier)
    TextView tvSupplier;
    @BindView(R.id.btn_save)
    Button btnSave;

    public static void show(Context context, ReagentStockPreIn vm) {
        Intent intent = new Intent(context, StockInActivity.class);
        dataPreIn1 = vm;
        context.startActivity(intent);
    }

    @Override
    protected void initView() {
        super.initView();
        ButterKnife.bind(this);
        EventBus.getDefault().register(this);
        mBtnLeft.setVisibility(View.VISIBLE);
        setTitle("入库");
        addAdapter();

        getPreInDetailData(dataPreIn1.getBillCode());

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

        tvBillInNo.setMovementMethod(new ScrollingMovementMethod());
        tvOperationDate.setMovementMethod(new ScrollingMovementMethod());
        tvSupplier.setMovementMethod(new ScrollingMovementMethod());

        tvBillInNo.setText(dataPreIn1.getBillCode());
        tvOperationDate.setText(DateUtil.getDate_(dataPreIn1.getCreateTime()));
        tvSupplier.setText(dataPreIn1.getSupplierShortName());

        flagInBillCode = null;

    }

    @Override
    protected void onDestroy() {
        EventBus.getDefault().unregister(this);
        super.onDestroy();
    }

    @Subscribe(threadMode = ThreadMode.MAIN)
    public void MessageEventBus(MessageEvent msg) {}

    private void addAdapter() {
        mAdapter = new StockInAdapter(this);
        SwingBottomInAnimationAdapter swingBottomInAnimationAdapter = new SwingBottomInAnimationAdapter(new SwipeDismissAdapter(mAdapter, this));
        swingBottomInAnimationAdapter.setInitialDelayMillis(300);
        swingBottomInAnimationAdapter.setAbsListView(mListView);
        mListView.setAdapter(swingBottomInAnimationAdapter);

    }

    @Override
    protected int getContentResId() {
        return R.layout.activity_stockin;
    }

    private void getDate(String searchKey) {
        LoadingUtil.showLoading(this);

        String _searchKey = searchKey.replace("\uFEFF", "");

        BillService apiInterface = RestClient.getClient(this).create(BillService.class);
        Call<CommonResult<ReagentItemBean>> callC = apiInterface.findPreItem(_searchKey);
        callC.enqueue(new Callback<CommonResult<ReagentItemBean>>() {
            @Override
            public void onResponse(Call<CommonResult<ReagentItemBean>> call, Response<CommonResult<ReagentItemBean>> response) {
                CommonResult<ReagentItemBean> result = response.body();

                if (result == null) {
                    ToastUtil.show(StockInActivity.this, Constance.DICT.RES_FAILURE);
                    LoadingUtil.hideLoading();
                    return;
                }

                if (result.getCode() == ResultCode.SUCCESS.getCode()) {
                    ReagentItemBean data = result.getData();
                    // 未查询到数据
                    if (data == null) {
                        ToastUtil.show(StockInActivity.this, Constance.DICT.DATA_NOT_FOUND);
                    } else {    // 有数据
                        addItem(data);
                        mAdapter.setItemsList(itemList);
                        mAdapter.notifyDataSetChanged();
                    }
                } else {
                    ToastUtil.show(StockInActivity.this, result.getMessage());
                }
                LoadingUtil.hideLoading();
            }

            @Override
            public void onFailure(Call<CommonResult<ReagentItemBean>> call, Throwable t) {
                call.cancel();
                ToastUtil.show(StockInActivity.this, Constance.DICT.NET_ON_FAILURE);
                t.printStackTrace();
                LoadingUtil.hideLoading();
            }
        });

    }

    private void  addItem(ReagentItemBean item) {
        if (item == null) return;

        // 试剂信息与当前随货同行单不符
        if (!item.getBillCode().equals(dataPreIn1.getBillCode())) {
            ToastUtil.show(this, "种类不符");
            return;
        }

        ReagentItemBean obj = null;
        for (ReagentItemBean vm: itemList) {
            // 试剂ID 和批号需同时一致
            if (item.getCode().equals(vm.getCode())
                    && item.getBatchNo().equals(vm.getBatchNo())) obj = vm;
        }

        ReagentPreInDetail tempDetailItem = null;
        for (ReagentPreInDetail detailItem: dataPreInDetailList) {
            if (item.getCode().equals(detailItem.getReagentCode()) &&
                    item.getBatchNo().equals(detailItem.getBatchNo()))
            {
                tempDetailItem = detailItem;
                break;
            }
        }

        String _mapKey = tempDetailItem.getBatchNo() + tempDetailItem.getReagentCode();

        if (obj == null) {  // 未扫过码的试剂
            // 试剂不包含在该随货同行单中
            if (tempDetailItem == null) {
                ToastUtil.show(this, "种类不符");
            } else {

                ReagentNumberBean _rnDraft = new ReagentNumberBean();
                _rnDraft.setReagentName(tempDetailItem.getReagentName());
                _rnDraft.setBatchNo(tempDetailItem.getBatchNo());
                _rnDraft.setReagentNumber(1);
                _rnDraft.setStatus(tempDetailItem.getBillStatus());
                mapInDetailDraftNumber.put(_mapKey, _rnDraft);

                item.setQuantity(1);
                item.getQrCodeList().add(item.getQrCode());
                item.getQrCodeValueList().add(item.getCodeValue());
                item.getReagentCodeList().add(item.getReagentCode());
                item.setExpireDateReq(DateUtil.getDate_ymdhms(item.getExpireDate()));
                String temp = DateUtil.getDate_ymd_fromString(item.getExpireDate());
                item.setExpireDate(temp);
                itemList.add(item);
                ToastUtil.show(this, "新增试剂：" + item.getReagentName());
            }

        } else {    // 已扫过码的试剂
            // 已存在于当前的草稿单中
            assert tempDetailItem != null;

            // 重复扫码
            if (obj.getQrCodeList().contains(item.getQrCode())) {
                ToastUtil.show(this, Constance.DICT.QR_CODE_REPEAT);
                return;
            }

            // 已完成该试剂的入库
            if (mapPreInDetailNumber.get(_mapKey).equals(mapInDetailDraftNumber.get(_mapKey))) {
                ToastUtil.show(this, "已完成对 " + obj.getReagentName() + " 的入库");
            } else {
                // 未完成对该试剂的入库
                obj.getQrCodeList().add(item.getQrCode());
                obj.getQrCodeValueList().add(item.getCodeValue());
                obj.getReagentCodeList().add(item.getReagentCode());
                obj.setQuantity(obj.getQuantity() + 1);

                ReagentNumberBean _rn = mapPreInDetailNumber.get(_mapKey);
                ReagentNumberBean _rnDraft = mapInDetailDraftNumber.get(_mapKey);

                long _number = _rn.getReagentNumber();
                long _numberDraft = _rnDraft.getReagentNumber();
                _rnDraft.setReagentNumber(++_numberDraft);

                mapInDetailDraftNumber.put(_mapKey, _rnDraft);

                if (_number == _numberDraft) {
                    ToastUtil.show(this, "已完成对 "+ obj.getReagentName()+" 的入库");
                } else {
                    ToastUtil.show(this, item.getReagentName() + "数量+1");
                }
            }
        }
    }

    /**
     * 获取随货同行单详情（第2层数据）
     * @param keyword
     */
    private void getPreInDetailData(String keyword) {
        LoadingUtil.showLoading(this);

        StockService apiInterface = RestClient.getClient(this).create(StockService.class);
        Call<CommonResult<ReagentPreInDetailRes>> call1 = apiInterface.getPreInDetailList(keyword);
        call1.enqueue(new Callback<CommonResult<ReagentPreInDetailRes>>() {
            @Override
            public void onResponse(Call<CommonResult<ReagentPreInDetailRes>> call, Response<CommonResult<ReagentPreInDetailRes>> response) {
                CommonResult<ReagentPreInDetailRes> result = response.body();
                if (result.getCode() == ResultCode.SUCCESS.getCode()) {
                    ReagentPreInDetailRes data = result.getData();
                    // 未查询到数据
                    if (data == null) {
                        ToastUtil.show(StockInActivity.this, Constance.DICT.DATA_NOT_FOUND);
                    } else {    // 有数据
                        List<ReagentPreInDetail> _list = data.getList();
                        List<ReagentPreInDetail> _listToShow = new ArrayList<>();

                        for (ReagentPreInDetail item: _list) {
                            // 过滤已入库的试剂订单
                            if (!item.getBillStatus().equals("1")) {
                                _listToShow.add(item);
                            }
                        }

                        dataPreInDetailList = _listToShow;

                        if (detailAdapter != null) {
                            detailAdapter.setItemsList(_listToShow);
                            detailAdapter.notifyDataSetChanged();
                        }

                        if (_listToShow.size() > 0) {
                            updateMapPreInDetail();
                        }

                    }
                } else {
                    ToastUtil.show(StockInActivity.this, "获取随货同行单数据失败");
                }
                LoadingUtil.hideLoading();

            }

            @Override
            public void onFailure(Call<CommonResult<ReagentPreInDetailRes>> call, Throwable t) {
                call.cancel();
                ToastUtil.show(StockInActivity.this, Constance.DICT.NET_ON_FAILURE);
                t.printStackTrace();
                LoadingUtil.hideLoading();
            }
        });

    }

    /**
     * 获取入库单草稿汇总
     * @param keyword 供货商名称
     */
    private void getOrderDraftData(String keyword) {
        String username = SharedPreferencesUtil.getInstance(this).getKeyValue(Constance.SHAREP.LOGINNAME);
        String stockType = SharedPreferencesUtil.getInstance(this).getKeyValue(Constance.SHAREP.STOCK_TYPE);

        // 入库单种类：1 一级中心入库单， 2 二级中心入库单，3 科室入库单
        String billType = "1";
        if (stockType.equals("3")) billType = "2";

        StockService apiInterface = RestClient.getClient(this).create(StockService.class);
        Call<CommonResult<ReagentInBillRes>> call1 = apiInterface.getInBillList(username, billType, keyword);
        call1.enqueue(new Callback<CommonResult<ReagentInBillRes>>() {
            @Override
            public void onResponse(Call<CommonResult<ReagentInBillRes>> call, Response<CommonResult<ReagentInBillRes>> response) {
                CommonResult<ReagentInBillRes> result = response.body();
                if (result.getCode() == ResultCode.SUCCESS.getCode()) {
                    ReagentInBillRes data = result.getData();
                    // 未查询到数据
                    if (data == null) {
                        ToastUtil.show(StockInActivity.this, Constance.DICT.DATA_NOT_FOUND);
                    } else {    // 有数据
                        List<ReagentInBillVm> list = new ArrayList<>();
                        for (ReagentInBillVm item: data.getList()) {
                            // 筛选状态为草稿且属于相同随货单的草稿单
                            if (item.getBillStatus().equals("0")
                                    && item.getPreInBillCode() != null
                                    && item.getPreInBillCode().equals(dataPreIn1.getBillCode())) {
                                list.add(item);
                            }
                        }

                        orderDraftAdapter.setItemsList(list);
                        orderDraftAdapter.notifyDataSetChanged();
                    }
                } else {
                    ToastUtil.show(StockInActivity.this, result.getMessage());
                    finish();
                }
            }

            @Override
            public void onFailure(Call<CommonResult<ReagentInBillRes>> call, Throwable t) {
                call.cancel();
                ToastUtil.show(StockInActivity.this, Constance.DICT.NET_ON_FAILURE);
                t.printStackTrace();
            }
        });

    }

    /**
     * 获取入库单详情
     * @param inBillDraftVm ReagentInBillVm
     */
    private void getOrderDetailData(final ReagentInBillVm inBillDraftVm) {
        StockService apiInterface = RestClient.getClient(this).create(StockService.class);
        Call<CommonResult<ReagentInBillDetailRes>> call1 = apiInterface.getInBillDetailList(inBillDraftVm.getBillCode());
        call1.enqueue(new Callback<CommonResult<ReagentInBillDetailRes>>() {
            @Override
            public void onResponse(Call<CommonResult<ReagentInBillDetailRes>> call, Response<CommonResult<ReagentInBillDetailRes>> response) {
                CommonResult<ReagentInBillDetailRes> result = response.body();
                if (result.getCode() == ResultCode.SUCCESS.getCode()) {
                    ReagentInBillDetailRes data = result.getData();
                    // 未查询到数据
                    if (data == null) {
                        ToastUtil.show(StockInActivity.this, Constance.DICT.DATA_NOT_FOUND);
                    } else {
                        // 加载到 itemList
                        loadDraftData(data.getList(), inBillDraftVm);
                    }
                } else {
                    ToastUtil.show(StockInActivity.this, result.getMessage());
                    finish();
                }
            }

            @Override
            public void onFailure(Call<CommonResult<ReagentInBillDetailRes>> call, Throwable t) {
                call.cancel();
                ToastUtil.show(StockInActivity.this, Constance.DICT.NET_ON_FAILURE);
                t.printStackTrace();
            }
        });
    }

    /**
     * 获取入库单 试剂item 数据，用于回填 itemList
     * @param inDetailNo 入库单详情号
     * @param draftLen 入库单详情（第二层）试剂的数量
     */
    private void getOrderDetailItemData(String inDetailNo, final int currentIndex, final int draftLen) {
        StockService apiInterface = RestClient.getClient(this).create(StockService.class);
        Call<CommonResult<ReagentInBillItemRes>> call1 = apiInterface.getInBillDetailItemList(inDetailNo);
        call1.enqueue(new Callback<CommonResult<ReagentInBillItemRes>>() {
            @Override
            public void onResponse(Call<CommonResult<ReagentInBillItemRes>> call, Response<CommonResult<ReagentInBillItemRes>> response) {
                CommonResult<ReagentInBillItemRes> result = response.body();
                if (result.getCode() == ResultCode.SUCCESS.getCode()) {
                    ReagentInBillItemRes data = result.getData();
                    // 未查询到数据
                    if (data == null) {
                        ToastUtil.show(StockInActivity.this, Constance.DICT.DATA_NOT_FOUND);
                    } else {
                        List<ReagentInBillItemVm> list = data.getList();
                        if (list != null) {
                            // 批量将 detailID 相同的试剂二维码添加到当前新建的草稿中
                            for (ReagentItemBean item: itemList) {
                                if (list.get(0).getInDetailId().equals(item.getInDetailId())) {
                                    for (ReagentInBillItemVm vm: list) {
                                        item.getQrCodeList().add(vm.getQrCode());
                                        item.getQrCodeValueList().add(vm.getCodeValue());
                                        item.getReagentCodeList().add(vm.getReagentCode());
                                    }
                                    break;
                                }
                            }
                        }

                        if (currentIndex == draftLen-1) LoadingUtil.hideLoading();

                    }
                } else {
                    ToastUtil.show(StockInActivity.this, result.getMessage());
                    finish();
                }
            }

            @Override
            public void onFailure(Call<CommonResult<ReagentInBillItemRes>> call, Throwable t) {
                call.cancel();
                ToastUtil.show(StockInActivity.this, Constance.DICT.NET_ON_FAILURE);
                t.printStackTrace();
            }
        });

    }

    /**
     * 获取入库单草稿数据后
     * 载入入库单草稿并展示
     * @param draftList List<ReagentInBillDetailVm>
     */
    private void loadDraftData(List<ReagentInBillDetailVm> draftList, ReagentInBillVm inBillDraftVm) {
        String username = SharedPreferencesUtil.getInstance(this).getKeyValue(Constance.SHAREP.LOGINNAME);
        int currentIndex = 0;

        for (ReagentInBillDetailVm detail: draftList) {
            ReagentItemBean tempItem = new ReagentItemBean();
            tempItem.setSupplierId(inBillDraftVm.getSupplierId());
            tempItem.setSupplierShortName(dataPreIn1.getSupplierShortName());
            tempItem.setCode(detail.getReagentId());
            tempItem.setInDetailId(detail.getInDetailId());
            tempItem.setReagentName(detail.getReagentName());
            tempItem.setBatchNo(detail.getBatchNo());
            tempItem.setPrice(detail.getPrice());
            tempItem.setExpireDate(DateUtil.getDate_ymd(detail.getExpireDate()));
            tempItem.setCreateBy(username);
            tempItem.setQuantity(detail.getQuantity());
            tempItem.setReagentCode(detail.getReagentCode());

            getOrderDetailItemData(detail.getInDetailId(), currentIndex, draftList.size());

            itemList.add(tempItem);
            currentIndex++;

        }

        flagInBillCode = inBillDraftVm.getBillCode();

        mAdapter.setItemsList(itemList);
        mAdapter.notifyDataSetChanged();

    }

    /**
     * 重新计算随货通行单中试剂的数量
     * （存在同一批号名称的试剂被拆分成两条）
     */
    private void updateMapPreInDetail() {
        if (dataPreInDetailList.size() < 1) {
            Log.e(TAG, "随货通行单数据为空");
            return;
        }

        for (ReagentPreInDetail detailItem: dataPreInDetailList) {
            // 批号+试剂ID
            String _key = detailItem.getBatchNo() + detailItem.getReagentCode();
            boolean hasKey = mapPreInDetailNumber.containsKey(_key);
            long newNumber = detailItem.getQuantity();

            // 已存入该试剂
            if (hasKey) {
                ReagentNumberBean _rn = mapPreInDetailNumber.get(_key);
                long oldNumber = _rn.getReagentNumber();
                newNumber += oldNumber;
            }

            ReagentNumberBean newRn = new ReagentNumberBean();
            newRn.setBatchNo(detailItem.getBatchNo());
            newRn.setReagentName(detailItem.getReagentName());
            newRn.setReagentNumber(newNumber);

            mapPreInDetailNumber.put(_key, newRn);

        }

        // log，便于调试
//        for (String key: mapPreInDetailNumber.keySet()) {
//            int value = mapPreInDetailNumber.get(key);
//            System.out.println(key + ": " + value);
//        }
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

    /**
     * 查看随货同行单详情
     */
    @OnClick(R.id.btn_open_detail)
    public void onOpenDetailClicked() {

        LinearLayout parent = (LinearLayout) LayoutInflater.from(this).inflate(R.layout.activity_dialog_stock_list, null);
        lvDialogDetail = (ListView) parent.findViewById(R.id.activity_googlecards_listview);
        TextView tvIconFont = (TextView) parent.findViewById(R.id.dialog_close);

        // load icon
        Typeface iconfont = Typeface.createFromAsset(getAssets(), "iconfont.ttf");
        tvIconFont.setTypeface(iconfont);

        detailAdapter = new StockInDetailAdapter(this);
        lvDialogDetail.setAdapter(detailAdapter);
        detailAdapter.setItemsList(dataPreInDetailList);

        // 取详情数据
        if (dataPreInDetailList == null) {
            getPreInDetailData(dataPreIn1.getBillCode());
            LoadingUtil.showLoading(parent.getContext());
        }

        // 弹 dialog
        final SyCustomDialog dia = new SyCustomDialog(StockInActivity.this);
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

    /**
     * 保存为草稿
     */
    @OnClick(R.id.btn_save)
    public void onSaveViewClicked() {
        if (itemList.size() == 0) {
            ToastUtil.show(StockInActivity.this, Constance.DICT.DATA_DRAFT_IS_NULL);
            return;
        }

        saveData("0");

//        AlertDialog.Builder adb = new AlertDialog.Builder(this);
//        adb.setSingleChoiceItems(opts, 0, new DialogInterface.OnClickListener() {
//            @Override
//            public void onClick(DialogInterface d, int n) {
//                // 点击 radio 事件
//                typeTmp = n;
//            }
//        });
//        adb.setNegativeButton("取消", null);
//        adb.setPositiveButton("确认", new DialogInterface.OnClickListener() {
//            @Override
//            public void onClick(DialogInterface dialog, int which) {
//                saveData();
//            }
//        });
//        adb.setTitle("选择入库类型");
//        adb.show();

    }

    /**
     * 正式入库
     */
    @OnClick(R.id.btn_to_in)
    public void onSaveToStore() {
        if (itemList.size() == 0) {
            ToastUtil.show(StockInActivity.this, Constance.DICT.DATA_DRAFT_IS_NULL);
            return;
        }

        // 剔除已入库的随货同行单第二层
        int countCategory = 0;
        for (ReagentPreInDetail detail: dataPreInDetailList) {
            if (detail.getBillStatus().equals("0")) countCategory++;
        }

        // start: 与随货同行单相校验

        // 种类不符，禁止入库
        if (mapInDetailDraftNumber.size() != mapPreInDetailNumber.size()) {
            AlertDialogUtil.show(this, "与随货同行单试剂种类不符，禁止入库", null);
            return;
        }

        // 数量不符，禁止入库
        for (String _mapDraftKey: mapInDetailDraftNumber.keySet()) {
            ReagentNumberBean _rn = mapPreInDetailNumber.get(_mapDraftKey);
            ReagentNumberBean _rnDraft = mapInDetailDraftNumber.get(_mapDraftKey);

            if (_rn.getStatus().equals("0")) {
                if (_rn.getReagentNumber() != _rnDraft.getReagentNumber()) {
                    String txtError = _rn.getReagentName() + "数量与随货同行单中数量不符，禁止入库";
                    AlertDialogUtil.show(this, txtError, null);
                    return;
                }
            }
        }

        // end: 与随货同行单相校验

        saveData("1");
    }

    /**
     * 保存为草稿 / 入库
     * @param saveType 0-草稿；1-入库
     */
    private void saveData(final String saveType) {
        LoadingUtil.showLoading(this);

        String username = SharedPreferencesUtil.getInstance(this).getKeyValue(Constance.SHAREP.LOGINNAME);
        String stockType = SharedPreferencesUtil.getInstance(this).getKeyValue(Constance.SHAREP.STOCK_TYPE);

        ReagentInBillReq req = new ReagentInBillReq();
        req.setBillCreator(username);

        String billTypeTemp = "1";  // 一级中心入库单
        String createTypeTmp = "3"; // 一级扫码入库
        if (stockType.equals("3")) {
            billTypeTemp = "2"; // 二级中心库入库单
            createTypeTmp = "4";    // 二级扫码入库
        }

        if (flagInBillCode!=null && !flagInBillCode.equals("1")) req.setTempInBillCode(flagInBillCode);
        req.setPreInBillCode(dataPreIn1.getBillCode());
        req.setBillType(billTypeTemp);
        req.setCreateType(createTypeTmp);
        req.setStockType(stockType);
        req.setBillStatus(saveType);

        List<ReagentInBillMessReq> list = new ArrayList<>();
        for (ReagentItemBean item: itemList) {
            ReagentInBillMessReq detail = new ReagentInBillMessReq();
            detail.setCode(item.getCode());
            detail.setBatchNo(item.getBatchNo());
            detail.setPrice(item.getPrice());
            detail.setQuantity(item.getQuantity());
            detail.setSupplierId(item.getSupplierId());
            detail.setSupplierShortName(item.getSupplierShortName());
            detail.setCreateBy(item.getCreateBy());
            detail.setExpireDate(item.getExpireDate());
            detail.setQrList(item.getQrCodeList());
            detail.setQrCodeValueList(item.getQrCodeValueList());
            detail.setReagentCodeList(item.getReagentCodeList());
            list.add(detail);
        }
        req.setInBillMessList(list);

        BillService apiInterface = RestClient.getClient(this).create(BillService.class);
        Call<CommonResult<String>> call1 = apiInterface.save(req);
        call1.enqueue(new Callback<CommonResult<String>>() {
            @Override
            public void onResponse(Call<CommonResult<String>> call, Response<CommonResult<String>> response) {
                CommonResult<String> result = response.body();
                if (result.getCode() == ResultCode.SUCCESS.getCode()) {
                    flagInBillCode = result.getData();
                    if (saveType.equals("0")) clearData(0);
                    else clearData(1);
                } else {
                    ToastUtil.show(StockInActivity.this, Constance.DICT.RES_FAILURE);
                }
                LoadingUtil.hideLoading();
            }

            @Override
            public void onFailure(Call<CommonResult<String>> call, Throwable t) {
                call.cancel();
                t.printStackTrace();
                ToastUtil.show(StockInActivity.this, Constance.DICT.NET_ON_FAILURE);
                LoadingUtil.hideLoading();
            }
        });

    }

    /**
     * 打开草稿汇总弹窗 dialog.show
     */
    @OnClick(R.id.btn_read)
    public void onLoadDraft() {
        LinearLayout parent = (LinearLayout) LayoutInflater.from(this).inflate(R.layout.activity_dialog_order_draft, null);
        ListView lvDialogDetail = parent.findViewById(R.id.activity_googlecards_listview);
        TextView tvIconFont = parent.findViewById(R.id.dialog_close);

        // load icon
        Typeface iconfont = Typeface.createFromAsset(getAssets(), "iconfont.ttf");
        tvIconFont.setTypeface(iconfont);

        orderDraftAdapter = new StockOrderDraftAdapter(this);
        lvDialogDetail.setAdapter(orderDraftAdapter);
        lvDialogDetail.setEmptyView(parent.findViewById(R.id.tvEmptyData));

        getOrderDraftData(dataPreIn1.getSupplierShortName());

        cDialog = new SyCustomDialog(StockInActivity.this);
        cDialog.setWidthRatio(0.9f);
        cDialog.setHeightRatio(0.8f);

        cDialog.setContentView(parent);
        cDialog.show();

        // dialog 关闭按钮
        tvIconFont.setClickable(true);
        tvIconFont.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                cDialog.cancel();
            }
        });

    }

    /**
     * itemview 点击读取草稿
     * @param vm ReagentInBillVm
     */
    public void onLoadDraftData(ReagentInBillVm vm) {
        LoadingUtil.showLoading(this);

        clearData(3);

        getOrderDetailData(vm);
        cDialog.cancel();
    }

    private void clearData(int clearType) {
        // 保存为草稿
        if (clearType == 0) {
            ToastUtil.show(this, "保存成功");
        } else if (clearType == 1) {
            // 入库
            AlertDialog.Builder builder = new AlertDialog.Builder(this);
            builder.setMessage("入库成功")
                    .setPositiveButton("确认", new DialogInterface.OnClickListener() {
                        @Override
                        public void onClick(DialogInterface dialog, int which) {
                            finish();
                        }
                    }).create().show();

        }

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
