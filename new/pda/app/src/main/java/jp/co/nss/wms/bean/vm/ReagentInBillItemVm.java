package jp.co.nss.wms.bean.vm;

import java.util.Date;

import lombok.Data;

@Data
public class ReagentInBillItemVm {
    private String billCode;

    private String codeValue;

    private String createBy;

    private Date createTime;

    private String deleteBy;

    private String deleteFlag;

    private Date deleteTime;

    private Long id;

    private String inDetailId;

    private String qrCode;

    private String reagentCode;

    private String status;

    private String updateBy;

    private Date updateTime;

}
