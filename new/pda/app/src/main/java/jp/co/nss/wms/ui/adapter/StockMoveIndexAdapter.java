package jp.co.nss.wms.ui.adapter;

import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;

import org.greenrobot.eventbus.EventBus;

import java.util.List;

import jp.co.nss.wms.bean.bean.MessageEvent;
import jp.co.nss.wms.bean.vm.ReagentMoveVm;
import jp.co.nss.wms.ui.itemview.StockMoveItemView;

public class StockMoveIndexAdapter extends BaseAdapter {

    Context mContext;

    private List<ReagentMoveVm> obj;

    public void setItemsList(List<ReagentMoveVm> obj) {
        this.obj = obj;
    }

    public StockMoveIndexAdapter(Context context) {
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
        StockMoveItemView itemView = null;
        if (convertView == null) {
            itemView = new StockMoveItemView(mContext);
            convertView = itemView.getmView();
            convertView.setTag(itemView);
        } else {
            itemView = (StockMoveItemView) convertView.getTag();
        }
        itemView.bind(obj.get(position), position);

        return convertView;
    }

    public void remove(int position){
        EventBus.getDefault().post(new MessageEvent(""));
    }

}
