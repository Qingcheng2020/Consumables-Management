package jp.co.nss.wms.base;

import android.app.Activity;
import android.app.ProgressDialog;

import jp.co.nss.wms.R;

/**
 * Created by NSS.
 */

public class BaseBackActivity extends BaseActivity {
    private ProgressDialog proDialog;

    /**
     * 进度对话框
     *
     * @param text
     *            进度提示内容
     * @param style
     *            进度样式
     */
    public void showProgressDialog(String text, int style) {
        proDialog = new ProgressDialog(this);
        proDialog.setMessage(text);
        proDialog.setProgressStyle(style);
        proDialog.show();

    }

    /**
     * 取消对话框
     */
    public void disMissDialog() {
        if (proDialog != null) {
            proDialog.dismiss();
        }

    }
    @Override
    protected int getTitleBarResId() {
        return R.layout.titlebar_back;
    }

    @Override
    protected void onLeftButtonClick() {
        setResult(Activity.RESULT_CANCELED);
        finish();
    }
}
