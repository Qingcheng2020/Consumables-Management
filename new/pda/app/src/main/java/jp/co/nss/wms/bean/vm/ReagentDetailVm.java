package jp.co.nss.wms.bean.vm;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class ReagentDetailVm  implements Serializable {
    // stock_no 库存编号
    private String billId;

    private String detailId;

    private String reagentId;

    private String qrId;

    private String qrCode;

    private String qrCodeValue;

    // 试剂耗材ID from base_info
    private String code;

    private String reagentName;

    private String reagentCode;

    // 规格型号
    private String reagentSpecification;

    private Double reagentPrice;

    private String reagentStatus;

    private Double price;

    private String batchNo;

    private Date expireDate;

    // 开启有效期
    private int openPeriod;

    private String reagentUnit;

    private String supplierShortName;

    // 生产厂家
    private String manufacturerName;

    // 注册证号
    private String registrationNo;

    // 同类型批号的在库数量
    private long reagentCount;

    // 同科室同类试剂数量
    private long reagentNumber;

    private int quantity = 0;

    // 上机的设备名
    private String deviceName;

    // 上机的设备编号（非设备id）
    private String deviceCode;

    private List<String> qrList = new ArrayList<>();

    private List<String> qrIdList = new ArrayList<>();

    private List<String> qrCodeValueList = new ArrayList<>();

    private List<String> reagentCodeList = new ArrayList<>();

    // 更早过期的试剂数量
    private Integer earlierNum;

    // 出库时间
    private Date outTime;

}
