package jp.co.nss.wms.ui.itemview;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import butterknife.BindView;
import butterknife.ButterKnife;
import jp.co.nss.wms.R;
import jp.co.nss.wms.bean.vm.ReagentInfoVm;

/**
 * Created by nss.
 */

public class BillInItemView {
    View mView;
    ViewHolder holder;
    private Context mContext;
    public BillInItemView(Context context) {
        mContext=context;
        mView = LayoutInflater.from(context).inflate(R.layout.item_stockquery, null);
        holder=new ViewHolder(mView);
    }

    public View getmView() {
        return mView;
    }
    public void bind(ReagentInfoVm vm, int position){
        holder.tvReagName.setText(vm.getName());
        holder.tvBatchNo.setText(vm.getBatchNo());
        holder.tvExpireDate.setText(vm.getExpireDateStr());
        holder.tvMaker.setText(vm.getManufacturerName());
        holder.tvSupplier.setText(vm.getSupplierShortName());
        holder.tvQrCode.setText(vm.getQrCode());

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
        @BindView(R.id.tv_qrCode)
        TextView tvQrCode;
        @BindView(R.id.btn_save)
        Button btnSave;

        ViewHolder(View view) {
            ButterKnife.bind(this, view);
        }
    }
}
