package jp.co.nss.wms.bean.vm;

import java.util.Date;

import lombok.Data;

@Data
public class ReagentPreInDetail {
    private String batchNo;

    private String billCode;

    // 0-未入库；1-已入库
    private String billStatus;

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

    private String reagentCode;

    private String reagentName;

    private String reagentSpecification;

    private String reagentUnit;

    private String remark;

    private double total;

    private String updateBy;

    private Date updateTime;

}
