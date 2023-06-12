package jp.co.nss.wms.ui.itemview;

import android.app.Activity;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.TextView;

import com.zhy.android.percent.support.PercentLinearLayout;

import jp.co.nss.wms.R;
import jp.co.nss.wms.bean.bean.HomeMenuBean;
import jp.co.nss.wms.constance.Constance;
import jp.co.nss.wms.ui.acitivity.ItemCloseActivity;
import jp.co.nss.wms.ui.acitivity.ItemRetireActivity;
import jp.co.nss.wms.ui.acitivity.StockCheckActivity;
import jp.co.nss.wms.ui.acitivity.StockInNActivity;
import jp.co.nss.wms.ui.acitivity.StockMoveIndexActivity;
import jp.co.nss.wms.ui.acitivity.StockOutActivity;
import jp.co.nss.wms.ui.acitivity.StockQueryActivity;
import jp.co.nss.wms.ui.view.CircleImageView;

/**
 * Created by NSS
 */

public class HomeGridItemView {


    protected Activity mActivity;
    CircleImageView imgHomeitem;
    TextView tvHomename;
    PercentLinearLayout ll_root;
    private View mView;


    public HomeGridItemView(Activity act) {
        this.mActivity = act;

        LayoutInflater inflater = LayoutInflater.from(act);
        mView = inflater.inflate(R.layout.itemhome, null);
        imgHomeitem=mView.findViewById(R.id.img_homeitem);
        tvHomename=mView.findViewById(R.id.tv_homename);
        ll_root=mView.findViewById(R.id.ll_root);
    }


    public View getView() {
        return mView;
    }

    public void bindView(final HomeMenuBean bean) {
        imgHomeitem.setImageResource(bean.getImaResId());
        tvHomename.setText(bean.getBtnName());
        ll_root.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
//                ToastUtil.show(mActivity,bean.getBtnName());
                Jump(bean.getBtnName());
            }
        });
    }
    private void Jump(String btnName){
        if(Constance.btnNameList[0].equals(btnName)) {     // 在库查询
            StockQueryActivity.show(mActivity, 0);
        } else if (Constance.btnNameList[1].equals(btnName)) { // 入库
//            StockInActivity.show(mActivity);
            StockInNActivity.show(mActivity);
        } else if (Constance.btnNameList[2].equals(btnName)) { // 移库
//            StockMoveActivity.show(mActivity);
            StockMoveIndexActivity.show(mActivity);
        } else if (Constance.btnNameList[3].equals(btnName)) { // 出库
            StockOutActivity.show(mActivity);
        } else if (Constance.btnNameList[4].equals(btnName)) { // 退货
            ItemRetireActivity.show(mActivity);
        } else if (Constance.btnNameList[5].equals(btnName)) { // 库损
            StockCheckActivity.show(mActivity);
        } else if (Constance.btnNameList[6].equals(btnName)) { // 终结
            ItemCloseActivity.show(mActivity);
        }
    }
}
