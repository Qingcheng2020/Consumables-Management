package jp.co.nss.wms.model;

import java.util.ArrayList;
import java.util.List;

import jp.co.nss.wms.bean.vm.ReagentStockPreIn;
import lombok.Data;

@Data
public class ReagentStockPreInRes {
    private int total;
    private int totalPage;
    private int pageNum;
    private int pageSize;

    List<ReagentStockPreIn> list = new ArrayList<>();
}
