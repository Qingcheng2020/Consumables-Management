package jp.co.nss.wms.bean.vm;

import com.google.gson.annotations.SerializedName;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import jp.co.nss.wms.util.DateUtil;
import lombok.Data;

/**
 * 试剂情报
 * Created by macro on 2018/4/26.
 */
@Data
public class ReagentInfoVm  implements Serializable {
    // "id"
    private Long id;

    // "科室ID "
    private Long branchId;

    // "试剂耗材ID"
    private Long reagentId;

    // "系统批号"
    @SerializedName("batchNo")
    private String batchNo;

    // "到期日期"
    @SerializedName("expireDate")
    private Date expireDate;

    // "库存数量"
    private BigDecimal quantity;

    // "id"
    private Long itemId;

    // "库存ID"
    private Long stockId;

    // "二维码"
    @SerializedName("qrCode")
    private String qrCode;

    // "状态 1:在库，2:出库，9:损失"
    private String status;

    // "试剂耗材编号"
    private String code;

    // "试剂名称"
    @SerializedName("name")
    private String name;

    // "单位"
    private String unit;

    // "规格型号"
    private String specification;

    // "生产厂家"
    @SerializedName("manufacturerName")
    private String manufacturerName;

    // "注册证号"
    private String registrationNo;

    // "供货商 ID"
    private Long supplierId;

    // "供货商名"
    @SerializedName("supplierShortName")
    private String supplierShortName;

    // "储存温度: 常温，冷藏，冷冻"
    private Long stockType;

    // "过期预警时间阈值"
    private Integer experationLimit;

    // "低库存预警阈值"
    private Integer stockLimit;

    // "开启有效期限"
    private Integer useDayLimit;




    public String getExpireDateStr(){
        return DateUtil.getDateStr(this.expireDate);
    }

}
