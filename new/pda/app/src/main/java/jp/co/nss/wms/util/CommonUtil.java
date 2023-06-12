package jp.co.nss.wms.util;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

public class CommonUtil {

    /**
     * 计算开启有效期等相关时间
     */
    public static class EffectiveTimeUtil {
        // 开启有效期 到期日期
        Date timeEffect;
        // 过期剩余最短天数（库存有效期和开启有效期比较）
        long timeLeft;
        // 开启有效期距离过期剩余天数
        long timeLeftEffect;
        // 库存到期 剩余天数
        long timeLeftExpire;
        // 判断最近的到期时间是否是今天
        // 当 timeEffect 为 0 时，需要判断是今天还是明天
        boolean isTodayInvalid = false;
        static long timeDayStamp = 24*60*60*1000;

        /**
         * 库存和开启有效期
         * @param expireTime Date 库存过期时间
         * @param outTime Date 出库时间
         * @param effectPeriod int 开启有效期天数
         */
        public EffectiveTimeUtil(Date expireTime, Date outTime, int effectPeriod) {
            Calendar calendar = new GregorianCalendar();
            calendar.setTime(outTime);
            calendar.add(Calendar.DATE, effectPeriod);
            timeEffect = calendar.getTime();

            long timeNow = new Date().getTime();

            timeLeftExpire = (expireTime.getTime() - timeNow) / timeDayStamp;
            timeLeftEffect = (timeEffect.getTime() - timeNow) / timeDayStamp;

            // 库存过期时间在前
            if (expireTime.before(timeEffect)) {
                timeLeft = timeLeftExpire;
                if (timeLeft==0 && checkIsTodayInvalid(timeNow, expireTime.getTime())) isTodayInvalid = true;
            } else {
                // 开启有效期时间在前
                // 日期相等时，无论哪个都可
                timeLeft = timeLeftEffect;
                if (timeLeft==0 && checkIsTodayInvalid(timeNow, timeEffect.getTime())) isTodayInvalid = true;
            }
        }

        // 判断是否为同一天
        private boolean checkIsTodayInvalid(long timeNow, long timeInvalid) {
            SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
            String dateNow = sf.format(timeNow);
            String dateInvalid = sf.format(timeInvalid);
            return dateNow.equals(dateInvalid);
        }

        public Date getTimeEffect() {
            return timeEffect;
        }

        public long getTimeLeft() {
            if (timeLeft > 0) {
                timeLeft++;
            }
            return timeLeft;
        }

        public long getTimeLeftEffect() {
            return timeLeftEffect;
        }

        public long getTimeLeftExpire() {
            return timeLeftExpire;
        }

        public boolean getIsTodayInvalid() {
            return isTodayInvalid;
        }
    }

    /**
     * 处理二维码中包含特殊字符的问题
     */
    public static String qrcode2param (String qrcode) {
        String _qrcode = qrcode.replaceAll("\uFEFF", "");
//        try {
//            _qrcode = URLEncoder.encode(_qrcode, "UTF-8");
//        } catch (UnsupportedEncodingException e) {
//            e.printStackTrace();
//        }

        return _qrcode;
    }

}
