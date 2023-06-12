package jp.co.nss.wms.ui.itemview;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import butterknife.BindView;
import butterknife.ButterKnife;
import jp.co.nss.wms.R;
import jp.co.nss.wms.bean.vm.ReagentStockPreIn;
import jp.co.nss.wms.ui.acitivity.StockInActivity;
import jp.co.nss.wms.ui.acitivity.StockInNActivity;
import jp.co.nss.wms.util.DateUtil;

public class StockPreInItemView {
    View mView;
    ViewHolder holder;
    private StockInNActivity instance;
    private Context mContext;

    public StockPreInItemView(Context context, StockInNActivity sina) {
        mContext = context;
        instance = sina;
        mView = LayoutInflater.from(context).inflate(R.layout.item_stockprein, null);
        holder = new ViewHolder(mView);
    }

    public View getmView() {
        return mView;
    }

    public void bind(final ReagentStockPreIn vm, int position) {
        holder.tvPreInBillNo.setText(vm.getBillCode());
        holder.tvSupplier.setText(vm.getSupplierShortName());
        holder.tvDate.setText(DateUtil.getDate_ymd(vm.getBillDate()));
        holder.tvPreInBillStatus.setText(vm.getBillStatusText());
        holder.tvPreInBillCreator.setText(vm.getBillCreator());

        // 0-已撤销，不展示入库按钮
        if (vm.getBillStatus().equals("0")) {
            holder.btnDetail.setVisibility(View.GONE);
            holder.btnToIn.setVisibility(View.GONE);
        } else {
            holder.btnDetail.setVisibility(View.VISIBLE);
            holder.btnToIn.setVisibility(View.VISIBLE);

            holder.btnDetail.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    // 入库的第二个页面-草稿页面
                    StockInActivity.show(mContext, vm);
                }
            });

            holder.btnToIn.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    instance.onOneKeyToInPre(vm);
                }
            });
        }

    }

    static class ViewHolder {
        @BindView(R.id.tv_preinbill_code)
        TextView tvPreInBillNo;
        @BindView(R.id.tv_supplier)
                TextView tvSupplier;
        @BindView(R.id.tv_date)
                TextView tvDate;
        @BindView(R.id.tv_preinbill_status)
                TextView tvPreInBillStatus;
        @BindView(R.id.tv_preinbill_creator)
                TextView tvPreInBillCreator;
        @BindView(R.id.btn_detail)
                Button btnDetail;
        @BindView(R.id.btn_to_in)
                Button btnToIn;

        ViewHolder(View view) {
            ButterKnife.bind(this, view);
        }
    }

}
