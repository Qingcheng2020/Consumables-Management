package jp.co.nss.wms.model;

import java.util.ArrayList;
import java.util.List;

import lombok.Data;

@Data
public class ReagentMoveReq {
    // 申领入库标识
    // 0：中心库确认移库，等待科室管理员确认申领
    // 1：科室管理员确认申领，正式入科室库
    private String applyInType;

    // 制单人
    private String createBy;

    private String updateBy;

    // 出库单种类：1-中心库领用/移库/退货出库单（中心出给科室或人）；2-科室库领用/退货出库；3-二级中心库出库（移库/退货）
    private String outType;

    // 入库单种类：1-一级中心入库单；2-二级中心入库单；3-科室入库单
    private String inType;

    // 单据状态：0-草稿；1-已入库
    private String collectState;

    // 1-移库；2-领用；3-出库
    private String operationType;

    // 科室名---移库必须传
    private String branch;

    // 移库申请单号---移库必须传，用于更新移库申请单状态
    private String collectNo;

    // 科室名，用于一键移库
    private String branchCode;

    // 随货同行单号，用于一键移库
    private String preInBillCode;

    // 用于一键移库
    private String stockType;

    // 申领人---申领必须传
    private String applyMan;

    private List<String> qrList = new ArrayList<>();

    private List<ReagentMoveItemReq> collectMessList = new ArrayList<>();
}
