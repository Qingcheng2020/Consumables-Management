package jp.co.nss.wms.ui.adapter;

import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;

import org.greenrobot.eventbus.EventBus;

import java.util.List;

import jp.co.nss.wms.bean.bean.MessageEvent;
import jp.co.nss.wms.bean.vm.ReagentInBillVm;
import jp.co.nss.wms.ui.acitivity.StockInActivity;
import jp.co.nss.wms.ui.itemview.StockInBillDetailItemView;

public class StockOrderDraftAdapter extends BaseAdapter {
    Context mContext;

    private List<ReagentInBillVm> obj;

    public void setItemsList(List<ReagentInBillVm> obj){
        this.obj = obj;
    }

    public StockOrderDraftAdapter(Context context){
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
        StockInBillDetailItemView itemView;
        if(convertView == null) {
            itemView = new StockInBillDetailItemView(parent.getContext(), (StockInActivity) parent.getContext());
            convertView = itemView.getmView();
            convertView.setTag(itemView);
        } else {
            itemView = (StockInBillDetailItemView) convertView.getTag();
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
