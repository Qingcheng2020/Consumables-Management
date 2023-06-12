package jp.co.nss.wms.ui.adapter;

import android.app.Activity;
import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;

import org.greenrobot.eventbus.EventBus;

import java.util.List;

import jp.co.nss.wms.bean.bean.MessageEvent;
import jp.co.nss.wms.bean.vm.ReagentOrderDetailVm;
import jp.co.nss.wms.ui.itemview.StockPreInOrderDetailItemView;

public class StockPreInOrderAdapter extends BaseAdapter {
    Context mContext;

    private List<ReagentOrderDetailVm> obj;

    public void setItemsList(List<ReagentOrderDetailVm> obj){
        this.obj = obj;
    }

    public StockPreInOrderAdapter(Context context){
        mContext = context;
    }

    @Override
    public int getCount() {
        return obj==null ? 0 : obj.size();
    }

    @Override
    public Object getItem(int position) {
        return null;
    }

    @Override
    public long getItemId(int position) {
        return 0;
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        StockPreInOrderDetailItemView itemView = null;
        if(convertView == null) {
            itemView = new StockPreInOrderDetailItemView((Activity) parent.getContext());
            convertView = itemView.getmView();
            convertView.setTag(itemView);
        } else {
            itemView = (StockPreInOrderDetailItemView) convertView.getTag();
        }
        itemView.bind(obj.get(position), position);

        return convertView;
    }

    public void remove(int position){
        obj.remove(position);
        notifyDataSetChanged();
        EventBus.getDefault().post(new MessageEvent(""));
    }

}
