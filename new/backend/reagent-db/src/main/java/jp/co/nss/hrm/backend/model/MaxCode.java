package jp.co.nss.hrm.backend.model;

import io.swagger.annotations.ApiModelProperty;
import java.io.Serializable;

public class MaxCode implements Serializable {
    @ApiModelProperty(value = "耗材编号")
    private String code;

    private static final long serialVersionUID = 1L;

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", code=").append(code);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }
}
