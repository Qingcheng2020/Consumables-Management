package jp.co.nss.wms.bean.vm;

import java.util.Date;

import lombok.Data;

@Data
public class ReagentInBillDetailVm {
    private String batchNo;

    private String billCode;

    private String createBy;

    private Date createTime;

    private String deleteBy;

    private Date deleteTime;

    private String deleteFlag;

    private Date expireDate;

    private String factory;

    private Long id;

    private String inDetailId;

    private double price;

    private int quantity;

    // 试剂编号
    private String reagentCode;

    // 试剂ID
    private String reagentId;

    private String reagentName;

    private String reagentSpecification;

    private String reagentUnit;

    private String remark;

    private Long total;

    private String updateBy;

    private Date updateTime;

}
