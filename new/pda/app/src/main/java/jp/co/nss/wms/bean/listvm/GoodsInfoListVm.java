package jp.co.nss.wms.bean.listvm;

import java.util.List;

import jp.co.nss.wms.bean.vm.GoodsInfoVm;

/**
 * Created by 13799 on 2018/6/23.
 */

public class GoodsInfoListVm {
    private String errorCode;
    private String ok;
    private String errorMsg;
    private List<GoodsInfoVm> obj;

    public String getErrorCode() {
        return errorCode;
    }

    public void setErrorCode(String errorCode) {
        this.errorCode = errorCode;
    }

    public String getOk() {
        return ok;
    }

    public void setOk(String ok) {
        this.ok = ok;
    }

    public String getErrorMsg() {
        return errorMsg;
    }

    public void setErrorMsg(String errorMsg) {
        this.errorMsg = errorMsg;
    }

    public List<GoodsInfoVm> getObj() {
        return obj;
    }

    public void setObj(List<GoodsInfoVm> obj) {
        this.obj = obj;
    }
}
