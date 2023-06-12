package jp.co.nss.wms.bean.bean;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class ReagentItemBean {
    private String name;

    private Long id;

    //入库单编号
    private String billCode;

    // 详细ID
    private String inDetailId;

    // 试剂批号
    private String batchNo;

    // 试剂编号
    private String reagentCode;

    // 试剂名称
    private String reagentName;

    // 二维码
    private String qrCode;

    // 二维码数据
    private String codeValue;

    // 状态
    private String status;

    private Date createTime;

    private String createBy;

    private Date updateTime;

    private String updateBy;

    // 软删除标志: 0, 未删除, 1: 已删除
    private Byte deleteFlag;

    private Date deleteTime;

    private String deleteBy;

    private static final long serialVersionUID = 1L;

    // 过期时间
    public String expireDate;

    // 过期时间-用于入库传参
    private Date expireDateReq;

    // 试剂计数
    private int count;

    // 价格
    private double price;

    // 试剂耗材编号 base_info
    private String code;

    // 生产厂家 base_info
    private String factory;

    // 数量
    private int quantity;

    // 试剂规格型号
    private String reagentSpecificatoin;

    // 试剂单位
    private String reagentUnit;

    // 供货商ID
    private String supplierId;

    // 供货商简称
    private String supplierShortName;

    private List<String> qrCodeList = new ArrayList<>();

    private List<String> qrCodeValueList = new ArrayList<>();

    private List<String> reagentCodeList = new ArrayList<>();

}
