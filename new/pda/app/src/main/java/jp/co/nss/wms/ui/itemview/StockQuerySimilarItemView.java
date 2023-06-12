package jp.co.nss.wms.ui.itemview;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import butterknife.BindView;
import butterknife.ButterKnife;
import jp.co.nss.wms.R;
import jp.co.nss.wms.bean.bean.ReagentStock;

/**
 * Created by nss.
 */

public class StockQuerySimilarItemView {
    View mView;
    ViewHolder holder;
    private Context mContext;

    public StockQuerySimilarItemView(Context context) {
        mContext=context;
        mView = LayoutInflater.from(context).inflate(R.layout.item_stockquery_similar, null);
        holder=new ViewHolder(mView);
    }

    public View getmView() {
        return mView;
    }
    public void bind(ReagentStock vm, int position) {
        holder.tvReagName.setText(vm.getReagentName());
        holder.tvBatchNo.setText(vm.getBatchNo());

//        String txtExpireDate;
//        try {
//            txtExpireDate = DateUtil.getDate_ymd_fromNewDate(vm.getExpireDate());
//        } catch (Exception e) {
//            txtExpireDate = DateUtil.getDate_ymd_fromString(vm.getExpireDate());
//        }

        String txtFactory = vm.getFactory();
        if (vm.getFactory() == null) {
            txtFactory = vm.getManufacturerName();
        }

        String txtSupplierShortName = vm.getSupplierShortName();
        if (vm.getSupplierShortName() == null) {
            txtSupplierShortName = vm.getSupplierName();
        }

//        holder.tvExpireDate.setText(txtExpireDate);
        holder.tvMaker.setText(txtFactory);
        holder.tvSupplier.setText(txtSupplierShortName);
        holder.tvReagentSpecification.setText(vm.getSpecification());
        holder.tvReagentUnit.setText(vm.getReagentUnit());
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
        @BindView(R.id.tv_reagent_specification)
        TextView tvReagentSpecification;
        @BindView(R.id.tv_reagent_unit)
        TextView tvReagentUnit;

        @BindView(R.id.btn_save)
        Button btnSave;

        ViewHolder(View view) {
            ButterKnife.bind(this, view);
        }
    }
}
