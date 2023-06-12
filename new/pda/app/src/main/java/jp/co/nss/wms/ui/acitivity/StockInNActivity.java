package jp.co.nss.wms.ui.acitivity;

import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.Color;
import android.graphics.Typeface;
import android.support.annotation.NonNull;
import android.support.v7.app.AlertDialog;
import android.view.KeyEvent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.AutoCompleteTextView;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.Spinner;
import android.widget.TextView;

import com.nhaarman.listviewanimations.itemmanipulation.swipedismiss.OnDismissCallback;
import com.nhaarman.listviewanimations.itemmanipulation.swipedismiss.SwipeDismissAdapter;

import org.greenrobot.eventbus.EventBus;
import org.greenrobot.eventbus.Subscribe;
import org.greenrobot.eventbus.ThreadMode;
import org.jetbrains.annotations.NotNull;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;
import jp.co.nss.wms.R;
import jp.co.nss.wms.api.BillService;
import jp.co.nss.wms.api.CommonService;
import jp.co.nss.wms.api.StockService;
import jp.co.nss.wms.base.BaseActivity;
import jp.co.nss.wms.bean.bean.MessageEvent;
import jp.co.nss.wms.bean.vm.BranchVm;
import jp.co.nss.wms.bean.vm.ReagentOrderVm;
import jp.co.nss.wms.bean.vm.ReagentStockPreIn;
import jp.co.nss.wms.constance.Constance;
import jp.co.nss.wms.model.CommonResult;
import jp.co.nss.wms.model.ReagentInBillReq;
import jp.co.nss.wms.model.ReagentMoveReq;
import jp.co.nss.wms.model.ReagentOrderDedetailRes;
import jp.co.nss.wms.model.ReagentOrderRes;
import jp.co.nss.wms.model.ReagentStockPreInRes;
import jp.co.nss.wms.model.ResultCode;
import jp.co.nss.wms.ui.adapter.StockPreInAdapter;
import jp.co.nss.wms.ui.adapter.StockPreInOrderAdapter;
import jp.co.nss.wms.ui.view.dialog.SyCustomDialog;
import jp.co.nss.wms.util.LoadingUtil;
import jp.co.nss.wms.util.RestClient;
import jp.co.nss.wms.util.SharedPreferencesUtil;
import jp.co.nss.wms.util.StringUtil;
import jp.co.nss.wms.util.ToastUtil;
import jp.co.nss.wms.util.listviewanimations.swinginadapters.prepared.SwingBottomInAnimationAdapter;
import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class StockInNActivity extends BaseActivity implements OnDismissCallback {

    StockPreInAdapter mAdapter;
    StockPreInOrderAdapter orderDetailAdapter;

    String flagBillType;

    @BindView(R.id.activity_googlecards_listview)
    ListView mListView;
    @BindView(R.id.btn_search)
    Button btnSearch;
    @BindView(R.id.btn_filter)
    Button btnFilter;
    @BindView(R.id.et_search)
    AutoCompleteTextView etSearch;
    @BindView(R.id.sp_stock_inbill_type)
    Spinner spBillType;

    // 所有科室，一键移库需要选择科室
    List<BranchVm> dataBranchList = new ArrayList<>();
    // 用于展示的科室项，排除了占位选项和中心库选项
    List<BranchVm> dataBranchShowList = new ArrayList<>();

    // 二级中心库管 一键入库按钮会弹出选择框
    // 选择框移库或入库
    CharSequence optsOneKey[] = new CharSequence[]{"一键入库", "一键移库"};
    // [一键] 类型
    // 0-一键入库；1-一键移库
    int typeOnekey = 0;
    // 用户选择的科室
    int branchIndex = -1;
    Boolean isFirstIn = true;

    @Override
    protected void onResume() {
        super.onResume();

        List<ReagentStockPreIn> list = new ArrayList<>();
        mAdapter.setItemsList(list);
        mAdapter.notifyDataSetChanged();

        // initView 之后会调用 onResume
        if (!isFirstIn) {
            getData("");
            getBranchSet();
        } else {
            isFirstIn = false;
        }
    }

    @Override
    protected void initView() {
        super.initView();
        ButterKnife.bind(this);
        EventBus.getDefault().register(this);
        mBtnLeft.setVisibility(View.VISIBLE);
        setTitle("入库");
        addAdapter();
        getData("");
        getBranchSet();

        etSearch.setOnKeyListener(new View.OnKeyListener() {
            @Override
            public boolean onKey(View view, int i, KeyEvent keyEvent) {
                if (i == KeyEvent.KEYCODE_ENTER) {
                    String value = etSearch.getText().toString();
                    if (!StringUtil.isEmpty(value)) {
                        etSearch.setText("");
                        getData(value);
                    }
                    return true;
                }
                return false;
            }
        });

        flagBillType = spBillType.getSelectedItem().toString();

    }

    /**
     * 获取随货同行单数据
     *
     * @param searchKey 同行单号
     */
    private void getData(String searchKey) {
        LoadingUtil.showLoading(this);

        String username = SharedPreferencesUtil.getInstance(this).getKeyValue(Constance.SHAREP.LOGINNAME);

        StockService apiInterface = RestClient.getClient(this).create(StockService.class);
        Call<CommonResult<ReagentStockPreInRes>> callC = apiInterface.getPreInBillList(searchKey, username);
        callC.enqueue(new Callback<CommonResult<ReagentStockPreInRes>>() {
            @Override
            public void onResponse(Call<CommonResult<ReagentStockPreInRes>> call, Response<CommonResult<ReagentStockPreInRes>> response) {
                CommonResult<ReagentStockPreInRes> result = response.body();

                if (result == null) {
                    ToastUtil.show(StockInNActivity.this, Constance.DICT.RES_FAILURE);
                    LoadingUtil.hideLoading();
                    return;
                }

                if (result.getCode() == ResultCode.SUCCESS.getCode()) {
                    ReagentStockPreInRes data = result.getData();
                    // 未查询到数据
                    if (data == null) {
                        ToastUtil.show(StockInNActivity.this, Constance.DICT.DATA_NOT_FOUND);
                    } else {    // 有数据
                        List<ReagentStockPreIn> list = data.getList();
                        // 过滤掉已入库的随货同行单
                        List<ReagentStockPreIn> listToShow = new ArrayList<>();
                        for (ReagentStockPreIn item : list) {
                            if (item.getBillStatus() != null) {
                                String tempStatusText = "未入库";
                                switch (item.getBillStatus()) {
                                    case "0":
                                        tempStatusText = "已撤销";
                                        break;
                                    case "2":
                                        tempStatusText = "未入库";
                                        break;
                                    case "3":
                                        tempStatusText = "未入库-与订单部分相符";
                                        break;
                                    case "4":
                                        tempStatusText = "未入库-与订单不符";
                                        break;
                                    case "5":
                                        tempStatusText = "已关闭";
                                        break;
                                }

                                // 只展示未入库且状态正常的试剂
                                if (item.getBillStatus().equals("2") ||
                                        item.getBillStatus().equals("3")) {
                                    item.setBillStatusText(tempStatusText);
                                    listToShow.add(item);
                                }

                            }
                        }

                        mAdapter.setItemsList(listToShow);
                        mAdapter.notifyDataSetChanged();
                    }
                } else {
                    ToastUtil.show(StockInNActivity.this, "获取随货同行单数据失败");
                }
                LoadingUtil.hideLoading();
            }

            @Override
            public void onFailure(Call<CommonResult<ReagentStockPreInRes>> call, Throwable t) {
                call.cancel();
                ToastUtil.show(StockInNActivity.this, Constance.DICT.NET_ON_FAILURE);
                t.printStackTrace();
                LoadingUtil.hideLoading();
            }
        });

    }

    /**
     * 获取订单数据
     *
     * @param searchKey 订单号
     */
    private void getOrderData(String searchKey) {
        LoadingUtil.showLoading(this);

        String username = SharedPreferencesUtil.getInstance(this).getKeyValue(Constance.SHAREP.LOGINNAME);

        StockService apiInterface = RestClient.getClient(this).create(StockService.class);
        Call<CommonResult<ReagentOrderRes>> callC = apiInterface.getOrderList(username, searchKey);
        callC.enqueue(new Callback<CommonResult<ReagentOrderRes>>() {
            @Override
            public void onResponse(Call<CommonResult<ReagentOrderRes>> call, Response<CommonResult<ReagentOrderRes>> response) {
                CommonResult<ReagentOrderRes> result = response.body();

                if (result == null) {
                    ToastUtil.show(StockInNActivity.this, Constance.DICT.RES_FAILURE);
                    LoadingUtil.hideLoading();
                    return;
                }

                if (result.getCode() == ResultCode.SUCCESS.getCode()) {
                    ReagentOrderRes data = result.getData();
                    // 未查询到数据
                    if (data == null) {
                        ToastUtil.show(StockInNActivity.this, Constance.DICT.DATA_NOT_FOUND);
                    } else {    // 有数据
                        List<ReagentOrderVm> list = data.getList();
                        // 过滤掉草稿状态的订单
                        List<ReagentOrderVm> listToShow = new ArrayList<>();
                        for (ReagentOrderVm item : list) {
                            if (item.getOrderStatus() != null) {
                                switch (item.getOrderStatus()) {
                                    case "1":
                                        item.setOrderStatusText("已提交");
                                        listToShow.add(item);
                                        break;
                                    case "2":
                                        item.setOrderStatusText("已配货");
                                        listToShow.add(item);
                                        break;
                                    case "3":
                                        item.setOrderStatusText("已撤销");
                                        listToShow.add(item);
                                        break;
                                    case "5":
                                        item.setOrderStatusText("已全部配货");
                                        listToShow.add(item);
                                        break;
                                }

                            }
                        }

                        mAdapter.setDataOrderList(listToShow);
                        mAdapter.notifyDataSetChanged();
                    }
                } else {
                    ToastUtil.show(StockInNActivity.this, "获取订单数据失败");
                }
                LoadingUtil.hideLoading();
            }

            @Override
            public void onFailure(Call<CommonResult<ReagentOrderRes>> call, Throwable t) {
                call.cancel();
                ToastUtil.show(StockInNActivity.this, Constance.DICT.NET_ON_FAILURE);
                t.printStackTrace();
                LoadingUtil.hideLoading();
            }
        });

    }

    /**
     * 获取所有科室
     */
    private void getBranchSet() {
        CommonService apiInterface = RestClient.getClient(this).create(CommonService.class);
        Call<CommonResult<List<BranchVm>>> callC = apiInterface.getBranchSet();
        callC.enqueue(new Callback<CommonResult<List<BranchVm>>>() {
            @Override
            public void onResponse(Call<CommonResult<List<BranchVm>>> call, Response<CommonResult<List<BranchVm>>> response) {
                CommonResult<List<BranchVm>> result = response.body();
                if (result == null) {
                    ToastUtil.show(StockInNActivity.this, Constance.DICT.RES_FAILURE);
                    return;
                }

                if (result.getCode() == ResultCode.SUCCESS.getCode()) {
                    dataBranchList = result.getData();
                } else {
                    ToastUtil.show(StockInNActivity.this, result.getMessage());
                }
            }

            @Override
            public void onFailure(Call<CommonResult<List<BranchVm>>> call, Throwable t) {
                call.cancel();
                ToastUtil.show(StockInNActivity.this, Constance.DICT.NET_ON_FAILURE);
                t.printStackTrace();
            }
        });
    }

    /**
     * 获取订单详情
     *
     * @param orderNo
     */
    private void getOrderDetailData(String orderNo) {
        StockService apiInterface = RestClient.getClient(this).create(StockService.class);
        Call<CommonResult<ReagentOrderDedetailRes>> callC = apiInterface.getOrderDetail(orderNo);
        callC.enqueue(new Callback<CommonResult<ReagentOrderDedetailRes>>() {
            @Override
            public void onResponse(Call<CommonResult<ReagentOrderDedetailRes>> call, Response<CommonResult<ReagentOrderDedetailRes>> response) {
                CommonResult<ReagentOrderDedetailRes> result = response.body();

                if (result == null) {
                    ToastUtil.show(StockInNActivity.this, Constance.DICT.RES_FAILURE);
                    return;
                }

                if (result.getCode() == ResultCode.SUCCESS.getCode()) {
                    ReagentOrderDedetailRes data = result.getData();
                    // 未查询到数据
                    if (data == null) {
                        ToastUtil.show(StockInNActivity.this, Constance.DICT.DATA_NOT_FOUND);
                    } else {    // 有数据
                        orderDetailAdapter.setItemsList(data.getList());
                        orderDetailAdapter.notifyDataSetChanged();
                    }
                } else {
                    ToastUtil.show(StockInNActivity.this, result.getMessage());
                    finish();
                }
            }

            @Override
            public void onFailure(Call<CommonResult<ReagentOrderDedetailRes>> call, Throwable t) {
                call.cancel();
                ToastUtil.show(StockInNActivity.this, Constance.DICT.NET_ON_FAILURE);
                t.printStackTrace();
            }
        });

    }

    public static void show(Context context) {
        Intent intent = new Intent(context, StockInNActivity.class);
        context.startActivity(intent);
    }

    private void addAdapter() {
        mAdapter = new StockPreInAdapter(this);
        SwingBottomInAnimationAdapter swingBottomInAnimationAdapter = new SwingBottomInAnimationAdapter(new SwipeDismissAdapter(mAdapter, this));
        swingBottomInAnimationAdapter.setInitialDelayMillis(300);
        swingBottomInAnimationAdapter.setAbsListView(mListView);
        mListView.setAdapter(swingBottomInAnimationAdapter);
    }

    @Subscribe(threadMode = ThreadMode.MAIN)
    public void MessageEventBus(MessageEvent msg) {
    }

    @Override
    protected int getContentResId() {
        return R.layout.activity_stockin_index;
    }

    @Override
    public void onDismiss(@NonNull @NotNull ViewGroup listView, @NonNull @NotNull int[] reverseSortedPositions) {
        for (int position : reverseSortedPositions) {
            mAdapter.remove(position);
        }
    }

    @OnClick(R.id.btn_search)
    public void onViewClicked() {
//        LoadingUtil.showLoading(this);
        mAdapter.clearAllList();
        if (flagBillType.equals("订单")) {
            getOrderData(etSearch.getText().toString());
        } else {
            getData(etSearch.getText().toString());
        }
//        LoadingUtil.hideLoading();
    }

    /**
     * 筛选-切换单据类型
     */
    @OnClick(R.id.btn_filter)
    public void onFilterClicked() {
        String currentBillType = spBillType.getSelectedItem().toString();
        if (!currentBillType.equals(flagBillType)) {
            flagBillType = currentBillType;
            etSearch.setText("");
            // 切换到 订单
            if (currentBillType.equals("订单")) {
                etSearch.setHint("订单号");
                getOrderData("");
            } else {
                // 切换到 随货同行单
                etSearch.setHint("随货同行单号");
                getData("");
            }
            mAdapter.clearAllList();
//            LoadingUtil.hideLoading();

        }

    }

    /**
     * 查看订单详情-dialog
     *
     * @param vm ReagentOrderVm
     */
    public void onOrderDetailClicked(ReagentOrderVm vm) {

        LinearLayout parent = (LinearLayout) LayoutInflater.from(this).inflate(R.layout.activity_dialog_stock_order_list, null);
        ListView lvDialogDetail = parent.findViewById(R.id.activity_googlecards_listview);
        TextView tvIconFont = parent.findViewById(R.id.dialog_close);

        // load icon
        Typeface iconfont = Typeface.createFromAsset(getAssets(), "iconfont.ttf");
        tvIconFont.setTypeface(iconfont);

        orderDetailAdapter = new StockPreInOrderAdapter(this);
        lvDialogDetail.setAdapter(orderDetailAdapter);

        getOrderDetailData(vm.getOrderNo());

        // 弹 dialog
        final SyCustomDialog dia = new SyCustomDialog(StockInNActivity.this);
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
     * 一键入库按钮
     * 二级库管先选择入库类型（一键入库、一键移库）
     */
    public void onOneKeyToInPre(final ReagentStockPreIn vm) {

        typeOnekey = 0;

        String userRoleId = SharedPreferencesUtil.getInstance(this).getKeyValue(Constance.SHAREP.USER_ROLE_ID);

        // 二级库 中心库管 - 先选择一键入库还是一键移库
        if (userRoleId.equals("6")) {
            AlertDialog.Builder adb = new AlertDialog.Builder(this);
            adb.setSingleChoiceItems(optsOneKey, 0, new DialogInterface.OnClickListener() {
                @Override
                public void onClick(DialogInterface dialogInterface, int i) {
                    typeOnekey = i;
                }
            });
            adb.setNegativeButton("取消", null);
            adb.setPositiveButton("确认", new DialogInterface.OnClickListener() {
                @Override
                public void onClick(DialogInterface dialogInterface, int i) {
                    checkOneKeyType(vm);
                }
            });
            adb.setTitle("选择入库类型");
            adb.show();
        } else {
            // 其他角色用户
            typeOnekey = 0;
            checkOneKeyType(vm);
        }

    }

    /**
     * 检查用户选择入库类型
     */
    private void checkOneKeyType(final ReagentStockPreIn vm) {
        // 一键入库
        if (typeOnekey == 0) {
            final TextView tv = new TextView(this);

            tv.setPadding(40, 20, 0, 0);
            tv.setText("确定一键入库？");

            new AlertDialog.Builder(this).setTitle("警告")
                    .setView(tv)
                    .setPositiveButton("确定", new DialogInterface.OnClickListener() {
                        @Override
                        public void onClick(DialogInterface dialog, int which) {
                            keepDialog(dialog);

                            onClickOneKeyToIn(vm);
                        }
                    })
                    .setNegativeButton("取消", new DialogInterface.OnClickListener() {
                        @Override
                        public void onClick(DialogInterface dialog, int which) {
                            closeDialog(dialog);
                        }
                    })
                    .show();
        } else if (typeOnekey == 1) {
            // 一键移库
            onOneKeyToMovePre(vm);
        }

    }

    /**
     * 用户选择一键移库 - 弹窗选择科室
     */
    private void onOneKeyToMovePre(final ReagentStockPreIn vm) {

        dataBranchShowList = new ArrayList<>();
        branchIndex = -1;

        List<String> listBranchName = new ArrayList<>();
        listBranchName.add("选择科室...");
        for (int i = 0; i < dataBranchList.size(); i++) {
            BranchVm _branch = dataBranchList.get(i);
            String branchCode = _branch.getBranchCode();
            // 去掉中心库
            if (branchCode != null && !branchCode.equals("1")) {
                listBranchName.add(dataBranchList.get(i).getBranchName());
                dataBranchShowList.add(_branch);
            }
        }

        // 数据为空
        if (listBranchName.size() < 2) {
            ToastUtil.show(this, "未查找到当前科室的试剂操作员");
        }

        // 弹窗选择科室
        ArrayAdapter<String> adapterSp;
        View viewSp = LayoutInflater.from(this).inflate(R.layout.dialog_spinner_operator, null);

        Spinner sp = (Spinner) viewSp.findViewById(R.id.spinner);
        sp.setPrompt("选择科室");

        adapterSp = new ArrayAdapter<String>(this, android.R.layout.simple_spinner_dropdown_item, listBranchName) {
            @Override
            public boolean isEnabled(int position) {
                return position != 0;
            }

            @Override
            public View getDropDownView(int position, View convertView, @NotNull ViewGroup parent) {
                View view = super.getDropDownView(position, convertView, parent);
                TextView tv = (TextView) view;
                if (position == 0) {
                    tv.setTextColor(Color.GRAY);
                } else {
                    tv.setTextColor(Color.BLACK);
                }
                return view;
            }
        };

        adapterSp.setDropDownViewResource(R.layout.spinner_item);
        sp.setAdapter(adapterSp);

        sp.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> adapterView, View view, int i, long l) {
                if (i > 0) {
                    // 有占位选项
                    branchIndex = i - 1;
                }
            }

            @Override
            public void onNothingSelected(AdapterView<?> adapterView) {
                // TODO Auto-generated method stub
            }
        });

        new android.app.AlertDialog.Builder(this).setTitle("请选择申请人")
                .setView(viewSp)
                .setPositiveButton("确定", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        // 阻止点击确认后关闭 dialog
                        keepDialog(dialog);

                        if (branchIndex == -1 || dataBranchShowList.get(branchIndex) == null) {
                            ToastUtil.show(StockInNActivity.this, "请选择科室");
                        } else {
                            closeDialog(dialog);
                            String branchCode = dataBranchShowList.get(branchIndex).getBranchCode();
                            onClickedMoveByOneKey(branchCode, vm);
                        }
                    }
                })
                .setNegativeButton("取消", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        closeDialog(dialog);
                    }
                })
                .show();
    }

    /**
     * 一键移库 req
     *
     * @param branchCode 科室代码
     * @param vm         ReagentStockPreIn
     */
    private void onClickedMoveByOneKey(String branchCode, ReagentStockPreIn vm) {
        LoadingUtil.showLoading(this);

        String stockType = SharedPreferencesUtil.getInstance(this).getKeyValue(Constance.SHAREP.STOCK_TYPE);

        ReagentMoveReq req = new ReagentMoveReq();
        req.setBranchCode(branchCode);
        req.setPreInBillCode(vm.getBillCode());
        req.setStockType(stockType);

        BillService apiInterface = RestClient.getClient(this).create(BillService.class);
        Call<CommonResult<Integer>> call1 = apiInterface.onKeyToMove(req);

        call1.enqueue(new Callback<CommonResult<Integer>>() {
            @Override
            public void onResponse(Call<CommonResult<Integer>> call, Response<CommonResult<Integer>> response) {
                CommonResult<Integer> result = response.body();
                if (result == null) {
                    ToastUtil.show(StockInNActivity.this, Constance.DICT.RES_FAILURE);
                    LoadingUtil.hideLoading();
                    return;
                }
                
                LoadingUtil.dismissLoading();

                if (result.getCode() == ResultCode.SUCCESS.getCode()) {
                    ToastUtil.show(StockInNActivity.this, "一键移库成功");
                    getData("");
                } else {
                    ToastUtil.show(StockInNActivity.this, "一键移库失败");
                }
            }

            @Override
            public void onFailure(Call<CommonResult<Integer>> call, Throwable t) {
                call.cancel();
                ToastUtil.show(StockInNActivity.this, Constance.DICT.NET_ON_FAILURE);
                t.printStackTrace();
                LoadingUtil.hideLoading();
            }
        });
    }

    /**
     * 一键入库 req
     */
    private void onClickOneKeyToIn(ReagentStockPreIn vm) {
        LoadingUtil.showLoading(this);

        String stockType = SharedPreferencesUtil.getInstance(this).getKeyValue(Constance.SHAREP.STOCK_TYPE);

        ReagentInBillReq req = new ReagentInBillReq();
        req.setPreInBillCode(vm.getBillCode());
        req.setStockType(stockType);

        BillService apiInterface = RestClient.getClient(this).create(BillService.class);
        Call<CommonResult<Integer>> call1 = apiInterface.oneKeyToIn(req);

        call1.enqueue(new Callback<CommonResult<Integer>>() {
            @Override
            public void onResponse(Call<CommonResult<Integer>> call, Response<CommonResult<Integer>> response) {
                CommonResult<Integer> result = response.body();
                if (result == null) {
                    ToastUtil.show(StockInNActivity.this, Constance.DICT.RES_FAILURE);
                    LoadingUtil.hideLoading();
                    return;
                }

                LoadingUtil.dismissLoading();

                if (result.getCode() == ResultCode.SUCCESS.getCode()) {
                    ToastUtil.show(StockInNActivity.this, "一键入库成功");
                    getData("");
                } else {
                    ToastUtil.show(StockInNActivity.this, "一键入库失败");
                }
            }

            @Override
            public void onFailure(Call<CommonResult<Integer>> call, Throwable t) {
                call.cancel();
                ToastUtil.show(StockInNActivity.this, Constance.DICT.NET_ON_FAILURE);
                t.printStackTrace();
                LoadingUtil.hideLoading();
            }
        });
    }

    /**
     * 假设对话框已经关闭，欺骗系统，以保持输入窗口
     *
     * @param mDialogLongInterface 点击对话框按钮事件传进来的mDialogInterface参数
     */
    public static void keepDialog(DialogInterface mDialogLongInterface) {
        try {
            Field field = mDialogLongInterface.getClass().getSuperclass().getDeclaredField("mShowing");
            field.setAccessible(true);// 将mShowing设置为false表示对话框已关闭
            field.set(mDialogLongInterface, false);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 销毁对话框
     *
     * @param mDialogInterface
     */
    public static void closeDialog(DialogInterface mDialogInterface) {
        try {
            Field field = mDialogInterface.getClass().getSuperclass().getDeclaredField("mShowing");
            field.setAccessible(true);
            field.set(mDialogInterface, true);
            mDialogInterface.dismiss();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
