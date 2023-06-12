package jp.co.nss.wms.bean.vm;

import java.util.Date;

import lombok.Data;

@Data
public class ReagentInBillVm {
    private String billCode;

    private String preInBillCode;

    private String billCreator;

    private Date billDate;

    // 单据状态：0-草稿，1-已入库
    private String billStatus;

    private String billType;

    private String branch;

    private String createBy;

    private Date createTime;

    // 添加种类：1 一级建码入库，2 二级建码入库 3 一级扫码入库，4 二级扫码入库
    private String createType;

    private String deleteBy;

    private String deleteFlag;

    private Date deleteTime;

    private Long id;

    private String remark;

    private String supplierId;

    private String supplierShortName;

    private String updateBy;

    private Date updateTime;

}
