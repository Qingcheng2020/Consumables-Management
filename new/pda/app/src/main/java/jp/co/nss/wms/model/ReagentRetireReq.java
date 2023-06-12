package jp.co.nss.wms.model;

import java.util.ArrayList;
import java.util.List;


public class ReagentRetireReq {
    // 出库单种类
    // 1-中心库领用/移库/退货出库单（中心出给科室或人）；2-科室库领用/退货出库；3-二级中心库出库（移库/退货）
    private int billType;
    // 退货类型
    // 1，一级中心退货；2，二级中心退货；3，二级科室退货
    private int refundType;
    // 制单人
    private String createBy;
    private String stockType;
    private String remark;
    // 退货状态
    private int refundStatus;

    private List<ReagentRetireDetailReq> refundMessList = new ArrayList<ReagentRetireDetailReq>();

    public int getRefundStatus() {
        return refundStatus;
    }

    public void setRefundStatus(int refundStatus) {
        this.refundStatus = refundStatus;
    }

    public int getBillType() {
        return billType;
    }

    public void setBillType(int billType) {
        this.billType = billType;
    }

    public int getRefundType() {
        return refundType;
    }

    public void setRefundType(int refundType) {
        this.refundType = refundType;
    }

    public String getCreateBy() {
        return createBy;
    }

    public void setCreateBy(String createBy) {
        this.createBy = createBy;
    }

    public String getStockType() {
        return stockType;
    }

    public void setStockType(String stockType) {
        this.stockType = stockType;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public List<ReagentRetireDetailReq> getRefundMessList() {
        return refundMessList;
    }

    public void setRefundMessList(List<ReagentRetireDetailReq> refundMessList) {
        this.refundMessList = refundMessList;
    }
}
