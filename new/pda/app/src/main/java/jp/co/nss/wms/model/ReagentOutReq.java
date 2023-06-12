package jp.co.nss.wms.model;

import java.util.ArrayList;
import java.util.List;

import lombok.Data;

@Data
public class ReagentOutReq {

    private String billDate;

    // 出库人
    private String billCreator;

    // 申领人
    private String applicationUser;

    private String remark;

    private List<ReagentOutDetailReq> details = new ArrayList<ReagentOutDetailReq>();

}

