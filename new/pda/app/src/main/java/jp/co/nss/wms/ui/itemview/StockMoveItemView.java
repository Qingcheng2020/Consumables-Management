package jp.co.nss.wms.ui.itemview;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import butterknife.BindView;
import butterknife.ButterKnife;
import jp.co.nss.wms.R;
import jp.co.nss.wms.bean.vm.ReagentMoveVm;
import jp.co.nss.wms.ui.acitivity.StockMoveActivity;
import jp.co.nss.wms.util.DateUtil;

public class StockMoveItemView {
    View mView;
    ViewHolder holder;
    private Context mContext;

    public StockMoveItemView(Context context) {
        mContext = context;
        mView = LayoutInflater.from(context).inflate(R.layout.item_reagent_move, null);
        holder = new ViewHolder(mView);
    }

    public View getmView() {
        return mView;
    }

    public void bind(final ReagentMoveVm vm, int position) {
        holder.tvMoveNo.setText(vm.getCollectNo());
        holder.tvDate.setText(DateUtil.getDate_ymd(vm.getCreateTime()));
        holder.tvMoveApplicant.setText(vm.getCreateName());
        holder.tvMoveBranch.setText(vm.getBranch());

        String txtStatus = vm.getCollectStatus();
        if (vm.getCollectStatus().equals("1")) {
            txtStatus = "已提交";
        } else if (vm.getCollectStatus().equals("2")) {
            txtStatus = "已完成移库";
        } else if (vm.getCollectStatus().equals("0")) {
            txtStatus = "草稿";
        }
        holder.tvMoveStatus.setText(txtStatus);

        holder.btnMove.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                StockMoveActivity.show(mContext, vm);
            }
        });
    }

    static class ViewHolder {
        @BindView(R.id.tv_move_no)
        TextView tvMoveNo;
        @BindView(R.id.tv_move_applicant)
        TextView tvMoveApplicant;
        @BindView(R.id.tv_move_branch)
        TextView tvMoveBranch;
        @BindView(R.id.tv_date)
        TextView tvDate;
        @BindView(R.id.tv_move_status)
        TextView tvMoveStatus;
        @BindView(R.id.btn_move)
        Button btnMove;

        ViewHolder(View view) {
            ButterKnife.bind(this, view);
        }
    }

}
