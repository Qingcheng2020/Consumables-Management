package jp.co.nss.wms.util;

import android.content.Context;

import com.google.gson.FieldNamingPolicy;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import java.util.concurrent.TimeUnit;

import jp.co.nss.wms.constance.Constance;
import okhttp3.OkHttpClient;
import okhttp3.logging.HttpLoggingInterceptor;
import retrofit2.Retrofit;
import retrofit2.converter.gson.GsonConverterFactory;

public class RestClient {

    private static final String URL = "http://192.168.10.110:8080"; // BaseUrlを指定

    // GSON
    private static final Gson gson = new GsonBuilder()
            .setFieldNamingPolicy(FieldNamingPolicy.IDENTITY)
            .create();

    // RetrofitにGSONとOkhttpを組み合わせてHttpクライアントの作成
    public static Retrofit getClient(Context context) {
        HttpLoggingInterceptor interceptor = new HttpLoggingInterceptor();
        interceptor.setLevel(HttpLoggingInterceptor.Level.BODY);
        // Okhttp
        OkHttpClient.Builder clientBuilder = new OkHttpClient.Builder()
                .connectTimeout(10, TimeUnit.SECONDS)
                .writeTimeout(10, TimeUnit.SECONDS)
                .readTimeout(30, TimeUnit.SECONDS)
                .addInterceptor(interceptor);
        String authToken = SharedPreferencesUtil.getInstance(context).getKeyValue(Constance.SHAREP.TOKEN);
        if (!StringUtil.isEmpty(authToken)) {
            AuthenticationInterceptor interceptor2 =
                    new AuthenticationInterceptor(authToken);

            if (!clientBuilder.interceptors().contains(interceptor2)) {
                clientBuilder.addInterceptor(interceptor2);
            }
        }

        OkHttpClient client = clientBuilder.build();

        Retrofit retrofit = new Retrofit.Builder()
                .baseUrl(Constance.getBaseUrl())
                .addConverterFactory(GsonConverterFactory.create(gson))
                .client(client)
                .build();
        return retrofit;
    }

}

