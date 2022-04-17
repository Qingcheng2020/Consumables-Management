package jp.co.nss.hrm.backend.model;

import io.swagger.annotations.ApiModelProperty;

import java.io.Serializable;
import java.util.Date;

public class ReagentStock implements Serializable {
    @ApiModelProperty(value = "id")
    private Long id;

    @ApiModelProperty(value = "库存编号")
    private String stockNo;

    @ApiModelProperty(value = "库存种类：1 一级中心库汇总单， 3 二级库科室汇总单，3二级库中心库库存")
    private String stockType;

    @ApiModelProperty(value = "试剂耗材ID")
    private String reagentId;

    @ApiModelProperty(value = "试剂名称")
    private String reagentName;

    @ApiModelProperty(value = "型号规格")
    private String reagentType;

    @ApiModelProperty(value = "单位")
    private String reagentUnit;

    @ApiModelProperty(value = "科室库名称")
    private String branchName;

    @ApiModelProperty(value = "生产厂家")
    private String factory;

    @ApiModelProperty(value = "供货商")
    private String supplierName;

    @ApiModelProperty(value = "库存数量")
    private Long quantity;

    @ApiModelProperty(value = "单价")
    private Double reagentPrice;

    @ApiModelProperty(value = "状态：1.中心已入库（在库），1997: 中心已出库，1999：科室已出库")
    private String reagentStatus;

    @ApiModelProperty(value = "存储温度")
    private String reagentTemp;

    @ApiModelProperty(value = "低库存预警")
    private String lowStock;

    @ApiModelProperty(value = "过期预警")
    private Integer overdueStock;

    @ApiModelProperty(value = "过期预警阈值")
    private Integer overdue;

    @ApiModelProperty(value = "过期时间")
    private String expireDate;

    @ApiModelProperty(value = "批号")
    private String batchNo;

    private Date createTime;

    private String createBy;

    private Date updateTime;

    private String updateBy;

    @ApiModelProperty(value = "软删除标志: 0, 未删除, 1: 已删除")
    private Byte deleteFlag;

    private Date deleteTime;

    private String deleteBy;

    private Long  outNumber;

    private static final long serialVersionUID = 1L;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getStockNo() {
        return stockNo;
    }

    public void setStockNo(String stockNo) {
        this.stockNo = stockNo;
    }

    public String getStockType() {
        return stockType;
    }

    public void setStockType(String stockType) {
        this.stockType = stockType;
    }

    public String getReagentId() {
        return reagentId;
    }

    public void setReagentId(String reagentId) {
        this.reagentId = reagentId;
    }

    public String getReagentName() {
        return reagentName;
    }

    public void setReagentName(String reagentName) {
        this.reagentName = reagentName;
    }

    public String getReagentType() {
        return reagentType;
    }

    public void setReagentType(String reagentType) {
        this.reagentType = reagentType;
    }

    public String getReagentUnit() {
        return reagentUnit;
    }

    public void setReagentUnit(String reagentUnit) {
        this.reagentUnit = reagentUnit;
    }

    public String getBranchName() {
        return branchName;
    }

    public void setBranchName(String branchName) {
        this.branchName = branchName;
    }

    public String getFactory() {
        return factory;
    }

    public void setFactory(String factory) {
        this.factory = factory;
    }

    public String getSupplierName() {
        return supplierName;
    }

    public void setSupplierName(String supplierName) {
        this.supplierName = supplierName;
    }

    public Long getQuantity() {
        return quantity;
    }

    public void setQuantity(Long quantity) {
        this.quantity = quantity;
    }

    public Double getReagentPrice() {
        return reagentPrice;
    }

    public void setReagentPrice(Double reagentPrice) {
        this.reagentPrice = reagentPrice;
    }

    public String getReagentStatus() {
        return reagentStatus;
    }

    public void setReagentStatus(String reagentStatus) {
        this.reagentStatus = reagentStatus;
    }

    public String getReagentTemp() {
        return reagentTemp;
    }

    public void setReagentTemp(String reagentTemp) {
        this.reagentTemp = reagentTemp;
    }

    public String getLowStock() {
        return lowStock;
    }

    public void setLowStock(String lowStock) {
        this.lowStock = lowStock;
    }

    public Integer getOverdueStock() {
        return overdueStock;
    }

    public void setOverdueStock(Integer overdueStock) {
        this.overdueStock = overdueStock;
    }

    public Integer getOverdue() {
        return overdue;
    }

    public void setOverdue(Integer overdue) {
        this.overdue = overdue;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getCreateBy() {
        return createBy;
    }

    public void setCreateBy(String createBy) {
        this.createBy = createBy;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    public String getUpdateBy() {
        return updateBy;
    }

    public void setUpdateBy(String updateBy) {
        this.updateBy = updateBy;
    }

    public Byte getDeleteFlag() {
        return deleteFlag;
    }

    public void setDeleteFlag(Byte deleteFlag) {
        this.deleteFlag = deleteFlag;
    }

    public Date getDeleteTime() {
        return deleteTime;
    }

    public void setDeleteTime(Date deleteTime) {
        this.deleteTime = deleteTime;
    }

    public String getDeleteBy() {
        return deleteBy;
    }

    public void setDeleteBy(String deleteBy) {
        this.deleteBy = deleteBy;
    }

    public String getExpireDate() {
        return expireDate;
    }

    public void setExpireDate(String expireDate) {
        this.expireDate = expireDate;
    }

    public String getBatchNo() {
        return batchNo;
    }

    public void setBatchNo(String batchNo) {
        this.batchNo = batchNo;
    }

    public Long getoutNumber() {
        return outNumber;
    }

    public void setoutNumber(Long outNumber) {
        this.outNumber = outNumber;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", id=").append(id);
        sb.append(", stockNo=").append(stockNo);
        sb.append(", stockType=").append(stockType);
        sb.append(", reagentId=").append(reagentId);
        sb.append(", reagentName=").append(reagentName);
        sb.append(", reagentType=").append(reagentType);
        sb.append(", reagentUnit=").append(reagentUnit);
        sb.append(", branchName=").append(branchName);
        sb.append(", factory=").append(factory);
        sb.append(", supplierName=").append(supplierName);
        sb.append(", quantity=").append(quantity);
        sb.append(", reagentPrice=").append(reagentPrice);
        sb.append(", reagentStatus=").append(reagentStatus);
        sb.append(", reagentTemp=").append(reagentTemp);
        sb.append(", lowStock=").append(lowStock);
        sb.append(", overdueStock=").append(overdueStock);
        sb.append(", overdue=").append(overdue);
        sb.append(", createTime=").append(createTime);
        sb.append(", createBy=").append(createBy);
        sb.append(", updateTime=").append(updateTime);
        sb.append(", updateBy=").append(updateBy);
        sb.append(", deleteFlag=").append(deleteFlag);
        sb.append(", deleteTime=").append(deleteTime);
        sb.append(", deleteBy=").append(deleteBy);
        sb.append(", outNumber=").append(outNumber);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }
}