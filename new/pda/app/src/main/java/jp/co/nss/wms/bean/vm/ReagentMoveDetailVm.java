package jp.co.nss.wms.bean.vm;

import java.util.Date;

import lombok.Data;

@Data
public class ReagentMoveDetailVm implements Cloneable {
    private String collectNo;

    private String createBy;

    private Date createTime;

    private String deleteBy;

    private String deleteFlag;

    private Date deleteTime;

    private String factory;

    private Long id;

    private Double price;

    private String reagentCode;

    private String reagentName;

    private Long reagentNumber;

    private String reagentType;

    private String supplierShortName;

    private String unit;

    private String updateBy;

    private Date updateTime;

    public Object clone() {
        Object o = null;
        try {
            o = (ReagentMoveDetailVm) super.clone(); // Object 中的clone()识别出你要复制的是哪一个对象。
        } catch (CloneNotSupportedException e) {
            System.out.println(e.toString());
        }
        return o;
    }
}
