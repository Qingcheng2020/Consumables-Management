package jp.co.nss.wms.ui.adapter;

import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;

import org.greenrobot.eventbus.EventBus;

import java.util.ArrayList;
import java.util.List;

import jp.co.nss.wms.bean.bean.MessageEvent;
import jp.co.nss.wms.bean.vm.ReagentOrderVm;
import jp.co.nss.wms.bean.vm.ReagentStockPreIn;
import jp.co.nss.wms.ui.acitivity.StockInNActivity;
import jp.co.nss.wms.ui.itemview.StockPreInItemView;
import jp.co.nss.wms.ui.itemview.StockPreInOrderItemView;

public class StockPreInAdapter extends BaseAdapter {

    Context mContext;
    // 当前要展示的 list 类型
    // 1-随货同行单；2-订单
    private String flagType = "1";

    private List<ReagentStockPreIn> obj;
    private List<ReagentOrderVm> dataOrderList;

    public void setItemsList(List<ReagentStockPreIn> obj){
        flagType = "1";
        this.obj = obj;
    }

    public void setDataOrderList(List<ReagentOrderVm> res) {
        flagType = "2";
        this.dataOrderList = res;
    }

    public void clearAllList() {
        this.dataOrderList = new ArrayList<>();
        this.obj = new ArrayList<>();
    }

    public StockPreInAdapter(Context context){
        mContext = context;
    }

    @Override
    public int getCount() {
        if (flagType.equals("1")) {
            return obj==null ? 0 : obj.size();
        } else {
            return dataOrderList==null ? 0 : dataOrderList.size();
        }

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
        // 随货同行单
        if (flagType.equals("1")) {
            StockPreInItemView itemView = null;
            if (convertView == null) {
                itemView = new StockPreInItemView(mContext, (StockInNActivity) parent.getContext());
                convertView = itemView.getmView();
                convertView.setTag(itemView);
            } else {
                itemView = (StockPreInItemView) convertView.getTag();
            }
            itemView.bind(obj.get(position), position);
        } else {
        // 订单
            StockPreInOrderItemView itemView = null;
            if (convertView == null) {
                itemView = new StockPreInOrderItemView(mContext, (StockInNActivity) parent.getContext());
                convertView = itemView.getmView();
                convertView.setTag(itemView);
            } else {
                itemView = (StockPreInOrderItemView) convertView.getTag();
            }
            itemView.bind(dataOrderList.get(position), position);
        }

        return convertView;
    }

    public void remove(int position){
        EventBus.getDefault().post(new MessageEvent(""));
    }

}
