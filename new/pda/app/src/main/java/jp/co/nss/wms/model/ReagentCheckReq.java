package jp.co.nss.wms.model;

import java.util.ArrayList;
import java.util.List;

import lombok.Data;

@Data
public class ReagentCheckReq {
    // 创建者
    private String createBy;
    // 库损类型：0-丢失；1-破损；2-过期；3-其它原因
    private String lossId;
    private String reagentStatus;
    private List<String> qrList = new ArrayList<String>();
}
