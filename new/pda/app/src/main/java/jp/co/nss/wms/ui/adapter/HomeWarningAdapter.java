package jp.co.nss.wms.ui.adapter;

import android.app.Activity;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;

import java.util.ArrayList;
import java.util.List;

import jp.co.nss.wms.bean.bean.HomeWarningBean;
import jp.co.nss.wms.ui.itemview.HomeWarningItemView;

public class HomeWarningAdapter extends BaseAdapter {

    List<HomeWarningBean> list  = new ArrayList<>();

    public void setList(List<HomeWarningBean> list) {
        this.list = list;
    }

    @Override
    public int getCount() {
        return list.size();
    }

    @Override
    public Object getItem(int position) {
        return null;
    }

    @Override
    public long getItemId(int position) {
        return position;
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        HomeWarningItemView itemView = null;
        if (convertView == null) {
            itemView = new HomeWarningItemView((Activity) parent.getContext());
            convertView = itemView.getView();
            convertView.setTag(itemView);
        } else {
            itemView = (HomeWarningItemView) convertView.getTag();
        }
        itemView.bindView(list.get(position));

        return convertView;
    }
}
