package jp.co.nss.wms.model;

import java.util.ArrayList;
import java.util.List;

import jp.co.nss.wms.bean.vm.ReagentMoveDetailVm;
import lombok.Data;

@Data
public class ReagentMoveDetailRes {
    private Integer pageNum;

    private Integer pageSize;

    private Long total;

    private Integer totalPage;

    List<ReagentMoveDetailVm> list = new ArrayList<>();
}
