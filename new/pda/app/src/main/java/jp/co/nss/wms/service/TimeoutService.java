package jp.co.nss.wms.service;

import android.app.Service;
import android.content.ComponentName;
import android.content.Intent;
import android.os.IBinder;
import android.util.Log;

import jp.co.nss.wms.util.ActivityListUtil;

public class TimeoutService extends Service {

    private static String TAG = "TimeoutService";

    @Override
    public IBinder onBind(Intent arg0) {
        return null;
    }

    boolean isrun = true;

    @Override
    public void onCreate() {
        Log.e(TAG, "BindService-->onCreate()");
        super.onCreate();
    }

    @Override
    public ComponentName startService(Intent service) {
        Log.d(TAG, "startService");
        return super.startService(service);
    }

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        Log.e(TAG, "BindService-->onStartCommand()");
        forceApplicationExit();
        return super.onStartCommand(intent, flags, startId);

    }

    private void forceApplicationExit() {
        new Thread(new Runnable() {
            @Override
            public void run() {
                ActivityListUtil.getInstence().cleanActivityList();
                stopSelf();
            }
        }).start();
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        isrun = false;
    }

}
