package jp.co.nss.wms;

import android.content.Context;
import android.content.Intent;
import android.graphics.Color;
import android.os.Bundle;
import android.support.v4.app.FragmentActivity;
import android.view.KeyEvent;
import android.view.View;

import com.hjm.bottomtabbar.BottomTabBar;

import butterknife.ButterKnife;
import jp.co.nss.wms.ui.frag.FriendsFragment;
import jp.co.nss.wms.ui.frag.HomeFragment;
import jp.co.nss.wms.ui.frag.MineFragment;
import jp.co.nss.wms.util.ToastUtil;

/**
 * Created by NSS.
 */

public class MainActivity extends FragmentActivity {

    private BottomTabBar mBottomTabBar;
    private long exitTime = 0;



    public static void show(Context context) {
        Intent intent = new Intent(context, MainActivity.class);
        context.startActivity(intent);
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        // TODO: add setContentView(...) invocation
        setContentView( R.layout.activity_main);
        ButterKnife.bind(this);
        initView();
    }

    protected void initView() {
        mBottomTabBar = (BottomTabBar) findViewById(R.id.bottom_tab_bar);
        mBottomTabBar.init(getSupportFragmentManager(),720,1280)
                .setImgSize(50, 50)
                .setFontSize(12)
                .setTabPadding(10, 0, 5)
                .setChangeColor(Color.parseColor("#45ACF9"), Color.parseColor("#505050"))
                .addTabItem("首页", R.drawable.ic_home_select, R.drawable.ic_home, HomeFragment.class)
                .addTabItem("好友", R.drawable.ic_friend_select, R.drawable.ic_friend, FriendsFragment.class)
                .addTabItem("我的", R.drawable.ic_mine_select, R.drawable.ic_mine, MineFragment.class)
                .isShowDivider(true)
                .setDividerColor(getResources().getColor(R.color.divider_color))
                .setTabBarBackgroundColor(Color.parseColor("#00FF0000"))
                .setOnTabChangeListener(new BottomTabBar.OnTabChangeListener() {
                    @Override
                    public void onTabChange(int position, String name, View view) {

                    }
                })
                .setSpot(0, false)
                .setSpot(1, false)
                .setSpot(2, false)
                .setCurrentTab(0);

    }

    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event) {
        if (keyCode == KeyEvent.KEYCODE_BACK
                && event.getAction() == KeyEvent.ACTION_DOWN) {
            if ((System.currentTimeMillis() - exitTime) > 2000) {
                ToastUtil.show(this, "再按一次退出程序");
                exitTime = System.currentTimeMillis();
            } else {
                finish();
                System.exit(0);
            }
            return true;
        }
        return super.onKeyDown(keyCode, event);
    }
}
