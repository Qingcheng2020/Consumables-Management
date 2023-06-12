package jp.co.nss.wms.ui.adapter;

import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;

import org.greenrobot.eventbus.EventBus;

import java.util.List;

import jp.co.nss.wms.bean.bean.MessageEvent;
import jp.co.nss.wms.bean.vm.ReagentMoveDetailVm;
import jp.co.nss.wms.ui.itemview.StockMoveDetailItemView;

public class StockMoveDetailAdapter  extends BaseAdapter {

    Context mContext;

    private List<ReagentMoveDetailVm> obj;

    public StockMoveDetailAdapter(Context context) {
        mContext = context;
    }

    public void setItemsList(List<ReagentMoveDetailVm> obj){
        this.obj = obj;
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
        StockMoveDetailItemView itemView;
        if (convertView == null) {
            itemView = new StockMoveDetailItemView(parent.getContext());
            convertView = itemView.getmView();
            convertView.setTag(itemView);
        } else {
            itemView = (StockMoveDetailItemView) convertView.getTag();
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
