package jp.co.nss.wms.model;

import java.util.ArrayList;
import java.util.List;

import jp.co.nss.wms.bean.vm.ReagentInBillDetailVm;
import lombok.Data;

@Data
public class ReagentInBillDetailRes {
    private Integer pageNum;

    private Integer pageSize;

    private Long total;

    private Integer totalPage;

    List<ReagentInBillDetailVm> list = new ArrayList<>();
}
