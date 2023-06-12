package jp.co.nss.wms.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class ReagentInBillMessReq {
    // 试剂ID---base_info
    // 根据该ID，在 base_info 表中查试剂基础信息
    private String code;

    // 试剂编号 batchNo + sort
    private String reagentCode;

    private String batchNo;

    private Double price;

    private int quantity;

    private String supplierId;

    private String supplierShortName;

    // ? 供货商名称
    private String createBy;

    private String expireDate;

    List<String> qrList = new ArrayList<>();

    List<String> qrCodeValueList = new ArrayList<>();

    List<String> reagentCodeList = new ArrayList<>();
}
