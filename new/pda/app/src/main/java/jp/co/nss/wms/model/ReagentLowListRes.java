package jp.co.nss.wms.model;

import java.util.List;

import jp.co.nss.wms.bean.bean.ReagentStock;
import jp.co.nss.wms.bean.vm.ReagentDetailVm;
import lombok.Data;

@Data
public class ReagentLowListRes {
    private Integer pageNum;

    private Integer pageSize;

    private Long total;

    private Integer totalPage;

    private List<ReagentStock> list;
}
