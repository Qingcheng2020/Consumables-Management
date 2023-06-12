package jp.co.nss.wms.ui.adapter;

import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;

import org.greenrobot.eventbus.EventBus;

import java.util.ArrayList;
import java.util.List;

import jp.co.nss.wms.bean.bean.MessageEvent;
import jp.co.nss.wms.bean.bean.ReagentStock;
import jp.co.nss.wms.ui.acitivity.StockQueryActivity;
import jp.co.nss.wms.ui.itemview.StockQueryItemDetailView;
import jp.co.nss.wms.ui.itemview.StockQueryItemView;

/**
 * Created by nss.
 */

public class StockQueryAdapter extends BaseAdapter {

    Context mContext;

    // 查询类型
    // 1-试剂数组；2-单个试剂数据（扫码）
    private int flagType = 1;
    private ReagentStock reagentItem;
    private List<ReagentStock> obj;

    public void setStockQueryList(List<ReagentStock> obj) {
        this.reagentItem = null;
        this.obj = obj;
        this.flagType = 1;
    }

    public void setStock(ReagentStock reangentItem) {
        this.obj = new ArrayList<>();
        this.reagentItem = reangentItem;
        this.flagType = 2;
    }

    public void clearData() {
        this.flagType = 1;
        this.obj = new ArrayList<>();
        this.reagentItem = null;
    }

    public StockQueryAdapter(Context context){
        mContext=context;
    }

    @Override
    public int getCount() {
        if (this.flagType == 1) {
            return obj==null ? 0 : obj.size();
        } else if (this.flagType == 2) {
            return 1;
        }
        return 0;
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
        // 试剂数组
        if (this.flagType == 1) {
            StockQueryItemView itemView;
            if(view == null || view.getTag().getClass()!=StockQueryItemView.class) {
                itemView = new StockQueryItemView(mContext);
                view = itemView.getmView();
                view.setTag(itemView);
            } else {
                itemView = (StockQueryItemView) view.getTag();
            }
            itemView.bind(obj.get(i), i);

        } else if (this.flagType == 2) {
            // 扫码查询的单个试剂数据
            StockQueryItemDetailView itemView;
            if (view==null || view.getTag().getClass()!=StockQueryItemDetailView.class) {
                itemView = new StockQueryItemDetailView(mContext, (StockQueryActivity) viewGroup.getContext());
                view = itemView.getmView();
                view.setTag(itemView);
            } else {
                itemView = (StockQueryItemDetailView) view.getTag();
            }

            itemView.bind(reagentItem, i);
        }

        return view;
    }

    public void remove(int position) {
        EventBus.getDefault().post(new MessageEvent(""));
    }
}
