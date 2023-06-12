package jp.co.nss.wms.bean.vm;

import java.util.Date;

import lombok.Data;

/**
 * 预入库单汇总
 */
@Data
public class ReagentStockPreIn {
    private String billCode;

    private String billCreator;

    private Date billDate;

    private String billStatus;

    private String billStatusText;

    private String billType;

    private String branch;

    private String createBy;

    private Date createTime;

    private String createType;

    private String deleteBy;

    private String deleteFlag;

    private Date deleteTime;

    private Integer id;

    private String remark;

    private String supplierId;

    private String supplierShortName;

    private String updateBy;

    private Date updateTime;

}
