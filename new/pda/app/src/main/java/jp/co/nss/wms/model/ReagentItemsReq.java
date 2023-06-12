package jp.co.nss.wms.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import lombok.Data;

@Data
public class ReagentItemsReq implements Serializable {

    private static final long serialVersionUID = 1L;

    // "使用者")
    private String userId;

    // "备注")
    private String remark;

    private List<Long> qrId = new ArrayList<>();

}
