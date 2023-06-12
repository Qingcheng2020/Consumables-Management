package jp.co.nss.wms.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtil {
    public static String getDateStr(Date date) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy年MM月dd日");
        if (date == null) return null;
        return dateFormat.format(date);
    }

    public static String getDateStr() {

        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy年MM月dd日");
        return dateFormat.format(new Date());
    }

    public static String getDateStrYYYYMMDD() {

        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
        return dateFormat.format(new Date());
    }

    public static Date  getDate(String date) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy年MM月dd日");
        if (date == null) return null;
        try {
            return dateFormat.parse(date);
        }catch (Exception e) {
            return  null;
        }
    }

    public static Date getDate_ymdhms(String date) {
        if (date == null) return null;
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date temp = null;
        try {
            temp =  dateFormat.parse(date);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return temp;
    }

    public static String getDate_(Date date) {
        if (date == null) return null;
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        try {
            return dateFormat.format(date);
        } catch (Exception e){
            return null;
        }
    }

    public static String getDate_ymd(Date date) {
        if (date == null) return null;
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        return dateFormat.format(date);
    }
    
    public static String getDate_ymd_fromString(String date) {
        if (date == null) return null;
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date temp;
        String res = null;
        try {
            temp = dateFormat.parse(date);
            res = dateFormat.format(temp);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return res;
    }

    public static String getDate_ymd_fromNewDate(String date) {
        if (date == null) return date;
        Date time = new Date(date);
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        String res = null;
        try {
            res = dateFormat.format(time);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return res;
    }

}
