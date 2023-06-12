package jp.co.nss.wms.ui.adapter;

import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;

import org.greenrobot.eventbus.EventBus;

import java.util.List;

import jp.co.nss.wms.bean.bean.MessageEvent;
import jp.co.nss.wms.bean.bean.ReagentItemBean;
import jp.co.nss.wms.ui.itemview.ReagentItemView;

/**
 * Created by nss.
 */

public class StockInAdapter extends BaseAdapter {

    Context mContext;
    private List<ReagentItemBean> obj;
    public void setItemsList(List<ReagentItemBean> obj){
        this.obj=obj;
    }
    public StockInAdapter(Context context){
        mContext=context;
    }
    @Override
    public int getCount() {
        return obj==null?0:obj.size();
    }

    @Override
    public Object getItem(int i) {
        return null;
    }

    @Override
    public long getItemId(int i) {
        return 0;
    }

    @Override
    public View getView(int i, View view, ViewGroup viewGroup) {
        ReagentItemView itemView = null;
        if(view == null){
            itemView = new ReagentItemView(mContext);
            view = itemView.getmView();
            view.setTag(itemView);
        }else{
            itemView = (ReagentItemView) view.getTag();
        }
        itemView.bind(obj.get(i),i);

        return view;
    }

    public void remove(int position){
//        obj.remove(position);
//        notifyDataSetChanged();
        EventBus.getDefault().post(new MessageEvent(""));
    }
}
