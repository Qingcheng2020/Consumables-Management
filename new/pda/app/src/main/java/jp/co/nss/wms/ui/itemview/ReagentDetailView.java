package jp.co.nss.wms.ui.itemview;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;

import butterknife.BindView;
import butterknife.ButterKnife;
import jp.co.nss.wms.R;
import jp.co.nss.wms.bean.vm.ReagentDetailVm;
import jp.co.nss.wms.util.DateUtil;

/**
 * Created by nss.
 */

public class ReagentDetailView {
    View mView;
    ViewHolder holder;
    private Context mContext;
    private String ptr="";


    public ReagentDetailView(Context context) {
        mContext = context;
        mView = LayoutInflater.from(context).inflate(R.layout.reagent_item, null);
        holder = new ViewHolder(mView);
    }

    public View getmView() {
        return mView;
    }

    public void bind(final ReagentDetailVm vm, final int position) {

        holder.tvReagName.setText(vm.getReagentName());
        holder.tvBatchNo.setText(vm.getBatchNo());
        holder.tvExpireDate.setText(DateUtil.getDate_ymd(vm.getExpireDate()));
        String _quantity = vm.getQuantity() + "";
        holder.tvQuantity.setText(_quantity);
    }

    static class ViewHolder {
        @BindView(R.id.tv_reagName)
        TextView tvReagName;
        @BindView(R.id.tv_batchNo)
        TextView tvBatchNo;
        @BindView(R.id.tv_expireDate)
        TextView tvExpireDate;
        @BindView(R.id.tv_itemcount)
        TextView tvQuantity;
        @BindView(R.id.btn_save)
        Button btnSave;

        ViewHolder(View view) {
            ButterKnife.bind(this, view);
        }
    }
}
