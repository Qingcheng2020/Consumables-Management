package jp.co.nss.wms.model;

import java.util.List;
import java.util.Map;

import lombok.Data;

@Data
public class UserInfoReq {
    private Double roleID;

    private List<String> roles;

    private String icon;

    private List<Map> menus;

    private String username;

    private String nickname;

}
