package jp.co.nss.wms.model;

import java.util.ArrayList;
import java.util.List;

import lombok.Data;

@Data
public class ReagentCloseReq {
    // 0：丢失，1：破损，2：过期，3：其他，4.用尽 5.损耗
    private String reagentStatus;

    private String createBy;

    private List<String> qrList = new ArrayList<>();
}
