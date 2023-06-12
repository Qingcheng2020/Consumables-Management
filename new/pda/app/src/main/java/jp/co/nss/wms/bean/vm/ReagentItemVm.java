package jp.co.nss.wms.bean.vm;

import com.google.gson.annotations.SerializedName;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import jp.co.nss.wms.util.DateUtil;
import lombok.Getter;
import lombok.Setter;

/**
 * 出入库项目
 * Created by macro on 2018/4/26.
 */
@Getter
@Setter
public class ReagentItemVm implements Serializable {
    // id
    @SerializedName("billId")
    private Long id;

    // 详细ID
    @SerializedName("detailId")
    private Long detailId;


    // QR ID
    @SerializedName("qrId")
    private Long qrId;


    // "试剂耗材ID")
    @SerializedName("reagentId")
    private Long reagentId;

    // "系统批号")
    @SerializedName("batchNo")
    private String batchNo;

    // "到期日期")
    @SerializedName("expireDate")
    private Date expireDate;

    // "二维码")
    @SerializedName("qrCode")
    private String qrCode;

    // "试剂耗材编号")
    @SerializedName("code")
    private String code;

    // "试剂名称")
    @SerializedName("name")
    private String name;

    // "供货商名")
    @SerializedName("supplierShortName")
    private String supplierShortName;

    //数量
    private  int count;

    //QR List
    private List<String> qrList  = new ArrayList<>();

    private List<Long> qrIdList = new ArrayList<>();

    //日付取得
    public String getDateStr(){
      return  DateUtil.getDateStr(this.expireDate);
    };
}
