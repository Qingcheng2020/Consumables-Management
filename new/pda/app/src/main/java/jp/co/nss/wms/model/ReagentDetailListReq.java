package jp.co.nss.wms.model;

import jp.co.nss.wms.constance.Constance;
import lombok.Data;

@Data
public class ReagentDetailListReq {
    // stockNo 试剂编号
    private String keyword;

    private String username;

    private int pageNum = 1;

    private int pageSize = Constance.PAGE_SIZE;
}
