package jp.co.nss.wms.util;

import android.content.Context;
import android.widget.Toast;

/**
 * Created by NSS
 */

public class ToastUtil {

    public static void show(Context context,String msg){
        if(context!=null)
        Toast.makeText(context,msg,Toast.LENGTH_SHORT).show();
    }
    public static void showLong(Context context,String msg){
        if(context!=null)
            Toast.makeText(context,msg,Toast.LENGTH_LONG).show();
    }
}
