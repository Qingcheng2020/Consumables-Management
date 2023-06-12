package jp.co.nss.wms.model;

import java.util.List;

import lombok.Data;

@Data
public class ReagentMoveItemReq {
    private String reagentId;

    // 同 reagentId
    private String reagentCode;

    private String reagentName;

    private String reagentSpecification;

    private String reagentUnit;

    private String batchNo;

    private String manufacturerName;

    private String registrationNo;

    private String supplierShortName;

    private int quantity;

    private Double reagentPrice;

    private String expireDate;

    private List<String> qrList;

    private List<String> qrCodeValueList;

    private List<String> reagentCodeList;

}
