package jp.co.nss.wms.ui.adapter;

import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;

import org.greenrobot.eventbus.EventBus;

import java.util.List;

import jp.co.nss.wms.bean.bean.MessageEvent;
import jp.co.nss.wms.bean.bean.ReagentStock;
import jp.co.nss.wms.ui.itemview.StockQueryOperatorItemView;

public class OperatorIndexAdapter extends BaseAdapter {
    Context mContext;

    private List<ReagentStock> dataList;

    public OperatorIndexAdapter(Context context) {
        mContext = context;
    }

    public void setData(List<ReagentStock> obj) {
        this.dataList = obj;
    }

    @Override
    public int getCount() {
        return dataList==null ? 0 : dataList.size();
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
        StockQueryOperatorItemView itemView;
        if (convertView == null) {
            itemView = new StockQueryOperatorItemView(mContext);
            convertView = itemView.getmView();
            convertView.setTag(itemView);
        } else {
            itemView = (StockQueryOperatorItemView) convertView.getTag();
        }

        itemView.bind(dataList.get(position), position);
        return convertView;
    }

    public void remove(int position) {
        EventBus.getDefault().post(new MessageEvent(""));
    }

}
