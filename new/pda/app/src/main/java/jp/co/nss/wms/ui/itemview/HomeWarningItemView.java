package jp.co.nss.wms.ui.itemview;

import android.app.Activity;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.TextView;

import com.zhy.android.percent.support.PercentLinearLayout;

import jp.co.nss.wms.R;
import jp.co.nss.wms.bean.bean.HomeWarningBean;
import jp.co.nss.wms.constance.Constance;
import jp.co.nss.wms.ui.acitivity.StockQueryActivity;

public class HomeWarningItemView {

    protected Activity mActivity;
    TextView tvWarningNum;
    TextView tvHomeWarningName;
    PercentLinearLayout ll_root;
    private View mView;

    public HomeWarningItemView(Activity act) {
        this.mActivity = act;

        LayoutInflater inflater = LayoutInflater.from(act);
        mView = inflater.inflate(R.layout.item_home_warning, null);
        tvHomeWarningName = mView.findViewById(R.id.tv_homename);
        tvWarningNum = mView.findViewById(R.id.tv_warning_num);
        ll_root = mView.findViewById(R.id.ll_root);
    }

    public View getView() {
        return mView;
    }

    public void bindView(final HomeWarningBean bean) {
        tvHomeWarningName.setText(bean.getBtnName());
        tvWarningNum.setText(bean.getWarningNum());
        ll_root.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (bean.getBtnName().equals(Constance.warningNameList[0])) {
                    //  低库存预警
                    StockQueryActivity.show(mActivity, 1);
                } else if (bean.getBtnName().equals(Constance.warningNameList[1])) {
                    // 过期预警
                    StockQueryActivity.show(mActivity, 2);
                }

            }
        });

    }

}
