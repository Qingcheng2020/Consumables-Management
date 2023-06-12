package jp.co.nss.wms.ui.acitivity;

import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.Color;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.view.KeyEvent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.AutoCompleteTextView;
import android.widget.Button;
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
import jp.co.nss.wms.api.CommonService;
import jp.co.nss.wms.api.StockService;
import jp.co.nss.wms.base.BaseActivity;
import jp.co.nss.wms.bean.bean.MessageEvent;
import jp.co.nss.wms.bean.vm.ReagentDetailVm;
import jp.co.nss.wms.constance.Constance;
import jp.co.nss.wms.model.CommonResult;
import jp.co.nss.wms.model.ReagentOutDetailReq;
import jp.co.nss.wms.model.ReagentOutReq;
import jp.co.nss.wms.model.ResultCode;
import jp.co.nss.wms.model.UserInfo;
import jp.co.nss.wms.ui.adapter.StockOutAdapter;
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
 * 出库
 */

public class StockOutActivity extends BaseActivity implements OnDismissCallback {

    StockOutAdapter mAdapter;
    @BindView(R.id.activity_googlecards_listview)
    ListView mListView;

    @BindView(R.id.et_search)
    AutoCompleteTextView etSearch;

    @BindView(R.id.btn_search)
    Button btnSearch;

    @BindView(R.id.btn_save)
    Button btnSave;

    // 申请人（试剂操作员） index
    int applicantIndex = -1;
    List<ReagentDetailVm> itemList = new ArrayList<>();
    List<UserInfo> dataOperatorList = new ArrayList<>();


    public static void show(Context context) {
        Intent intent = new Intent(context, StockOutActivity.class);
        context.startActivity(intent);
    }

    @Override
    protected void initView() {
        super.initView();
        ButterKnife.bind(this);
        EventBus.getDefault().register(this);
        mBtnLeft.setVisibility(View.VISIBLE);
        setTitle("出库");
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

        getOperators();
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
        mAdapter = new StockOutAdapter(this);
        SwingBottomInAnimationAdapter swingBottomInAnimationAdapter = new SwingBottomInAnimationAdapter(new SwipeDismissAdapter(mAdapter, this));
        swingBottomInAnimationAdapter.setInitialDelayMillis(300);
        swingBottomInAnimationAdapter.setAbsListView(mListView);
        mListView.setAdapter(swingBottomInAnimationAdapter);

    }

    @Override
    protected int getContentResId() {
        return R.layout.activity_stockout;
    }

    /**
     * 获取当前用户科室的所有试剂操作员
     */
    private void getOperators() {
        CommonService apiInterface = RestClient.getClient(this).create(CommonService.class);
        Call<CommonResult<List<UserInfo>>> call1 = apiInterface.getOperators();
        call1.enqueue(new Callback<CommonResult<List<UserInfo>>>() {
            @Override
            public void onResponse(Call<CommonResult<List<UserInfo>>> call, Response<CommonResult<List<UserInfo>>> response) {
                CommonResult<List<UserInfo>> result = response.body();

                if (result == null) {
                    ToastUtil.show(StockOutActivity.this, Constance.DICT.RES_FAILURE);
                    return;
                }

                if (result.getCode() == ResultCode.SUCCESS.getCode()) {
                    dataOperatorList = result.getData();
                } else {
                    ToastUtil.show(StockOutActivity.this, "获取试剂操作员数据失败");
                }

            }

            @Override
            public void onFailure(Call<CommonResult<List<UserInfo>>> call, Throwable t) {
                call.cancel();
                t.printStackTrace();
                ToastUtil.show(StockOutActivity.this, Constance.DICT.NET_ON_FAILURE);
            }
        });
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
                    ToastUtil.show(StockOutActivity.this, Constance.DICT.RES_FAILURE);
                    LoadingUtil.hideLoading();
                    return;
                }

                if (result.getCode() == ResultCode.SUCCESS.getCode()) {
                    ReagentDetailVm item = result.getData();
                    if (item == null) {
                        ToastUtil.show(StockOutActivity.this, Constance.DICT.DATA_NOT_FOUND);
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
                                ToastUtil.show(StockOutActivity.this, Constance.DICT.DATA_IS_NOT_EARLIER);
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
                    ToastUtil.show(StockOutActivity.this, result.getMessage());
                }
                LoadingUtil.hideLoading();
            }

            @Override
            public void onFailure(Call<CommonResult<ReagentDetailVm>> call, Throwable t) {
                call.cancel();
                t.printStackTrace();
                ToastUtil.show(StockOutActivity.this, Constance.DICT.NET_ON_FAILURE);
                LoadingUtil.hideLoading();
            }
        });

    }

    private void  addItem(ReagentDetailVm item) {
        if (item == null) return;
        ReagentDetailVm obj = null;
        for (ReagentDetailVm vm: itemList) {
            if (item.getBillId().equals(vm.getBillId()) &&
                item.getBatchNo().equals(vm.getBatchNo())) {
                obj = vm;
                break;
            }
        }

        if (obj == null) {
            item.setQuantity(1);
            item.getQrList().add(item.getQrCode());
            item.getQrIdList().add(item.getQrId());
            item.getQrCodeValueList().add(item.getQrCodeValue());
            item.getReagentCodeList().add(item.getReagentCode());
            itemList.add(item);
        } else {
            if (obj.getQrList().contains(item.getQrCode())) {
                // 重复扫码
                ToastUtil.show(this, Constance.DICT.QR_CODE_REPEAT);
            } else {
                obj.getQrList().add(item.getQrCode());
                obj.getQrIdList().add(item.getQrId());
                obj.getQrCodeValueList().add(item.getQrCodeValue());
                obj.getReagentCodeList().add(item.getReagentCode());
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
        String value = etSearch.getText().toString();
        LoadingUtil.showLoading(this);
        getDate(value);
        LoadingUtil.hideLoading();
    }

    @OnClick(R.id.btn_save)
    public void onSaveViewClicked() {
        // 草稿为空
        if (itemList.size() == 0) {
            ToastUtil.show(StockOutActivity.this, Constance.DICT.DATA_DRAFT_IS_NULL);
            return;
        }

        List<String> listOperatorName = new ArrayList<>();
        listOperatorName.add("选择人员...");
        for (int i=0; i<dataOperatorList.size(); i++) {
            listOperatorName.add(dataOperatorList.get(i).getTrueName());
        }

        // 数据为空
        if (listOperatorName.size() < 2) {
            ToastUtil.show(this, "未查找到当前科室的试剂操作员");
        }

        // 弹窗选择试剂操作员
        ArrayAdapter <String> adapterSp;
        View viewSp = LayoutInflater.from(this).inflate(R.layout.dialog_spinner_operator, null);

        Spinner sp = (Spinner) viewSp.findViewById(R.id.spinner);
        sp.setPrompt("请选择试剂操作员");

        adapterSp = new ArrayAdapter<String>(this, android.R.layout.simple_spinner_dropdown_item, listOperatorName) {
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
            // 选中触发的事件
            public void onItemSelected(AdapterView<?> parent, View view, int index,
                                       long id) {
//                String result = parent.getItemAtPosition(index).toString();
                if (index > 0) {
                    applicantIndex = index - 1;
                }
            }

            @Override
            public void onNothingSelected(AdapterView<?> parent) {
                // TODO Auto-generated method stub
            }
        });

        new AlertDialog.Builder(this).setTitle("请选择申请人")
                .setView(viewSp)
                .setPositiveButton("确定", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        // 阻止点击确认后关闭 dialog
                        keepDialog(dialog);

                        if (applicantIndex==-1 || dataOperatorList.get(applicantIndex)==null) {
                            ToastUtil.show(StockOutActivity.this, "请选择试剂操作员");
                        } else {
                            closeDialog(dialog);
                            String applicantUserName = dataOperatorList.get(applicantIndex).getUsername();
                            saveData(applicantUserName);
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

//    /**
//     * 检查当前科室是否存在指定的试剂操作员
//     * @param applicant 试剂操作员用户名
//     */
//    private void checkApplicant(final DialogInterface dialog, final String applicant) {
//        String username = SharedPreferencesUtil.getInstance(this).getKeyValue(Constance.SHAREP.LOGINNAME);
//
//        // 不能出库给自己
//        if (username.equals(applicant)) {
//            AlertDialogUtil.show(this, "不能出库给自己", null);
//            LoadingUtil.hideLoading();
//            return;
//        }
//
//        CommonService apiInterface = RestClient.getClient(this).create(CommonService.class);
//        Call<CommonResult<Integer>> call1 = apiInterface.checkUserFromBranch(username, applicant);
//
//        call1.enqueue(new Callback<CommonResult<Integer>>() {
//            @Override
//            public void onResponse(Call<CommonResult<Integer>> call, Response<CommonResult<Integer>> response) {
//                CommonResult<Integer> result = response.body();
//                if ((result!=null) && (result.getCode() == ResultCode.SUCCESS.getCode())) {
//                    Integer data = result.getData();
//                    // 该用户存在与当前科室
//                    if (data == 1) {
//                        // 关闭申请人输入框 dialog
//                        closeDialog(dialog);
//
//                        saveData(applicant);
//                    } else {
//                        // 未在当前科室中找到该用户
//                        AlertDialogUtil.show(StockOutActivity.this, "未找到该用户，请确认", null);
//                        LoadingUtil.hideLoading();
//                    }
//                } else {
//                    ToastUtil.show(StockOutActivity.this, "查询用户失败");
//                    LoadingUtil.hideLoading();
//                }
//            }
//
//            @Override
//            public void onFailure(Call<CommonResult<Integer>> call, Throwable t) {
//                call.cancel();
//                t.printStackTrace();
//                ToastUtil.show(StockOutActivity.this, Constance.DICT.NET_ON_FAILURE);
//                LoadingUtil.hideLoading();
//            }
//        });
//    }

    /**
     * 提交数据出库
     * @param applicant 申请人
     */
    private void saveData(String applicant) {
        LoadingUtil.showLoading(StockOutActivity.this);

        ReagentOutReq req = new ReagentOutReq();
        req.setBillCreator(SharedPreferencesUtil.getInstance(this).getKeyValue(Constance.SHAREP.LOGINNAME));
        req.setApplicationUser(applicant);
        req.setBillDate(DateUtil.getDateStrYYYYMMDD());
        req.setRemark("");

        for (ReagentDetailVm item: itemList) {
            ReagentOutDetailReq detail = new ReagentOutDetailReq();
            detail.setId(item.getBillId());
            detail.setReagentId(item.getReagentId());
            detail.setReagentSpecification(item.getReagentSpecification());
            detail.setBatchNo(item.getBatchNo());
            detail.setFactory(item.getManufacturerName());
            detail.setRegistrationNo(item.getRegistrationNo());
            detail.setSupplierShortName(item.getSupplierShortName());
            detail.setReagentUnit(item.getReagentUnit());
            detail.setPrice(item.getReagentPrice());
            detail.setQuantity(item.getQuantity());
            detail.setTotal(item.getReagentPrice()*item.getQuantity());
            detail.setExpireDate(DateUtil.getDate_ymd(item.getExpireDate()));
            detail.setQrList(item.getQrList());
            detail.setQrIdList(item.getQrIdList());
            detail.setQrCodeValueList(item.getQrCodeValueList());
            detail.setReagentCodeList(item.getReagentCodeList());
            req.getDetails().add(detail);
        }

        StockService apiInterface = RestClient.getClient(this).create(StockService.class);
        Call<CommonResult<Integer>> call1 = apiInterface.saveOutStock(req);
        call1.enqueue(new Callback<CommonResult<Integer>>() {
            @Override
            public void onResponse(Call<CommonResult<Integer>> call, Response<CommonResult<Integer>> response) {
                CommonResult<Integer> result = response.body();
                if ((result!=null) && (result.getCode() == ResultCode.SUCCESS.getCode())) {
                    if (result.getData() == 1) {
                        clearData();
                    } else {
                        ToastUtil.show(StockOutActivity.this, Constance.DICT.RES_FAILURE);
                    }
                } else {
                    ToastUtil.show(StockOutActivity.this, "出库失败");
                }
                LoadingUtil.hideLoading();
            }

            @Override
            public void onFailure(Call<CommonResult<Integer>> call, Throwable t) {
                call.cancel();
                t.printStackTrace();
                ToastUtil.show(StockOutActivity.this, Constance.DICT.NET_ON_FAILURE);
                LoadingUtil.hideLoading();
            }
        });

    }

    private  void clearData() {
        AlertDialog.Builder builder = new AlertDialog.Builder(this);
        builder.setMessage("出库成功")
                .setPositiveButton("确认", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        finish();
                    }
                }).create().show();
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
