package jp.co.nss.wms.ui.adapter;

import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;

import org.greenrobot.eventbus.EventBus;

import java.util.List;

import jp.co.nss.wms.bean.bean.MessageEvent;
import jp.co.nss.wms.bean.vm.ReagentPreInDetail;
import jp.co.nss.wms.ui.itemview.StockInDetailItemView;

public class StockInDetailAdapter extends BaseAdapter {

    Context mContext;

    private List<ReagentPreInDetail> obj;

    public void setItemsList(List<ReagentPreInDetail> obj){
        this.obj = obj;
    }

    public StockInDetailAdapter(Context context){
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
        StockInDetailItemView itemView;
        if(convertView == null) {
            itemView = new StockInDetailItemView(parent.getContext());
            convertView = itemView.getmView();
            convertView.setTag(itemView);
        } else {
            itemView = (StockInDetailItemView) convertView.getTag();
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
