package jp.co.nss.wms.ui.acitivity;

import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.text.InputType;
import android.view.KeyEvent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AutoCompleteTextView;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ListView;
import android.widget.TextView;

import com.nhaarman.listviewanimations.itemmanipulation.swipedismiss.OnDismissCallback;
import com.nhaarman.listviewanimations.itemmanipulation.swipedismiss.SwipeDismissAdapter;

import org.greenrobot.eventbus.EventBus;
import org.greenrobot.eventbus.Subscribe;
import org.greenrobot.eventbus.ThreadMode;
import org.jetbrains.annotations.NotNull;

import java.lang.reflect.Field;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;
import jp.co.nss.wms.R;
import jp.co.nss.wms.api.CommonService;
import jp.co.nss.wms.api.StockService;
import jp.co.nss.wms.base.BaseActivity;
import jp.co.nss.wms.bean.bean.MessageEvent;
import jp.co.nss.wms.bean.vm.DeviceVm;
import jp.co.nss.wms.bean.vm.ReagentDetailVm;
import jp.co.nss.wms.constance.Constance;
import jp.co.nss.wms.model.CommonResult;
import jp.co.nss.wms.model.ReagentCheckReq;
import jp.co.nss.wms.model.ReagentCloseReq;
import jp.co.nss.wms.model.ReagentRefundReq;
import jp.co.nss.wms.model.ResultCode;
import jp.co.nss.wms.ui.adapter.OperatorReagentDetailAdapter;
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

public class OperatorReagentDetailActivity extends BaseActivity implements OnDismissCallback {

    OperatorReagentDetailAdapter mAdapter;

    @BindView(R.id.activity_googlecards_listview)
    ListView mListView;
    @BindView(R.id.btn_refund)
    Button btnRefund;
    @BindView(R.id.btn_loss)
    Button btnLoss;
    @BindView(R.id.btn_change_date)
    Button btnChangeDate;
    @BindView(R.id.btn_close)
    Button btnClose;
    @BindView(R.id.btn_associate_device)
    Button btnAssDevice;

    // dialog 设备信息
    private TextView tvDeviceName;
    private TextView tvDeviceCode;

    private static ReagentDetailVm dataReagent;
    // 库损类型
    // 0-丢失；1-破损；2-过期；3-用尽；4-其它原因库损
    CharSequence optsLoss[] = new CharSequence[] {"破损", "过期", "其它原因"};
    int typeLoss = 1;   // 库损类型，默认为 1-破损

    // 已扫码获取了设备数据
    private boolean flagAlreadyGetDevice = false;
    private DeviceVm dataDevice;

    @Override
    protected int getContentResId() {
        return R.layout.activity_operator_reagent_detail;
    }

    public static void show(Context context, ReagentDetailVm vm) {
        Intent intent = new Intent(context, OperatorReagentDetailActivity.class);
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
        mAdapter = new OperatorReagentDetailAdapter(this);
        SwingBottomInAnimationAdapter swingBottomInAnimationAdapter = new SwingBottomInAnimationAdapter(new SwipeDismissAdapter(mAdapter, this));
        swingBottomInAnimationAdapter.setInitialDelayMillis(300);
        swingBottomInAnimationAdapter.setAbsListView(mListView);
        mListView.setAdapter(swingBottomInAnimationAdapter);
    }

    /**
     * 退货
     */
    @OnClick(R.id.btn_refund)
    public void onClickRefund() {
        refundReagent();
    }

    /**
     * 库损
     */
    @OnClick(R.id.btn_loss)
    public void onClickLoss() {
        AlertDialog.Builder adb = new AlertDialog.Builder(this);
        adb.setSingleChoiceItems(optsLoss, 0, new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface d, int n) {
                // 点击 radio 事件
                typeLoss = n + 1;
            }
        });
        adb.setNegativeButton("取消", null);
        adb.setPositiveButton("确认", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                lossReagent();
            }
        });
        adb.setTitle("选择库损类型");
        adb.show();
    }

    /**
     * 更改开启有效期
     */
    @OnClick(R.id.btn_change_date)
    public void onClickChangeDate() {
        final EditText et = new EditText(this);
        et.setInputType(InputType.TYPE_CLASS_NUMBER);

        new AlertDialog.Builder(this).setTitle("请输入开启有效期天数")
                .setView(et)
                .setPositiveButton("确定", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        // 阻止点击确认后关闭 dialog
                        keepDialog(dialog);

                        String time = et.getText().toString();
                        if (time.equals("")) {
                            ToastUtil.show(OperatorReagentDetailActivity.this, "请输入正确的有效期");
                        } else {
                            checkEffectiveTime(dialog, time);
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

    @OnClick(R.id.btn_associate_device)
    public void onClickAssociateDevice() {
        final View viewDiaDevice = LayoutInflater.from(this).inflate(R.layout.dialog_device, null);
        final AutoCompleteTextView atSearch = (AutoCompleteTextView) viewDiaDevice.findViewById(R.id.et_search);
        tvDeviceName = (TextView) viewDiaDevice.findViewById(R.id.tv_device_name);
        tvDeviceCode = (TextView) viewDiaDevice.findViewById(R.id.tv_device_code);

        if (dataReagent.getDeviceName() != null) {
            ToastUtil.show(this, "该试剂已上机");
            tvDeviceCode.setText(dataReagent.getDeviceCode());
            tvDeviceName.setText(dataReagent.getDeviceName());
        }

        atSearch.setOnKeyListener(new View.OnKeyListener() {
            @Override
            public boolean onKey(View v, int keyCode, KeyEvent event) {
                if (keyCode == KeyEvent.KEYCODE_ENTER) {
                    String device = atSearch.getText().toString();
                    if (!StringUtil.isEmpty(device)) {
                        String tempDeviceQrCode = atSearch.getText().toString();
                        atSearch.setText("");
                        LoadingUtil.showLoading(v.getContext());
                        getDataDevice(tempDeviceQrCode);

                        // todo 同步
//                        if (flagAlreadyGetDevice) {
//                            tvDeviceCode.setText(dataDevice.getDeviceCode());
//                            tvDeviceName.setText(dataDevice.getDeviceName());
//                            LoadingUtil.hideLoading();
//                        }

                    }
                    return true;
                }

                return false;
            }
        });

        new AlertDialog.Builder(this).setTitle("选择设备")
                .setView(viewDiaDevice)
                .setPositiveButton("确定", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        keepDialog(dialog);
                        if (!flagAlreadyGetDevice) {
                            ToastUtil.show(OperatorReagentDetailActivity.this, "请扫设备二维码");
                        } else {
                            closeDialog(dialog);
                            associateDevice();
                        }
                    }
                })
                .setNegativeButton("取消", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        closeDialog(dialog);
                        flagAlreadyGetDevice = false;
                        dataDevice = null;
                    }
                })
                .show();
    }

    /**
     * 终结（用尽）试剂
     */
    @OnClick(R.id.btn_close)
    public void onClickClose() {
        // todo ? 增加开启有效期验证条件
        // 存在更早过期的试剂，禁止终结当前试剂
        if (dataReagent.getEarlierNum() != 0) {
            ToastUtil.show(this, Constance.DICT.DATA_IS_NOT_EARLIER);
            return;
        }

        closeReagent();
    }

    /**
     * 根据设备二维码获取设备信息
     * @param qrcode String 设备二维码
     */
    private void getDataDevice(final String qrcode) {

        // todo 同步
//        new Thread(new Runnable() {
//            @Override
//            public void run() {
//                CommonService apiInterface = RestClient.getClient(OperatorReagentDetailActivity.this).create(CommonService.class);
//                Call<CommonResult<DeviceVm>> call1 = apiInterface.getDeviceByQrCode(qrcode);
//
//                try {
//                    Response<CommonResult<DeviceVm>> response = call1.execute();
//                    CommonResult<DeviceVm> result = response.body();
//
//                    if ((result!=null) && (result.getCode()==ResultCode.SUCCESS.getCode())) {
//                        dataDevice = result.getData();
//                        flagAlreadyGetDevice = true;
//
//                    } else {
//                        ToastUtil.show(OperatorReagentDetailActivity.this, "获取设备数据失败");
//                    }
//
//                } catch (IOException e) {
//                    ToastUtil.show(OperatorReagentDetailActivity.this, Constance.DICT.NET_ON_FAILURE);
//                    e.printStackTrace();
//                }
//
//                LoadingUtil.hideLoading();
//
//            }
//        }).start();


        CommonService apiInterface = RestClient.getClient(OperatorReagentDetailActivity.this).create(CommonService.class);
        Call<CommonResult<DeviceVm>> call1 = apiInterface.getDeviceByQrCode(qrcode);

        call1.enqueue(new Callback<CommonResult<DeviceVm>>() {
            @Override
            public void onResponse(Call<CommonResult<DeviceVm>> call, Response<CommonResult<DeviceVm>> response) {
                CommonResult<DeviceVm> result = response.body();
                if ((result!=null) && (result.getCode()==ResultCode.SUCCESS.getCode())) {
                    dataDevice = result.getData();
                    flagAlreadyGetDevice = true;

                    tvDeviceCode.setText(dataDevice.getDeviceCode());
                    tvDeviceName.setText(dataDevice.getDeviceName());
                } else {
                    ToastUtil.show(OperatorReagentDetailActivity.this, "获取设备数据失败");
                }
            }

            @Override
            public void onFailure(Call<CommonResult<DeviceVm>> call, Throwable t) {
                call.cancel();
                t.printStackTrace();
                ToastUtil.show(OperatorReagentDetailActivity.this, Constance.DICT.NET_ON_FAILURE);
            }
        });

        LoadingUtil.hideLoading();
    }

    /**
     * 退货 req
     */
    private void refundReagent() {
        LoadingUtil.showLoading(this);

        String username = SharedPreferencesUtil.getInstance(this).getKeyValue(Constance.SHAREP.LOGINNAME);

        ReagentRefundReq req = new ReagentRefundReq();
        req.setCreateBy(username);
        req.getQrList().add(dataReagent.getQrCode());

        StockService apiInterface = RestClient.getClient(this).create(StockService.class);
        Call<CommonResult<Integer>> call1 = apiInterface.refundReagent(req);
        call1.enqueue(new Callback<CommonResult<Integer>>() {
            @Override
            public void onResponse(Call<CommonResult<Integer>> call, Response<CommonResult<Integer>> response) {
                CommonResult<Integer> result = response.body();
                if ((result!=null) && (result.getCode()==ResultCode.SUCCESS.getCode())) {
                    if (result.getData() == 1) {
                        successReq("退货");
                    } else {
                        failReq("退货");
                    }
                } else {
                    failReq("退货");
                }
                LoadingUtil.hideLoading();
            }

            @Override
            public void onFailure(Call<CommonResult<Integer>> call, Throwable t) {
                call.cancel();
                t.printStackTrace();
                ToastUtil.show(OperatorReagentDetailActivity.this, Constance.DICT.NET_ON_FAILURE);
                LoadingUtil.hideLoading();
            }
        });

    }

    /**
     * 库损 req
     */
    private void lossReagent() {
        LoadingUtil.showLoading(this);

        String username = SharedPreferencesUtil.getInstance(this).getKeyValue(Constance.SHAREP.LOGINNAME);

        StockService apiInterface = RestClient.getClient(this).create(StockService.class);
        ReagentCheckReq req = new ReagentCheckReq();
        req.setCreateBy(username);
        if (typeLoss == 3) typeLoss = 4;
        req.setReagentStatus(typeLoss+"");
        req.getQrList().add(dataReagent.getQrCode());

        Call<CommonResult<Integer>> call1 = apiInterface.checkStock(req);
        call1.enqueue(new Callback<CommonResult<Integer>>() {
            @Override
            public void onResponse(Call<CommonResult<Integer>> call, Response<CommonResult<Integer>> response) {
                CommonResult<Integer> result = response.body();
                if ((result!=null) && (result.getCode() == ResultCode.SUCCESS.getCode())) {
                    if (result.getData() == 1) {    // 处理成功
                        successReq("库损");
                    } else {
                        failReq("库损");
                    }
                } else {
                    failReq("库损");
                }
                LoadingUtil.hideLoading();
            }

            @Override
            public void onFailure(Call<CommonResult<Integer>> call, Throwable t) {
                call.cancel();
                t.printStackTrace();
                ToastUtil.show(OperatorReagentDetailActivity.this, Constance.DICT.NET_ON_FAILURE);
                LoadingUtil.hideLoading();
            }
        });

    }

    /**
     * 更改开启有效期 req
     */
    private void changeOpenDate(int days) {
        LoadingUtil.showLoading(this);
        String qrcode = dataReagent.getQrCode();

        StockService apiInterface = RestClient.getClient(this).create(StockService.class);
        Call<CommonResult<Integer>> call1 = apiInterface.updateEffectiveOpenTime(days, qrcode);
        call1.enqueue(new Callback<CommonResult<Integer>>() {
            @Override
            public void onResponse(Call<CommonResult<Integer>> call, Response<CommonResult<Integer>> response) {
                CommonResult<Integer> result = response.body();
                if ((result!=null) && (result.getCode()==ResultCode.SUCCESS.getCode())) {
                    if (result.getData() == 1) {
                        successReq("更改开启有效期");
                    } else {
                        failReq("更改开启有效期");
                    }
                } else {
                    failReq("更改开启有效期");
                }
                LoadingUtil.hideLoading();
            }

            @Override
            public void onFailure(Call<CommonResult<Integer>> call, Throwable t) {
                call.cancel();
                t.printStackTrace();
                ToastUtil.show(OperatorReagentDetailActivity.this, Constance.DICT.NET_ON_FAILURE);
                LoadingUtil.hideLoading();
            }
        });
    }

    /**
     * 试剂用尽 req
     */
    private void closeReagent() {
        LoadingUtil.showLoading(this);
        String username = SharedPreferencesUtil.getInstance(this).getKeyValue(Constance.SHAREP.LOGINNAME);

        ReagentCloseReq req = new ReagentCloseReq();
        req.setCreateBy(username);
        req.setReagentStatus("3");  // 3-用尽
        req.getQrList().add(dataReagent.getQrCode());

        StockService apiInterface = RestClient.getClient(this).create(StockService.class);
        Call<CommonResult<Integer>> call1 = apiInterface.closeReagent(req);
        call1.enqueue(new Callback<CommonResult<Integer>>() {
            @Override
            public void onResponse(Call<CommonResult<Integer>> call, Response<CommonResult<Integer>> response) {
                CommonResult<Integer> result = response.body();
                if ((result!=null) && (result.getCode()==ResultCode.SUCCESS.getCode())) {
                    if (result.getData() == 1) {
                        successReq("操作");
                    } else {
                        failReq("操作");
                    }

                } else {
                    failReq("操作");
                }
                LoadingUtil.hideLoading();
            }

            @Override
            public void onFailure(Call<CommonResult<Integer>> call, Throwable t) {
                call.cancel();
                t.printStackTrace();
                ToastUtil.show(OperatorReagentDetailActivity.this, Constance.DICT.NET_ON_FAILURE);
                LoadingUtil.hideLoading();
            }
        });
    }

    /**
     * 上机使用 req
     */
    private void associateDevice() {
        LoadingUtil.showLoading(this);
        String qrcode = dataReagent.getQrCode();
        Long deviceId = dataDevice.getId();

        StockService apiInterface = RestClient.getClient(this).create(StockService.class);
        Call<CommonResult<Integer>> call1 = apiInterface.associateDevice(qrcode, deviceId);
        call1.enqueue(new Callback<CommonResult<Integer>>() {
            @Override
            public void onResponse(Call<CommonResult<Integer>> call, Response<CommonResult<Integer>> response) {
                CommonResult<Integer> result = response.body();
                if ((result!=null) && (result.getCode()==ResultCode.SUCCESS.getCode())) {
                    if (result.getData() == 1) {
                        successReq("上机");
                    } else {
                        failReq("上机");
                    }
                } else {
                    failReq("上机");
                }
                LoadingUtil.hideLoading();
            }

            @Override
            public void onFailure(Call<CommonResult<Integer>> call, Throwable t) {
                call.cancel();
                t.printStackTrace();
                ToastUtil.show(OperatorReagentDetailActivity.this, Constance.DICT.NET_ON_FAILURE);
                LoadingUtil.hideLoading();
            }
        });
    }

    /**
     * 检查开启有效期
     * @param dialog DialogInterface
     * @param tempDays String 输入的天数
     */
    private void checkEffectiveTime(final DialogInterface dialog, String tempDays) {
        int days = Integer.parseInt(tempDays);
        int curDays = dataReagent.getOpenPeriod();

        // 只能延长，不能缩短
        if (days <= curDays) {
            String tempToastText = "有效期不能低于" + dataReagent.getOpenPeriod() + "天";
            ToastUtil.show(this, tempToastText);
            return;
        }

        CommonUtil.EffectiveTimeUtil etu = new CommonUtil.EffectiveTimeUtil(
                dataReagent.getExpireDate(),
                dataReagent.getOutTime(),
                dataReagent.getOpenPeriod());
        long timeLeftExpire = etu.getTimeLeftExpire();

        // 不能晚于库存有效期
        if (days > timeLeftExpire) {
            String tempToastText = "不能晚于库存有效期（" + timeLeftExpire + "天）";
            ToastUtil.show(this, tempToastText);
            return;
        }

        closeDialog(dialog);
        changeOpenDate(days);

    }

    /**
     * 操作成功
     * @param content toast文本内容
     */
    private void successReq(String content) {
        ToastUtil.show(this, content+"成功");
        finish();
    }

    /**
     * 操作失败
     * @param content toast文本内容
     */
    private void failReq(String content) {
        ToastUtil.show(this, content+"失败");
    }

    /**
     * 假设对话框已经关闭，欺骗系统，以保持输入窗口
     * @param mDialogLongInterface	点击对话框按钮事件传进来的mDialogInterface参数
     */
    public static void keepDialog(DialogInterface mDialogLongInterface) {
        try {
            Field field = mDialogLongInterface.getClass().getSuperclass().getDeclaredField("mShowing");
            field.setAccessible(true);//将mShowing设置为false表示对话框已关闭
            field.set(mDialogLongInterface, false);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 销毁对话框
     * @param mDialogInterface
     */
    public static void closeDialog(DialogInterface mDialogInterface){
        try {
            Field field=mDialogInterface.getClass().getSuperclass().getDeclaredField("mShowing");
            field.setAccessible(true);
            field.set(mDialogInterface, true);
            mDialogInterface.dismiss();
        } catch (Exception e) {
            e.printStackTrace();
        }
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
