package jp.co.nss.wms.bean.bean;

import java.io.Serializable;

import lombok.Data;

/**
 * 试剂数量统计
 */
@Data
public class ReagentNumberBean implements Serializable {

    private String reagentName;

    private long reagentNumber;

    private String batchNo;

    // 0-未入库；1-已入库
    private String status = "0";

}
