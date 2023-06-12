package jp.co.nss.wms.ui.itemview;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.TextView;

import butterknife.BindView;
import butterknife.ButterKnife;
import jp.co.nss.wms.R;
import jp.co.nss.wms.bean.vm.ReagentPreInDetail;
import jp.co.nss.wms.util.DateUtil;

public class StockInDetailItemView {

    View mView;
    ViewHolder holder;
    private Context mContext;

    public StockInDetailItemView(Context context) {
        mContext = context;
        mView = LayoutInflater.from(context).inflate(R.layout.item_stockin_detail, null);
        holder = new ViewHolder(mView);
    }

    public View getmView() {
        return mView;
    }

    public void bind(ReagentPreInDetail vm, int position){
        holder.tvReagName.setText(vm.getReagentName());
        holder.tvReagentUnit.setText(vm.getReagentUnit());
        holder.tvBatchNo.setText(vm.getBatchNo());
        holder.tvExpireDate.setText(DateUtil.getDate_ymd(vm.getExpireDate()));
        holder.tvQuantity.setText(vm.getQuantity() + "");
    }

    static class ViewHolder {
        @BindView(R.id.tv_reagName)
                TextView tvReagName;
        @BindView(R.id.tv_reagent_unit)
                TextView tvReagentUnit;
        @BindView(R.id.tv_batchNo)
                TextView tvBatchNo;
        @BindView(R.id.tv_expireDate)
                TextView tvExpireDate;
        @BindView(R.id.tv_itemcount)
                TextView tvQuantity;

        ViewHolder(View view) {
            ButterKnife.bind(this, view);
        }
    }

}
