package jp.co.nss.wms.ui.itemview;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import butterknife.BindView;
import butterknife.ButterKnife;
import jp.co.nss.wms.R;
import jp.co.nss.wms.bean.vm.ReagentInBillVm;
import jp.co.nss.wms.ui.acitivity.StockInActivity;
import jp.co.nss.wms.util.DateUtil;

public class StockInBillDetailItemView {
    View mView;
    ViewHolder holder;
    private Context mContext;
    private StockInActivity instance;

    public StockInBillDetailItemView(Context context, StockInActivity sia) {
        mContext = context;
        instance = sia;
        mView = LayoutInflater.from(context).inflate(R.layout.item_stock_inbill, null);
        holder = new ViewHolder(mView);
    }

    public View getmView() {
        return mView;
    }

    public void bind(final ReagentInBillVm vm, int position){
        holder.tvInBillNo.setText(vm.getBillCode());
        holder.tvSupplier.setText(vm.getSupplierShortName());
        holder.tvInBillCreator.setText(vm.getBillCreator());
        holder.tvInBillDate.setText(DateUtil.getDate_ymd(vm.getCreateTime()));
        holder.btnLoad.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                instance.onLoadDraftData(vm);
            }
        });

    }

    static class ViewHolder {
        @BindView(R.id.tv_inbill_no)
            TextView tvInBillNo;
        @BindView(R.id.tv_supplier)
            TextView tvSupplier;
        @BindView(R.id.tv_inbill_date)
            TextView tvInBillDate;
        @BindView(R.id.tv_inbill_creator)
            TextView tvInBillCreator;
        @BindView(R.id.btn_load)
            Button btnLoad;

        ViewHolder(View view) {
            ButterKnife.bind(this, view);
        }
    }

}
