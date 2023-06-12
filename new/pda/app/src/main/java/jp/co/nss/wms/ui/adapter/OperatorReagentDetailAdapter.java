package jp.co.nss.wms.ui.adapter;

import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;

import org.greenrobot.eventbus.EventBus;

import jp.co.nss.wms.bean.bean.MessageEvent;
import jp.co.nss.wms.bean.vm.ReagentDetailVm;
import jp.co.nss.wms.ui.itemview.StockQueryOperatorDetailItemView;

public class OperatorReagentDetailAdapter extends BaseAdapter {

    Context mContext;

    private ReagentDetailVm data;

    public OperatorReagentDetailAdapter(Context context) {
        mContext = context;
    }

    public void setData(ReagentDetailVm vm) {
        this.data = vm;
    }

    @Override
    public int getCount() {
        return data==null ? 0 : 1;
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
        StockQueryOperatorDetailItemView itemView;
        if (convertView == null) {
            itemView = new StockQueryOperatorDetailItemView(mContext);
            convertView = itemView.getmView();
            convertView.setTag(itemView);
        } else {
            itemView = (StockQueryOperatorDetailItemView) convertView.getTag();
        }

        itemView.bind(data, position);
        return convertView;
    }

    public void remove(int position) {
        EventBus.getDefault().post(new MessageEvent(""));
    }

}
