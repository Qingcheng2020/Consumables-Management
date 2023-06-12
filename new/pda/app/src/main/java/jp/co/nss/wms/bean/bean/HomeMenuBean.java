package jp.co.nss.wms.bean.bean;

public class HomeMenuBean {
    private int id;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getBtnName() {
        return btnName;
    }

    public void setBtnName(String btnName) {
        this.btnName = btnName;
    }

    public int getImaResId() {
        return imaResId;
    }

    public void setImaResId(int imaResId) {
        this.imaResId = imaResId;
    }

    public int getOrder() {
        return order;
    }

    public void setOrder(int order) {
        this.order = order;
    }

    private String btnName;
    private int imaResId;
    private int order;

}