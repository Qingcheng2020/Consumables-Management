package jp.co.nss.wms.util;

import android.content.Context;
import android.os.Handler;

import jp.co.nss.wms.R;
import jp.co.nss.wms.ui.view.LoadingView;

/**
 * Created by 13799 on 2018/6/22.
 */

public class LoadingUtil {

    private static  LoadingView loading;
    public static void showLoading(Context context){
        loading = new LoadingView(context, R.style.CustomDialog);
        loading.show();
    }
    public static void hideLoading(){
        if(null!=loading){
            new Handler().postDelayed(new Runnable() {//定义延时任务模仿网络请求
                @Override
                public void run() {
                    loading.dismiss();//3秒后调用关闭加载的方法
                }
            }, 500);
        }
    }

    /**
     * 立即销毁
     */
    public static void dismissLoading() {
        if (null != loading) {
            loading.dismiss();
        }
    }

}
