package jp.co.nss.wms.model;

public class ReagentRetireDetailReq {
    private String reagentId;
    private String stockNo;
    private long quantity;
    private String supplierShortName;
    private Double reagentPrice;

    public String getReagentId() {
        return reagentId;
    }

    public void setReagentId(String reagentId) {
        this.reagentId = reagentId;
    }

    public String getStockNo() {
        return stockNo;
    }

    public void setStockNo(String stockNo) {
        this.stockNo = stockNo;
    }

    public long getQuantity() {
        return quantity;
    }

    public void setQuantity(long quantity) {
        this.quantity = quantity;
    }

    public String getSupplierShortName() {
        return supplierShortName;
    }

    public void setSupplierShortName(String supplierShortName) {
        this.supplierShortName = supplierShortName;
    }

    public Double getReagentPrice() {
        return reagentPrice;
    }

    public void setReagentPrice(Double reagentPrice) {
        this.reagentPrice = reagentPrice;
    }
}
