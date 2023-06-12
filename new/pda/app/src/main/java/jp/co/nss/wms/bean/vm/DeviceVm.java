package jp.co.nss.wms.bean.vm;

import java.util.Date;

import lombok.Data;

@Data
public class DeviceVm {
    private Long id;

    private String deviceCode;

    private String deviceName;

    private String deviceQrCode;

    private String deviceCodeValue;

    private Date createTime;

    private String createBy;

    private Date updateTime;

    private String updateBy;

    private Byte deleteFlag;

    private Date deleteTime;

    private String deleteBy;

    private static final long serialVersionUID = 1L;
}
