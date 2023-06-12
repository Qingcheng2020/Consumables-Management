package jp.co.nss.wms.model;

import lombok.Data;

@Data
public class HomeCountRes {
    private String lowStockCount;

    private String orderCount;

    private String overdueCount;

    private String stockCount;
}
