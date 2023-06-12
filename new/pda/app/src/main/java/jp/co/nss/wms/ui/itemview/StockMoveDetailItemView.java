package jp.co.nss.wms.ui.itemview;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.TextView;

import butterknife.BindView;
import butterknife.ButterKnife;
import jp.co.nss.wms.R;
import jp.co.nss.wms.bean.vm.ReagentMoveDetailVm;

public class StockMoveDetailItemView {
    View mView;
    ViewHolder holder;
    private Context mContext;

    public StockMoveDetailItemView(Context context) {
        mContext = context;
        mView = LayoutInflater.from(context).inflate(R.layout.item_reagent_move_detail, null);
        holder = new ViewHolder(mView);
    }

    public View getmView() {
        return mView;
    }

    public void bind(ReagentMoveDetailVm vm, int position) {
        holder.tvReagentName.setText(vm.getReagentName());
        holder.tvReagentUnit.setText(vm.getUnit());
        holder.tvSpecification.setText(vm.getReagentType());    // 试剂规格型号
        holder.tvSupplier.setText(vm.getSupplierShortName());
        holder.tvNum.setText(vm.getReagentNumber() + "");
        holder.tvMarker.setText(vm.getFactory());
    }

    static class ViewHolder {
        @BindView(R.id.tv_reagent_name)
        TextView tvReagentName;
        @BindView(R.id.tv_supplier)
        TextView tvSupplier;
        @BindView(R.id.tv_specification)
        TextView tvSpecification;
        @BindView(R.id.tv_reagent_unit)
        TextView tvReagentUnit;
        @BindView(R.id.tv_maker)
        TextView tvMarker;
        @BindView(R.id.tv_num)
        TextView tvNum;

        ViewHolder(View view) {
            ButterKnife.bind(this, view);
        }
    }

}
