package jp.co.nss.wms.model;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class ReagentDetailReq implements Serializable {
    private static final long serialVersionUID = 1L;


    //value = "id")
    private Long id;

    //value = "入库单ID")
    private Long inBillId;

    //value = "试剂ID")
    private Long reagentId;

    //value = "试剂名称")
    private String reagentName;

    //value = "单位")
    private String reagentUnit;

    //value = "规格型号")
    private String reagentSpecification;

    //value = "价格")
    private Long price;

    //value = "数量")
    private Long quantity;

    //value = "金额")
    private Long total;

    //value = "批号")
    private String batchNo;

    //value = "保质期")
    private Date expireDate;

    //value = "备注")
    private String remark;

    private Date createTime;

    private String createBy;

    private Date updateTime;

    private String updateBy;

    //value = "软删除标志: 0, 未删除, 1: 已删除")
    private Byte deleteFlag;

    private Date deleteTime;

    private String deleteBy;

    private List<String> qrList;

    private List<Long> qrIdList;


}