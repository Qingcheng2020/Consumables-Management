package jp.co.nss.wms.ui.itemview;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.TextView;

import java.util.Date;

import butterknife.BindView;
import butterknife.ButterKnife;
import jp.co.nss.wms.R;
import jp.co.nss.wms.bean.vm.ReagentDetailVm;
import jp.co.nss.wms.util.CommonUtil;
import jp.co.nss.wms.util.DateUtil;

public class StockQueryOperatorDetailItemView {
    View mView;
    ViewHolder holder;
    private Context mContext;

    public StockQueryOperatorDetailItemView(Context context) {
        mContext = context;
        mView = LayoutInflater.from(context).inflate(R.layout.item_stockquery_detail_operator, null);
        holder = new ViewHolder(mView);
    }

    public View getmView() {
        return mView;
    }

    public void bind(ReagentDetailVm vm, int position) {
        holder.tvReagName.setText(vm.getReagentName());
        holder.tvBatchNo.setText(vm.getBatchNo());
        holder.tvExpireDate.setText(DateUtil.getDate_ymd(vm.getExpireDate()));
        holder.tvMaker.setText(vm.getManufacturerName());
        holder.tvSupplier.setText(vm.getSupplierShortName());
        holder.tvReagentUnit.setText(vm.getReagentUnit());
        holder.tvSpecification.setText(vm.getReagentSpecification());

        Date timeExpire = vm.getExpireDate();

        CommonUtil.EffectiveTimeUtil etu = new CommonUtil.EffectiveTimeUtil(timeExpire,
                vm.getOutTime(),
                vm.getOpenPeriod());
        // 开启有效期限
        Date effectiveDate = etu.getTimeEffect();
        long timeLeft = etu.getTimeLeft();
        boolean isTodayInvalid = etu.getIsTodayInvalid();

        String timeLeftText = timeLeft + "天";
        if (timeLeft==0 && !isTodayInvalid) {
            timeLeftText = "不足1天";
        } else if (timeLeft <= 0) {
            timeLeftText = "已过期";
        }
        
        holder.tvEffectiveDate.setText(DateUtil.getDate_ymd(effectiveDate));
        holder.tvTimeLeft.setText(timeLeftText);

//        String reagentStatus = "其它";
//        switch (vm.getReagentStatus()) {
//            case "0":
//                reagentStatus = "丢失";
//                break;
//            case "1":
//                reagentStatus = "破损";
//                break;
//            case "2":
//                reagentStatus = "过期";
//                break;
//            case "3":
//                reagentStatus = "用尽";
//                break;
//            case "1998":
//                reagentStatus = "正常在库";
//                break;
//        }
//        holder.tvItemStatus.setText(reagentStatus);

    }

    static class ViewHolder {
        @BindView(R.id.tv_reagName)
        TextView tvReagName;
        @BindView(R.id.tv_batchNo)
        TextView tvBatchNo;
        @BindView(R.id.tv_expireDate)
        TextView tvExpireDate;
        @BindView(R.id.tv_effectiveDate)
        TextView tvEffectiveDate;
        @BindView(R.id.tv_maker)
        TextView tvMaker;
        @BindView(R.id.tv_supplier)
        TextView tvSupplier;
        @BindView(R.id.tv_reagent_unit)
        TextView tvReagentUnit;
        @BindView(R.id.tv_reagent_specification)
        TextView tvSpecification;
//        @BindView(R.id.tv_item_status)
//        TextView tvItemStatus;
        @BindView(R.id.tv_time_left)
        TextView tvTimeLeft;

        ViewHolder(View view) {
            ButterKnife.bind(this, view);
        }
    }

}
