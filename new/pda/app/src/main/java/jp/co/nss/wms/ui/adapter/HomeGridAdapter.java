package jp.co.nss.wms.ui.adapter;

import android.app.Activity;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;

import java.util.ArrayList;

import jp.co.nss.wms.bean.bean.HomeBtnBean;
import jp.co.nss.wms.bean.bean.HomeMenuBean;
import jp.co.nss.wms.ui.itemview.HomeGridItemView;

/**
 * Created by NSS
 */

public class HomeGridAdapter extends BaseAdapter{

    ArrayList<HomeMenuBean> list=new ArrayList<>();

    public void setList(ArrayList<HomeMenuBean> list){
        this.list=list;
    }
    @Override
    public int getCount() {
        return list.size();
    }

    @Override
    public Object getItem(int i) {
        return null;
    }

    @Override
    public long getItemId(int i) {
        return i;
    }

    @Override
    public View getView(int i, View view, ViewGroup viewGroup) {
        HomeGridItemView itemView=null;
        if(view==null){
            itemView=new HomeGridItemView((Activity) viewGroup.getContext());
            view=itemView.getView();
            view.setTag(itemView);
        }else{
            itemView= (HomeGridItemView) view.getTag();
        }
        itemView.bindView(list.get(i));

        return view;
    }
}
