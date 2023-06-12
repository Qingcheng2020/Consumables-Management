package jp.co.nss.wms.model;

import java.util.ArrayList;
import java.util.List;

import lombok.Data;

@Data
public class ReagentOutDetailReq {
    // billId
    private String id;

    // 试剂ID
    private String reagentId;

    // 规格型号
    private String reagentSpecification;

    // 批号
    private String batchNo;

    // 生产厂家
    private String factory;

    // 注册证号
    private String registrationNo;

    // 供货商名
    private String supplierShortName;

    // 试剂单位
    private String reagentUnit;

    private Double price;

    private long quantity;

    private Double total;

    private String expireDate;

    private List<String> qrList = new ArrayList<>();

    private List<String> qrIdList = new ArrayList<>();

    private List<String> reagentCodeList = new ArrayList<>();

    private List<String> qrCodeValueList = new ArrayList<>();

}
