package jp.co.nss.wms.bean.vm;

import java.util.Date;

import lombok.Data;

@Data
public class ReagentOrderDetailVm {
    private String createBy;

    private Date createTime;

    private String deleteFlag;

    private Date deleteTime;

    private Long id;

    private String manufacturerName;

    private String orderNo;

    private double price;

    private String reagentCode;

    private String reagentName;

    private Long reagentNumber;

    private String specification;

    private String unit;

    private String updateBy;

    private Date updateTime;
}
