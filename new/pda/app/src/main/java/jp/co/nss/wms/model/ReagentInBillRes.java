package jp.co.nss.wms.model;

import java.util.ArrayList;
import java.util.List;

import jp.co.nss.wms.bean.vm.ReagentInBillVm;
import lombok.Data;

@Data
public class ReagentInBillRes {
    private Integer pageNum;

    private Integer pageSize;

    private Long total;

    private Integer totalPage;

    List<ReagentInBillVm> list = new ArrayList<>();
}
