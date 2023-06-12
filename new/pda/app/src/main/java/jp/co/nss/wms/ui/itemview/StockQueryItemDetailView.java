package jp.co.nss.wms.ui.itemview;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import java.util.Date;

import butterknife.BindView;
import butterknife.ButterKnife;
import jp.co.nss.wms.R;
import jp.co.nss.wms.bean.bean.ReagentStock;
import jp.co.nss.wms.ui.acitivity.StockQueryActivity;
import jp.co.nss.wms.util.DateUtil;

public class StockQueryItemDetailView {
    View mView;
    ViewHolder holder;
    private StockQueryActivity instance;
    private Context mContext;

    public StockQueryItemDetailView(Context context, StockQueryActivity sqa) {
        mContext = context;
        instance = sqa;
        mView = LayoutInflater.from(context).inflate(R.layout.item_stockquery_detail, null);
        holder = new ViewHolder(mView);
    }

    public View getmView() {
        return mView;
    }

    public void bind(final ReagentStock vm, int position) {
        holder.tvReagName.setText(vm.getReagentName());
        holder.tvBatchNo.setText(vm.getBatchNo());
        holder.tvExpireDate.setText(DateUtil.getDate_ymd_fromString(vm.getExpireDate()));
        holder.tvMaker.setText(vm.getFactory());
        holder.tvSupplier.setText(vm.getSupplierName());

        Date timeNow = new Date();
        Date timeExpire = DateUtil.getDate_ymdhms(vm.getExpireDate());

        String reagentStatus = "其它";
        switch (vm.getReagentStatus()) {
            case "0":
                reagentStatus = "已丢失";
                break;
            case "1":
                reagentStatus = "已破损";
                break;
            case "2":
                reagentStatus = "已过期";
                break;
            case "3":
                reagentStatus = "已用尽";
                break;
            case "4":
                reagentStatus = "其它原因库损";
                break;
            case "1998":
                reagentStatus = "正常在库";
                break;
            case "1999":
                reagentStatus = "已出库";
                break;
        }

        // 库中状态码可能未更新，二次检查过期
        if (!vm.getReagentStatus().equals("2") && timeNow.after(timeExpire)) {
            reagentStatus = "已过期";
        }

        holder.tvItemStatus.setText(reagentStatus);

        holder.btnItemSimilar.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                instance.onLoadSimilar(vm);
            }
        });

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
        @BindView(R.id.tv_item_status)
        TextView tvItemStatus;
        @BindView(R.id.btn_item_similar)
        Button btnItemSimilar;

        ViewHolder(View view) {
            ButterKnife.bind(this, view);
        }
    }
}
