package jp.co.nss.wms.bean.vm;

import java.util.Date;

import lombok.Data;

@Data
public class ReagentOrderVm {
    private String createBy;

    private Date createTime;

    private String deleteBy;

    private Date deleteTime;

    private Long id;

    private String orderDay;

    private String orderDescribe;

    private String orderNo;

    private double orderPrice;

    // 订单状态 0-草稿；1-已提交；2-已配货
    private String orderStatus;

    private String orderStatusText;

    private Long supplierId;

    private String supplierShortName;

    private String updateBy;

    private Date updateTime;
}
