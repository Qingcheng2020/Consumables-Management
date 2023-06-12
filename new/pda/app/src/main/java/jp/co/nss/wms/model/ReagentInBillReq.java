package jp.co.nss.wms.model;

import java.util.List;
import lombok.Data;

@Data
public class ReagentInBillReq {

    // 预入库单号-创建草稿必填
    private String preInBillCode;

    // 如果操作的是草稿，则必传，用于更新状态
    private String tempInBillCode;

    // 入库单种类：1 一级中心入库单， 2 二级中心入库单，3 科室入库单
    private String billType;

    // 库存种类：1-一级中心库汇总单；2-二级库科室汇总单；3-二级库中心库库存
    private String stockType;

    // 添加种类：1 一级建码入库，2 二级建码入库 3 一级扫码入库，4 二级扫码入库
    private String createType;

    // 单据状态
    // 0-草稿；1-入库
    private String billStatus;

    // 制单人
    private String billCreator;

    private String remark;

    private List<ReagentInBillMessReq> inBillMessList;

}
