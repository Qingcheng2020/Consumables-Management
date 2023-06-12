package jp.co.nss.wms.bean.vm;

import java.util.Date;

import lombok.Data;

@Data
public class ReagentMoveVm {
    // 申请单种类：1 二级领用申请单， 2 移库申请单，3一级领用申请单
    private String applyType;

    private String branch;

    private Date collectDay;

    private String collectNo;

    // 申请状态 0 ：草稿，1：已提交
    private String collectStatus;

    private String createName;

    private Date createTime;

    private String deleteBy;

    private Date deleteTime;

    private Long id;

    private String updateBy;

    private Date updateTime;
}
