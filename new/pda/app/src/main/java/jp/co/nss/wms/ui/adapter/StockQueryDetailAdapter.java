package jp.co.nss.wms.ui.adapter;

import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;

import org.greenrobot.eventbus.EventBus;

import java.util.List;

import jp.co.nss.wms.bean.bean.MessageEvent;
import jp.co.nss.wms.bean.bean.ReagentStock;
import jp.co.nss.wms.ui.itemview.StockQuerySimilarItemView;

public class StockQueryDetailAdapter extends BaseAdapter {

    Context mContext;

    private List<ReagentStock> obj;

    public void setStockQueryDetailList(List<ReagentStock> obj) {
        this.obj = obj;
    }

    public StockQueryDetailAdapter(Context context){
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
        StockQuerySimilarItemView itemView;
        if (convertView == null) {
            itemView = new StockQuerySimilarItemView(mContext);
            convertView = itemView.getmView();
            convertView.setTag(itemView);
        } else {
            itemView = (StockQuerySimilarItemView) convertView.getTag();
        }

        itemView.bind(obj.get(position), position);

        return convertView;
    }

    public void remove(int position) {
        EventBus.getDefault().post(new MessageEvent(""));
    }

}
