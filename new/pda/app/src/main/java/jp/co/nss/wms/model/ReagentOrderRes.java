package jp.co.nss.wms.model;

import java.util.ArrayList;
import java.util.List;

import jp.co.nss.wms.bean.vm.ReagentOrderVm;
import lombok.Data;

@Data
public class ReagentOrderRes {

    private Integer pageNum;

    private Integer pageSize;

    private Long total;

    private Integer totalPage;

    List<ReagentOrderVm> list = new ArrayList<>();
}
