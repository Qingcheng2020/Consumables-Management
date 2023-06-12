package jp.co.nss.wms.base;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.res.Configuration;
import android.content.res.Resources;
import android.os.Bundle;
import android.os.Looper;
import android.support.annotation.Nullable;
import android.util.Log;
import android.view.KeyEvent;
import android.view.MenuItem;
import android.view.MotionEvent;
import android.view.View;
import android.widget.LinearLayout;
import android.widget.TextView;

import java.util.Timer;
import java.util.TimerTask;

import jp.co.nss.wms.LoginActivity;
import jp.co.nss.wms.R;
import jp.co.nss.wms.WelComeActivity;
import jp.co.nss.wms.api.LoginService;
import jp.co.nss.wms.constance.Constance;
import jp.co.nss.wms.model.CommonResult;
import jp.co.nss.wms.model.ResultCode;
import jp.co.nss.wms.util.LocalDisplay;
import jp.co.nss.wms.util.Logutil;
import jp.co.nss.wms.util.RestClient;
import jp.co.nss.wms.util.SharedPreferencesUtil;
import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

/**
 * Created by NSS.
 */

public class BaseActivity extends Activity {

    //总布局holder
    protected LinearLayout mLlHolder;
    //titlebarholder
    protected View mTitleBarHolder;
    protected View mBtnLeft;
    protected View mBtnRight;

    protected TextView mTvTitle;
    protected TextView mTvUser;

    private boolean mDestory = false;
    private boolean mPaused;
    private Context context;
    protected static Context curContext;

    private static String TAG = "BaseActivity";

    private static Timer mTimer; // 计时器，每1秒执行一次任务
    private static MyTimerTask mTimerTask; // 计时任务，判断是否未操作时间到达指定时间
    private static long mLastActionTime;


    @SuppressLint("InlinedApi")
    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        context = this;

        if (this.getClass() != LoginActivity.class && this.getClass() != WelComeActivity.class) {
            curContext = this;
        }

        LocalDisplay.init(this);
        mLlHolder = new LinearLayout(this);
        mLlHolder.setOrientation(LinearLayout.VERTICAL);
        int titleBarResId = getTitleBarResId();
        if (titleBarResId > 0) {
            mTitleBarHolder = getLayoutInflater().inflate(titleBarResId, null);
            LinearLayout.LayoutParams lp = new LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT, LocalDisplay.dp2px(48));
            Logutil.print(LocalDisplay.dp2px(48));
            mLlHolder.addView(mTitleBarHolder, lp);
            mBtnLeft = mTitleBarHolder.findViewById(R.id.btn_titlebar_left);
            mBtnRight = mTitleBarHolder.findViewById(R.id.btn_titlebar_right);
            mTvTitle = (TextView) mTitleBarHolder.findViewById(R.id.tv_title);
            mTvUser = (TextView) mTitleBarHolder.findViewById(R.id.tv_user);

            if (null != mBtnLeft) {
                mBtnLeft.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View view) {
                        onLeftButtonClick();
                    }
                });
            }
            if (null != mBtnRight) {
                mBtnRight.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View view) {
                        onRightButtonClick();
                    }
                });
            }
            if (mTvTitle != null) {
                int titleResId = getTitleResId();// id == 0
                setTitle(titleResId);
                mTvTitle.setOnClickListener(new View.OnClickListener() {

                    @Override
                    public void onClick(View v) {
                        onTitleTextClick();
                    }
                });
            }
            if (mTvUser != null) {

                mTvUser.setText(SharedPreferencesUtil.getInstance(this).getKeyValue(Constance.SHAREP.NICKNAME));
            }
        }

        View content;
        int contentResId = getContentResId();
        if (contentResId > 0) {
            content = getLayoutInflater().inflate(contentResId, null);
        } else {
            content = getContentView();
        }
        if (content != null) {
            LinearLayout.LayoutParams lp = new LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT,
                    LinearLayout.LayoutParams.WRAP_CONTENT, 1);
            mLlHolder.addView(content, lp);
        }
        setContentView(mLlHolder);
        initView();

        // 目前不需要关闭全部 activity
//        if (this.getClass() != LoginActivity.class && this.getClass()!= WelComeActivity.class) {
//            ActivityListUtil.getInstence().addActivityToList(this);
//        }

    }

    protected void onLeftButtonClick() {
        finish();
    }

    protected void onRightButtonClick() {

    }

    protected void onTitleTextClick() {

    }

    public void setTitle(int resid) {
        if (mTvTitle != null && resid > 0)
            mTvTitle.setText(resid);
    }

    public void setTitle(String title) {
        if (mTvTitle != null)
            mTvTitle.setText(title);
    }

    @Override
    public Resources getResources() {
        // TODO Auto-generated method stub
        Resources res = super.getResources();
        Configuration config = new Configuration();
        config.setToDefaults();
        res.updateConfiguration(config, res.getDisplayMetrics());
        return res;
    }

    protected int getTitleResId() {
        return 0;
    }

    protected int getContentResId() {
        return 0;
    }

    protected View getContentView() {
        return null;
    }

    protected void initView() {

    }

    @Override
    public boolean onOptionsItemSelected(final MenuItem item) {
        switch (item.getItemId()) {
            case android.R.id.home:
                finish();
                return true;
            default:
                return super.onOptionsItemSelected(item);
        }
    }

    protected void addContentView(View v) {
        if (v != null)
            mLlHolder.addView(v, LinearLayout.LayoutParams.MATCH_PARENT,
                    LinearLayout.LayoutParams.WRAP_CONTENT);
    }

    protected int getTitleBarResId() {
        return R.layout.titlebar_default;
    }

    @Override
    protected void onResume() {
        super.onResume();
        mPaused = false;
        if (this.getClass() != LoginActivity.class && this.getClass() != WelComeActivity.class) {
            curContext = this;
        }
    }

    public boolean isPaused() {
        return mPaused;
    }

    @Override
    protected void onPause() {
        super.onPause();
        mPaused = true;
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        mDestory = true;
    }

    public boolean isDestroy() {
        return mDestory;
    }

    public Context getActivity() {
        return context;
    }

    // 监听用户触屏
    @Override
    public boolean dispatchTouchEvent(MotionEvent ev) {
        if (this.getClass() != LoginActivity.class && this.getClass() != WelComeActivity.class) {
            mLastActionTime = System.currentTimeMillis();
            Log.e(TAG, "user action");
        }
        return super.dispatchTouchEvent(ev);
    }

    /**
     * 软键盘动作，一般指软键盘回车
     * 用于重置超时登出时间
     *
     * @param event KeyEvent
     * @return boolean
     */
    @Override
    public boolean dispatchKeyEvent(KeyEvent event) {
        resetTimeLogout();
        return super.dispatchKeyEvent(event);
    }

    /**
     * 重置超时登出时间
     */
    protected static void resetTimeLogout() {
        Log.d(TAG, "user reset logout time");
        mLastActionTime = System.currentTimeMillis();
    }

    private static class MyTimerTask extends TimerTask {
        @Override
        public void run() {
//            Log.e(TAG, "check time");
            if (System.currentTimeMillis() - mLastActionTime > Constance.TIME_LOGOUT * 1000) {
                Log.e(TAG, "time out");
                stopTimer();
                exit();
            }
        }

    }

    // 退出登录
    protected static void exit() {
        SharedPreferencesUtil.getInstance(curContext).setKeyValue(Constance.SHAREP.USERINFO, "");
        SharedPreferencesUtil.getInstance(curContext).setKeyValue(Constance.SHAREP.TOKEN, "");
        SharedPreferencesUtil.getInstance(curContext).setKeyValue(Constance.SHAREP.USER_ROLE_ID, "");
        SharedPreferencesUtil.getInstance(curContext).setKeyValue(Constance.SHAREP.PASSWORD, "");

        if (Looper.myLooper() == null) {
            Looper.prepare();
        }

        AlertDialog.Builder builder = new AlertDialog.Builder(curContext);
        builder.setMessage("登录已超时，请重新登录")
                .setPositiveButton("确认", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        // 目前不需要关闭全部 activity
//                        ActivityListUtil.getInstence().cleanActivityList();
                        logout();
                    }
                });
        builder.setCancelable(false);
        builder.create();
        builder.show();

        Looper.loop();
    }

    /**
     * 登录成功，开始计时
     */
    protected static void startTimer() {
        mTimer = new Timer();
        mTimerTask = new MyTimerTask();
        mLastActionTime = System.currentTimeMillis();
        // 每过1s检查一次
        mTimer.schedule(mTimerTask, 0, 1000);
        Log.e(TAG, "start timer");
    }

    /**
     * 停止计时任务
     */
    protected static void stopTimer() {
        if (mTimer != null) {
            mTimer.cancel();
        }
        Log.e(TAG, "cancel timer");
    }

    /**
     * 退出登录
     */
    private static void logout() {
        LoginActivity.show(curContext);

        LoginService apiInterface = RestClient.getClient(curContext).create(LoginService.class);
        Call<CommonResult> call1 = apiInterface.logout();

        call1.enqueue(new Callback<CommonResult>() {
            @Override
            public void onResponse(Call<CommonResult> call, Response<CommonResult> response) {
                CommonResult result = response.body();
                if ((result != null) && (result.getCode() == ResultCode.SUCCESS.getCode())) {
                    Log.d(TAG, "登出请求成功");
                } else {
                    Log.e(TAG, "登出请求失败");
                }

            }

            @Override
            public void onFailure(Call<CommonResult> call, Throwable t) {
                call.cancel();
                Log.e(TAG, "网络错误，未能正常登出");
            }
        });

    }

}
