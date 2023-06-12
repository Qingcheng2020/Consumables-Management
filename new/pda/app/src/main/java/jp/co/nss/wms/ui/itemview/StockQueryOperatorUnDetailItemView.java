package jp.co.nss.wms.ui.itemview;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.TextView;

import butterknife.BindView;
import butterknife.ButterKnife;
import jp.co.nss.wms.R;
import jp.co.nss.wms.bean.vm.ReagentDetailVm;
import jp.co.nss.wms.util.DateUtil;

public class StockQueryOperatorUnDetailItemView {
    View mView;
    ViewHolder holder;
    private Context mContext;

    public StockQueryOperatorUnDetailItemView(Context context) {
        mContext = context;
        mView = LayoutInflater.from(context).inflate(R.layout.item_stockquery_un_detail_operator, null);
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
        String _reagentNumber = vm.getReagentNumber() + "";
        holder.tvReagentNumber.setText(_reagentNumber);
    }

    static class ViewHolder {
        @BindView(R.id.tv_reagName)
        TextView tvReagName;
        @BindView(R.id.tv_batchNo)
        TextView tvBatchNo;
        @BindView(R.id.tv_expireDate)
        TextView tvExpireDate;
        @BindView(R.id.tv_maker)
        TextView tvMaker;
        @BindView(R.id.tv_supplier)
        TextView tvSupplier;
        @BindView(R.id.tv_reagent_unit)
        TextView tvReagentUnit;
        @BindView(R.id.tv_reagent_specification)
        TextView tvSpecification;
        @BindView(R.id.tv_reagent_number)
        TextView tvReagentNumber;

        ViewHolder(View view) {
            ButterKnife.bind(this, view);
        }
    }

}
