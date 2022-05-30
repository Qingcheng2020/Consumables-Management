package jp.co.nss.hrm.backend.mapper;

import java.util.List;
import jp.co.nss.hrm.backend.model.ReagentBaseInfo;
import jp.co.nss.hrm.backend.model.ReagentBaseInfoExample;
import org.apache.ibatis.annotations.Param;

public interface ReagentBaseInfoMapper {
    long countByExample(ReagentBaseInfoExample example);

    int deleteByExample(ReagentBaseInfoExample example);

    int deleteByPrimaryKey(Long id);

    int insert(ReagentBaseInfo record);

    int insertSelective(ReagentBaseInfo record);

    List<ReagentBaseInfo> selectByExample(ReagentBaseInfoExample example);

    ReagentBaseInfo selectByPrimaryKey(Long id);

    int updateByExampleSelective(@Param("record") ReagentBaseInfo record, @Param("example") ReagentBaseInfoExample example);

    int updateByExample(@Param("record") ReagentBaseInfo record, @Param("example") ReagentBaseInfoExample example);

    int updateByPrimaryKeySelective(ReagentBaseInfo record);

    int updateByPrimaryKey(ReagentBaseInfo record);

    String getreagentid(@Param("stocknum")String stocknum);
}