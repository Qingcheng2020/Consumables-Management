package jp.co.nss.wms.ui.itemview;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.TextView;

import butterknife.BindView;
import butterknife.ButterKnife;
import jp.co.nss.wms.R;
import jp.co.nss.wms.bean.vm.ReagentOrderDetailVm;

public class StockPreInOrderDetailItemView {
    View mView;
    ViewHolder holder;
    private Context mContext;

    public StockPreInOrderDetailItemView(Context context) {
        mContext = context;
        mView = LayoutInflater.from(context).inflate(R.layout.item_stock_prein_order_detail, null);
        holder = new ViewHolder(mView);
    }

    public View getmView() {
        return mView;
    }

    public void bind(ReagentOrderDetailVm vm, int position){
        holder.tvReagName.setText(vm.getReagentName());
        holder.tvReagentUnit.setText(vm.getUnit());
        holder.tvSpecification.setText(vm.getSpecification());
        holder.tvMaker.setText(vm.getManufacturerName());
        holder.tvQuantity.setText(vm.getReagentNumber() + "");
    }

    static class ViewHolder {
        @BindView(R.id.tv_reagName)
            TextView tvReagName;
        @BindView(R.id.tv_reagent_unit)
            TextView tvReagentUnit;
        @BindView(R.id.tv_specification)
            TextView tvSpecification;
        @BindView(R.id.tv_maker)
            TextView tvMaker;
        @BindView(R.id.tv_itemcount)
            TextView tvQuantity;

        ViewHolder(View view) {
            ButterKnife.bind(this, view);
        }
    }

}
