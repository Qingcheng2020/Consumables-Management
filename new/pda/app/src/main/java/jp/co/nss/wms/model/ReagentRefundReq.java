package jp.co.nss.wms.model;

import java.util.ArrayList;
import java.util.List;

import lombok.Data;

@Data
public class ReagentRefundReq {

    private String createBy;

    private List<String> qrList = new ArrayList<>();

}
