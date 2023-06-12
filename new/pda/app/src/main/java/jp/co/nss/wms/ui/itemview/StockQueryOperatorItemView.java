package jp.co.nss.wms.ui.itemview;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.TextView;

import java.util.Date;

import butterknife.BindView;
import butterknife.ButterKnife;
import jp.co.nss.wms.R;
import jp.co.nss.wms.bean.bean.ReagentStock;
import jp.co.nss.wms.util.CommonUtil;
import jp.co.nss.wms.util.DateUtil;

public class StockQueryOperatorItemView {
    View mView;
    ViewHolder holder;
    private Context mContext;

    public StockQueryOperatorItemView(Context context) {
        mContext = context;
        mView = LayoutInflater.from(context).inflate(R.layout.item_stockquery_operator, null);
        holder = new ViewHolder(mView);
    }

    public View getmView() {
        return mView;
    }

    public void bind(ReagentStock vm, int position) {
        holder.tvReagName.setText(vm.getReagentName());
        holder.tvBatchNo.setText(vm.getBatchNo());
        holder.tvExpireDate.setText(DateUtil.getDate_ymd_fromString(vm.getExpireDate()));
        holder.tvMaker.setText(vm.getManufacturerName());
        holder.tvSupplier.setText(vm.getSupplierShortName());

        Date timeExpire = DateUtil.getDate_ymdhms(vm.getExpireDate());

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
        } else if (timeLeft == 0) {
            timeLeftText = "今日已过期";
        } else if (timeLeft < 0) {
            timeLeftText = "已过期" + (-timeLeft) + "天";
        }

        holder.tvEffectiveDate.setText(DateUtil.getDate_ymd(effectiveDate));
        holder.tvTimeLeft.setText(timeLeftText);

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
//        @BindView(R.id.tv_item_status)
//        TextView tvItemStatus;
        @BindView(R.id.tv_time_left)
        TextView tvTimeLeft;

        ViewHolder(View view) {
            ButterKnife.bind(this, view);
        }
    }

}
