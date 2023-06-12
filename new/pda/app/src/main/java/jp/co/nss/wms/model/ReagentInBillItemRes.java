package jp.co.nss.wms.model;

import java.util.ArrayList;
import java.util.List;

import jp.co.nss.wms.bean.vm.ReagentInBillItemVm;
import lombok.Data;

@Data
public class ReagentInBillItemRes {

    private Integer pageNum;

    private Integer pageSize;

    private Long total;

    private Integer totalPage;

    List<ReagentInBillItemVm> list = new ArrayList<>();
}
