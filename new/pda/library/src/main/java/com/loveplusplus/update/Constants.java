package com.loveplusplus.update;

class Constants {


    // json {"url":"http://192.168.205.33:8080/Hello/app_v3.0.1_Other_20150116.apk","versionCode":2,"updateMessage":"版本更新信息"}

    static final String APK_DOWNLOAD_URL = "updateUrl";
    static final String APK_UPDATE_CONTENT = "des";
    static final String APK_VERSION_CODE = "versionCode";


    static final int TYPE_NOTIFICATION = 2;

    static final int TYPE_DIALOG = 1;

    static final String TAG = "UpdateChecker";

    static final String HOST = "yotcap.top";
    // Postman 随机生成
//    static final String AUTHORIZATION = "Basic Z2hwX2d1cnBtQUhkNmJKb1pDdnRUT2pad2RUSTlEZmhtcDNpMTlQUzo=";
    static final String AUTHORIZATION = "A123A321A";

//    static final String UPDATE_URL = "https://gitee.com/journary/app/raw/master/app/appversion.json";
//    static final String UPDATE_URL = "http://192.168.10.101:9090/xpi/static/appstore/appInfo.json?token=ABCDEFFGHIJKKLMN";
    static final String UPDATE_URL = "http://yotcap.top/xpi/static/appstore/appInfo.json?token=ABCDEFFGHIJKKLMN";
}
