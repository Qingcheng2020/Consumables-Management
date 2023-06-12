package jp.co.nss.wms.model;

import java.util.ArrayList;
import java.util.List;

import jp.co.nss.wms.bean.vm.ReagentMoveVm;
import lombok.Data;

@Data
public class ReagentMoveRes {

    private Integer pageNum;

    private Integer pageSize;

    private Long total;

    private Integer totalPage;

    private List<ReagentMoveVm> list = new ArrayList<>();

}
