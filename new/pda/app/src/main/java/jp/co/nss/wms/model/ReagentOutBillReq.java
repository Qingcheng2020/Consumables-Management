package jp.co.nss.wms.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import lombok.Data;

@Data
public class ReagentOutBillReq implements Serializable {

    private static final long serialVersionUID = 1L;

    // "id")
    private Long id;

    // "出库单编号")
    private String code;

    // "出库单种类：1 出库申请单， 2 中心库出库单，2 2级库出库单，")
    private String billType;

    // "单据日期（业务发生的日期，不一定等于单据创建时间，根据单据不同，在此单为做成日期）")
    private String billDate;

    // "单据状态：0-草稿，1-已完结 ")
    private Boolean billStatus;

    // "制单人")
    private String billCreator;

    // "备注")
    private String remark;

    // "申请科室ID")
    private Long branchId;

    // "申请科室名")
    private String branchName;

    // "出库预定日")
    private String stockDay;

    // "申请日")
    private String applicationDate;

    // "申请人")
    private String applicationUser;

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getBillType() {
        return billType;
    }

    public void setBillType(String billType) {
        this.billType = billType;
    }

    public String getBillDate() {
        return billDate;
    }

    public void setBillDate(String billDate) {
        this.billDate = billDate;
    }

    public Boolean getBillStatus() {
        return billStatus;
    }

    public void setBillStatus(Boolean billStatus) {
        this.billStatus = billStatus;
    }

    public String getBillCreator() {
        return billCreator;
    }

    public void setBillCreator(String billCreator) {
        this.billCreator = billCreator;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public Long getBranchId() {
        return branchId;
    }

    public void setBranchId(Long branchId) {
        this.branchId = branchId;
    }

    public String getBranchName() {
        return branchName;
    }

    public void setBranchName(String branchName) {
        this.branchName = branchName;
    }

    public String getStockDay() {
        return stockDay;
    }

    public void setStockDay(String stockDay) {
        this.stockDay = stockDay;
    }

    public String getApplicationDate() {
        return applicationDate;
    }

    public void setApplicationDate(String applicationDate) {
        this.applicationDate = applicationDate;
    }

    public String getApplicationUser() {
        return applicationUser;
    }

    public void setApplicationUser(String applicationUser) {
        this.applicationUser = applicationUser;
    }

    public Long getConsumerId() {
        return consumerId;
    }

    public void setConsumerId(Long consumerId) {
        this.consumerId = consumerId;
    }

    public String getCreateBy() {
        return createBy;
    }

    public void setCreateBy(String createBy) {
        this.createBy = createBy;
    }

    public String getUpdateBy() {
        return updateBy;
    }

    public void setUpdateBy(String updateBy) {
        this.updateBy = updateBy;
    }

    public List<ReagentDetailReq> getDetails() {
        return details;
    }

    public void setDetails(List<ReagentDetailReq> details) {
        this.details = details;
    }

    private Long consumerId;


    private String createBy;

    private String updateBy;


    private List<ReagentDetailReq> details = new ArrayList<>();

}
