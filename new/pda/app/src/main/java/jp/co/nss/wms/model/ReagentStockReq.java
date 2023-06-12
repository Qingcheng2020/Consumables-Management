package jp.co.nss.wms.model;

import java.util.List;

import jp.co.nss.wms.bean.bean.ReagentStock;
import lombok.Data;

@Data
public class ReagentStockReq {
    private Integer pageNum;

    private Integer pageSize;

    private Long total;

    private Integer totalPage;

    private List<ReagentStock> list;
}
