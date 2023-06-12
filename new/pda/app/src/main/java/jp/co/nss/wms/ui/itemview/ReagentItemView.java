package jp.co.nss.wms.ui.itemview;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;

import java.util.Date;

import butterknife.BindView;
import butterknife.ButterKnife;
import jp.co.nss.wms.R;
import jp.co.nss.wms.bean.bean.ReagentItemBean;
import jp.co.nss.wms.util.DateUtil;

/**
 * Created by nss.
 */

public class ReagentItemView {
    View mView;
    ViewHolder holder;
    private Context mContext;
    private String ptr="";


    public ReagentItemView(Context context) {
        mContext = context;
        mView = LayoutInflater.from(context).inflate(R.layout.item_stockint, null);
        holder = new ViewHolder(mView);
    }

    public View getmView() {
        return mView;
    }

    public void bind(final ReagentItemBean vm, final int position) {

        holder.tvReagName.setText(vm.getReagentName());
        holder.tvBatchNo.setText(vm.getBatchNo());
        String expireDateTmp = vm.getExpireDate() + "";
        holder.tvExpireDate.setText(DateUtil.getDate_ymd_fromString(expireDateTmp));
        holder.tvItemCount.setText(vm.getQuantity() + "");
    }

    static class ViewHolder {
        @BindView(R.id.tv_reagName)
        TextView tvReagName;
        @BindView(R.id.tv_batchNo)
        TextView tvBatchNo;
        @BindView(R.id.tv_expireDate)
        EditText tvExpireDate;
        @BindView(R.id.tv_itemcount)
        TextView tvItemCount;
        @BindView(R.id.btn_save)
        Button btnSave;

        ViewHolder(View view) {
            ButterKnife.bind(this, view);
        }
    }
}
