package jp.co.nss.wms.bean.bean;

import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/*
 * 试剂信息
 *
 * */
@Data
public class ReagentStock implements Serializable {
    private Long id;

    // 库存编号
    private String stockNo;

    // 库存种类
    // 1 一级中心库汇总    2 二级库科室汇总   3 二级库中心库库存
    private String stockType;

    // 批号
    private String batchNo;

    // 试剂耗材ID
    private String reagentId;

    // 试剂名称
    private String reagentName;

    // 过期时间
    private String expireDate;

    // 开启有效期
    private String openPeriod;

    // 型号规格
    private String reagentType;

    private String specification;

    // 单位
    private String reagentUnit;

    // 科室库名称
    private String branchName;

    // 生产厂家
    private String factory;

    // 生产厂家
    private String manufacturerName;

    // 供货商
    private String supplierName;

    // 供货商
    private String supplierShortName;

    // 库存数量
    private Long quantity;

    // 单价
    private Double reagentPrice;

    // 状态
    private String reagentStatus;

    // 存储温度
    private String reagentTemp;

    // 低库存预警
    private String lowStock;

    // 过期预警
    private String overdueStock;

    // 出库时间
    private Date outTime;

    private Date createTime;

    private String createBy;

    private Date updateTime;

    private String updateBy;

    //软删除标志: 0, 未删除, 1: 已删除
    private Byte deleteFlag;

    private Date deleteTime;

    private String deleteBy;

    private static final long serialVersionUID = 1L;

    public int getOpenPeriod() {
        int timeOpen;

        try {
            timeOpen = Integer.parseInt(this.openPeriod);
        } catch (NumberFormatException e) {
            timeOpen = 0;
        }

        return timeOpen;
    }

}
