package jp.co.nss.wms.ui.itemview;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import butterknife.BindView;
import butterknife.ButterKnife;
import jp.co.nss.wms.R;
import jp.co.nss.wms.bean.vm.ReagentOrderVm;
import jp.co.nss.wms.ui.acitivity.StockInNActivity;
import jp.co.nss.wms.util.DateUtil;

public class StockPreInOrderItemView {
    View mView;
    ViewHolder holder;
    private Context mContext;
    public static StockInNActivity instance = null;

    public StockPreInOrderItemView(Context context, StockInNActivity ma) {
        mContext = context;
        instance = ma;
        mView = LayoutInflater.from(context).inflate(R.layout.item_stockprein_order, null);
        holder = new ViewHolder(mView);
    }

    public View getmView() {
        return mView;
    }

    public void bind(final ReagentOrderVm vm, int position) {
        holder.tvOrderNo.setText(vm.getOrderNo());
        holder.tvSupplier.setText(vm.getSupplierShortName());
        holder.tvDate.setText(DateUtil.getDate_ymd(vm.getCreateTime()));
        holder.tvCreator.setText(vm.getCreateBy());
        holder.tvOrderStatus.setText(vm.getOrderStatusText());

        holder.btnDetail.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                instance.onOrderDetailClicked(vm);
            }
        });
    }

    static class ViewHolder {
        @BindView(R.id.tv_prein_order_no)
            TextView tvOrderNo;
        @BindView(R.id.tv_supplier)
            TextView tvSupplier;
        @BindView(R.id.tv_date)
            TextView tvDate;
        @BindView(R.id.tv_preinbill_creator)
            TextView tvCreator;
        @BindView(R.id.tv_prein_order_status)
            TextView tvOrderStatus;
        @BindView(R.id.btn_detail)
            Button btnDetail;

        ViewHolder(View view) {
            ButterKnife.bind(this, view);
        }
    }

}
