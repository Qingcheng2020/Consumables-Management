package jp.co.nss.wms.model;

import java.util.ArrayList;
import java.util.List;

import jp.co.nss.wms.bean.vm.ReagentPreInDetail;
import lombok.Data;

@Data
public class ReagentPreInDetailRes {
    private Integer pageNum;

    private Integer pageSize;

    private Long total;

    private Integer totalPage;

    List<ReagentPreInDetail> list = new ArrayList<>();

}
