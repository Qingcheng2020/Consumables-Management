package jp.co.nss.hrm.backend.api.dao;

import jp.co.nss.hrm.backend.api.dto.ReagentInfo;
import jp.co.nss.hrm.backend.model.ReagentBaseInfo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ReagentBaseInfoDao {


    List<ReagentBaseInfo> searchByDouble(String code, String name, String manufacturerName, String supplierShortName);

    String getLow(String code);

    String getOverDue(String code);

    String getMaxId();

    int updateId(@Param("idIndex") Long idIndex);

    List<ReagentBaseInfo> getInfoList(String reagentName, String supplierId, String factory);

    int updateBS();

    List<ReagentInfo> getEnSupList(String keyword);

    String getReagentId(@Param("reagentName") String reagentName);

    Boolean getIsQr(@Param("reagentId") String reagentId);
}
