package jp.co.nss.hrm.backend.common.util.SmsTentcent;

import com.tencentcloudapi.common.Credential;
import com.tencentcloudapi.common.profile.ClientProfile;
import com.tencentcloudapi.common.profile.HttpProfile;
import com.tencentcloudapi.sms.v20210111.SmsClient;
import com.tencentcloudapi.sms.v20210111.models.SendSmsRequest;
import com.tencentcloudapi.sms.v20210111.models.SendSmsResponse;

public class SmsTencent {

    private static final String SecretId = "AKIDUnpb6KHzQaU8WdT3NQChwtZy6yZtwjFW";
    private static final String SecretKey = "2oKYVCdnfHdiV1HGyPZT5QUHn20jBMGt";
    private static final String Endpoint = "sms.tencentcloudapi.com";
    private static final String Region = "ap-beijing";
    private static final String SmsSdkAppId = "1400604278";
    private static final String SignName = "忠联科技";

    public static SendSmsResponse send(String templateId, String[] phoneNumberSet, String[] templateParamSet) {

        try {
            // 实例化一个认证对象，入参需要传入腾讯云账户secretId，secretKey,此处还需注意密钥对的保密
            // 密钥可前往https://console.cloud.tencent.com/cam/capi网站进行获取
            Credential cred = new Credential(SecretId, SecretKey);
            // 实例化一个http选项，可选的，没有特殊需求可以跳过
            HttpProfile httpProfile = new HttpProfile();
            httpProfile.setEndpoint(Endpoint);
            // 实例化一个client选项，可选的，没有特殊需求可以跳过
            ClientProfile clientProfile = new ClientProfile();
            clientProfile.setHttpProfile(httpProfile);
            // 实例化要请求产品的client对象,clientProfile是可选的
            SmsClient client = new SmsClient(cred, Region, clientProfile);
            // 实例化一个请求对象,每个接口都会对应一个request对象
            SendSmsRequest req = new SendSmsRequest();

            // 转换为国内手机号
            String[] _phoneNumberSet = new String[phoneNumberSet.length];
            for (int i = 0; i < phoneNumberSet.length; i++) {
                String _p = "+86" + phoneNumberSet[i];
                _phoneNumberSet[i] = _p;
            }

            req.setPhoneNumberSet(_phoneNumberSet);
            req.setSmsSdkAppId(SmsSdkAppId);
            req.setSignName(SignName);
            req.setTemplateId(templateId);
            req.setTemplateParamSet(templateParamSet);

            // 返回的resp是一个SendSmsResponse的实例，与请求对象对应
            SendSmsResponse resp = client.SendSms(req);

            // 输出json格式的字符串回包
            System.out.println(SendSmsResponse.toJsonString(resp));

            return resp;
        } catch (Exception e) {
            System.out.println(e.toString());
        }

        return null;
    }
}
