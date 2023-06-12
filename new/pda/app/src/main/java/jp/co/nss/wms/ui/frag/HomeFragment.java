package jp.co.nss.wms.ui.frag;

import android.view.View;
import android.widget.GridView;

import java.util.ArrayList;

import jp.co.nss.wms.R;
import jp.co.nss.wms.base.BaseTitlebarFragment;
import jp.co.nss.wms.bean.bean.HomeMenuBean;
import jp.co.nss.wms.constance.Constance;
import jp.co.nss.wms.ui.adapter.HomeGridAdapter;

/**
 * Created by 13799 on 2018/6/29.
 */

public class HomeFragment  extends BaseTitlebarFragment {

    HomeGridAdapter adapter;
    GridView gvHome;
    private View mView;

    ArrayList<HomeMenuBean> list = new ArrayList<>();
    @Override
    protected int getContentResId() {
        return R.layout.fragment_home;
    }



    @Override
    protected void initView() {
        super.initView();
        mView=getContentView();
        adapter = new HomeGridAdapter();
        gvHome = getContentView().findViewById(R.id.gv_home);
        gvHome.setAdapter(adapter);
        addBtn();
    }
    //添加按钮
    private void addBtn() {
        list.clear();
        for (int i = 0; i < Constance.btnNameList.length; i++) {
            addBtn2List(Constance.btnNameList[i], Constance.btnImgList[i]);
        }
        adapter.setList(list);
        adapter.notifyDataSetChanged();
    }

    private void addBtn2List(String btnName, int imgResId) {
        HomeMenuBean btn1 = new HomeMenuBean();
        btn1.setBtnName(btnName);
        btn1.setImaResId(imgResId);
        list.add(btn1);
    }
}
